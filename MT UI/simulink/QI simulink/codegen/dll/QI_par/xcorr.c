/*
 * File: xcorr.c
 *
 * MATLAB Coder version            : 3.4
 * C/C++ source code generated on  : 23-Jun-2018 15:45:59
 */

/* Include Files */
#include "rt_nonfinite.h"
#include "QI_par.h"
#include "xcorr.h"
#include "QI_par_emxutil.h"
#include "error.h"
#include "QI_par_rtwutil.h"
#include "ifft.h"
#include "fft.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Variable Definitions */
static rtEqualityCheckInfo g_emlrtECI = { -1,/* nDims */
  406,                                 /* lineNo */
  9,                                   /* colNo */
  "xcorr",                             /* fName */
  "D:\\Program Files\\MATLAB\\R2017b\\toolbox\\signal\\signal\\xcorr.m"/* pName */
};

static rtRunTimeErrorInfo f_emlrtRTEI = { 112,/* lineNo */
  27,                                  /* colNo */
  "xcorr",                             /* fName */
  "D:\\Program Files\\MATLAB\\R2017b\\toolbox\\signal\\signal\\xcorr.m"/* pName */
};

static rtDoubleCheckInfo p_emlrtDCI = { 396,/* lineNo */
  15,                                  /* colNo */
  "xcorr",                             /* fName */
  "D:\\Program Files\\MATLAB\\R2017b\\toolbox\\signal\\signal\\xcorr.m",/* pName */
  1                                    /* checkKind */
};

static rtDoubleCheckInfo q_emlrtDCI = { 396,/* lineNo */
  15,                                  /* colNo */
  "xcorr",                             /* fName */
  "D:\\Program Files\\MATLAB\\R2017b\\toolbox\\signal\\signal\\xcorr.m",/* pName */
  4                                    /* checkKind */
};

static rtRunTimeErrorInfo h_emlrtRTEI = { 273,/* lineNo */
  5,                                   /* colNo */
  "xcorr",                             /* fName */
  "D:\\Program Files\\MATLAB\\R2017b\\toolbox\\signal\\signal\\xcorr.m"/* pName */
};

static rtEqualityCheckInfo h_emlrtECI = { -1,/* nDims */
  290,                                 /* lineNo */
  20,                                  /* colNo */
  "xcorr",                             /* fName */
  "D:\\Program Files\\MATLAB\\R2017b\\toolbox\\signal\\signal\\xcorr.m"/* pName */
};

static rtBoundsCheckInfo fb_emlrtBCI = { -1,/* iFirst */
  -1,                                  /* iLast */
  296,                                 /* lineNo */
  33,                                  /* colNo */
  "",                                  /* aName */
  "xcorr",                             /* fName */
  "D:\\Program Files\\MATLAB\\R2017b\\toolbox\\signal\\signal\\xcorr.m",/* pName */
  0                                    /* checkKind */
};

static rtBoundsCheckInfo gb_emlrtBCI = { -1,/* iFirst */
  -1,                                  /* iLast */
  296,                                 /* lineNo */
  35,                                  /* colNo */
  "",                                  /* aName */
  "xcorr",                             /* fName */
  "D:\\Program Files\\MATLAB\\R2017b\\toolbox\\signal\\signal\\xcorr.m",/* pName */
  0                                    /* checkKind */
};

static rtRunTimeErrorInfo i_emlrtRTEI = { 88,/* lineNo */
  9,                                   /* colNo */
  "indexShapeCheck",                   /* fName */
  "D:\\Program Files\\MATLAB\\R2017b\\toolbox\\eml\\eml\\+coder\\+internal\\indexShapeCheck.m"/* pName */
};

static rtBoundsCheckInfo hb_emlrtBCI = { -1,/* iFirst */
  -1,                                  /* iLast */
  474,                                 /* lineNo */
  44,                                  /* colNo */
  "",                                  /* aName */
  "xcorr",                             /* fName */
  "D:\\Program Files\\MATLAB\\R2017b\\toolbox\\signal\\signal\\xcorr.m",/* pName */
  0                                    /* checkKind */
};

static rtBoundsCheckInfo ib_emlrtBCI = { -1,/* iFirst */
  -1,                                  /* iLast */
  482,                                 /* lineNo */
  53,                                  /* colNo */
  "",                                  /* aName */
  "xcorr",                             /* fName */
  "D:\\Program Files\\MATLAB\\R2017b\\toolbox\\signal\\signal\\xcorr.m",/* pName */
  0                                    /* checkKind */
};

