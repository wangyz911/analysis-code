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

//int compInc(const void *a, const void *b)
//{
//	return *(int *)a - *(int *)b;
//}
//
//__global__ void compute_radial_profile
//(float *img_array, float xc, float yc, float *r_sample, float *t_sample, int t_size, int r_size, float *radial_profile, int arraySize)
//{
//	const unsigned int idx = (blockIdx.x*blockDim.x) + threadIdx.x;
//	const unsigned int idy = (blockIdx.y*blockDim.y) + threadIdx.y;
//	int thread_idx = ((gridDim.x*blockDim.x)*idy) + idx;
//	//int i = thread_idx / (arraySize*arraySize); 
//
//	//int inner_thread_idx = thread_idx % (arraySize*arraySize);
//	int id_r = thread_idx / t_size;
//	int id_t = thread_idx % t_size;
//	float x = xc + r_sample[id_r] * sin(t_sample[id_t]);
//	float y = yc + r_sample[id_r] * cos(t_sample[id_t]);
//	int x1 = (int)x;
//	int y1 = (int)y;
//	int x2 = x1 + 1;
//	int y2 = y1 + 1;
//	float rdp = img_array[y1*arraySize + x1] * ((float)x2 - x)*((float)y2 - y) + \
//		img_array[y2*arraySize + x1] * ((float)x2 - x)*(y - (float)y1) + \
//		img_array[y1*arraySize + x2] * (x - (float)x1)*((float)y2 - y) + \
//		img_array[y2*arraySize + x2] * (x - (float)x1)*(y - (float)y1);
//	float power_id = (float)(id_r) / r_size;
//
//	float fall = 1.0 - exp(-(1.0 - power_id)*(1.0 - power_id) / 0.05);
//	float rise = 1.0 - exp(-power_id*power_id / 0.01);
//	float power = sqrt(fall*rise*power_id * 2.0);
//	radial_profile[thread_idx] = rdp*power;
//
//}
//
///*下列函数用于计算图像矩阵四个象限的radial profile*/
//__global__ void compute_radial_profile_MN
//(float *img_array, float *xc, float *yc, float *r_sample, float *t_sample, int t_size, int r_size, float *radial_profile, int arraySize)
//{
//	const unsigned int idx = (blockIdx.x*blockDim.x) + threadIdx.x;
//	const unsigned int idy = (blockIdx.y*blockDim.y) + threadIdx.y;
//	int thread_idx = ((gridDim.x*blockDim.x)*idy) + idx;
//	int s = thread_idx / (r_size*t_size);  //用i 来判断是第几张图的数据，然后选取不同的质心坐标
//	int img_offset = s*arraySize*arraySize;
//	int r_offset = s*r_size;
//	int t_offset = s*t_size;
//	int inner_thread_idx = thread_idx % (r_size*t_size);
//	int id_r = inner_thread_idx / t_size;
//	int id_t = inner_thread_idx % t_size;
//	float x = xc[s] + r_sample[id_r + r_offset] * sin(t_sample[id_t + t_offset]);
//	float y = yc[s] + r_sample[id_r + r_offset] * cos(t_sample[id_t + t_offset]);
//	int x1 = (int)x;
//	int y1 = (int)y;
//	int x2 = x1 + 1;
//	int y2 = y1 + 1;
//	float rdp =
//		img_array[y1*arraySize + x1 + img_offset] * ((float)x2 - x)*((float)y2 - y) + \
//		img_array[y2*arraySize + x1 + img_offset] * ((float)x2 - x)*(y - (float)y1) + \
//		img_array[y1*arraySize + x2 + img_offset] * (x - (float)x1)*((float)y2 - y) + \
//		img_array[y2*arraySize + x2 + img_offset] * (x - (float)x1)*(y - (float)y1);
//	float power_id = (float)(id_r) / r_size;
//
//	float fall = 1.0 - exp(-(1.0 - power_id)*(1.0 - power_id) / 0.05);
//	float rise = 1.0 - exp(-power_id*power_id / 0.01);
//	float power = sqrt(fall*rise*power_id * 2.0);
//	radial_profile[thread_idx] = rdp*power;
//
//
//}
//
//
//
//void getMean(float *img_mat, float *arrayMed, int len, int n_stream)
//{
//	for (int j = 0; j < n_stream; j++)
//	{
//		arrayMed[j] = 0;
//		for (int i = j*len; i < (j + 1)*len; i++)
//		{
//			arrayMed[j] += img_mat[i];
//		}
//		arrayMed[j] = arrayMed[j] / len;
//	}
//
//}
//
//void getMean_MN(float *img_mat, float *arrayMed, int len, int n_frame, int n_stream)
//{
//	for (int k = 0; k < n_stream; k++)
//	{
//		int s_offset = k*len*n_frame;
//
//		for (int j = 0; j < n_frame; j++)
//		{
//			int offset = len*j;
//			arrayMed[j + k*n_frame] = 0;
//			for (int i = 0; i < len; i++)
//			{
//				arrayMed[j + k*n_frame] += img_mat[i + offset + s_offset];
//			}
//			arrayMed[j + k*n_frame] = arrayMed[j + k*n_frame] / len;
//		}
//	}
//}
///* 以下函数根据radial profile 矩阵直接计算x方向上的radial profile 和Y 方向上的radial profile */
//
//void getrdp_x_y(float *rdp_matrix, int r_N, int theta_num_perQ, float *rdp_all, float *rdp_x, float *rdp_y)
//{
//	size_t r_byte = sizeof(float)*r_N;
//	float *rdp_1 = (float *)malloc(r_byte);
//	float *rdp_2 = (float *)malloc(r_byte);
//	float *rdp_3 = (float *)malloc(r_byte);
//	float *rdp_4 = (float *)malloc(r_byte);
//
//	for (int i = 0; i < r_N; i++)
//	{
//		rdp_1[i] = 0;
//		rdp_2[i] = 0;
//		rdp_3[i] = 0;
//		rdp_4[i] = 0;
//
//		for (int j = 0; j < theta_num_perQ; j++)
//		{
//			rdp_1[i] = rdp_1[i] + rdp_matrix[j + 4 * i*theta_num_perQ];
//
//			rdp_2[i] = rdp_2[i] + rdp_matrix[j + 1 * theta_num_perQ + 4 * i*theta_num_perQ];
//
//			rdp_3[i] = rdp_3[i] + rdp_matrix[j + 2 * theta_num_perQ + 4 * i*theta_num_perQ];
//
//			rdp_4[i] = rdp_4[i] + rdp_matrix[j + 3 * theta_num_perQ + 4 * i*theta_num_perQ];
//		};
//		rdp_all[i] = (rdp_1[i] + rdp_2[i] + rdp_3[i] + rdp_4[i]) / (200 * theta_num_perQ);
//	};
//
//	for (int k = 0; k < (2 * r_N - 1); k++)
//	{
//		if (k < r_N - 1)
//		{
//			rdp_x[k] = (rdp_2[r_N - 1 - k] + rdp_3[r_N - 1 - k]) / 100;
//			rdp_y[k] = (rdp_3[r_N - 1 - k] + rdp_4[r_N - 1 - k]) / 100;
//		}
//		else
//		{
//			rdp_x[k] = (rdp_1[k + 1 - r_N] + rdp_4[k + 1 - r_N]) / 100;
//			rdp_y[k] = (rdp_1[k + 1 - r_N] + rdp_2[k + 1 - r_N]) / 100;
//		}
//	}
//	free(rdp_1);
//	rdp_1 = NULL;
//	free(rdp_2);
//	rdp_2 = NULL;
//	free(rdp_3);
//	rdp_3 = NULL;
//	free(rdp_4);
//	rdp_4 = NULL;
//
//
//}
//
//void get_rev_rdp(float *rdp, float *rdp_rev, int rdp_x_size)
//{
//	for (int i = 0; i < rdp_x_size; i++)
//	{
//		rdp_rev[i] = rdp[rdp_x_size - 1 - i];
//	}
//	return;
//}
//
//void rdp_corr(float *rdp, float *rdp_rev, float *rdp_corr, int N)
//{
//	float corr_ij;
//	int    delay, i, j;
//
//	for (delay = -N + 1; delay < N; delay++)
//	{
//		//Calculate the numerator
//		corr_ij = 0;
//		for (i = 0; i < N; i++)
//		{
//			j = i + delay;
//			if ((j < 0) || (j >= N))  //The series are no wrapped,so the value is ignored
//				continue;
//			else
//				corr_ij += (rdp[i] * rdp_rev[j]);
//		}
//
//		//Calculate the correlation series at "delay"
//		rdp_corr[delay + N - 1] = corr_ij;
//	}
//}
//
//float findpeak(float *rdp_corr, int N)
//{
//	float max = rdp_corr[0];
//	int index = 0;
//	for (int i = 0; i < N; i++)
//	{
//		if (max <= rdp_corr[i])
//		{
//			index = i;
//			max = rdp_corr[i];
//		}
//		;
//	}
//	return index;
//}
//
//float LeastSquareGuassian(float *arr_x, float *arr_y, int arr_N)
//{
//	const int rank_ = 2;
//	float atemp[2 * (rank_ + 1)] = { 0 }, b[rank_ + 1] = { 0 }, a[rank_ + 1][rank_ + 1];
//	int i, j, k;
//
//	for (i = 0; i < arr_N; i++) {  //
//		atemp[1] += arr_x[i];
//		atemp[2] += pow(arr_x[i], 2);
//		atemp[3] += pow(arr_x[i], 3);
//		atemp[4] += pow(arr_x[i], 4);
//		//atemp[5] += pow(arr_x[i], 5);
//		//atemp[6] += pow(arr_x[i], 6);
//		b[0] += arr_y[i];
//		b[1] += arr_x[i] * arr_y[i];
//		b[2] += pow(arr_x[i], 2) * arr_y[i];
//		//b[3] += pow(arr_x[i], 3) * arr_y[i];
//	}
//
//	atemp[0] = arr_N;
//	/*
//	for(i = 0; i <= 2 * rank_; i++)  printf("atemp[%d] = %f\n", i, atemp[i]);
//	printf("\n");
//	for(i = 0; i <= rank_; i++)  printf("b[%d] = %f\n", i, b[i]);
//	printf("\n");
//	*/
//	for (i = 0; i < rank_ + 1; i++) {
//		k = i;
//		for (j = 0; j < rank_ + 1; j++)  a[i][j] = atemp[k++];
//	}
//	/*
//	for(i = 0; i < rank_ + 1; i++){
//	for(j = 0; j < rank_ + 1; j++)  printf("a[%d][%d] = %-17f  ", i, j, a[i][j]);
//	printf("\n");
//	}
//	printf("\n");
//	*/
//
//
//	for (k = 0; k < rank_ + 1 - 1; k++) {
//		int column = k;
//		float mainelement = a[k][k];
//
//		for (i = k; i < rank_ + 1; i++)
//			if (fabs(a[i][k]) > mainelement) {
//				mainelement = fabs(a[i][k]);
//				column = i;
//			}
//		for (j = k; j < rank_ + 1; j++)
//		{  
//			float atemp = a[k][j];
//			a[k][j] = a[column][j];
//			a[column][j] = atemp;
//		}
//		float btemp = b[k];
//		b[k] = b[column];
//		b[column] = btemp;
//
//		for (i = k + 1; i < rank_ + 1; i++) {
//			float Mik = a[i][k] / a[k][k];
//			for (j = k; j < rank_ + 1; j++)  a[i][j] -= Mik * a[k][j];
//			b[i] -= Mik * b[k];
//		}
//	}
//	/*
//	for(i = 0; i < rank_ + 1; i++){
//	for(j = 0; j < rank_ + 1; j++)  printf("%20f", a[i][j]);
//	printf("%20f\n", b[i]);
//	}
//	printf("\n");
//	*/
//	b[rank_ + 1 - 1] /= a[rank_ + 1 - 1][rank_ + 1 - 1];
//	for (i = rank_ + 1 - 2; i >= 0; i--) {
//		float sum = 0;
//		for (j = i + 1; j < rank_ + 1; j++)  sum += a[i][j] * b[j];
//		b[i] = (b[i] - sum) / a[i][i];
//	}
//
//
//	/*printf("P(x) = %f + %f x + %f x^2\n", b[0], b[1], b[2]);*/
//	float detx = -b[1] / (2 * b[2]);
//	return detx;
//
//
//}
//
//void getCentroid(float *p_img, int arraySize, int n_stream, float *xc, float *yc)
//{
//	int LEN = arraySize*arraySize;
//	float temp = 0;
//	float A = 0;
//	float *array_med3 = (float*)malloc(n_stream * sizeof(float));
//	getMean(p_img, array_med3, LEN, n_stream);
//	for (int i = 0; i < n_stream; i++)
//	{
//		int i_offset = i*LEN;
//		temp = 0;
//		A = 0;
//		xc[i] = 0;
//		yc[i] = 0;
//		for (int j = i_offset; j < LEN + i_offset; j++)
//		{
//			int arr_x = (j - i_offset) % arraySize;
//			int arr_y = (j - i_offset) / arraySize;
//			float temp = p_img[j] - array_med3[i];
//			temp = fabs(temp);
//			A += temp;
//			xc[i] += (temp)*arr_x;
//			yc[i] += (temp)*arr_y;
//		}
//		xc[i] = xc[i] / A;
//		yc[i] = yc[i] / A;
//		//printf("the center of array is %f, %f\n", xc[i], yc[i]);
//
//	}
//
//
//	free(array_med3);
//	array_med3 = NULL;
//}
//
//void getCentroid_MN(float *p_img, int arraySize, int n_frame, int n_stream, float *xc, float *yc)
//{
//	int LEN = arraySize*arraySize;
//	int s_LEN = LEN*n_frame;
//	float temp = 0;
//	float A = 0;
//	float *array_med3 = (float*)calloc(n_stream*n_frame, sizeof(float));  // 此处使用自带初始化为0 的calloc函数
//	getMean_MN(p_img, array_med3, LEN, n_frame, n_stream);
//
//	for (int k = 0; k<n_stream; k++)
//	{
//		int s_offset = k*n_frame*LEN;
//		for (int i = 0; i < n_frame; i++)
//		{
//			int i_offset = i*LEN;
//			temp = 0;
//			A = 0;
//			xc[i + k*n_frame] = 0;
//			yc[i + k*n_frame] = 0;
//			for (int j = 0; j < LEN; j++)
//			{
//				int arr_x = j % arraySize;
//				int arr_y = j / arraySize;
//				float temp = p_img[j + i_offset + s_offset] - array_med3[i + k*n_frame];
//				temp = fabs(temp);
//				A += temp;
//				xc[i + k*n_frame] += (temp)*arr_x;
//				yc[i + k*n_frame] += (temp)*arr_y;
//			}
//			xc[i + k*n_frame] = xc[i + k*n_frame] / A;
//			yc[i + k*n_frame] = yc[i + k*n_frame] / A;
//			//printf("the center of array is %f, %f\n", xc[i+k*n_frame], yc[i+ k*n_frame]);
//
//		}
//	}
//
//	free(array_med3);
//	//*array_med3 = NULL;
//
//
//}

