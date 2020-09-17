#pragma once
#include "stdafx.h"
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#define _CRTDBG_MAP_ALLOC
#include <stdlib.h>
#include <crtdbg.h>
#include <math.h>
int compInc(const void *a, const void *b);



// 下列函数用来计算xy 极坐标的常数部分
void compute_x_y(float *x_sample, float *y_sample, float r_step, int t_size, int r_N);

void compute_power(float *power, int r_N);

void self_conv(const float *A, float *out, const int N);

// 新创建一个计算均值的函数
void getMean_MN(float *img_mat, float *arrayMed, int len, int n_frame, int n_stream);

void getrdp_x_y(float* rdp_matrix, int r_N, int theta_num_perQ, float* rdp_all, float* rdp_x, float* rdp_y, float* power);
/*以下函数用来得到radial profile 的反转，为求互相关做准备*/
void get_rev_rdp(float *rdp, float *rdp_rev, int rdp_x_size);

/*以下函数用来计算两个序列的互相关曲线，其中rdp_corr是最终结果，N是rdp的大小*/
void rdp_corr(float *rdp, float *rdp_rev, float *rdp_corr, int N);


/*以下函数用来寻找曲线的峰值，返回其坐标位置*/
float findpeak(float *rdp_corr, int N);

/// 废物CPU函数
void getCentroid(float *p_img, int arraySize, int n_stream, float *xc, float *yc);



float LeastSquareGuassian(float *arr_x, float *arr_y, int arr_N);

void getCentroid_MN(float *p_img, int arraySize, int n_frame, int n_stream, float *xc, float *yc);

/*下列函数用于计算图像矩阵四个象限的radial profile*/
__global__ void compute_radial_profile_MN
(float *img_array, float *xc, float *yc, float *r_sample, float *t_sample, int t_size, int r_size, float *radial_profile, int arraySize);
// 本函数用来计算计算均值用的权重值
__global__ void compute_mean_rdp
(float *mean_rdp, float *d_radial_profile);

__global__ void compute_x_rdp
(float *d_radial_profile, float *d_x_rdp, int r_N, int thetaPerQ);

__global__ void compute_y_rdp
(float *d_radial_profile, float *d_y_rdp, int r_N, int thetaPerQ);

__global__ void conv_Kernelx(const float *A, float *d_conv_xy, const int rx_N, const int n_frame);

__global__ void conv_Kernely(const float *A, float *d_conv_xy, const int rx_N, const int n_frame);