static rtBoundsCheckInfo jb_emlrtBCI = { -1,/* iFirst */
  -1,                                  /* iLast */
  296,                                 /* lineNo */
  9,                                   /* colNo */
  "",                                  /* aName */
  "xcorr",                             /* fName */
  "D:\\Program Files\\MATLAB\\R2017b\\toolbox\\signal\\signal\\xcorr.m",/* pName */
  0                                    /* checkKind */
};

static rtDoubleCheckInfo r_emlrtDCI = { 296,/* lineNo */
  9,                                   /* colNo */
  "xcorr",                             /* fName */
  "D:\\Program Files\\MATLAB\\R2017b\\toolbox\\signal\\signal\\xcorr.m",/* pName */
  1                                    /* checkKind */
};

static rtDoubleCheckInfo s_emlrtDCI = { 466,/* lineNo */
  11,                                  /* colNo */
  "xcorr",                             /* fName */
  "D:\\Program Files\\MATLAB\\R2017b\\toolbox\\signal\\signal\\xcorr.m",/* pName */
  1                                    /* checkKind */
};

static rtDoubleCheckInfo t_emlrtDCI = { 466,/* lineNo */
  11,                                  /* colNo */
  "xcorr",                             /* fName */
  "D:\\Program Files\\MATLAB\\R2017b\\toolbox\\signal\\signal\\xcorr.m",/* pName */
  4                                    /* checkKind */
};

static rtBoundsCheckInfo kb_emlrtBCI = { -1,/* iFirst */
  -1,                                  /* iLast */
  484,                                 /* lineNo */
  7,                                   /* colNo */
  "",                                  /* aName */
  "xcorr",                             /* fName */
  "D:\\Program Files\\MATLAB\\R2017b\\toolbox\\signal\\signal\\xcorr.m",/* pName */
  0                                    /* checkKind */
};

static rtBoundsCheckInfo lb_emlrtBCI = { -1,/* iFirst */
  -1,                                  /* iLast */
  482,                                 /* lineNo */
  44,                                  /* colNo */
  "",                                  /* aName */
  "xcorr",                             /* fName */
  "D:\\Program Files\\MATLAB\\R2017b\\toolbox\\signal\\signal\\xcorr.m",/* pName */
  0                                    /* checkKind */
};

static rtBoundsCheckInfo mb_emlrtBCI = { -1,/* iFirst */
  -1,                                  /* iLast */
  476,                                 /* lineNo */
  7,                                   /* colNo */
  "",                                  /* aName */
  "xcorr",                             /* fName */
  "D:\\Program Files\\MATLAB\\R2017b\\toolbox\\signal\\signal\\xcorr.m",/* pName */
  0                                    /* checkKind */
};

static rtBoundsCheckInfo nb_emlrtBCI = { -1,/* iFirst */
  -1,                                  /* iLast */
  474,                                 /* lineNo */
  49,                                  /* colNo */
  "",                                  /* aName */
  "xcorr",                             /* fName */
  "D:\\Program Files\\MATLAB\\R2017b\\toolbox\\signal\\signal\\xcorr.m",/* pName */
  0                                    /* checkKind */
};

/* Function Declarations */
static void crosscorr(const emxArray_real_T *x, const emxArray_real_T *y, double
                      maxlag, emxArray_real_T *c);
static double rt_powd_snf(double u0, double u1);

/* Function Definitions */

/*
 * Arguments    : const emxArray_real_T *x
 *                const emxArray_real_T *y
 *                double maxlag
 *                emxArray_real_T *c
 * Return Type  : void
 */
