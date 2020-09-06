/*
 * mandelbrot_count.c
 *
 * Code generation for function 'mandelbrot_count'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "mandelbrot_count.h"
#include "abs.h"
#include "log.h"
#include "mandelbrot_count_data.h"

/* Variable Definitions */
static emlrtRSInfo emlrtRSI = { 15,    /* lineNo */
  "mandelbrot_count",                  /* fcnName */
  "E:\\analysis code\\data-analysis-for-magnet-tweezers\\cuda test\\mandelbrot_count.m"/* pathName */
};

static emlrtRTEInfo emlrtRTEI = { 10,  /* lineNo */
  9,                                   /* colNo */
  "mandelbrot_count",                  /* fName */
  "E:\\analysis code\\data-analysis-for-magnet-tweezers\\cuda test\\mandelbrot_count.m"/* pName */
};

/* Function Definitions */
void mandelbrot_count(mandelbrot_countStackData *SD, const emlrtStack *sp,
                      real_T maxIterations, const real_T xGrid[1000000], const
                      real_T yGrid[1000000], real_T count[1000000])
{
  int32_T i0;
  int32_T n;
  real_T z_im;
  emlrtStack st;
  st.prev = sp;
  st.tls = sp->tls;

  /*  mandelbrot computation */
  /*  Add Kernelfun pragma to trigger kernel creation */
  for (i0 = 0; i0 < 1000000; i0++) {
    SD->f0.z0[i0].re = xGrid[i0] + 0.0 * yGrid[i0];
    SD->f0.z0[i0].im = yGrid[i0];
    count[i0] = 1.0;
    SD->f0.z[i0] = SD->f0.z0[i0];
  }

  emlrtForLoopVectorCheckR2012b(0.0, 1.0, maxIterations, mxDOUBLE_CLASS,
    (int32_T)(maxIterations + 1.0), &emlrtRTEI, sp);
  n = 0;
  while (n <= (int32_T)(maxIterations + 1.0) - 1) {
    for (i0 = 0; i0 < 1000000; i0++) {
      z_im = SD->f0.z[i0].re * SD->f0.z[i0].im + SD->f0.z[i0].im * SD->f0.z[i0].
        re;
      SD->f0.z[i0].re = (SD->f0.z[i0].re * SD->f0.z[i0].re - SD->f0.z[i0].im *
                         SD->f0.z[i0].im) + SD->f0.z0[i0].re;
      SD->f0.z[i0].im = z_im + SD->f0.z0[i0].im;
    }

    b_abs(SD->f0.z, SD->f0.dv0);
    for (i0 = 0; i0 < 1000000; i0++) {
      count[i0] += (real_T)(SD->f0.dv0[i0] <= 2.0);
    }

    n++;
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(sp);
    }
  }

  st.site = &emlrtRSI;
  b_log(&st, count);
}

/* End of code generation (mandelbrot_count.c) */
