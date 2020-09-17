#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <conio.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>  // 用来复制数组
#include "stdafx.h"




#define PI 3.141592653


#define BLK_DIM2 32
#define CHECK(call)  \
     { const cudaError_t error = call;         \
       if (error != cudaSuccess) {            \
            printf("Error:%s:%d, ",__FILE__,__LINE__);  \
            printf("code:%d, reason:%s\n",error,cudaGetErrorString(error)); \
            exit(1);     \
          }}   









/*下列函数用于计算图像矩阵四个象限的radial profile*/
__global__ void compute_radial_profile_MN
(float *img_array, float *xc, float *yc, float *r_sample, float *t_sample, int t_size, int r_size, float *radial_profile, int arraySize)
{
	const unsigned int idx = (blockIdx.x*blockDim.x) + threadIdx.x;
	const unsigned int idy = (blockIdx.y*blockDim.y) + threadIdx.y;
	int thread_idx = ((gridDim.x*blockDim.x)*idy) + idx;

	//if (thread_idx > (t_size*r_size*n_frame*n_stream))
	//	return;
	int s = (thread_idx + 1) / (r_size*t_size);  //用i 来判断是第几张图的数据，然后选取不同的质心坐标 这里应该加1
	int img_offset = s*arraySize*arraySize;
	int inner_thread_idx = thread_idx % (r_size*t_size);

	int id_r = inner_thread_idx / t_size;
	int id_t = inner_thread_idx % t_size;
	float x = xc[s] + r_sample[id_r] * cos(t_sample[id_t]);
	float y = yc[s] + r_sample[id_r] * sin(t_sample[id_t]);
	int x1 = (int)x;
	int y1 = (int)y;
	int x2 = x1 + 1;
	int y2 = y1 + 1;
	float rdp =
		img_array[y1*arraySize + x1 + img_offset] * ((float)x2 - x)*((float)y2 - y) + \
		img_array[y2*arraySize + x1 + img_offset] * ((float)x2 - x)*(y - (float)y1) + \
		img_array[y1*arraySize + x2 + img_offset] * (x - (float)x1)*((float)y2 - y) + \
		img_array[y2*arraySize + x2 + img_offset] * (x - (float)x1)*(y - (float)y1);
	float power_id = (float)(id_r) / r_size;

	float fall = 1.0 - exp(-(1.0 - power_id)*(1.0 - power_id) / 0.05);
	float rise = 1.0 - exp(-power_id*power_id / 0.01);
	float power = sqrt(fall*rise*power_id * 2.0);
	radial_profile[thread_idx] = rdp*power;
	//d_check[thread_idx] = thread_idx;
}

// 本函数用来计算计算均值用的权重值
__global__ void compute_mean_rdp
(float *mean_rdp, float *d_radial_profile)
{
	const unsigned int idx = (blockIdx.x*blockDim.x) + threadIdx.x;
	const unsigned int idy = (blockIdx.y*blockDim.y) + threadIdx.y;
	int thread_idx = ((gridDim.x*blockDim.x)*idy) + 16 * idx;
	float x_r = 0;
	float y_r = 0;
	float mean = 0;
	for (int i = 0; i < 16; i++)
	{
		mean = mean + d_radial_profile[thread_idx + i];
	}
	mean_rdp[idx] = mean / 16;
}

__global__ void compute_x_rdp
(float *d_radial_profile, float *d_x_rdp, int r_N, int thetaPerQ)
{
	const unsigned int idx = (blockIdx.x*blockDim.x) + threadIdx.x;
	const unsigned int idy = (blockIdx.y*blockDim.y) + threadIdx.y;
	int thread_idx = ((gridDim.x*blockDim.x)*idy) + thetaPerQ * 4 * idx;
	int s = idx / (2 * r_N - 1);
	int inner_idx = idx%r_N; // 因为
	float r1 = 0;
	float r2 = 0;
	float r3 = 0;
	float r4 = 0;
	for (int i = 0; i < thetaPerQ; i++)
	{
		r1 = r1 + d_radial_profile[thread_idx + i + s*r_N*thetaPerQ * 4];
		r2 = r2 + d_radial_profile[thread_idx + i + thetaPerQ + s*r_N*thetaPerQ * 4];
		r3 = r3 + d_radial_profile[thread_idx + i + 2 * thetaPerQ + s*r_N*thetaPerQ * 4];
		r4 = r4 + d_radial_profile[thread_idx + i + 3 * thetaPerQ + s*r_N*thetaPerQ * 4];
	}
	// 注意，2N+1的中心位置是N, 但C语言是从0开始的，所以中心位置应该是N-1
	d_x_rdp[inner_idx + r_N - 1 + s*(2 * r_N - 1)] = (r1 + r4) / (2 * thetaPerQ);
	d_x_rdp[r_N - 1 - inner_idx + s*(2 * r_N - 1)] = (r2 + r3) / (2 * thetaPerQ);
	//d_y_rdp[inner_idx + r_N-1 + s*(2 * r_N - 1)] = r1+r2;
	//d_y_rdp[r_N-1 - inner_idx + s*(2 * r_N - 1)] = r3+r4;
	//d_mean_rdp[inner_idx +s*r_N] = r1;

}