static void crosscorr(const emxArray_real_T *x, const emxArray_real_T *y, double
                      maxlag, emxArray_real_T *c)
{
  int u0;
  int m;
  double mxl;
  double c0;
  int maxmn;
  double ceilLog2;
  double m2;
  int n;
  double Sn;
  emxArray_creal_T *X;
  emxArray_creal_T *Y;
  int i9;
  int loop_ub;
  emxArray_creal_T *b_X;
  int i10;
  emxArray_real_T *c1;
  double ihi;
  emxArray_real_T *r3;
  boolean_T nonSingletonDimFound;
  u0 = x->size[0];
  m = y->size[0];
  if (u0 > m) {
    m = u0;
  }

  mxl = (double)m - 1.0;
  if (maxlag < mxl) {
    mxl = maxlag;
  }

  c0 = frexp((unsigned int)fabs(2.0 * (double)m - 1.0), &maxmn);
  ceilLog2 = maxmn;
  if (c0 == 0.5) {
    ceilLog2 = (double)maxmn - 1.0;
  }

  m2 = rt_powd_snf(2.0, ceilLog2);
  if (!(m2 <= 4.0 * (double)m - 3.0)) {
    g_rtErrorWithMessageID(&h_emlrtRTEI);
  }

  u0 = x->size[0];
  m = y->size[0];
  if (u0 > m) {
    m = u0;
  }

  u0 = x->size[0];
  n = y->size[0];
  if (u0 < n) {
    n = u0;
  }

  c0 = 2.0 * (double)n - 1.0;
  if (mxl <= (double)n - 1.0) {
    Sn = mxl * ((c0 - mxl) - 1.0);
    if (mxl <= m - n) {
      c0 = (c0 + mxl * c0) + Sn;
    } else {
      c0 = ((c0 + (double)(m - n) * c0) + (mxl - (double)(m - n)) * ((((double)m
               - mxl) + (double)n) - 2.0)) + Sn;
    }
  } else if (mxl <= (double)m - 1.0) {
    Sn = ((double)n - 1.0) * ((double)n - 1.0);
    if (mxl <= m - n) {
      c0 = (c0 + mxl * c0) + Sn;
    } else {
      c0 = ((c0 + (double)(m - n) * c0) + (mxl - (double)(m - n)) * ((((double)m
               - mxl) + (double)n) - 2.0)) + Sn;
    }
  } else {
    c0 = 2.0 * (double)m * (double)n - ((double)((unsigned int)m + n) - 1.0);
  }

  if (c0 < m2 * (15.0 * ceilLog2 + 6.0)) {
    m = x->size[0];
    n = y->size[0];
    u0 = x->size[0];
    maxmn = y->size[0];
    if (u0 > maxmn) {
      maxmn = u0;
    }

    ceilLog2 = (double)maxmn - 1.0;
    if (mxl < ceilLog2) {
      ceilLog2 = mxl;
    }

    c0 = 2.0 * ceilLog2 + 1.0;
    i9 = c->size[0];
    if (!(c0 >= 0.0)) {
      rtNonNegativeError(c0, &t_emlrtDCI);
    }

    if (c0 != (int)floor(c0)) {
      rtIntegerError(c0, &s_emlrtDCI);
    }

    c->size[0] = (int)c0;
    emxEnsureCapacity_real_T1(c, i9);
    if (!(c0 >= 0.0)) {
      rtNonNegativeError(c0, &t_emlrtDCI);
    }

    if (c0 != (int)floor(c0)) {
      rtIntegerError(c0, &s_emlrtDCI);
    }

    loop_ub = (int)c0;
    for (i9 = 0; i9 < loop_ub; i9++) {
      c->data[i9] = 0.0;
    }

    for (maxmn = 0; maxmn < (int)(ceilLog2 + 1.0); maxmn++) {
      c0 = (double)m - (double)maxmn;
      ihi = n;
      if (c0 < ihi) {
        ihi = c0;
      }

      Sn = 0.0;
      for (u0 = 0; u0 < (int)ihi; u0++) {
        i9 = y->size[0];
        i10 = u0 + 1;
        if (!((i10 >= 1) && (i10 <= i9))) {
          rtDynamicBoundsError(i10, 1, i9, &hb_emlrtBCI);
        }

        i9 = x->size[0];
        i10 = (int)((double)maxmn + (1.0 + (double)u0));
        if (!((i10 >= 1) && (i10 <= i9))) {
          rtDynamicBoundsError(i10, 1, i9, &nb_emlrtBCI);
        }

        c0 = x->data[i10 - 1];
        Sn += y->data[u0] * c0;
      }

      i9 = c->size[0];
      i10 = (int)((ceilLog2 + (double)maxmn) + 1.0);
      if (!((i10 >= 1) && (i10 <= i9))) {
        rtDynamicBoundsError(i10, 1, i9, &mb_emlrtBCI);
      }

      c->data[i10 - 1] = Sn;
    }

    for (maxmn = 0; maxmn < (int)ceilLog2; maxmn++) {
      ihi = (double)n - (1.0 + (double)maxmn);
      c0 = m;
      if (c0 < ihi) {
        ihi = c0;
      }

      Sn = 0.0;
      for (u0 = 0; u0 < (int)ihi; u0++) {
        i9 = y->size[0];
        i10 = (int)((1.0 + (double)maxmn) + (1.0 + (double)u0));
        if (!((i10 >= 1) && (i10 <= i9))) {
          rtDynamicBoundsError(i10, 1, i9, &lb_emlrtBCI);
        }

        c0 = y->data[i10 - 1];
        i9 = x->size[0];
        i10 = u0 + 1;
        if (!((i10 >= 1) && (i10 <= i9))) {
          rtDynamicBoundsError(i10, 1, i9, &ib_emlrtBCI);
        }

        Sn += c0 * x->data[u0];
      }

      i9 = c->size[0];
      i10 = (int)((ceilLog2 - (1.0 + (double)maxmn)) + 1.0);
      if (!((i10 >= 1) && (i10 <= i9))) {
        rtDynamicBoundsError(i10, 1, i9, &kb_emlrtBCI);
      }

      c->data[i10 - 1] = Sn;
    }
  } else {
    emxInit_creal_T(&X, 1);
    emxInit_creal_T(&Y, 1);
    fft(x, m2, X);
    fft(y, m2, Y);
    i9 = Y->size[0];
    emxEnsureCapacity_creal_T(Y, i9);
    loop_ub = Y->size[0];
    for (i9 = 0; i9 < loop_ub; i9++) {
      Y->data[i9].im = -Y->data[i9].im;
    }

    emxInit_creal_T(&b_X, 1);
    i9 = X->size[0];
    i10 = Y->size[0];
    if (i9 != i10) {
      rtSizeEq1DError(i9, i10, &h_emlrtECI);
    }

    i9 = b_X->size[0];
    b_X->size[0] = X->size[0];
    emxEnsureCapacity_creal_T(b_X, i9);
    loop_ub = X->size[0];
    for (i9 = 0; i9 < loop_ub; i9++) {
      c0 = X->data[i9].re;
      Sn = X->data[i9].im;
      ceilLog2 = Y->data[i9].re;
      ihi = Y->data[i9].im;
      b_X->data[i9].re = c0 * ceilLog2 - Sn * ihi;
      b_X->data[i9].im = c0 * ihi + Sn * ceilLog2;
    }

    emxFree_creal_T(&Y);
    emxInit_real_T1(&c1, 1);
    ifft(b_X, X);
    i9 = c1->size[0];
    c1->size[0] = X->size[0];
    emxEnsureCapacity_real_T1(c1, i9);
    loop_ub = X->size[0];
    emxFree_creal_T(&b_X);
    for (i9 = 0; i9 < loop_ub; i9++) {
      c1->data[i9] = X->data[i9].re;
    }

    emxFree_creal_T(&X);
    emxInit_real_T(&r3, 2);
    if (mxl < 1.0) {
      i9 = r3->size[0] * r3->size[1];
      r3->size[0] = 1;
      r3->size[1] = 0;
      emxEnsureCapacity_real_T(r3, i9);
    } else {
      i9 = r3->size[0] * r3->size[1];
      r3->size[0] = 1;
      r3->size[1] = (int)floor(mxl - 1.0) + 1;
      emxEnsureCapacity_real_T(r3, i9);
      loop_ub = (int)floor(mxl - 1.0);
      for (i9 = 0; i9 <= loop_ub; i9++) {
        r3->data[r3->size[0] * i9] = 1.0 + (double)i9;
      }
    }

    nonSingletonDimFound = !(c1->size[0] != 1);
    if (nonSingletonDimFound) {
      nonSingletonDimFound = false;
      if (r3->size[1] != 1) {
        nonSingletonDimFound = true;
      }

      if (nonSingletonDimFound) {
        nonSingletonDimFound = true;
      } else {
        nonSingletonDimFound = false;
      }
    } else {
      nonSingletonDimFound = false;
    }

    if (nonSingletonDimFound) {
      h_rtErrorWithMessageID(&i_emlrtRTEI);
    }

    if (1.0 > mxl + 1.0) {
      loop_ub = 0;
    } else {
      i9 = c1->size[0];
      if (!(1 <= i9)) {
        rtDynamicBoundsError(1, 1, i9, &fb_emlrtBCI);
      }

      i9 = c1->size[0];
      loop_ub = (int)(mxl + 1.0);
      if (!((loop_ub >= 1) && (loop_ub <= i9))) {
        rtDynamicBoundsError(loop_ub, 1, i9, &gb_emlrtBCI);
      }
    }

    nonSingletonDimFound = !(c1->size[0] != 1);
    if (nonSingletonDimFound) {
      nonSingletonDimFound = false;
      if (loop_ub != 1) {
        nonSingletonDimFound = true;
      }

      if (nonSingletonDimFound) {
        nonSingletonDimFound = true;
      } else {
        nonSingletonDimFound = false;
      }
    } else {
      nonSingletonDimFound = false;
    }

    if (nonSingletonDimFound) {
      h_rtErrorWithMessageID(&i_emlrtRTEI);
    }

    m2 -= mxl;
    maxmn = c1->size[0];
    i9 = c->size[0];
    c->size[0] = r3->size[1] + loop_ub;
    emxEnsureCapacity_real_T1(c, i9);
    u0 = r3->size[1];
    for (i9 = 0; i9 < u0; i9++) {
      c0 = m2 + r3->data[r3->size[0] * i9];
      if (c0 != (int)floor(c0)) {
        rtIntegerError(c0, &r_emlrtDCI);
      }

      i10 = (int)c0;
      if (!((i10 >= 1) && (i10 <= maxmn))) {
        rtDynamicBoundsError(i10, 1, maxmn, &jb_emlrtBCI);
      }

      c->data[i9] = c1->data[i10 - 1];
    }

    for (i9 = 0; i9 < loop_ub; i9++) {
      c->data[i9 + r3->size[1]] = c1->data[i9];
    }

    emxFree_real_T(&r3);
    emxFree_real_T(&c1);
  }
}

