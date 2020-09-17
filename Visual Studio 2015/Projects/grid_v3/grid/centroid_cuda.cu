#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <conio.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>  


#define PI 3.141592653
#define BLK_DIM 256
#define CHECK(call)  \
     { const cudaError_t error = call;         \
       if (error != cudaSuccess) {            \
            printf("Error:%s:%d, ",__FILE__,__LINE__);  \
            printf("code:%d, reason:%s\n",error,cudaGetErrorString(error)); \
            exit(1);     \
          }}

int compInc(const void *a, const void *b);
//{
//	return *(int *)a - *(int *)b;
//}

__global__ void compute_radial_profile
(float *img_array, float xc, float yc, float *r_sample, float *t_sample, int t_size, int r_size, float *radial_profile, int arraySize);
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
//	float power_id = id_r/ (float)r_size;
//
//	float fall = 1.0 - exp(-(1.0 - power_id)*(1.0 - power_id) / 0.05);
//	float rise = 1.0 - exp(-power_id*power_id / 0.01);
//	float power = sqrt(fall*rise*power_id * 2.0);
//	radial_profile[thread_idx] = rdp*power;
//
//}

void getMean(float *img_mat, float *arrayMed, int len, int n_stream);
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



void getrdp_x_y(float *rdp_matrix, int r_N, int theta_num_perQ, float *rdp_all, float *rdp_x, float *rdp_y);
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
//		rdp_all[i] = (rdp_1[i] + rdp_2[i] + rdp_3[i] + rdp_4[i]) / (4*theta_num_perQ);
//	};
//
//	for (int k = 0; k < (2 * r_N - 1); k++)
//	{
//		if (k < r_N - 1)
//		{
//			rdp_x[k] = (rdp_2[r_N - 1 - k] + rdp_3[r_N - 1 - k])/theta_num_perQ;
//			rdp_y[k] = (rdp_3[r_N - 1 - k] + rdp_4[r_N - 1 - k])/theta_num_perQ;
//		}
//		else
//		{
//			rdp_x[k] = (rdp_1[k + 1 - r_N] + rdp_4[k + 1 - r_N]) /theta_num_perQ;
//			rdp_y[k] = (rdp_1[k + 1 - r_N] + rdp_2[k + 1 - r_N]) /theta_num_perQ;
//		}
//	}
//
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

void get_rev_rdp(float *rdp, float *rdp_rev, int rdp_x_size);
//{
//	for (int i = 0; i < rdp_x_size; i++)
//	{
//		rdp_rev[i] = rdp[rdp_x_size - 1 - i];
//	}
//	return;
//}

void rdp_corr(float *rdp, float *rdp_rev, float *rdp_corr, int N);
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

float findpeak(float *rdp_corr, int N);
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

float LeastSquareGuassian(float *arr_x, float *arr_y, int arr_N);
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

void getCentroid(float *p_img, int arraySize, int n_stream, float *xc, float *yc);
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





