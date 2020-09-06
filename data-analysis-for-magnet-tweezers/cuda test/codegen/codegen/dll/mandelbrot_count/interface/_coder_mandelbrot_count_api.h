/*
 * File: _coder_mandelbrot_count_api.h
 *
 * GPU Coder version                    : 1.0
 * CUDA/C/C++ source code generated on  : 26-Dec-2017 22:57:54
 */

#ifndef _CODER_MANDELBROT_COUNT_API_H
#define _CODER_MANDELBROT_COUNT_API_H

/* Include Files */
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"
#include "xil_host_interface.h"
#include <stddef.h>
#include <stdlib.h>
#include "_coder_mandelbrot_count_api.h"

/* Variable Declarations */
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

/* Function Declarations */
#ifdef __cplusplus

extern "C" {

#endif

  extern void mandelbrot_countXilWrapper(real_T maxIterations, const real_T
    xGrid[1000000], const real_T yGrid[1000000], real_T count[1000000]);
  extern void mandelbrot_count_api(const mxArray * const prhs[3], const mxArray *
    plhs[1]);
  extern void mandelbrot_count_atexit(void);
  extern void mandelbrot_count_initialize(void);
  extern void mandelbrot_count_terminate(void);
  extern void mandelbrot_count_xil_terminate(void);
  extern void xil_terminate(void);

#ifdef __cplusplus

}
#endif
#endif

/*
 * File trailer for _coder_mandelbrot_count_api.h
 *
 * [EOF]
 */