/*
 * Arguments    : double u0
 *                double u1
 * Return Type  : double
 */
static double rt_powd_snf(double u0, double u1)
{
  double y;
  double d1;
  double d2;
  if (rtIsNaN(u0) || rtIsNaN(u1)) {
    y = rtNaN;
  } else {
    d1 = fabs(u0);
    d2 = fabs(u1);
    if (rtIsInf(u1)) {
      if (d1 == 1.0) {
        y = 1.0;
      } else if (d1 > 1.0) {
        if (u1 > 0.0) {
          y = rtInf;
        } else {
          y = 0.0;
        }
      } else if (u1 > 0.0) {
        y = 0.0;
      } else {
        y = rtInf;
      }
    } else if (d2 == 0.0) {
      y = 1.0;
    } else if (d2 == 1.0) {
      if (u1 > 0.0) {
        y = u0;
      } else {
        y = 1.0 / u0;
      }
    } else if (u1 == 2.0) {
      y = u0 * u0;
    } else if ((u1 == 0.5) && (u0 >= 0.0)) {
      y = sqrt(u0);
    } else if ((u0 < 0.0) && (u1 > floor(u1))) {
      y = rtNaN;
    } else {
      y = pow(u0, u1);
    }
  }

  return y;
}

/*
 * Arguments    : const emxArray_real_T *x
 *                const emxArray_real_T *varargin_1
 *                emxArray_real_T *c
 * Return Type  : void
 */
