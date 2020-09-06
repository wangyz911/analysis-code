/*
 * File: cuda_1_initialize.cu
 *
 * GPU Coder version                    : 1.0
 * CUDA/C/C++ source code generated on  : 23-Jul-2018 11:04:01
 */

/* Include Files */
#include "rt_nonfinite.h"
#include "cuda_1.h"
#include "cuda_1_initialize.h"

/* Function Definitions */

/*
 * Arguments    : void
 * Return Type  : void
 */
void cuda_1_initialize(void)
{
  rt_InitInfAndNaN(8U);
}

/*
 * File trailer for cuda_1_initialize.cu
 *
 * [EOF]
 */
