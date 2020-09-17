#pragma once
#include "stdafx.h"
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#define _CRTDBG_MAP_ALLOC
#include <stdlib.h>
#include <crtdbg.h>
#include <math.h>
int compInc(const void *a, const void *b);



// ���к�����������xy ������ĳ�������
void compute_x_y(float *x_sample, float *y_sample, float r_step, int t_size, int r_N);

void compute_power(float *power, int r_N);

void self_conv(const float *A, float *out, const int N);

// �´���һ�������ֵ�ĺ���
void getMean_MN(float *img_mat, float *arrayMed, int len, int n_frame, int n_stream);

void getrdp_x_y(float *rdp_matrix, int r_N, int theta_num_perQ, float *rdp_all, float *rdp_x, float *rdp_y);

/*���º��������õ�radial profile �ķ�ת��Ϊ�������׼��*/
void get_rev_rdp(float *rdp, float *rdp_rev, int rdp_x_size);

/*���º������������������еĻ�������ߣ�����rdp_corr�����ս����N��rdp�Ĵ�С*/
void rdp_corr(float *rdp, float *rdp_rev, float *rdp_corr, int N);


/*���º�������Ѱ�����ߵķ�ֵ������������λ��*/
float findpeak(float *rdp_corr, int N);

/// ����CPU����
void getCentroid(float *p_img, int arraySize, int n_stream, float *xc, float *yc);



float LeastSquareGuassian(float *arr_x, float *arr_y, int arr_N);

void getCentroid_MN(float *p_img, int arraySize, int n_frame, int n_stream, float *xc, float *yc);

/*���к������ڼ���ͼ������ĸ����޵�radial profile*/
__global__ void compute_radial_profile_MN
(float *img_array, float *xc, float *yc, float *r_sample, float *t_sample, int t_size, int r_size, float *radial_profile, int arraySize);
// ������������������ֵ�õ�Ȩ��ֵ
__global__ void compute_mean_rdp
(float *mean_rdp, float *d_radial_profile);

__global__ void compute_x_rdp
(float *d_radial_profile, float *d_x_rdp, int r_N, int thetaPerQ);

__global__ void compute_y_rdp
(float *d_radial_profile, float *d_y_rdp, int r_N, int thetaPerQ);

__global__ void conv_Kernelx(const float *A, float *d_conv_xy, const int rx_N, const int n_frame);

__global__ void conv_Kernely(const float *A, float *d_conv_xy, const int rx_N, const int n_frame);