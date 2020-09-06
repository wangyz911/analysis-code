/*
 * abs.c
 *
 * Code generation for function 'abs'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "mandelbrot_count.h"
#include "abs.h"

/* Function Definitions */
void b_abs(const creal_T x[1000000], real_T y[1000000])
{
  int32_T k;
  for (k = 0; k < 1000000; k++) {
    y[k] = muDoubleScalarHypot(x[k].re, x[k].im);
  }
}

/* End of code generation (abs.c) */
