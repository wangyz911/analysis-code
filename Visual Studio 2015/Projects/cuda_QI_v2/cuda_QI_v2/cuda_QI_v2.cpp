// cuda_QI_v2.cpp : ���� DLL Ӧ�ó���ĵ���������
//

#include "stdafx.h"

bool cuda_QI4(float img_mat_4d[][5][50][50], int arraySize, int n_frame, int n_stream, float rdp_array[][5][57], float xc_array[][5], float yc_array[][5],float rdp_mean[][57]);

extern "C" _declspec(dllexport) bool cuda_QI4_main(float img_mat_4d[][5][50][50], int arraySize, int n_frame, int n_stream, float rdp_array[][5][57], float xc_array[][5], float yc_array[][5],float rdp_mean[][57])
{
	return cuda_QI4(img_mat_4d, arraySize,n_frame, n_stream,rdp_array, xc_array, yc_array,rdp_mean);
}


