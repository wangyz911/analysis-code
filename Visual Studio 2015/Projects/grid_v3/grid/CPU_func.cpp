#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <conio.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>  // 用来复制数组
#include "device_functions.h"

#define PI 3.141592653

int compInc(const void *a, const void *b)
{
	return *(int *)a - *(int *)b;
}


// 下列函数用来计算xy 极坐标的常数部分
void compute_x_y(float *x_sample, float *y_sample, float r_step, int t_size, int r_N)
{

	// 抛弃了生成r和t 采样点的方案，改为直接生成极坐标矩阵，r_sample 和t_sample 随算随用，覆盖重用，节省空间。
	for (int i = 0; i < r_N; i++)
	{
		float r_sample = i*r_step;
		for (int j = 0; j < t_size; j++)
		{
			float t_sample = j*PI * 2 / t_size;
			x_sample[i*t_size + j] = r_sample * cos(t_sample);
			y_sample[i*t_size + j] = r_sample * sin(t_sample);
		}
	}

}
// 下列函数计算强度值power
void compute_power(float *power, int r_N)
{
	float fall, rise, power_id;
	for (int i = 0; i < r_N; i++)
	{
		power_id = (float)(i) / r_N;
		fall = 1.0 - exp(-(1.0 - power_id)*(1.0 - power_id) / 0.05);
		rise = 1.0 - exp(-power_id*power_id / 0.01);
		power[i] = sqrt(fall*rise*power_id * 2.0);
	}
}

void self_conv(const float *A, float *out, const int N)
{

	for (int j = N - 20; j < N + 20; j++)
	{
		float my_sum = 0;
		for (int i = 0; i < N; i++)
		{

			if (((j < N) && (i <= j)) || ((j >= N) && (i >(j - N)))) my_sum += A[i] * A[j - i];
			out[j] = my_sum;
		}
	}

	//// 多次使用下面的函数一定要初始化为0
	//memset(out, 0, (2 * N - 1) * sizeof(float));
	//for (int i = 0; i < N; ++i)
	//	for (int j = 0; j < N; ++j)
	//		out[i + j] += A[i] * A[j];

}


// 新创建一个计算均值的函数
void getMean_MN(float *img_mat, float *arrayMed, int len, int n_frame, int n_stream)
{
	for (int k = 0; k < n_stream; k++)
	{
		int s_offset = k*len*n_frame;

		for (int j = 0; j < n_frame; j++)
		{
			int offset = len*j;
			arrayMed[j + k*n_frame] = 0;
			for (int i = 0; i < len; i++)
			{
				arrayMed[j + k*n_frame] += img_mat[i + offset + s_offset];
			}
			arrayMed[j + k*n_frame] = arrayMed[j + k*n_frame] / len;
		}
	}
}

void getrdp_x_y(float *rdp_matrix, int r_N, int theta_num_perQ, float *rdp_all, float *rdp_x, float *rdp_y)
{
	size_t r_byte = sizeof(float)*r_N;
	float *rdp_1 = (float *)malloc(r_byte);
	float *rdp_2 = (float *)malloc(r_byte);
	float *rdp_3 = (float *)malloc(r_byte);
	float *rdp_4 = (float *)malloc(r_byte);

	for (int i = 0; i < r_N; i++)
	{
		rdp_1[i] = 0;
		rdp_2[i] = 0;
		rdp_3[i] = 0;
		rdp_4[i] = 0;

		for (int j = 0; j < theta_num_perQ; j++)
		{
			rdp_1[i] = rdp_1[i] + rdp_matrix[j + 4 * i*theta_num_perQ];

			rdp_2[i] = rdp_2[i] + rdp_matrix[j + 1 * theta_num_perQ + 4 * i*theta_num_perQ];

			rdp_3[i] = rdp_3[i] + rdp_matrix[j + 2 * theta_num_perQ + 4 * i*theta_num_perQ];

			rdp_4[i] = rdp_4[i] + rdp_matrix[j + 3 * theta_num_perQ + 4 * i*theta_num_perQ];
		};
		rdp_all[i] = (rdp_1[i] + rdp_2[i] + rdp_3[i] + rdp_4[i]) / (4 * theta_num_perQ);
	};

	for (int k = 0; k < (2 * r_N - 1); k++)
	{
		if (k < r_N - 1)
		{
			rdp_x[k] = (rdp_2[r_N - 1 - k] + rdp_3[r_N - 1 - k]) / theta_num_perQ;
			rdp_y[k] = (rdp_3[r_N - 1 - k] + rdp_4[r_N - 1 - k]) / theta_num_perQ;
		}
		else
		{
			rdp_x[k] = (rdp_1[k + 1 - r_N] + rdp_4[k + 1 - r_N]) / theta_num_perQ;
			rdp_y[k] = (rdp_1[k + 1 - r_N] + rdp_2[k + 1 - r_N]) / theta_num_perQ;
		}
	}

	free(rdp_1);
	rdp_1 = NULL;
	free(rdp_2);
	rdp_2 = NULL;
	free(rdp_3);
	rdp_3 = NULL;
	free(rdp_4);
	rdp_4 = NULL;


}

