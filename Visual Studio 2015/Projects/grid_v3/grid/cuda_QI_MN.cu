
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <conio.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>  // 用来复制数组
#include "gpu_func.cuh"





#define PI 3.141592653


#define BLK_DIM2 32
#define CHECK(call)  \
     { const cudaError_t error = call;         \
       if (error != cudaSuccess) {            \
            printf("Error:%s:%d, ",__FILE__,__LINE__);  \
            printf("code:%d, reason:%s\n",error,cudaGetErrorString(error)); \
            exit(1);     \
          }}   



// Texture reference for 2D float texture
texture<float, 2, cudaReadModeElementType> tex;

__global__ void compute_radial_profile_tex
(float *d_xc, float *d_yc, float *d_x_sample, float *d_y_sample, float *power, int t_size, int r_size, float *d_radial_profile, int arraySize)
{
	const unsigned int idx = (blockIdx.x*blockDim.x) + threadIdx.x;
	const unsigned int idy = (blockIdx.y*blockDim.y) + threadIdx.y;
	int thread_idx = ((gridDim.x*blockDim.x)*idy) + idx;
	int s = thread_idx / (r_size*t_size);  //用i 来判断是第几张图的数据，然后选取不同的质心坐标 这里不应该加1
	int img_offset = s*arraySize*arraySize;
	int inner_thread_idx = thread_idx % (r_size*t_size);
	int p_id = inner_thread_idx/t_size;
	float x = d_xc[s] + d_x_sample[inner_thread_idx];
	float y = d_yc[s] + d_y_sample[inner_thread_idx]+s*arraySize;
	float p = power[p_id];
	d_radial_profile[thread_idx] = tex2D(tex, x + 0.5f, y+ 0.5f)*p;
	//d_check[thread_idx] = d_radial_profile[thread_idx];
}
//// 准备每个核函数算多一点，但是好像很容易出错
//__global__ void compute_radial_profile_tex_4
//(float *d_xc, float *d_yc, float *d_x_sample, float *d_y_sample, float *power, int t_size, int r_size, float *d_radial_profile, int arraySize, float *d_check, int n_frame)
//{
//
//	const unsigned int idx = (blockIdx.x*blockDim.x) + threadIdx.x;
//	//const unsigned int idy = (blockIdx.y*blockDim.y) + threadIdx.y;
//	if (idx<= r_size*t_size*n_frame)
//	{
//		//int thread_idx = ((gridDim.x*blockDim.x)*idy) + 4*idx;
//		int thread_idx = 4 * idx;
//		int s = thread_idx / (r_size*t_size);  //用i 来判断是第几张图的数据，然后选取不同的质心坐标 这里不应该加1
//		int img_offset = s*arraySize*arraySize;
//		int inner_thread_idx = thread_idx % (r_size*t_size);
//		int p_id = inner_thread_idx / t_size;
//		for (int i =0; i < 4; i++)
//		{
//			float x = d_xc[s] + d_x_sample[inner_thread_idx+i];
//			float y = d_yc[s] + d_y_sample[inner_thread_idx+i] + s*arraySize;
//			float p = power[p_id];
//			d_radial_profile[thread_idx+i] = tex2D(tex, x + 0.5f, y + 0.5f)*p;
//			d_check[thread_idx + i] = d_radial_profile[thread_idx + i];
//		}
//
//	}
//
//}


