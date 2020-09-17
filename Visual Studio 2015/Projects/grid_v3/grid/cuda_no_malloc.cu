
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <conio.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>  // 用来复制数组





#define PI 3.141592653

#define BLK_DIM 256

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
__global__ void compute_radial_profile2
(float *img_array, float *xc, float *yc, float *r_sample, float *t_sample, int t_size, int r_size, float *radial_profile, int arraySize);






// 新创建一个计算均值的函数
void getMean(float *img_mat, float *arrayMed, int len, int n_stream);



void getrdp_x_y(float *rdp_matrix, int r_N, int theta_num_perQ, float *rdp_all, float *rdp_x, float *rdp_y);

/*以下函数用来得到radial profile 的反转，为求互相关做准备*/
void get_rev_rdp(float *rdp, float *rdp_rev, int rdp_x_size);

/*以下函数用来计算两个序列的互相关曲线，其中rdp_corr是最终结果，N是rdp的大小*/
void rdp_corr(float *rdp, float *rdp_rev, float *rdp_corr, int N);


/*以下函数用来寻找曲线的峰值，返回其坐标位置*/
float findpeak(float *rdp_corr, int N);



float LeastSquareGuassian(float *arr_x, float *arr_y, int arr_N);



void getCentroid(float *p_img, int arraySize, int n_stream, float *xc, float *yc);


void getCentroid3(float *p_img, int arraySize, int n_stream, float *xc, float *yc)
{
	int LEN = arraySize*arraySize;
	float temp = 0;
	float A = 0;
	float *array_med3 = (float*)malloc(n_stream*sizeof(float));
	getMean(p_img, array_med3, LEN, n_stream);
	for (int i = 0; i < n_stream; i++)
	{
		int i_offset = i*LEN;
		temp = 0;
		A = 0;
		xc[i] = 0;
		yc[i] = 0;
		for (int j = i_offset; j < LEN+i_offset; j++)
		{
			int arr_x = (j-i_offset) % arraySize;
			int arr_y = (j-i_offset) / arraySize;
			float temp = p_img[j] - array_med3[i];
			temp = fabs(temp);
			A += temp;
			xc[i] += (temp)*arr_x;
			yc[i] += (temp)*arr_y;
		}
		xc[i] = xc[i] / A;
		yc[i] = yc[i] / A;
		printf("the center of array is %f, %f\n", xc[i], yc[i]);

	}


	free(array_med3);
	//*array_med3 = NULL;


}









