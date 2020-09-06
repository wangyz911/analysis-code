/*
 * mandelbrot_count.h
 *
 * Code generation for function 'mandelbrot_count'
 *
 */

#ifndef MANDELBROT_COUNT_H
#define MANDELBROT_COUNT_H

/* Include files */
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "mwmathutil.h"
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"
#include "rtwtypes.h"
#include "mandelbrot_count_types.h"

/* Function Declarations */
extern void mandelbrot_count(mandelbrot_countStackData *SD, const emlrtStack *sp,
  real_T maxIterations, const real_T xGrid[1000000], const real_T yGrid[1000000],
  real_T count[1000000]);

#endif

/* End of code generation (mandelbrot_count.h) */