/////////////////////////////////////////////////////////////////////////////////////////////////////
void cuda_QI4(float *p_img_4d, int arraySize, int n_frame,int n_stream, float *rdp_profile, float *xc, float *yc)
{
	//int arraySize = 80;

	size_t img_bytes = arraySize*arraySize * sizeof(float);   // 矩阵元素所占空间
	size_t f_bytes = sizeof(float);

	//cudaStream_t *streams = (cudaStream_t *)malloc(n_stream * sizeof(cudaStream_t));

	int LEN = arraySize*arraySize;                            // 图像矩阵元素数
	int s_LEN = LEN*n_frame;

	// 调用getCentroid 函数计算n_stream 张图的质心xc,yc

	getCentroid_MN(p_img_4d, arraySize, n_frame,n_stream, xc, yc);
	//printf("please be good!\n");


	/// 接下来实现QI算法  
	// 先定义相关的变量；
	float r_step = 0.4;
	int thetaPerQ =4;
	int t_size = thetaPerQ * 4;
	//int t_size =4 ;
	int r_max = arraySize / 2 - 5;
	int r_N = r_max / r_step;

	// 创建采样点，这些点对于所有的ROI矩阵是一样的
	size_t r_bytes = r_N * sizeof(float);
	size_t t_bytes = t_size * sizeof(float);



	//预设置QI核函数相关结果变量，以及对应的GPU部分
	size_t rdp_bytes = r_N*t_size * sizeof(float);
	size_t rdp_s_bytes = rdp_bytes*n_frame;
	/// 生成极坐标化的常数部分，加上质心坐标即可得到所有采样点坐标， 将x_sample 和y_sample 按照角度变化排列，和核函数一致，能够减少数据访问次数
	// 抛弃了生成r和t 采样点的方案，改为直接生成极坐标矩阵，r_sample 和t_sample 随算随用，覆盖重用，节省空间。
	float *x_sample = (float *)malloc(rdp_bytes);
	if (*x_sample = NULL)
		printf("out of memory!");
	float *y_sample = (float *)malloc(rdp_bytes);
	if (*y_sample = NULL)
		printf("out of memory!");
	compute_x_y(x_sample, y_sample, r_step, t_size, r_N);
	/// ***************************************************************************************************************************************                              
	/// 计算权重，并保存于常量内存
	float *power = (float *)malloc(r_bytes);

	compute_power(power, r_N);



	float * radial_profile = (float *)malloc(rdp_bytes*n_frame*n_stream);  
	//float * check = (float *)malloc(rdp_bytes*n_frame*n_stream);  //检查数据
															// GPU allocation
	float *d_radial_profile = NULL;                                        
	//float *d_check = NULL;

	float *d_img_mat = NULL;                                                            // 设备端创建图像，预备绑定纹理
	float *d_xc = NULL;
	float *d_yc = NULL;
	////
	float *d_x_sample = NULL;

	float *d_y_sample = NULL;
	float *d_power = NULL;


	CHECK(cudaMalloc(&d_power, r_bytes));
	CHECK(cudaMalloc(&d_x_sample, rdp_bytes));
	CHECK(cudaMalloc(&d_y_sample, rdp_bytes));
	CHECK(cudaMallocHost(&d_radial_profile, rdp_bytes*n_frame*n_stream));            

	CHECK(cudaMalloc(&d_img_mat, img_bytes*n_frame*n_stream));                     //// 设备端创建图像，预备绑定纹理
	CHECK(cudaMalloc(&d_xc, sizeof(float)*n_frame*n_stream));
	CHECK(cudaMalloc(&d_yc, sizeof(float)*n_frame*n_stream));
	//CHECK(cudaMallocHost(&d_check, rdp_bytes*n_frame*n_stream));

	cudaStream_t *streams = (cudaStream_t *)malloc(n_stream * sizeof(cudaStream_t));

	CHECK(cudaMemcpy(d_power, power, r_bytes, cudaMemcpyHostToDevice));
	CHECK(cudaMemcpy(d_x_sample, x_sample, rdp_bytes, cudaMemcpyHostToDevice));
	CHECK(cudaMemcpy(d_y_sample, y_sample, rdp_bytes, cudaMemcpyHostToDevice));

	/// 设置纹理内存
	// Allocate array and copy image data
	size_t pitch;


	CHECK(cudaMallocPitch((void**)&d_img_mat, &pitch, arraySize * sizeof(float), arraySize*n_frame*n_stream));
	cudaChannelFormatDesc desc = cudaCreateChannelDesc<float>();
	CHECK(cudaBindTexture2D(0, &tex, d_img_mat, &desc, arraySize, arraySize*n_frame*n_stream, pitch));
	tex.addressMode[0] = cudaAddressModeClamp;
	tex.addressMode[1] = cudaAddressModeClamp;
	tex.filterMode = cudaFilterModeLinear;    // --- Enable linear filtering
	tex.normalized = false;                    // --- Texture coordinates will NOT be normalized
	CHECK(cudaMemcpy2D(d_img_mat, pitch, p_img_4d, sizeof(float)*arraySize, sizeof(float)*arraySize, arraySize*n_frame*n_stream, cudaMemcpyHostToDevice));

	// 图像矩阵已经绑定到纹理，接下来就可以在核函数中使用纹理了。

	for (int i = 0; i < n_stream; i++)
	{
		CHECK(cudaStreamCreate(&streams[i]));
	}



	int s_rdp_LEN = r_N*t_size*n_frame;
	const dim3 block2(BLK_DIM2);
	const dim3 grid2((s_rdp_LEN + block2.x - 1) / block2.x, 1);



	// 设置CPU端的x y 数据（后面也许并不需要，如果直接算完了的话，但GPU端是必须设置的）
	size_t rdpxy_byte = (r_N* 2 - 1) *n_frame*n_stream* sizeof(float);
	size_t s_rdpxy_byte = (r_N * 2 - 1) *n_frame * sizeof(float);
	float *rdp_x = (float *)malloc(rdpxy_byte);
	float *rdp_y = (float *)malloc(rdpxy_byte);

	//// 接下来取rdp_x 的反，调用两次反向函数。
	//float *rdp_x_rev = (float *)malloc(rdpxy_byte);
	//float *rdp_y_rev = (float *)malloc(rdpxy_byte);

	// 接下来进行互相关计算，
	size_t corr_bytes = (r_N* 4 - 3) * sizeof(float);
	float *rdp_x_corr = (float*)malloc(corr_bytes);
	float *rdp_y_corr = (float*)malloc(corr_bytes);
	memset(rdp_x_corr, 0, corr_bytes);
	memset(rdp_y_corr, 0, corr_bytes);


	for (int j = 0; j < 5; j++)
	{
		//for (int i = 0; i < n_stream; i++)
		//{
		//	int s_xy_offset = i*n_frame;
		CHECK(cudaMemcpy(d_xc, xc, sizeof(float)*n_frame*n_stream, cudaMemcpyHostToDevice));
		CHECK(cudaMemcpy(d_yc, yc, sizeof(float)*n_frame*n_stream, cudaMemcpyHostToDevice));
		//}
		// 这里测试了一下，把传输XY和计算在一个循环里执行速度不变，但是启动会略微延迟，最终加长总的执行时间

			// 尝试一下分解广度运行来覆盖GPU和CPU的执行时间
			// 第一步，第一次GPU计算
		for (int i = 0; i < n_stream; i++)
		{
			//int s_img_offset = i*n_frame*LEN;
			int s_xy_offset = i*n_frame;

			int s_rdp_offset = i*n_frame*r_N*t_size;
			compute_radial_profile_tex << <grid2, block2, 0, streams[i] >> >
				(d_xc + s_xy_offset, d_yc + s_xy_offset, d_x_sample, d_y_sample, d_power, t_size, r_N, d_radial_profile + s_rdp_offset, arraySize,s_img_offset);


		}

		for (int i = 0; i < n_stream; i++)
		{
			CHECK(cudaStreamSynchronize(streams[i]));
		}

			CHECK(cudaMemcpyAsync(radial_profile, d_radial_profile, rdp_bytes*n_frame*n_stream, cudaMemcpyDeviceToHost, streams[0])); // 直接全拉回来


		//FILE *fr = fopen("r4.txt", "w");
		//if (fr == NULL)
		//{
		//	exit(1);
		//}

		//for (int t = 0; t < r_N*n_frame; t++)
		//{
		//	for (int t2 = 0; t2 < t_size; t2++)
		//	{
		//	fprintf(fr, "%f\t ",check[t2+t*t_size]);
		//	}
		//	fprintf(fr, "%\n");
		//}
		//fclose(fr);




		for (int s = 0; s < n_stream; s++)
		{

			int s_rdp_offset = s*n_frame*r_N*t_size;
			int s_xy_offset = s*n_frame;


			int s_rN_offset = s*n_frame*r_N;

			for (int i = 0; i < n_frame; i++)
			{
				int xy_offset = i;
				int rdp_offset = i*r_N*t_size;
				int rN_offset = i*r_N;
				//radial profile 在X Y方向上合并
				getrdp_x_y(radial_profile + rdp_offset + s_rdp_offset, r_N, thetaPerQ, rdp_profile + rN_offset + s_rN_offset, rdp_x, rdp_y);


				//get_rev_rdp(rdp_x, rdp_x_rev, 2 * r_N - 1);
				//get_rev_rdp(rdp_y, rdp_y_rev, 2 * r_N - 1);

				//rdp_corr(rdp_x, rdp_x_rev, rdp_x_corr, r_N * 2 - 1);
				//rdp_corr(rdp_y, rdp_y_rev, rdp_y_corr, r_N * 2 - 1);

				self_conv(rdp_x, rdp_x_corr, 2 * r_N - 1);
				self_conv(rdp_y, rdp_y_corr, 2 * r_N - 1);


				// 寻找最大值附近的值及其索引。
				int pkx, pky;
				pkx = findpeak(rdp_x_corr, r_N * 2 - 1);
				pky = findpeak(rdp_y_corr, r_N * 2 - 1);


				// 提取最大值附近的5个点，并计算其下标
				float pkx_value[5] = { 0 };
				float pkx_index[5] = { 0 };
				float pky_value[5] = { 0 };
				float pky_index[5] = { 0 };
				for (int k = 0; k < 5; k++)
				{
					pkx_value[k] = rdp_x_corr[pkx - 2 + k];
					pky_value[k] = rdp_y_corr[pky - 2 + k];
					pkx_index[k] = (-(2 * r_N - 2) + (pkx - 2 + k))*r_step;
					pky_index[k] = (-(2 * r_N - 2) + (pky - 2 + k))*r_step;
				}

				// 接下来分别输入x y方向的相关曲线极值点，并利用最小二乘法计算出修正坐标

				float detx = LeastSquareGuassian(pkx_index, pkx_value, 5);
				float dety = LeastSquareGuassian(pky_index, pky_value, 5);

				//printf("the deviation of center is %f, %f\n", detx, dety);

				xc[i + s_xy_offset] = xc[i + s_xy_offset] + 2 * detx / PI;
				yc[i + s_xy_offset] = yc[i + s_xy_offset] + 2 * dety / PI;

			}
		}
	}

	// 至此已经完成了一轮从图像矩阵到中心坐标的全部过程，剩下的就是迭代QI。
	//printf("good until now!\n");

	for (int i = 0; i < n_stream; i++)
	{
		CHECK(cudaStreamDestroy(streams[i]));
	}

	//for (int i = 0; i < n_stream; i++)
	//{
	//	int xy_offset = i*n_frame;
	//	for (int j = 0; j < n_frame; j++)
	//	{
	//		printf("the real center of image is %f, %f\n", xc[j+xy_offset], yc[j+xy_offset]);
	//	}

	//}


	/////// 释放内存空间


	//free(check);
	//check = NULL;

	// 释放申请的内存

	free(x_sample);
	x_sample = NULL;
	free(y_sample);
	y_sample = NULL;


	free(radial_profile);
	radial_profile = NULL;
	free(rdp_x);
	rdp_x = NULL;
	free(rdp_y);
	rdp_y = NULL;
	free(power);
	power = NULL;
	//free(rdp_x_rev);
	//rdp_x_rev = NULL;
	//free(rdp_y_rev);
	//rdp_y_rev = NULL;
	free(rdp_x_corr);
	rdp_x_corr = NULL;
	free(rdp_y_corr);
	rdp_y_corr = NULL;



	////
	////
	//CHECK(cudaFreeHost(d_check));
	CHECK(cudaFreeHost(d_radial_profile));


	CHECK(cudaFree(d_img_mat));
	CHECK(cudaFree(d_xc));
	CHECK(cudaFree(d_yc));
	CHECK(cudaFree(d_x_sample));
	CHECK(cudaFree(d_y_sample));
	CHECK(cudaFree(d_power));

}


