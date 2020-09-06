/*
 * File: error.c
 *
 * MATLAB Coder version            : 3.4
 * C/C++ source code generated on  : 23-Jun-2018 15:45:59
 */

/* Include Files */
#include "rt_nonfinite.h"
#include "QI_par.h"
#include "error.h"
#include "QI_par_rtwutil.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Variable Definitions */
static rtRunTimeErrorInfo g_emlrtRTEI = { 19,/* lineNo */
  5,                                   /* colNo */
  "error",                             /* fName */
  "D:\\Program Files\\MATLAB\\R2017b\\toolbox\\shared\\coder\\coder\\+coder\\+internal\\error.m"/* pName */
};

/* Function Definitions */

/*
 * Arguments    : void
 * Return Type  : void
 */
void error(void)
{
  f_rtErrorWithMessageID(&g_emlrtRTEI);
}

/*
 * File trailer for error.c
 *
 * [EOF]
 */
