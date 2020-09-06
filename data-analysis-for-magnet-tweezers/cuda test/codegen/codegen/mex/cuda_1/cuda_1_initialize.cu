/*
 * cuda_1_initialize.cu
 *
 * Code generation for function 'cuda_1_initialize'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "cuda_1.h"
#include "cuda_1_initialize.h"
#include "_coder_cuda_1_mex.h"
#include "cuda_1_data.h"

/* Function Definitions */
void cuda_1_initialize(void)
{
  mexFunctionCreateRootTLS();
  emlrtClearAllocCountR2012b(emlrtRootTLSGlobal, false, 0U, 0);
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (cuda_1_initialize.cu) */