// Texture reference for 2D float texture
texture<float, 2, cudaReadModeElementType> tex;

__global__ void compute_radial_profile_tex
(const float *d_xc, const float *d_yc,const float *d_x_sample, const float *d_y_sample,const float *power,const int t_size,const int r_size, float *d_radial_profile, const int arraySize,const int s_img_offset)
{
	const unsigned int idx = (blockIdx.x*blockDim.x) + threadIdx.x;
	const unsigned int idy = (blockIdx.y*blockDim.y) + threadIdx.y;
	int thread_idx = ((gridDim.x*blockDim.x)*idy) + idx;
	int s = thread_idx / (r_size*t_size);  //用i 来判断是第几张图的数据，然后选取不同的质心坐标 这里不应该加1
	int img_offset = s*arraySize*arraySize;
	int inner_thread_idx = thread_idx % (r_size*t_size);
	int p_id = inner_thread_idx / t_size;
	float x = d_xc[s] + d_x_sample[inner_thread_idx];
	float y = d_yc[s] + d_y_sample[inner_thread_idx] + s*arraySize+s_img_offset;
	float p = power[p_id];
	d_radial_profile[thread_idx] = tex2D(tex, x + 0.5f, y + 0.5f)*p;
	//d_check[thread_idx] = d_radial_profile[thread_idx];
}