__global__ void compute_y_rdp
(float *d_radial_profile, float *d_y_rdp, int r_N, int thetaPerQ)
{
	const unsigned int idx = (blockIdx.x*blockDim.x) + threadIdx.x;
	const unsigned int idy = (blockIdx.y*blockDim.y) + threadIdx.y;
	int thread_idx = ((gridDim.x*blockDim.x)*idy) + thetaPerQ * 4 * idx;
	int s = idx / (2 * r_N - 1);
	int inner_idx = idx%r_N; // 因为idx一个线程填入了两个值，所以r_N个线程就已经填好了2*r_N个值
	float r1 = 0;
	float r2 = 0;
	float r3 = 0;
	float r4 = 0;
	for (int i = 0; i < thetaPerQ; i++)
	{
		r1 = r1 + d_radial_profile[thread_idx + i + s*r_N*thetaPerQ * 4];
		r2 = r2 + d_radial_profile[thread_idx + i + thetaPerQ + s*r_N*thetaPerQ * 4];
		r3 = r3 + d_radial_profile[thread_idx + i + 2 * thetaPerQ + s*r_N*thetaPerQ * 4];
		r4 = r4 + d_radial_profile[thread_idx + i + 3 * thetaPerQ + s*r_N*thetaPerQ * 4];
	}
	// 注意，2N+1的中心位置是N, 但C语言是从0开始的，所以中心位置应该是N-1
	//d_x_rdp[inner_idx + r_N-1 + s*(2*r_N-1)] = r1 + r4;
	//d_x_rdp[r_N-1 - inner_idx + s*(2 * r_N - 1)] = r2 + r3;
	d_y_rdp[inner_idx + r_N - 1 + s*(2 * r_N - 1)] = (r1 + r2) / (2 * thetaPerQ);
	d_y_rdp[r_N - 1 - inner_idx + s*(2 * r_N - 1)] = (r3 + r4) / (2 * thetaPerQ);
	//d_mean_rdp[inner_idx +s*r_N] = r1;

}
// 自卷积函数，就一个A
__global__ void conv_Kernelx(const float *A, float *d_conv_xy, const int rx_N, const int n_frame) {
	int idx = threadIdx.x + blockDim.x*blockIdx.x;
	int s = idx / (2 * rx_N - 1);
	int inner_idx = idx % (2 * rx_N - 1); // 一个线程一个点，需要这么多个点。
	if (idx < n_frame*(2 * rx_N) - 1) {
		float my_sum = 0;
		for (int i = 0; i < rx_N; i++)
			if (((inner_idx < rx_N) && (i <= inner_idx)) || ((inner_idx >= rx_N) && (i >(inner_idx - rx_N)))) my_sum += A[i + s*rx_N] * A[inner_idx - i + s*rx_N];
		d_conv_xy[idx] = my_sum;
	}
}
// 自卷积函数，就一个A
__global__ void conv_Kernely(const float *A, float *d_conv_xy, const int rx_N, const int n_frame) {
	int idx = threadIdx.x + blockDim.x*blockIdx.x;
	int s = idx / (2 * rx_N - 1);
	int inner_idx = idx % (2 * rx_N - 1); // 一个线程一个点，需要这么多个点。
	if (idx < n_frame*(2 * rx_N) - 1) {
		float my_sum = 0;
		for (int i = 0; i < rx_N; i++)
			if (((inner_idx < rx_N) && (i <= inner_idx)) || ((inner_idx >= rx_N) && (i >(inner_idx - rx_N)))) my_sum += A[i + s*rx_N] * A[inner_idx - i + s*rx_N];
		d_conv_xy[idx] = my_sum;
	}
}

__global__ void compute_radial_profile
(float *img_array, float xc, float yc, float *r_sample, float *t_sample, int t_size, int r_size, float *radial_profile, int arraySize)
{
	const unsigned int idx = (blockIdx.x*blockDim.x) + threadIdx.x;
	const unsigned int idy = (blockIdx.y*blockDim.y) + threadIdx.y;
	int thread_idx = ((gridDim.x*blockDim.x)*idy) + idx;
	//int i = thread_idx / (arraySize*arraySize); 

	//int inner_thread_idx = thread_idx % (arraySize*arraySize);
	int id_r = thread_idx / t_size;
	int id_t = thread_idx % t_size;
	float x = xc + r_sample[id_r] * sin(t_sample[id_t]);
	float y = yc + r_sample[id_r] * cos(t_sample[id_t]);
	int x1 = (int)x;
	int y1 = (int)y;
	int x2 = x1 + 1;
	int y2 = y1 + 1;
	float rdp = img_array[y1*arraySize + x1] * ((float)x2 - x)*((float)y2 - y) + \
		img_array[y2*arraySize + x1] * ((float)x2 - x)*(y - (float)y1) + \
		img_array[y1*arraySize + x2] * (x - (float)x1)*((float)y2 - y) + \
		img_array[y2*arraySize + x2] * (x - (float)x1)*(y - (float)y1);
	float power_id = id_r / (float)r_size;

	float fall = 1.0 - exp(-(1.0 - power_id)*(1.0 - power_id) / 0.05);
	float rise = 1.0 - exp(-power_id*power_id / 0.01);
	float power = sqrt(fall*rise*power_id * 2.0);
	radial_profile[thread_idx] = rdp*power;

}