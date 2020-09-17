
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <conio.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>  // 用来复制数组





#define PI 3.141592653

#define BLK_DIM 128

#define CHECK(call)  \
     { const cudaError_t error = call;         \
       if (error != cudaSuccess) {            \
            printf("Error:%s:%d, ",__FILE__,__LINE__);  \
            printf("code:%d, reason:%s\n",error,cudaGetErrorString(error)); \
            exit(1);     \
          }}   

//void * alloc(size_t size)
//{
//	void *new_mem;
//	new_mem = malloc(size);
//	if (new_mem == NULL)
//	{
//		printf("Out of memory!\n");
//		exit(1);
//
//	}
//	return new_mem;
//}

/*Declare statically six arrays of ARRAY_SIZE each
** 声明CPU数组变量，以及用来存放返回结果的矩阵
//*/
//float cpu_cen_mat_x[ARRAY_SIZE_Y][ARRAY_SIZE_X];
//float cpu_cen_mat_y[ARRAY_SIZE_Y][ARRAY_SIZE_X];
//float cpu_yc[1];
//float cpu_xc[1];
//float img_mat[ARRAY_SIZE_Y][ARRAY_SIZE_X] = { 0 };  // 这里最好初始化一下， 不然容易报错


int compInc(const void *a, const void *b);







/*下列函数用于计算图像矩阵四个象限的radial profile*/
__global__ void compute_radial_profile_MN
(float *img_array, int n_frame,int n_stream,float *xc, float *yc, float *r_sample, float *t_sample, int t_size, int r_size, float *radial_profile, int arraySize)
{
	const unsigned int idx = (blockIdx.x*blockDim.x) + threadIdx.x;
	const unsigned int idy = (blockIdx.y*blockDim.y) + threadIdx.y;
	int thread_idx = ((gridDim.x*blockDim.x)*idy) + idx;
	//if (thread_idx > (t_size*r_size*n_frame*n_stream))
	//	return;
	int s = thread_idx / (r_size*t_size);  //用i 来判断是第几张图的数据，然后选取不同的质心坐标
	int img_offset = s*arraySize*arraySize;
	int inner_thread_idx = thread_idx % (r_size*t_size);
	int id_r = inner_thread_idx / t_size ;
	int id_t = inner_thread_idx % t_size ;
	float x = xc[s] + r_sample[id_r ] * cos(t_sample[id_t]);
	float y = yc[s] + r_sample[id_r] *  sin(t_sample[id_t]);
	int x1 = (int)x;
	int y1 = (int)y;
	int x2 = x1 + 1;
	int y2 = y1 + 1;
	float rdp = 
		img_array[y1*arraySize + x1+img_offset] * ((float)x2 - x)*((float)y2 - y) + \
		img_array[y2*arraySize + x1+img_offset] * ((float)x2 - x)*(y - (float)y1) + \
		img_array[y1*arraySize + x2+img_offset] * (x - (float)x1)*((float)y2 - y) + \
		img_array[y2*arraySize + x2+img_offset] * (x - (float)x1)*(y - (float)y1);
	float power_id = (float)(id_r) / r_size;

	float fall = 1.0 - exp(-(1.0 - power_id)*(1.0 - power_id) / 0.05);
	float rise = 1.0 - exp(-power_id*power_id / 0.01);
	float power = sqrt(fall*rise*power_id * 2.0);
	radial_profile[thread_idx] = rdp*power;
	//d_check[thread_idx] = thread_idx;


}





// 新创建一个计算均值的函数
void getMean_MN(float *img_mat, float *arrayMed, int len, int n_frame,int n_stream)
{
	for (int k = 0; k < n_stream; k++)
	{
		int s_offset = k*len*n_frame;
		
     	for (int j = 0; j < n_frame; j++)
	   {
			int offset = len*j;
		    arrayMed[j+k*n_frame] = 0;
		for (int i = 0; i < len; i++)
		  {
			arrayMed[j+k*n_frame] += img_mat[i+offset+s_offset];
		  }
		arrayMed[j+ k*n_frame] = arrayMed[j+k*n_frame] / len;
	}
	}
}


void getrdp_x_y(float *rdp_matrix, int r_N, int theta_num_perQ, float *rdp_all, float *rdp_x, float *rdp_y);

/*以下函数用来得到radial profile 的反转，为求互相关做准备*/
void get_rev_rdp(float *rdp, float *rdp_rev, int rdp_x_size);