/////////////////////////////////////////////////////////////////////////////////////////////////////
void cuda_QI3(float *p_img, int arraySize, int n_stream, float *rdp_profile, float *xc, float *yc)
{
	//int arraySize = 80;

	size_t img_bytes = arraySize*arraySize * sizeof(float);   // 矩阵元素所占空间
	size_t f_bytes = sizeof(float);

	//cudaStream_t *streams = (cudaStream_t *)malloc(n_stream * sizeof(cudaStream_t));

	int LEN = arraySize*arraySize;                            // 图像矩阵元素数
	int full_LEN = LEN*n_stream;

	//const dim3 block(BLK_DIM);
	//const dim3 grid((full_LEN + block.x - 1) / block.x, 1);
	//float *p_img = &img_mat[0][0][0];

	// 调用getCentroid 函数计算n_stream 张图的质心xc,yc

	getCentroid3(p_img, arraySize, n_stream, xc, yc);
	printf("please be good!\n");


	/// 接下来实现QI算法  
	// 先定义相关的变量；
	float r_step = 0.4;
	int theta_num_perQ = 8;
	int t_size = theta_num_perQ * 4;
	int r_max = arraySize / 2 - 2;
	int r_N = r_max / r_step;

	// 创建采样点，这些点对于所有的ROI矩阵是一样的
	size_t r_bytes = r_N * sizeof(float);
	size_t t_bytes = t_size * sizeof(float);
	float *r_sample = (float *)malloc(r_bytes);
	if (*r_sample = NULL)
		printf("out of memory!");

	float *t_sample = (float *)malloc(t_bytes);
	if (*t_sample = NULL)
		printf("out of memory!");
	printf("good now!");
	for (int i = 0; i < r_N; i++)
	{
		r_sample[i] = i*r_step;
		//printf("the r_sequence is :%f\n", r_sample[i]);
	}
	for (int i = 0; i < theta_num_perQ * 4; i++)
	{
		t_sample[i] = i*PI * 2 / (theta_num_perQ * 4);
		//printf("the t_sequence is :%f\n", t_sample[i]);
	}

	//预设置QI核函数相关结果变量，以及对应的GPU部分
	size_t rdp_bytes = r_N*theta_num_perQ * 4 * sizeof(float);
	size_t rdp_s_bytes = rdp_bytes*n_stream;
	//size_t rN_bytes = r_N * sizeof(float);


	float * radial_profile = (float *)malloc(rdp_s_bytes);  // 存放所有radial profile的数据

	// GPU allocation
	float *d_radial_profile = NULL;
	float *d_r_sample = NULL;
	float *d_t_sample = NULL;
	float *d_img_mat = NULL;
	float *d_xc = NULL;
	float *d_yc = NULL;
	////

	CHECK(cudaMalloc(&d_radial_profile, rdp_s_bytes));
	CHECK(cudaMalloc(&d_r_sample, r_bytes));
	CHECK(cudaMalloc(&d_t_sample, t_bytes));
	CHECK(cudaMalloc(&d_img_mat, img_bytes*n_stream));
	CHECK(cudaMalloc(&d_xc, sizeof(float)*n_stream));
	CHECK(cudaMalloc(&d_yc, sizeof(float)*n_stream));



	// 传递数据  
	//CHECK(cudaMemcpy(d_radial_profile, radial_profile, rdp_bytes, cudaMemcpyHostToDevice));
	CHECK(cudaMemcpy(d_r_sample, r_sample, r_bytes, cudaMemcpyHostToDevice));
	CHECK(cudaMemcpy(d_t_sample, t_sample, t_bytes, cudaMemcpyHostToDevice));
	CHECK(cudaMemcpy(d_img_mat, p_img, img_bytes*n_stream, cudaMemcpyHostToDevice));

	//for (int i = 0; i < n_stream; i++)
	//{
	//	CHECK(cudaStreamSynchronize(streams[i]));
	//}
	int rdp_LEN = r_N*t_size*n_stream;
	const dim3 block2(BLK_DIM);
	const dim3 grid2((rdp_LEN + block2.x - 1) / block2.x, 1);

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



	for (int j = 0; j < 3; j++)
	{
		CHECK(cudaMemcpy(d_xc, xc, sizeof(float)*n_stream, cudaMemcpyHostToDevice));
		CHECK(cudaMemcpy(d_yc, yc, sizeof(float)*n_stream, cudaMemcpyHostToDevice));

		compute_radial_profile2 << <grid2, block2 >> >
			(d_img_mat, d_yc, d_xc, d_r_sample, d_t_sample, t_size, r_N, d_radial_profile, arraySize);


		CHECK(cudaMemcpy(radial_profile, d_radial_profile, rdp_s_bytes, cudaMemcpyDeviceToHost));


		for (int i = 0; i < n_stream; i++)
		{
			int rdp_offset = i*r_N*theta_num_perQ * 4;
			int rN_offset = i*r_N;
			// radial profile 在X Y方向上合并
			getrdp_x_y( radial_profile + rdp_offset, r_N, theta_num_perQ, rdp_profile+rN_offset, rdp_x, rdp_y);

			get_rev_rdp(rdp_x, rdp_x_rev, 2 * r_N - 1);

			get_rev_rdp(rdp_y, rdp_y_rev, 2 * r_N - 1);

			rdp_corr(rdp_x, rdp_x_rev, rdp_x_corr, r_N * 2 - 1);
			rdp_corr(rdp_y, rdp_y_rev, rdp_y_corr, r_N * 2 - 1);

			// 寻找最大值附近的值及其索引。
			int pkx, pky;
			pkx = findpeak(rdp_x_corr, r_N * 4 - 3);
			pky = findpeak(rdp_y_corr, r_N * 4 - 3);

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

			printf("the deviation of center is %f, %f\n", detx, dety);

			xc[i] = xc[i] - 2 * detx / PI;
			yc[i] = yc[i] - 2 * dety / PI;
		}
	}
	// 至此已经完成了一轮从图像矩阵到中心坐标的全部过程，剩下的就是迭代QI。
	//printf("good until now!\n");



	for (int i = 0; i < n_stream; i++)
	{
		printf("the real center of image is %f, %f\n", xc[i], yc[i]);
	}


	/////// 释放内存空间

	free(r_sample);
	//*r_sample = NULL;
	free(t_sample);
	//*t_sample = NULL;

	free(radial_profile);
	//*radial_profile = NULL;
	free(rdp_x);
	//*rdp_x = NULL;
	free(rdp_y);
	//*rdp_y = NULL;

	free(rdp_x_rev);
	//*rdp_x_rev = NULL;
	free(rdp_y_rev);
	//*rdp_y_rev = NULL;
	free(rdp_x_corr);
	//*rdp_x_corr = NULL;
	free(rdp_y_corr);
	//*rdp_y_corr = NULL;




	////
	////
	CHECK(cudaFree(d_radial_profile));
	CHECK(cudaFree(d_r_sample));
	CHECK(cudaFree(d_t_sample));
	CHECK(cudaFree(d_img_mat));
	CHECK(cudaFree(d_xc));
	CHECK(cudaFree(d_yc));

}


