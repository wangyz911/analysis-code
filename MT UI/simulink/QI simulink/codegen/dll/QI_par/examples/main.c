/*
 * File: main.c
 *
 * MATLAB Coder version            : 3.4
 * C/C++ source code generated on  : 23-Jun-2018 15:45:32
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
#include "QI_par.h"
#include "main.h"
#include "QI_par_terminate.h"
#include "QI_par_emxAPI.h"
#include "QI_par_initialize.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Function Declarations */
static void argInit_80x80_uint8_T(unsigned char result[6400]);
static double argInit_real_T(void);
static unsigned char argInit_uint8_T(void);
static void main_QI_par(void);

/* Function Definitions */

/*
 * Arguments    : unsigned char result[6400]
 * Return Type  : void
 */
static void argInit_80x80_uint8_T(unsigned char result[6400])
{
  int idx0;
  int idx1;

  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < 80; idx0++) {
    for (idx1 = 0; idx1 < 80; idx1++) {
      /* Set the value of the array element.
         Change this value to the value that the application requires. */
      result[idx0 + 80 * idx1] = argInit_uint8_T();
    }
  }
}

/*
 * Arguments    : void
 * Return Type  : double
 */
static double argInit_real_T(void)
{
  return 0.0;
}

/*
 * Arguments    : void
 * Return Type  : unsigned char
 */
static unsigned char argInit_uint8_T(void)
{
  return 0;
}

/*
 * Arguments    : void
 * Return Type  : void
 */
static void main_QI_par(void)
{
  emxArray_real_T *corr_X;
  emxArray_real_T *corr_Y;
  emxArray_real_T *r_index;
  unsigned char uv0[6400];
  emxInitArray_real_T(&corr_X, 2);
  emxInitArray_real_T(&corr_Y, 2);
  emxInitArray_real_T(&r_index, 2);

  /* Initialize function 'QI_par' input arguments. */
  /* Initialize function input argument 'img_array'. */
  /* Call the entry-point 'QI_par'. */
  argInit_80x80_uint8_T(uv0);
  QI_par(uv0, argInit_real_T(), argInit_real_T(), argInit_real_T(),
         argInit_real_T(), corr_X, corr_Y, r_index);
  emxDestroyArray_real_T(r_index);
  emxDestroyArray_real_T(corr_Y);
  emxDestroyArray_real_T(corr_X);
}

/*
 * Arguments    : int argc
 *                const char * const argv[]
 * Return Type  : int
 */
int main(int argc, const char * const argv[])
{
  (void)argc;
  (void)argv;

  /* Initialize the application.
     You do not need to do this more than one time. */
  QI_par_initialize();

  /* Invoke the entry-point functions.
     You can call entry-point functions multiple times. */
  main_QI_par();

  /* Terminate the application.
     You do not need to do this more than one time. */
  QI_par_terminate();
  return 0;
}

/*
 * File trailer for main.c
 *
 * [EOF]
 */
