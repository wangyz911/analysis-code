#pragma once


#define _CRTDBG_MAP_ALLOC
#include <stdlib.h>
#include <crtdbg.h>


void cuda_QI(float *p_img, int arraySize, int n_stream, float *rdp_profile, float *xc, float *yc);

void cuda_QI2(float *p_img, int arraySize, int n_stream, float *rdp_profile, float *xc, float *yc);

void cuda_QI3(float *p_img, int arraySize, int n_stream, float *rdp_profile, float *xc, float *yc);