bool cuda_QI4(float img_mat_4d[][5][50][50], int arraySize, int n_frame, int n_stream, float rdp_array[][5][50], float xc_array[][5], float yc_array[][5], float rdp_mean[][50])
{

	size_t img_bytes = arraySize*arraySize * sizeof(float);   // 矩阵元素所占空间
	size_t f_bytes = sizeof(float);

	//cudaStream_t *streams = (cudaStream_t *)malloc(n_stream * sizeof(cudaStream_t));

	int LEN = arraySize*arraySize;                            // 图像矩阵元素数
	//int s_LEN = LEN*n_frame;

	// 调用getCentroid 函数计算n_stream 张图的质心xc,yc
	float *p_img_4d = &img_mat_4d[0][0][0][0];
	float *rdp_profile = &rdp_array[0][0][0];
	float *xc = &xc_array[0][0];
	float *yc = &yc_array[0][0];
	float *p_rdp_mean = &rdp_mean[0][0];
	//getCentroid_MN(p_img_4d, arraySize, n_frame, n_stream, xc, yc);

	/// 接下来实现QI算法  
	// 先定义相关的变量；
	float r_step = 0.4;
	int thetaPerQ = 4;
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
	size_t rdpxy_byte = (r_N * 2 - 1) *n_frame*n_stream * sizeof(float);
	size_t s_rdpxy_byte = (r_N * 2 - 1) *n_frame * sizeof(float);
	float *rdp_x = (float *)malloc(rdpxy_byte);
	float *rdp_y = (float *)malloc(rdpxy_byte);

	//// 接下来取rdp_x 的反，调用两次反向函数。
	//float *rdp_x_rev = (float *)malloc(rdpxy_byte);
	//float *rdp_y_rev = (float *)malloc(rdpxy_byte);

	// 接下来进行互相关计算，
	size_t corr_bytes = (r_N * 4 - 3) * sizeof(float);
	float *rdp_x_corr = (float*)malloc(corr_bytes);
	float *rdp_y_corr = (float*)malloc(corr_bytes);
	memset(rdp_x_corr, 0, corr_bytes);
	memset(rdp_y_corr, 0, corr_bytes);


	for (int j = 0; j < 3; j++)
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
			int s_img_offset = i*n_frame*arraySize;
			int s_rdp_offset = i*n_frame*r_N*t_size;
			compute_radial_profile_tex << <grid2, block2, 0, streams[i] >> >
				(d_xc + s_xy_offset, d_yc + s_xy_offset, d_x_sample, d_y_sample, d_power, t_size, r_N, d_radial_profile + s_rdp_offset, arraySize, s_img_offset);


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

	return true;
}