void cuda_QI(float *p_img, int arraySize, int n_stream, float *rdp_profile, float *xc, float *yc)
{
	size_t img_bytes = arraySize*arraySize * sizeof(float);
	size_t f_bytes = sizeof(float);

	cudaStream_t *streams = (cudaStream_t *)malloc(n_stream * sizeof(cudaStream_t));

	int LEN = arraySize*arraySize;

	//float *p_img = &img_mat[0][0][0];
	getCentroid(p_img, arraySize, n_stream, xc, yc);

	float r_step = 0.4;
	int theta_num_perQ = 8;
	int t_size = theta_num_perQ * 4;
	int r_max = arraySize / 2 - 2;
	int r_N = r_max / r_step;

	int rdp_LEN = r_N*t_size;
	const dim3 block2(BLK_DIM);
	const dim3 grid2((rdp_LEN + block2.x - 1) / block2.x, 1);

	size_t r_bytes = r_N * sizeof(float);
	size_t t_bytes = theta_num_perQ * 4 * sizeof(float);
	float *r_sample = (float *)malloc(r_bytes);
	float *t_sample = (float *)malloc(t_bytes);
	for (int i = 0; i < r_N; i++)
	{
		r_sample[i] = i*r_step;
	}
	for (int i = 0; i < theta_num_perQ * 4; i++)
	{
		t_sample[i] = i*PI * 2 / (theta_num_perQ * 4);
	}

	size_t rdp_bytes = r_N*theta_num_perQ * 4 * sizeof(float);
	float * radial_profile = (float *)malloc(rdp_bytes*n_stream);
	float *d_radial_profile = NULL;
	float *d_r_sample = NULL;
	float *d_t_sample = NULL;
	float *d_img_mat = NULL;

	CHECK(cudaMallocHost(&d_radial_profile, rdp_bytes*n_stream));
	CHECK(cudaMallocHost(&d_r_sample, r_bytes));
	CHECK(cudaMallocHost(&d_t_sample, t_bytes));
	CHECK(cudaMallocHost(&d_img_mat, img_bytes*n_stream));

	for (int i = 0; i < n_stream; i++)
	{
		CHECK(cudaStreamCreate(&streams[i]));
	}

	for (int i = 0; i < n_stream; i++)
	{
		int offset = i*LEN;
		CHECK(cudaMemcpyAsync(d_r_sample, r_sample, r_bytes, cudaMemcpyHostToDevice, streams[i]));
		CHECK(cudaMemcpyAsync(d_t_sample, t_sample, t_bytes, cudaMemcpyHostToDevice, streams[i]));
		CHECK(cudaMemcpyAsync(d_img_mat + offset, p_img + offset, img_bytes, cudaMemcpyHostToDevice, streams[i]));
	}

	size_t rdpxy_byte = (r_N*theta_num_perQ * 4 * 2 - 1) * sizeof(float);
	float *rdp_x = (float *)malloc(rdpxy_byte);
	float *rdp_y = (float *)malloc(rdpxy_byte);

	float *rdp_x_rev = (float *)malloc(rdpxy_byte);
	float *rdp_y_rev = (float *)malloc(rdpxy_byte);

	size_t corr_bytes = (r_N*theta_num_perQ * 4 * 4 - 3) * sizeof(float);
	float *rdp_x_corr = (float*)malloc(corr_bytes);
	float *rdp_y_corr = (float*)malloc(corr_bytes);

	for (int j = 0; j < 3; j++)
	{
		for (int i = 0; i < n_stream; i++)
		{
			int offset = i*LEN;
			int rdp_offset = i*r_N*theta_num_perQ * 4;
			int xy_offset = i;

			compute_radial_profile << <grid2.x, block2, 0, streams[i] >> >
				(d_img_mat + offset, *(yc + xy_offset), *(xc + xy_offset), d_r_sample, d_t_sample, t_size, r_N, d_radial_profile + rdp_offset, arraySize);
		}
		for (int i = 0; i < n_stream; i++)
		{
			CHECK(cudaStreamSynchronize(streams[i]));
		}

		for (int i = 0; i < n_stream; i++)
		{
			int rdp_offset = i*r_N*theta_num_perQ * 4;
			CHECK(cudaMemcpyAsync(radial_profile + rdp_offset, d_radial_profile + rdp_offset, rdp_bytes, cudaMemcpyDeviceToHost, streams[i]));
		}

		for (int i = 0; i < n_stream; i++)
		{
			int rdp_offset = i*r_N*theta_num_perQ * 4;

			getrdp_x_y(radial_profile + rdp_offset, r_N, theta_num_perQ, rdp_profile, rdp_x, rdp_y);

			get_rev_rdp(rdp_x, rdp_x_rev, 2 * r_N - 1);
			get_rev_rdp(rdp_y, rdp_y_rev, 2 * r_N - 1);

			rdp_corr(rdp_x, rdp_x_rev, rdp_x_corr, r_N * 2 - 1);
			rdp_corr(rdp_y, rdp_y_rev, rdp_y_corr, r_N * 2 - 1);

			int pkx, pky;
			pkx = findpeak(rdp_x_corr, r_N * 4 - 3);
			pky = findpeak(rdp_y_corr, r_N * 4 - 3);

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

			float detx = LeastSquareGuassian(pkx_index, pkx_value, 5);
			float dety = LeastSquareGuassian(pky_index, pky_value, 5);

			xc[i] = xc[i] - 2 * detx / PI;
			yc[i] = yc[i] - 2 * dety / PI;
		}
	}

	for (int i = 0; i < n_stream; i++)
	{
		CHECK(cudaStreamDestroy(streams[i]));
	}
	free(r_sample);
	r_sample = NULL;
	free(t_sample);
	t_sample = NULL;
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


	CHECK(cudaFreeHost(d_radial_profile));
	CHECK(cudaFreeHost(d_r_sample));
	CHECK(cudaFreeHost(d_t_sample));
	CHECK(cudaFreeHost(d_img_mat));


}
