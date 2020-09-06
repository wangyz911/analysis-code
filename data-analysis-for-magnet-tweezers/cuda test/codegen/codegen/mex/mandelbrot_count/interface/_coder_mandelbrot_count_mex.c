/*
 * _coder_mandelbrot_count_mex.c
 *
 * Code generation for function '_coder_mandelbrot_count_mex'
 *
 */

/* Include files */
#include "mandelbrot_count.h"
#include "_coder_mandelbrot_count_mex.h"
#include "mandelbrot_count_terminate.h"
#include "_coder_mandelbrot_count_api.h"
#include "mandelbrot_count_initialize.h"
#include "mandelbrot_count_data.h"

/* Function Declarations */
static void mandelbrot_count_mexFunction(mandelbrot_countStackData *SD, int32_T
  nlhs, mxArray *plhs[1], int32_T nrhs, const mxArray *prhs[3]);

/* Function Definitions */
static void mandelbrot_count_mexFunction(mandelbrot_countStackData *SD, int32_T
  nlhs, mxArray *plhs[1], int32_T nrhs, const mxArray *prhs[3])
{
  int32_T n;
  const mxArray *inputs[3];
  const mxArray *outputs[1];
  int32_T b_nlhs;
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;

  /* Check for proper number of arguments. */
  if (nrhs != 3) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:WrongNumberOfInputs", 5, 12, 3, 4,
                        16, "mandelbrot_count");
  }

  if (nlhs > 1) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, 4, 16,
                        "mandelbrot_count");
  }

  /* Temporary copy for mex inputs. */
  for (n = 0; n < nrhs; n++) {
    inputs[n] = prhs[n];
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(&st);
    }
  }

  /* Call the function. */
  mandelbrot_count_api(SD, inputs, outputs);

  /* Copy over outputs to the caller. */
  if (nlhs < 1) {
    b_nlhs = 1;
  } else {
    b_nlhs = nlhs;
  }

  emlrtReturnArrays(b_nlhs, plhs, outputs);

  /* Module termination. */
  mandelbrot_count_terminate();
}

void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs, const mxArray
                 *prhs[])
{
  mandelbrot_countStackData *mandelbrot_countStackDataGlobal = NULL;
  mandelbrot_countStackDataGlobal = (mandelbrot_countStackData *)emlrtMxCalloc(1,
    1U * sizeof(mandelbrot_countStackData));
  mexAtExit(mandelbrot_count_atexit);

  /* Initialize the memory manager. */
  /* Module initialization. */
  mandelbrot_count_initialize();

  /* Dispatch the entry-point. */
  mandelbrot_count_mexFunction(mandelbrot_countStackDataGlobal, nlhs, plhs, nrhs,
    prhs);
  emlrtMxFree(mandelbrot_countStackDataGlobal);
}

emlrtCTX mexFunctionCreateRootTLS(void)
{
  emlrtCreateRootTLS(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1);
  return emlrtRootTLSGlobal;
}

/* End of code generation (_coder_mandelbrot_count_mex.c) */