void get_rev_rdp(float *rdp, float *rdp_rev, int rdp_x_size)
{
	for (int i = 0; i < rdp_x_size; i++)
	{
		rdp_rev[i] = rdp[rdp_x_size - 1 - i];
	}
	return;
}

void rdp_corr(float *rdp, float *rdp_rev, float *rdp_corr, int N)
{
	float corr_ij;
	int    delay, i, j;

	for (delay = -N + 1; delay < N; delay++)
	{
		//Calculate the numerator
		corr_ij = 0;
		for (i = 0; i < N; i++)
		{
			j = i + delay;
			if ((j < 0) || (j >= N))  //The series are no wrapped,so the value is ignored
				continue;
			else
				corr_ij += (rdp[i] * rdp_rev[j]);
		}

		//Calculate the correlation series at "delay"
		rdp_corr[delay + N - 1] = corr_ij;
	}
}

float findpeak(float *rdp_corr, int N)
{
	float max = rdp_corr[0];
	int index = 0;
	for (int i = 0; i < N; i++)
	{
		if (max <= rdp_corr[i])
		{
			index = i;
			max = rdp_corr[i];
		}
		;
	}
	return index;
}

void getCentroid_MN(float *p_img, int arraySize, int n_frame, int n_stream, float *xc, float *yc)
{
	int LEN = arraySize*arraySize;
	int s_LEN = LEN*n_frame;
	float temp = 0;
	float A = 0;
	float *array_med3 = (float*)calloc(n_stream*n_frame, sizeof(float));  // 此处使用自带初始化为0 的calloc函数
	getMean_MN(p_img, array_med3, LEN, n_frame, n_stream);

	for (int k = 0; k<n_stream; k++)
	{
		int s_offset = k*n_frame*LEN;
		for (int i = 0; i < n_frame; i++)
		{
			int i_offset = i*LEN;
			temp = 0;
			A = 0;
			xc[i + k*n_frame] = 0;
			yc[i + k*n_frame] = 0;
			for (int j = 0; j < LEN; j++)
			{
				int arr_x = j % arraySize;
				int arr_y = j / arraySize;
				float temp = p_img[j + i_offset + s_offset] - array_med3[i + k*n_frame];
				temp = fabs(temp);
				A += temp;
				xc[i + k*n_frame] += (temp)*arr_x;
				yc[i + k*n_frame] += (temp)*arr_y;
			}
			xc[i + k*n_frame] = xc[i + k*n_frame] / A;
			yc[i + k*n_frame] = yc[i + k*n_frame] / A;
			//printf("the center of array is %f, %f\n", xc[i+k*n_frame], yc[i+ k*n_frame]);

		}
	}

	free(array_med3);
	//*array_med3 = NULL;


}

