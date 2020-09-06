/*
 * File: _coder_cuda_1_api.h
 *
 * GPU Coder version                    : 1.0
 * CUDA/C/C++ source code generated on  : 23-Jul-2018 11:04:01
 */

#ifndef _CODER_CUDA_1_API_H
#define _CODER_CUDA_1_API_H

/* Include Files */
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"
#include <stddef.h>
#include <stdlib.h>
#include "_coder_cuda_1_api.h"

/* Variable Declarations */
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

/* Function Declarations */
#ifdef __cplusplus

extern "C" {

#endif

  extern void cuda_1(real_T x[1000000], real_T n, real_T y_data[], int32_T
                     y_size[2]);
  extern void cuda_1_api(const mxArray * const prhs[2], const mxArray *plhs[1]);
  extern void cuda_1_atexit(void);
  extern void cuda_1_initialize(void);
  extern void cuda_1_terminate(void);
  extern void cuda_1_xil_terminate(void);

#ifdef __cplusplus

}
#endif
#endif

/*
 * File trailer for _coder_cuda_1_api.h
 *
 * [EOF]
 */
