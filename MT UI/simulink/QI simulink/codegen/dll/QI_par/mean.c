/*
 * File: mean.c
 *
 * MATLAB Coder version            : 3.4
 * C/C++ source code generated on  : 23-Jun-2018 15:45:59
 */

/* Include Files */
#include "rt_nonfinite.h"
#include "QI_par.h"
#include "mean.h"
#include "QI_par_emxutil.h"
#include "eml_int_forloop_overflow_check.h"
#include "QI_par_rtwutil.h"
#include "isequal.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Variable Definitions */
static rtRunTimeErrorInfo c_emlrtRTEI = { 30,/* lineNo */
  5,                                   /* colNo */
  "mean",                              /* fName */
  "D:\\Program Files\\MATLAB\\R2017b\\toolbox\\eml\\lib\\matlab\\datafun\\mean.m"/* pName */
};

static rtRunTimeErrorInfo d_emlrtRTEI = { 21,/* lineNo */
  5,                                   /* colNo */
  "mean",                              /* fName */
  "D:\\Program Files\\MATLAB\\R2017b\\toolbox\\eml\\lib\\matlab\\datafun\\mean.m"/* pName */
};

static rtRunTimeErrorInfo e_emlrtRTEI = { 17,/* lineNo */
  15,                                  /* colNo */
  "mean",                              /* fName */
  "D:\\Program Files\\MATLAB\\R2017b\\toolbox\\eml\\lib\\matlab\\datafun\\mean.m"/* pName */
};

/* Function Definitions */

/*
 * Arguments    : const emxArray_real_T *x
 *                emxArray_real_T *y
 * Return Type  : void
 */
void mean(const emxArray_real_T *x, emxArray_real_T *y)
{
  boolean_T overflow;
  int vlen;
  int xpageoffset;
  unsigned int sz[2];
  int i;
  int k;
  if (((x->size[0] == 1) && (x->size[1] == 1)) || (x->size[0] != 1)) {
    overflow = true;
  } else {
    overflow = false;
  }

  if (!overflow) {
    d_rtErrorWithMessageID(&e_emlrtRTEI);
  }

  overflow = !isequal(x);
  if (!overflow) {
    c_rtErrorWithMessageID(&d_emlrtRTEI);
  }

  overflow = !isequal(x);
  if (!overflow) {
    c_rtErrorWithMessageID(&c_emlrtRTEI);
  }

  vlen = x->size[0];
  if ((x->size[0] == 0) || (x->size[1] == 0)) {
    for (xpageoffset = 0; xpageoffset < 2; xpageoffset++) {
      sz[xpageoffset] = (unsigned int)x->size[xpageoffset];
    }

    xpageoffset = y->size[0] * y->size[1];
    y->size[0] = 1;
    y->size[1] = (int)sz[1];
    emxEnsureCapacity_real_T(y, xpageoffset);
    i = (int)sz[1];
    for (xpageoffset = 0; xpageoffset < i; xpageoffset++) {
      y->data[xpageoffset] = 0.0;
    }
  } else {
    xpageoffset = y->size[0] * y->size[1];
    y->size[0] = 1;
    y->size[1] = x->size[1];
    emxEnsureCapacity_real_T(y, xpageoffset);
    overflow = (x->size[1] > 2147483646);
    if (overflow) {
      check_forloop_overflow_error();
    }

    for (i = 0; i + 1 <= x->size[1]; i++) {
      xpageoffset = i * x->size[0];
      y->data[i] = x->data[xpageoffset];
      if ((!(2 > vlen)) && (vlen > 2147483646)) {
        check_forloop_overflow_error();
      }

      for (k = 2; k <= vlen; k++) {
        y->data[i] += x->data[(xpageoffset + k) - 1];
      }
    }
  }

  xpageoffset = y->size[0] * y->size[1];
  y->size[0] = 1;
  emxEnsureCapacity_real_T(y, xpageoffset);
  i = y->size[0];
  xpageoffset = y->size[1];
  k = x->size[0];
  i *= xpageoffset;
  for (xpageoffset = 0; xpageoffset < i; xpageoffset++) {
    y->data[xpageoffset] /= (double)k;
  }
}

/*
 * File trailer for mean.c
 *
 * [EOF]
 */
