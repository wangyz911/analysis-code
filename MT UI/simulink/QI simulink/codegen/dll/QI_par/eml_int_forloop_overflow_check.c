/*
 * File: eml_int_forloop_overflow_check.c
 *
 * MATLAB Coder version            : 3.4
 * C/C++ source code generated on  : 23-Jun-2018 15:45:59
 */

/* Include Files */
#include "rt_nonfinite.h"
#include "QI_par.h"
#include "eml_int_forloop_overflow_check.h"
#include "QI_par_rtwutil.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Variable Definitions */
static rtRunTimeErrorInfo b_emlrtRTEI = { 87,/* lineNo */
  15,                                  /* colNo */
  "eml_int_forloop_overflow_check",    /* fName */
  "D:\\Program Files\\MATLAB\\R2017b\\toolbox\\eml\\lib\\matlab\\eml\\eml_int_forloop_overflow_check.m"/* pName */
};

/* Function Definitions */

/*
 * Arguments    : void
 * Return Type  : void
 */
void check_forloop_overflow_error(void)
{
  b_rtErrorWithMessageID(5, "int32", &b_emlrtRTEI);
}

/*
 * File trailer for eml_int_forloop_overflow_check.c
 *
 * [EOF]
 */