void xcorr(const emxArray_real_T *x, const emxArray_real_T *varargin_1,
           emxArray_real_T *c)
{
  boolean_T b0;
  int maxdimlen;
  unsigned int b_varargin_1[2];
  int u0;
  int u1;
  emxArray_real_T *c1;
  emxArray_real_T *b_c1;
  int b_x[1];
  int c_varargin_1[1];
  emxArray_real_T c_x;
  emxArray_real_T d_varargin_1;
  double d0;
  emxArray_int32_T *r2;
  int iv0[1];
  int iv1[1];
  if ((x->size[1] == 1) || (x->size[1] != 1)) {
    b0 = true;
  } else {
    b0 = false;
  }

  if (!b0) {
    e_rtErrorWithMessageID(1, "x", &f_emlrtRTEI);
  }

  for (maxdimlen = 0; maxdimlen < 2; maxdimlen++) {
    b_varargin_1[maxdimlen] = (unsigned int)x->size[maxdimlen];
  }

  maxdimlen = 1;
  if ((int)b_varargin_1[1] > 1) {
    maxdimlen = (int)b_varargin_1[1];
  }

  u0 = x->size[1];
  if (u0 > maxdimlen) {
    maxdimlen = u0;
  }

  if (x->size[1] > maxdimlen) {
    error();
  }

  if (1 > maxdimlen) {
    error();
  }

  if ((x->size[1] == 1) || (x->size[1] != 1)) {
    b0 = true;
  } else {
    b0 = false;
  }

  if (!b0) {
    e_rtErrorWithMessageID(1, "x", &f_emlrtRTEI);
  }

  u0 = x->size[1];
  u1 = varargin_1->size[1];
  if (u0 > u1) {
    u1 = u0;
  }

  emxInit_real_T1(&c1, 1);
  emxInit_real_T1(&b_c1, 1);
  b_x[0] = x->size[1];
  c_varargin_1[0] = varargin_1->size[1];
  c_x = *x;
  c_x.size = (int *)&b_x;
  c_x.numDimensions = 1;
  d_varargin_1 = *varargin_1;
  d_varargin_1.size = (int *)&c_varargin_1;
  d_varargin_1.numDimensions = 1;
  crosscorr(&c_x, &d_varargin_1, (double)u1 - 1.0, b_c1);
  maxdimlen = c1->size[0];
  d0 = 2.0 * ((double)u1 - 1.0) + 1.0;
  if (!(d0 >= 0.0)) {
    rtNonNegativeError(d0, &q_emlrtDCI);
  }

  if (d0 != (int)d0) {
    rtIntegerError(d0, &p_emlrtDCI);
  }

  c1->size[0] = (int)d0;
  emxEnsureCapacity_real_T1(c1, maxdimlen);
  d0 = 2.0 * ((double)u1 - 1.0) + 1.0;
  if (!(d0 >= 0.0)) {
    rtNonNegativeError(d0, &q_emlrtDCI);
  }

  if (d0 != (int)d0) {
    rtIntegerError(d0, &p_emlrtDCI);
  }

  u0 = (int)d0;
  for (maxdimlen = 0; maxdimlen < u0; maxdimlen++) {
    c1->data[maxdimlen] = 0.0;
  }

  emxInit_int32_T(&r2, 1);
  u0 = (int)(2.0 * ((double)u1 - 1.0) + 1.0);
  maxdimlen = r2->size[0];
  r2->size[0] = u0;
  emxEnsureCapacity_int32_T(r2, maxdimlen);
  for (maxdimlen = 0; maxdimlen < u0; maxdimlen++) {
    r2->data[maxdimlen] = maxdimlen;
  }

  maxdimlen = b_c1->size[0];
  iv0[0] = r2->size[0];
  iv1[0] = maxdimlen;
  rtSubAssignSizeCheck(&iv0[0], 1, &iv1[0], 1, &g_emlrtECI);
  u0 = b_c1->size[0] - 1;
  for (maxdimlen = 0; maxdimlen <= u0; maxdimlen++) {
    c1->data[r2->data[maxdimlen]] = b_c1->data[maxdimlen];
  }

  emxFree_int32_T(&r2);
  emxFree_real_T(&b_c1);
  b_varargin_1[0] = (unsigned int)c1->size[0];
  maxdimlen = (int)b_varargin_1[0];
  if (1 > (int)b_varargin_1[0]) {
    maxdimlen = 1;
  }

  u0 = c1->size[0];
  if (u0 > maxdimlen) {
    maxdimlen = u0;
  }

  if (1 > maxdimlen) {
    error();
  }

  if (c1->size[0] > maxdimlen) {
    error();
  }

  maxdimlen = c->size[0] * c->size[1];
  c->size[0] = 1;
  c->size[1] = c1->size[0];
  emxEnsureCapacity_real_T(c, maxdimlen);
  u0 = c1->size[0];
  for (maxdimlen = 0; maxdimlen < u0; maxdimlen++) {
    c->data[maxdimlen] = c1->data[maxdimlen];
  }

  emxFree_real_T(&c1);
}

/*
 * File trailer for xcorr.c
 *
 * [EOF]
 */
