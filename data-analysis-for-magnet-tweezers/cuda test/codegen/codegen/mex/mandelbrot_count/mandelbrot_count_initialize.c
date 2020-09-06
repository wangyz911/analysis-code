/*
 * mandelbrot_count_initialize.c
 *
 * Code generation for function 'mandelbrot_count_initialize'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "mandelbrot_count.h"
#include "mandelbrot_count_initialize.h"
#include "_coder_mandelbrot_count_mex.h"
#include "mandelbrot_count_data.h"

/* Function Definitions */
void mandelbrot_count_initialize(void)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  mexFunctionCreateRootTLS();
  emlrtBreakCheckR2012bFlagVar = emlrtGetBreakCheckFlagAddressR2012b();
  st.tls = emlrtRootTLSGlobal;
  emlrtClearAllocCountR2012b(&st, false, 0U, 0);
  emlrtEnterRtStackR2012b(&st);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (mandelbrot_count_initialize.c) */
