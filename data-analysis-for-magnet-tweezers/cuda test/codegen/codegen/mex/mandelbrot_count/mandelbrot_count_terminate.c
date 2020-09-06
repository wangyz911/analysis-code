/*
 * mandelbrot_count_terminate.c
 *
 * Code generation for function 'mandelbrot_count_terminate'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "mandelbrot_count.h"
#include "mandelbrot_count_terminate.h"
#include "_coder_mandelbrot_count_mex.h"
#include "mandelbrot_count_data.h"

/* Function Definitions */
void mandelbrot_count_atexit(void)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtEnterRtStackR2012b(&st);
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

void mandelbrot_count_terminate(void)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/* End of code generation (mandelbrot_count_terminate.c) */
