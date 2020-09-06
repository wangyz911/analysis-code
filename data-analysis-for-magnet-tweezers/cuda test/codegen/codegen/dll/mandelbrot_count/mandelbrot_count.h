/*
 * File: mandelbrot_count.h
 *
 * GPU Coder version                    : 1.0
 * CUDA/C/C++ source code generated on  : 26-Dec-2017 22:57:54
 */

#ifndef MANDELBROT_COUNT_H
#define MANDELBROT_COUNT_H

/* Include Files */
#include <stddef.h>
#include <stdlib.h>
#include "rtwtypes.h"
#include "mandelbrot_count_types.h"

/* Function Declarations */
#ifdef __cplusplus

extern "C" {

#endif

  extern void mandelbrot_count(real_T maxIterations, const real_T xGrid[1000000],
    const real_T yGrid[1000000], real_T count[1000000]);

#ifdef __cplusplus

}
#endif
#endif

/*
 * File trailer for mandelbrot_count.h
 *
 * [EOF]
 */
