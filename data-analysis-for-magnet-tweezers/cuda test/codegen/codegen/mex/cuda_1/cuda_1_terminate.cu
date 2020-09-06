/*
 * cuda_1_terminate.cu
 *
 * Code generation for function 'cuda_1_terminate'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "cuda_1.h"
#include "cuda_1_terminate.h"
#include "_coder_cuda_1_mex.h"
#include "cuda_1_data.h"

/* Function Definitions */
void cuda_1_atexit(void)
{
  mexFunctionCreateRootTLS();
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtLeaveRtStackR2012b(emlrtRootTLSGlobal);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

void cuda_1_terminate(void)
{
  emlrtLeaveRtStackR2012b(emlrtRootTLSGlobal);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/* End of code generation (cuda_1_terminate.cu) */