/*以下函数用来计算两个序列的互相关曲线，其中rdp_corr是最终结果，N是rdp的大小*/
void rdp_corr(float *rdp, float *rdp_rev, float *rdp_corr, int N);


/*以下函数用来寻找曲线的峰值，返回其坐标位置*/
float findpeak(float *rdp_corr, int N);



float LeastSquareGuassian(float *arr_x, float *arr_y, int arr_N);



void getCentroid(float *p_img, int arraySize, int n_stream, float *xc, float *yc);


void getCentroid_MN(float *p_img, int arraySize, int n_frame,int n_stream, float *xc, float *yc)
{
	int LEN = arraySize*arraySize;
	int s_LEN = LEN*n_frame;
	float temp = 0;
	float A = 0;
	float *array_med3 = (float*)calloc(n_stream*n_frame , sizeof(float));  // 此处使用自带初始化为0 的calloc函数
	getMean_MN(p_img, array_med3, LEN,n_frame, n_stream);

	for (int k=0;k<n_stream;k++)
	{
		int s_offset = k*n_frame*LEN;
	for (int i = 0; i < n_frame; i++)
	{
		int i_offset = i*LEN;
		temp = 0;
		A = 0;
		xc[i+k*n_frame] = 0;
		yc[i+k*n_frame] = 0;
		for (int j = 0; j < LEN; j++)
		{
			int arr_x = j % arraySize;
			int arr_y = j / arraySize;
			float temp = p_img[j+i_offset+s_offset] - array_med3[i+k*n_frame];
			temp = fabs(temp);
			A += temp;
			xc[i+ k*n_frame] += (temp)*arr_x;
			yc[i+ k*n_frame] += (temp)*arr_y;
		}
		xc[i+ k*n_frame] = xc[i+ k*n_frame] / A;
		yc[i+ k*n_frame] = yc[i+ k*n_frame] / A;
		//printf("the center of array is %f, %f\n", xc[i+k*n_frame], yc[i+ k*n_frame]);

	}
	}

	free(array_med3);
	//*array_med3 = NULL;


}









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
	int theta_num_perQ =4;
	int t_size = theta_num_perQ * 4;
	int r_max = arraySize / 2 - 2;
	int r_N = r_max / r_step;

	// 创建采样点，这些点对于所有的ROI矩阵是一样的
	size_t r_bytes = r_N * sizeof(float);
	size_t t_bytes = t_size * sizeof(float);
	float *r_sample = (float *)malloc(r_bytes*n_frame);
	if (*r_sample = NULL)
		printf("out of memory!");

	float *t_sample = (float *)malloc(t_bytes*n_frame);
	if (*t_sample = NULL)
		printf("out of memory!");
	//printf("good now!");



for (int i = 0; i < r_N; i++)
{
	r_sample[i] = i*r_step;
	//printf("the r_sequence is :%f\n", r_sample[i]);
}