float LeastSquareGuassian(float *arr_x, float *arr_y, int arr_N)
{
	const int rank_ = 2;
	float atemp[2 * (rank_ + 1)] = { 0 }, b[rank_ + 1] = { 0 }, a[rank_ + 1][rank_ + 1];
	int i, j, k;

	for (i = 0; i < arr_N; i++) {  //
		atemp[1] += arr_x[i];
		atemp[2] += pow(arr_x[i], 2);
		atemp[3] += pow(arr_x[i], 3);
		atemp[4] += pow(arr_x[i], 4);
		//atemp[5] += pow(arr_x[i], 5);
		//atemp[6] += pow(arr_x[i], 6);
		b[0] += arr_y[i];
		b[1] += arr_x[i] * arr_y[i];
		b[2] += pow(arr_x[i], 2) * arr_y[i];
		//b[3] += pow(arr_x[i], 3) * arr_y[i];
	}

	atemp[0] = arr_N;
	/*
	for(i = 0; i <= 2 * rank_; i++)  printf("atemp[%d] = %f\n", i, atemp[i]);
	printf("\n");
	for(i = 0; i <= rank_; i++)  printf("b[%d] = %f\n", i, b[i]);
	printf("\n");
	*/
	for (i = 0; i < rank_ + 1; i++) {
		k = i;
		for (j = 0; j < rank_ + 1; j++)  a[i][j] = atemp[k++];
	}
	/*
	for(i = 0; i < rank_ + 1; i++){
	for(j = 0; j < rank_ + 1; j++)  printf("a[%d][%d] = %-17f  ", i, j, a[i][j]);
	printf("\n");
	}
	printf("\n");
	*/


	for (k = 0; k < rank_ + 1 - 1; k++) {
		int column = k;
		float mainelement = a[k][k];

		for (i = k; i < rank_ + 1; i++)
			if (fabs(a[i][k]) > mainelement) {
				mainelement = fabs(a[i][k]);
				column = i;
			}
		for (j = k; j < rank_ + 1; j++)
		{
			float atemp = a[k][j];
			a[k][j] = a[column][j];
			a[column][j] = atemp;
		}
		float btemp = b[k];
		b[k] = b[column];
		b[column] = btemp;

		for (i = k + 1; i < rank_ + 1; i++) {
			float Mik = a[i][k] / a[k][k];
			for (j = k; j < rank_ + 1; j++)  a[i][j] -= Mik * a[k][j];
			b[i] -= Mik * b[k];
		}
	}
	/*
	for(i = 0; i < rank_ + 1; i++){
	for(j = 0; j < rank_ + 1; j++)  printf("%20f", a[i][j]);
	printf("%20f\n", b[i]);
	}
	printf("\n");
	*/
	b[rank_ + 1 - 1] /= a[rank_ + 1 - 1][rank_ + 1 - 1];
	for (i = rank_ + 1 - 2; i >= 0; i--) {
		float sum = 0;
		for (j = i + 1; j < rank_ + 1; j++)  sum += a[i][j] * b[j];
		b[i] = (b[i] - sum) / a[i][i];
	}


	/*printf("P(x) = %f + %f x + %f x^2\n", b[0], b[1], b[2]);*/
	float detx = -b[1] / (2 * b[2]);
	return detx;


}

void getMean(float *img_mat, float *arrayMed, int len, int n_stream)
{
	for (int j = 0; j < n_stream; j++)
	{
		arrayMed[j] = 0;
		for (int i = j*len; i < (j + 1)*len; i++)
		{
			arrayMed[j] += img_mat[i];
		}
		arrayMed[j] = arrayMed[j] / len;
	}

}

void getCentroid(float *p_img, int arraySize, int n_stream, float *xc, float *yc)
{
	int LEN = arraySize*arraySize;
	float temp = 0;
	float A = 0;
	float *array_med3 = (float*)malloc(n_stream * sizeof(float));
	getMean(p_img, array_med3, LEN, n_stream);
	for (int i = 0; i < n_stream; i++)
	{
		int i_offset = i*LEN;
		temp = 0;
		A = 0;
		xc[i] = 0;
		yc[i] = 0;
		for (int j = i_offset; j < LEN + i_offset; j++)
		{
			int arr_x = (j - i_offset) % arraySize;
			int arr_y = (j - i_offset) / arraySize;
			float temp = p_img[j] - array_med3[i];
			temp = fabs(temp);
			A += temp;
			xc[i] += (temp)*arr_x;
			yc[i] += (temp)*arr_y;
		}
		xc[i] = xc[i] / A;
		yc[i] = yc[i] / A;
		//printf("the center of array is %f, %f\n", xc[i], yc[i]);

	}


	free(array_med3);
	array_med3 = NULL;
}