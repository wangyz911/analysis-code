/*
 * File: main.cu
 *
 * GPU Coder version                    : 1.0
 * CUDA/C/C++ source code generated on  : 23-Jul-2018 11:04:01
 */

/*************************************************************************/
/* This automatically generated example C main file shows how to call    */
/* entry-point functions that MATLAB Coder generated. You must customize */
/* this file for your application. Do not modify this file directly.     */
/* Instead, make a copy of this file, modify it, and integrate it into   */
/* your development environment.                                         */
/*                                                                       */
/* This file initializes entry-point function arguments to a default     */
/* size and value before calling the entry-point functions. It does      */
/* not store or use any values returned from the entry-point functions.  */
/* If necessary, it does pre-allocate memory for returned values.        */
/* You can use this file as a starting point for a main function that    */
/* you can deploy in your application.                                   */
/*                                                                       */
/* After you copy the file, and before you deploy it, you must make the  */
/* following changes:                                                    */
/* * For variable-size function arguments, change the example sizes to   */
/* the sizes that your application requires.                             */
/* * Change the example values of function arguments to the values that  */
/* your application requires.                                            */
/* * If the entry-point functions return values, store these values or   */
/* otherwise use them as required by your application.                   */
/*                                                                       */
/*************************************************************************/
/* Include Files */
#include "rt_nonfinite.h"
#include "cuda_1.h"
#include "main.h"
#include "cuda_1_terminate.h"
#include "cuda_1_initialize.h"

/* Function Declarations */
static void argInit_1000x1000_real_T(real_T result[1000000]);
static real_T argInit_real_T(void);
static void main_cuda_1(void);

/* Function Definitions */

/*
 * Arguments    : real_T result[1000000]
 * Return Type  : void
 */
static void argInit_1000x1000_real_T(real_T result[1000000])
{
  int32_T idx0;
  int32_T idx1;

  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < 1000; idx0++) {
    for (idx1 = 0; idx1 < 1000; idx1++) {
      /* Set the value of the array element.
         Change this value to the value that the application requires. */
      result[idx0 + 1000 * idx1] = argInit_real_T();
    }
  }
}

/*
 * Arguments    : void
 * Return Type  : real_T
 */
static real_T argInit_real_T(void)
{
  return 0.0;
}

/*
 * Arguments    : void
 * Return Type  : void
 */
static void main_cuda_1(void)
{
  static real_T y_data[1000000];
  int32_T y_size[2];
  static real_T b[1000000];

  /* Initialize function 'cuda_1' input arguments. */
  /* Initialize function input argument 'x'. */
  /* Call the entry-point 'cuda_1'. */
  argInit_1000x1000_real_T(b);
  cuda_1(b, argInit_real_T(), y_data, y_size);
}

/*
 * Arguments    : int32_T argc
 *                const char * const argv[]
 * Return Type  : int32_T
 */
int32_T main(int32_T argc, const char * const argv[])
{
  (void)argc;
  (void)argv;

  /* Initialize the application.
     You do not need to do this more than one time. */
  cuda_1_initialize();

  /* Invoke the entry-point functions.
     You can call entry-point functions multiple times. */
  main_cuda_1();

  /* Terminate the application.
     You do not need to do this more than one time. */
  cuda_1_terminate();
  return 0;
}

/*
 * File trailer for main.cu
 *
 * [EOF]
 */