for (int i = 0; i < t_size; i++)
   {
	   t_sample[i] = i*PI * 2 / t_size;
		//printf("the t_sequence is :%f\n", t_sample[i]);
	}


	//预设置QI核函数相关结果变量，以及对应的GPU部分
	size_t rdp_bytes = r_N*t_size * sizeof(float);
	size_t rdp_s_bytes = rdp_bytes*n_frame;



	float * radial_profile = (float *)malloc(rdp_bytes*n_frame*n_stream);  // 存放所有radial profile的数据
	//float * check = (float *)malloc(rdp_bytes*n_frame*n_stream);  //检查数据
															// GPU allocation
	float *d_radial_profile = NULL;
	//float *d_check = NULL;
	float *d_r_sample = NULL;
	float *d_t_sample = NULL;
	float *d_img_mat = NULL;
	float *d_xc = NULL;
	float *d_yc = NULL;
	////

	CHECK(cudaMallocHost(&d_radial_profile, rdp_bytes*n_frame*n_stream));
	CHECK(cudaMallocHost(&d_r_sample, r_bytes));
	CHECK(cudaMallocHost(&d_t_sample, t_bytes));
	CHECK(cudaMallocHost(&d_img_mat, img_bytes*n_frame*n_stream));
	CHECK(cudaMallocHost(&d_xc, sizeof(float)*n_frame*n_stream));
	CHECK(cudaMallocHost(&d_yc, sizeof(float)*n_frame*n_stream));
	//CHECK(cudaMallocHost(&d_check, rdp_bytes*n_frame*n_stream));

	cudaStream_t *streams = (cudaStream_t *)malloc(n_stream * sizeof(cudaStream_t));

	for (int i = 0; i < n_stream; i++)
	{
		CHECK(cudaStreamCreate(&streams[i]));
	}


	// 传递数据  
	//CHECK(cudaMemcpy(d_radial_profile, radial_profile, rdp_bytes, cudaMemcpyHostToDevice));

	for (int i = 0; i < n_stream; i++)
	{
		int s_offset = i*n_frame*LEN;

		//for (int j = 0; j < n_frame; j++)
		//{
		//	int offset = j*LEN;
		//	int r_offset = j*r_N;
		//	int t_offset = j*t_size;

			CHECK(cudaMemcpyAsync(d_r_sample, r_sample, r_bytes, cudaMemcpyHostToDevice, streams[i]));
			CHECK(cudaMemcpyAsync(d_t_sample, t_sample, t_bytes, cudaMemcpyHostToDevice, streams[i]));
			CHECK(cudaMemcpyAsync(d_img_mat+ s_offset, p_img_4d+ s_offset, img_bytes*n_frame, cudaMemcpyHostToDevice, streams[i]));
		}
			// 将多次传输改为1次传输，速度提升了5ms，但是走一个流的数据其他流无法读取！！
	//}



	//for (int i = 0; i < n_stream; i++)
	//{
	//	CHECK(cudaStreamSynchronize(streams[i]));
	//}
	int s_rdp_LEN = r_N*t_size*n_frame;
	const dim3 block2(BLK_DIM);
	const dim3 grid2((s_rdp_LEN + block2.x - 1) / block2.x, 1);

	//printf("grid.x %d, grid.y %d,grid.z,%d\n",grid2.x,grid2.y,grid2.z);
	//printf("block.x %d, block.y %d,block.z,%d\n", block2.x, block2.y, block2.z);



	size_t rdpxy_byte = (r_N*theta_num_perQ * 4 * 2 - 1) * sizeof(float);
	float *rdp_x = (float *)malloc(rdpxy_byte);
	float *rdp_y = (float *)malloc(rdpxy_byte);

	// 接下来取rdp_x 的反，调用两次反向函数。
	float *rdp_x_rev = (float *)malloc(rdpxy_byte);
	float *rdp_y_rev = (float *)malloc(rdpxy_byte);

	// 接下来进行互相关计算，
	size_t corr_bytes = (r_N*theta_num_perQ * 4 * 4 - 3) * sizeof(float);
	float *rdp_x_corr = (float*)malloc(corr_bytes);
	float *rdp_y_corr = (float*)malloc(corr_bytes);

	float *p_rdp_mean = (float *)calloc(r_N*n_stream, sizeof(float));

	for (int j = 0; j < 3; j++)
	{
		//for (int i = 0; i < n_stream; i++)
		//{
		//	int s_xy_offset = i*n_frame;
			CHECK(cudaMemcpyAsync(d_xc, xc, sizeof(float)*n_frame*n_stream, cudaMemcpyHostToDevice,streams[0]));
			CHECK(cudaMemcpyAsync(d_yc, yc, sizeof(float)*n_frame*n_stream, cudaMemcpyHostToDevice,streams[0]));
		//}
		// 这里测试了一下，把传输XY和计算在一个循环里执行速度不变，但是启动会略微延迟，最终加长总的执行时间

			// 尝试一下分解广度运行来覆盖GPU和CPU的执行时间
			// 第一步，第一次GPU计算
		for (int i = 0; i < n_stream; i++)
		{
			int s_img_offset = i*n_frame*LEN;
			int s_xy_offset = i*n_frame;
			int s_r_offset = i*n_frame*r_N;
			int s_t_offset = i*n_frame*t_size;
			int s_rdp_offset = i*n_frame*r_N*t_size;
			compute_radial_profile_MN << <grid2, block2, 0, streams[i] >> >
				(d_img_mat+s_img_offset, n_frame,n_stream , d_xc+s_xy_offset,d_yc + s_xy_offset, d_r_sample, d_t_sample, t_size, r_N, d_radial_profile+ s_rdp_offset, arraySize);
		}

		// 合并这里上下两个循环，GPU处理时间直接提升一倍，没有并行可言

		for (int s = 0; s < n_stream; s++)
		{

				int s_rdp_offset = s*n_frame*r_N*t_size;
				int s_xy_offset = s*n_frame;
				CHECK(cudaMemcpyAsync(radial_profile + s_rdp_offset, d_radial_profile + s_rdp_offset, rdp_bytes*n_frame, cudaMemcpyDeviceToHost, streams[s]));
				//CHECK(cudaMemcpyAsync(check + s_rdp_offset, d_check + s_rdp_offset, rdp_bytes*n_frame, cudaMemcpyDeviceToHost, streams[s]));

		//FILE *fr = fopen("rdp.txt", "w");
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

			int s_rN_offset = s*n_frame*r_N;
		
		for (int i = 0; i < n_frame; i++)
		{
			int xy_offset = i;
			int rdp_offset = i*r_N*t_size;
			int rN_offset = i*r_N;
			// radial profile 在X Y方向上合并
			getrdp_x_y(radial_profile + rdp_offset + s_rdp_offset, r_N, theta_num_perQ, rdp_profile + rN_offset+s_rN_offset, rdp_x, rdp_y);






			get_rev_rdp(rdp_x, rdp_x_rev, 2 * r_N - 1);

			get_rev_rdp(rdp_y, rdp_y_rev, 2 * r_N - 1);



			rdp_corr(rdp_x, rdp_x_rev, rdp_x_corr, r_N * 2 - 1);
			rdp_corr(rdp_y, rdp_y_rev, rdp_y_corr, r_N * 2 - 1);

			// 寻找最大值附近的值及其索引。
			int pkx, pky;
			pkx = findpeak(rdp_x_corr, r_N * 4 - 3);
			pky = findpeak(rdp_y_corr, r_N * 4 - 3);

			//FILE *fr2 = fopen("rdp_corr_x.txt", "w");
			//if (fr2 == NULL)
			//{
			//	exit(1);
			//}
			//for (int t2 = 0; t2 < (r_N * 4 - 3); t2++)
			//{
			//	fprintf(fr, "%f\n", rdp_x_corr[t2]);
			//}
			//fclose(fr2);
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

			xc[i+ s_xy_offset] = xc[i+ s_xy_offset] - 2 * detx / PI;
			yc[i+ s_xy_offset] = yc[i+ s_xy_offset]- 2 * dety / PI;

		}
		}
	}

	// 至此已经完成了一轮从图像矩阵到中心坐标的全部过程，剩下的就是迭代QI。
	//printf("good until now!\n");

	for (int i = 0; i < n_stream; i++)
	{
		CHECK(cudaStreamDestroy(streams[i]));
	}

	for (int i = 0; i < n_stream; i++)
	{
		int s_mean_offset = i*r_N;
		int s_rN_offset = i*n_frame*r_N;
		for (int j = 0; j < n_frame; j++)
		{
			int rN_offset = j*r_N;
			for (int k = 0; k < r_N; k++)
			{
				p_rdp_mean[k + s_mean_offset] = p_rdp_mean[k + s_mean_offset] + rdp_profile[k + rN_offset + s_rN_offset] / n_frame;
			}
		}

	}





	//for (int i = 0; i < n_stream; i++)
	//{
	//	for (int j = 0; j < r_N; j++)
	//	{
	//		printf("the rdp_mean is %f\n", p_rdp_mean[j + i*r_N]);
	//	}
	//}
	//for (int i = 0; i < n_stream; i++)
	//{
	//	int xy_offset = i*n_frame;
	//	for (int j = 0; j < n_frame; j++)
	//	{
	//		printf("the real center of image is %f, %f\n", xc[j+xy_offset], yc[j+xy_offset]);
	//	}

	//}


	/////// 释放内存空间

	free(r_sample);
	r_sample = NULL;
	free(t_sample);
	t_sample = NULL;
	//free(check);
	//check = NULL;



	free(radial_profile);
	radial_profile = NULL;
	free(rdp_x);
	rdp_x = NULL;
	free(rdp_y);
	rdp_y = NULL;

	free(rdp_x_rev);
	rdp_x_rev = NULL;
	free(rdp_y_rev);
	rdp_y_rev = NULL;
	free(rdp_x_corr);
	rdp_x_corr = NULL;
	free(rdp_y_corr);
	rdp_y_corr = NULL;

	free(p_rdp_mean);
	p_rdp_mean = NULL;


	////
	////
	//CHECK(cudaFreeHost(d_check));
	CHECK(cudaFreeHost(d_radial_profile));
	CHECK(cudaFreeHost(d_r_sample));
	CHECK(cudaFreeHost(d_t_sample));
	CHECK(cudaFreeHost(d_img_mat));
	CHECK(cudaFreeHost(d_xc));
	CHECK(cudaFreeHost(d_yc));

}


