/*
 * File: mandelbrot_count_initialize.cu
 *
 * GPU Coder version                    : 1.0
 * CUDA/C/C++ source code generated on  : 26-Dec-2017 22:57:54
 */

/* Include Files */
#include "rt_nonfinite.h"
#include "mandelbrot_count.h"
#include "mandelbrot_count_initialize.h"

/* Function Definitions */

/*
 * Arguments    : void
 * Return Type  : void
 */
void mandelbrot_count_initialize(void)
{
  rt_InitInfAndNaN(8U);
}

/*
 * File trailer for mandelbrot_count_initialize.cu
 *
 * [EOF]
 */
