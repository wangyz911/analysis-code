/*
 * mandelbrot_count_types.h
 *
 * Code generation for function 'mandelbrot_count'
 *
 */

#ifndef MANDELBROT_COUNT_TYPES_H
#define MANDELBROT_COUNT_TYPES_H

/* Include files */
#include "rtwtypes.h"

/* Type Definitions */
#ifndef typedef_mandelbrot_countStackData
#define typedef_mandelbrot_countStackData

typedef struct {
  struct {
    creal_T z0[1000000];
    creal_T z[1000000];
    real_T dv0[1000000];
  } f0;
} mandelbrot_countStackData;

#endif                                 /*typedef_mandelbrot_countStackData*/
#endif

/* End of code generation (mandelbrot_count_types.h) */
