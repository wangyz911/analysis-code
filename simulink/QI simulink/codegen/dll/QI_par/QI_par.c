/*
 * File: QI_par.c
 *
 * MATLAB Coder version            : 3.4
 * C/C++ source code generated on  : 23-Jun-2018 15:45:59
 */

/* Include Files */
#include "rt_nonfinite.h"
#include "QI_par.h"
#include "QI_par_rtwutil.h"
#include "QI_par_emxutil.h"
#include "xcorr.h"
#include "flip.h"
#include "mean.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Variable Definitions */
static rtBoundsCheckInfo emlrtBCI = { -1,/* iFirst */
  -1,                                  /* iLast */
  27,                                  /* lineNo */
  18,                                  /* colNo */
  "theta_matrix",                      /* aName */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m",/* pName */
  0                                    /* checkKind */
};

static rtEqualityCheckInfo emlrtECI = { -1,/* nDims */
  27,                                  /* lineNo */
  5,                                   /* colNo */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m"/* pName */
};

static rtBoundsCheckInfo b_emlrtBCI = { -1,/* iFirst */
  -1,                                  /* iLast */
  23,                                  /* lineNo */
  14,                                  /* colNo */
  "r_matrix",                          /* aName */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m",/* pName */
  0                                    /* checkKind */
};

static rtEqualityCheckInfo b_emlrtECI = { -1,/* nDims */
  23,                                  /* lineNo */
  5,                                   /* colNo */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m"/* pName */
};

static rtBoundsCheckInfo c_emlrtBCI = { -1,/* iFirst */
  -1,                                  /* iLast */
  50,                                  /* lineNo */
  47,                                  /* colNo */
  "theta_matrix",                      /* aName */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m",/* pName */
  0                                    /* checkKind */
};

static rtBoundsCheckInfo d_emlrtBCI = { -1,/* iFirst */
  -1,                                  /* iLast */
  50,                                  /* lineNo */
  49,                                  /* colNo */
  "theta_matrix",                      /* aName */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m",/* pName */
  0                                    /* checkKind */
};

static rtBoundsCheckInfo e_emlrtBCI = { -1,/* iFirst */
  -1,                                  /* iLast */
  51,                                  /* lineNo */
  47,                                  /* colNo */
  "theta_matrix",                      /* aName */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m",/* pName */
  0                                    /* checkKind */
};

static rtBoundsCheckInfo f_emlrtBCI = { -1,/* iFirst */
  -1,                                  /* iLast */
  51,                                  /* lineNo */
  49,                                  /* colNo */
  "theta_matrix",                      /* aName */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m",/* pName */
  0                                    /* checkKind */
};

static rtBoundsCheckInfo g_emlrtBCI = { -1,/* iFirst */
  -1,                                  /* iLast */
  64,                                  /* lineNo */
  34,                                  /* colNo */
  "radial_sum",                        /* aName */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m",/* pName */
  0                                    /* checkKind */
};

static rtDoubleCheckInfo emlrtDCI = { 64,/* lineNo */
  36,                                  /* colNo */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m",/* pName */
  1                                    /* checkKind */
};

static rtBoundsCheckInfo h_emlrtBCI = { -1,/* iFirst */
  -1,                                  /* iLast */
  64,                                  /* lineNo */
  36,                                  /* colNo */
  "radial_sum",                        /* aName */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m",/* pName */
  0                                    /* checkKind */
};

static rtDoubleCheckInfo b_emlrtDCI = { 65,/* lineNo */
  35,                                  /* colNo */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m",/* pName */
  1                                    /* checkKind */
};

static rtBoundsCheckInfo i_emlrtBCI = { -1,/* iFirst */
  -1,                                  /* iLast */
  65,                                  /* lineNo */
  35,                                  /* colNo */
  "radial_sum",                        /* aName */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m",/* pName */
  0                                    /* checkKind */
};

static rtDoubleCheckInfo c_emlrtDCI = { 65,/* lineNo */
  53,                                  /* colNo */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m",/* pName */
  1                                    /* checkKind */
};

static rtBoundsCheckInfo j_emlrtBCI = { -1,/* iFirst */
  -1,                                  /* iLast */
  65,                                  /* lineNo */
  53,                                  /* colNo */
  "radial_sum",                        /* aName */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m",/* pName */
  0                                    /* checkKind */
};

static rtDoubleCheckInfo d_emlrtDCI = { 66,/* lineNo */
  35,                                  /* colNo */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m",/* pName */
  1                                    /* checkKind */
};

static rtBoundsCheckInfo k_emlrtBCI = { -1,/* iFirst */
  -1,                                  /* iLast */
  66,                                  /* lineNo */
  35,                                  /* colNo */
  "radial_sum",                        /* aName */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m",/* pName */
  0                                    /* checkKind */
};

static rtDoubleCheckInfo e_emlrtDCI = { 66,/* lineNo */
  55,                                  /* colNo */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m",/* pName */
  1                                    /* checkKind */
};

static rtBoundsCheckInfo l_emlrtBCI = { -1,/* iFirst */
  -1,                                  /* iLast */
  66,                                  /* lineNo */
  55,                                  /* colNo */
  "radial_sum",                        /* aName */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m",/* pName */
  0                                    /* checkKind */
};

static rtDoubleCheckInfo f_emlrtDCI = { 67,/* lineNo */
  35,                                  /* colNo */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m",/* pName */
  1                                    /* checkKind */
};

static rtBoundsCheckInfo m_emlrtBCI = { -1,/* iFirst */
  -1,                                  /* iLast */
  67,                                  /* lineNo */
  35,                                  /* colNo */
  "radial_sum",                        /* aName */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m",/* pName */
  0                                    /* checkKind */
};

static rtDoubleCheckInfo g_emlrtDCI = { 67,/* lineNo */
  55,                                  /* colNo */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m",/* pName */
  1                                    /* checkKind */
};

static rtBoundsCheckInfo n_emlrtBCI = { -1,/* iFirst */
  -1,                                  /* iLast */
  67,                                  /* lineNo */
  55,                                  /* colNo */
  "radial_sum",                        /* aName */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m",/* pName */
  0                                    /* checkKind */
};

static rtEqualityCheckInfo c_emlrtECI = { 2,/* nDims */
  69,                                  /* lineNo */
  15,                                  /* colNo */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m"/* pName */
};

static rtEqualityCheckInfo d_emlrtECI = { 2,/* nDims */
  70,                                  /* lineNo */
  16,                                  /* colNo */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m"/* pName */
};

static rtBoundsCheckInfo o_emlrtBCI = { -1,/* iFirst */
  -1,                                  /* iLast */
  71,                                  /* lineNo */
  32,                                  /* colNo */
  "radial_left",                       /* aName */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m",/* pName */
  0                                    /* checkKind */
};

static rtEqualityCheckInfo e_emlrtECI = { 2,/* nDims */
  75,                                  /* lineNo */
  13,                                  /* colNo */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m"/* pName */
};

static rtEqualityCheckInfo f_emlrtECI = { 2,/* nDims */
  76,                                  /* lineNo */
  15,                                  /* colNo */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m"/* pName */
};

static rtBoundsCheckInfo p_emlrtBCI = { -1,/* iFirst */
  -1,                                  /* iLast */
  77,                                  /* lineNo */
  30,                                  /* colNo */
  "radial_up",                         /* aName */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m",/* pName */
  0                                    /* checkKind */
};

static rtRunTimeErrorInfo emlrtRTEI = { 388,/* lineNo */
  15,                                  /* colNo */
  "colon",                             /* fName */
  "D:\\Program Files\\MATLAB\\R2017b\\toolbox\\eml\\lib\\matlab\\ops\\colon.m"/* pName */
};

static rtBoundsCheckInfo q_emlrtBCI = { -1,/* iFirst */
  -1,                                  /* iLast */
  50,                                  /* lineNo */
  25,                                  /* colNo */
  "r_matrix",                          /* aName */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m",/* pName */
  0                                    /* checkKind */
};

static rtBoundsCheckInfo r_emlrtBCI = { -1,/* iFirst */
  -1,                                  /* iLast */
  50,                                  /* lineNo */
  27,                                  /* colNo */
  "r_matrix",                          /* aName */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m",/* pName */
  0                                    /* checkKind */
};

static rtBoundsCheckInfo s_emlrtBCI = { -1,/* iFirst */
  -1,                                  /* iLast */
  51,                                  /* lineNo */
  25,                                  /* colNo */
  "r_matrix",                          /* aName */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m",/* pName */
  0                                    /* checkKind */
};

static rtBoundsCheckInfo t_emlrtBCI = { -1,/* iFirst */
  -1,                                  /* iLast */
  51,                                  /* lineNo */
  27,                                  /* colNo */
  "r_matrix",                          /* aName */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m",/* pName */
  0                                    /* checkKind */
};

static rtBoundsCheckInfo u_emlrtBCI = { 1,/* iFirst */
  80,                                  /* iLast */
  56,                                  /* lineNo */
  40,                                  /* colNo */
  "img_array",                         /* aName */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m",/* pName */
  0                                    /* checkKind */
};

static rtDoubleCheckInfo h_emlrtDCI = { 56,/* lineNo */
  40,                                  /* colNo */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m",/* pName */
  1                                    /* checkKind */
};

static rtBoundsCheckInfo v_emlrtBCI = { 1,/* iFirst */
  80,                                  /* iLast */
  56,                                  /* lineNo */
  43,                                  /* colNo */
  "img_array",                         /* aName */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m",/* pName */
  0                                    /* checkKind */
};

static rtDoubleCheckInfo i_emlrtDCI = { 56,/* lineNo */
  43,                                  /* colNo */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m",/* pName */
  1                                    /* checkKind */
};

static rtBoundsCheckInfo w_emlrtBCI = { 1,/* iFirst */
  80,                                  /* iLast */
  56,                                  /* lineNo */
  71,                                  /* colNo */
  "img_array",                         /* aName */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m",/* pName */
  0                                    /* checkKind */
};

static rtDoubleCheckInfo j_emlrtDCI = { 56,/* lineNo */
  71,                                  /* colNo */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m",/* pName */
  1                                    /* checkKind */
};

static rtBoundsCheckInfo x_emlrtBCI = { 1,/* iFirst */
  80,                                  /* iLast */
  56,                                  /* lineNo */
  74,                                  /* colNo */
  "img_array",                         /* aName */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m",/* pName */
  0                                    /* checkKind */
};

static rtDoubleCheckInfo k_emlrtDCI = { 56,/* lineNo */
  74,                                  /* colNo */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m",/* pName */
  1                                    /* checkKind */
};

static rtBoundsCheckInfo y_emlrtBCI = { 1,/* iFirst */
  80,                                  /* iLast */
  57,                                  /* lineNo */
  24,                                  /* colNo */
  "img_array",                         /* aName */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m",/* pName */
  0                                    /* checkKind */
};

static rtDoubleCheckInfo l_emlrtDCI = { 57,/* lineNo */
  24,                                  /* colNo */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m",/* pName */
  1                                    /* checkKind */
};

static rtBoundsCheckInfo ab_emlrtBCI = { 1,/* iFirst */
  80,                                  /* iLast */
  57,                                  /* lineNo */
  27,                                  /* colNo */
  "img_array",                         /* aName */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m",/* pName */
  0                                    /* checkKind */
};

static rtDoubleCheckInfo m_emlrtDCI = { 57,/* lineNo */
  27,                                  /* colNo */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m",/* pName */
  1                                    /* checkKind */
};

static rtBoundsCheckInfo bb_emlrtBCI = { 1,/* iFirst */
  80,                                  /* iLast */
  57,                                  /* lineNo */
  55,                                  /* colNo */
  "img_array",                         /* aName */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m",/* pName */
  0                                    /* checkKind */
};

static rtDoubleCheckInfo n_emlrtDCI = { 57,/* lineNo */
  55,                                  /* colNo */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m",/* pName */
  1                                    /* checkKind */
};

static rtBoundsCheckInfo cb_emlrtBCI = { 1,/* iFirst */
  80,                                  /* iLast */
  57,                                  /* lineNo */
  58,                                  /* colNo */
  "img_array",                         /* aName */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m",/* pName */
  0                                    /* checkKind */
};

static rtDoubleCheckInfo o_emlrtDCI = { 57,/* lineNo */
  58,                                  /* colNo */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m",/* pName */
  1                                    /* checkKind */
};

static rtBoundsCheckInfo db_emlrtBCI = { -1,/* iFirst */
  -1,                                  /* iLast */
  56,                                  /* lineNo */
  23,                                  /* colNo */
  "radial_result",                     /* aName */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m",/* pName */
  0                                    /* checkKind */
};

static rtBoundsCheckInfo eb_emlrtBCI = { -1,/* iFirst */
  -1,                                  /* iLast */
  56,                                  /* lineNo */
  25,                                  /* colNo */
  "radial_result",                     /* aName */
  "QI_par",                            /* fName */
  "E:\\analysis code\\simulink\\QI simulink\\QI_par.m",/* pName */
  0                                    /* checkKind */
};

/* Function Definitions */

/*
 * 本函数用于计算若干张图像数据的质心位置，图像有先后顺序但无逻辑顺序。
 *  本函数对图心的寻找进行了改进，主要是消除背景噪声。
 *  输入来的是N张图拼接起来的长图矩阵。
 *  本函数是labview 并行计划的第一环
 *  本函数必须假设图像矩阵是长宽一致的。
 * Arguments    : const unsigned char img_array[6400]
 *                double xc
 *                double yc
 *                double r_step
 *                double theta_num_perQ
 *                emxArray_real_T *corr_X
 *                emxArray_real_T *corr_Y
 *                emxArray_real_T *r_index
 * Return Type  : void
 */
void QI_par(const unsigned char img_array[6400], double xc, double yc, double
            r_step, double theta_num_perQ, emxArray_real_T *corr_X,
            emxArray_real_T *corr_Y, emxArray_real_T *r_index)
{
  int i0;
  double b_img_array[6400];
  double varargin_1[4];
  int ixstart;
  double r_max;
  int ix;
  boolean_T exitg1;
  double x;
  emxArray_real_T *r;
  double ndbl;
  double apnd;
  double theta_step;
  double cdiff;
  emxArray_real_T *theta;
  int n;
  emxArray_real_T *r_matrix;
  emxArray_real_T *theta_matrix;
  int i;
  emxArray_int32_T *r0;
  int i1;
  emxArray_real_T *b_theta_matrix;
  int radialProfile2[2];
  emxArray_real_T *radial_result;
  int i2;
  emxArray_real_T *b_radialProfile2;
  int i3;
  emxArray_real_T *radialProfile3;
  emxArray_real_T *radialProfile4;
  int b_radialProfile3[2];
  int i4;
  int i5;
  int i6;
  int i7;
  emxArray_real_T *r1;
  int i8;
  emxArray_real_T *radial_x;

  /*  第一步，确定图像总矩阵大小，img_array 是一个三维矩阵， */
  for (i0 = 0; i0 < 6400; i0++) {
    b_img_array[i0] = (double)img_array[i0] / 255.0;
  }

  /*  第二步，按参数生成QI的采样极坐标，并生成极坐标矩阵 */
  /*  此处令r_max 等于距离边界最小的 */
  varargin_1[0] = xc;
  varargin_1[1] = yc;
  varargin_1[2] = 80.0 - xc;
  varargin_1[3] = 80.0 - yc;
  ixstart = 1;
  r_max = xc;
  if (rtIsNaN(xc)) {
    ix = 2;
    exitg1 = false;
    while ((!exitg1) && (ix < 5)) {
      ixstart = ix;
      if (!rtIsNaN(varargin_1[ix - 1])) {
        r_max = varargin_1[ix - 1];
        exitg1 = true;
      } else {
        ix++;
      }
    }
  }

  if (ixstart < 4) {
    while (ixstart + 1 < 5) {
      if (varargin_1[ixstart] < r_max) {
        r_max = varargin_1[ixstart];
      }

      ixstart++;
    }
  }

  x = floor(r_max);
  r_max = floor(r_max) - 1.0;

  /*   r_max = 10; */
  emxInit_real_T(&r, 2);
  if (rtIsNaN(r_step) || rtIsNaN(r_max)) {
    i0 = r->size[0] * r->size[1];
    r->size[0] = 1;
    r->size[1] = 1;
    emxEnsureCapacity_real_T(r, i0);
    r->data[0] = rtNaN;
  } else if ((r_step == 0.0) || ((0.0 < x - 1.0) && (r_step < 0.0)) || ((x - 1.0
    < 0.0) && (r_step > 0.0))) {
    i0 = r->size[0] * r->size[1];
    r->size[0] = 1;
    r->size[1] = 0;
    emxEnsureCapacity_real_T(r, i0);
  } else if (rtIsInf(r_max) && (rtIsInf(r_step) || (0.0 == x - 1.0))) {
    i0 = r->size[0] * r->size[1];
    r->size[0] = 1;
    r->size[1] = 1;
    emxEnsureCapacity_real_T(r, i0);
    r->data[0] = rtNaN;
  } else if (rtIsInf(r_step)) {
    i0 = r->size[0] * r->size[1];
    r->size[0] = 1;
    r->size[1] = 1;
    emxEnsureCapacity_real_T(r, i0);
    r->data[0] = 0.0;
  } else if (floor(r_step) == r_step) {
    i0 = r->size[0] * r->size[1];
    r->size[0] = 1;
    r->size[1] = (int)floor((x - 1.0) / r_step) + 1;
    emxEnsureCapacity_real_T(r, i0);
    ix = (int)floor((x - 1.0) / r_step);
    for (i0 = 0; i0 <= ix; i0++) {
      r->data[r->size[0] * i0] = r_step * (double)i0;
    }
  } else {
    ndbl = floor((x - 1.0) / r_step + 0.5);
    apnd = ndbl * r_step;
    if (r_step > 0.0) {
      cdiff = apnd - (x - 1.0);
    } else {
      cdiff = (x - 1.0) - apnd;
    }

    if (fabs(cdiff) < 4.4408920985006262E-16 * fabs(r_max)) {
      ndbl++;
      apnd = x - 1.0;
    } else if (cdiff > 0.0) {
      apnd = (ndbl - 1.0) * r_step;
    } else {
      ndbl++;
    }

    if (ndbl >= 0.0) {
      n = (int)ndbl;
    } else {
      n = 0;
    }

    if (2.147483647E+9 < ndbl) {
      rtErrorWithMessageID(&emlrtRTEI);
    }

    i0 = r->size[0] * r->size[1];
    r->size[0] = 1;
    r->size[1] = n;
    emxEnsureCapacity_real_T(r, i0);
    if (n > 0) {
      r->data[0] = 0.0;
      if (n > 1) {
        r->data[n - 1] = apnd;
        ixstart = (n - 1) / 2;
        for (ix = 1; ix < ixstart; ix++) {
          r_max = (double)ix * r_step;
          r->data[ix] = r_max;
          r->data[(n - ix) - 1] = apnd - r_max;
        }

        if (ixstart << 1 == n - 1) {
          r->data[ixstart] = apnd / 2.0;
        } else {
          r_max = (double)ixstart * r_step;
          r->data[ixstart] = r_max;
          r->data[ixstart + 1] = apnd - r_max;
        }
      }
    }
  }

  theta_step = 1.5707963267948966 / theta_num_perQ;
  emxInit_real_T(&theta, 2);
  if (rtIsNaN(theta_step) || rtIsNaN(theta_step)) {
    i0 = theta->size[0] * theta->size[1];
    theta->size[0] = 1;
    theta->size[1] = 1;
    emxEnsureCapacity_real_T(theta, i0);
    theta->data[0] = rtNaN;
  } else if ((theta_step == 0.0) || ((theta_step < 6.2831853071795862) &&
              (theta_step < 0.0)) || (6.2831853071795862 < theta_step)) {
    i0 = theta->size[0] * theta->size[1];
    theta->size[0] = 1;
    theta->size[1] = 0;
    emxEnsureCapacity_real_T(theta, i0);
  } else if ((floor(theta_step) == theta_step) && (floor(theta_step) ==
              theta_step)) {
    i0 = theta->size[0] * theta->size[1];
    theta->size[0] = 1;
    theta->size[1] = (int)floor((6.2831853071795862 - theta_step) / theta_step)
      + 1;
    emxEnsureCapacity_real_T(theta, i0);
    ix = (int)floor((6.2831853071795862 - theta_step) / theta_step);
    for (i0 = 0; i0 <= ix; i0++) {
      theta->data[theta->size[0] * i0] = theta_step + theta_step * (double)i0;
    }
  } else {
    ndbl = floor((6.2831853071795862 - theta_step) / theta_step + 0.5);
    apnd = theta_step + ndbl * theta_step;
    if (theta_step > 0.0) {
      cdiff = apnd - 6.2831853071795862;
    } else {
      cdiff = 6.2831853071795862 - apnd;
    }

    if (fabs(cdiff) < 2.7902947984069054E-15) {
      ndbl++;
      apnd = 6.2831853071795862;
    } else if (cdiff > 0.0) {
      apnd = theta_step + (ndbl - 1.0) * theta_step;
    } else {
      ndbl++;
    }

    if (ndbl >= 0.0) {
      n = (int)ndbl;
    } else {
      n = 0;
    }

    if (2.147483647E+9 < ndbl) {
      rtErrorWithMessageID(&emlrtRTEI);
    }

    i0 = theta->size[0] * theta->size[1];
    theta->size[0] = 1;
    theta->size[1] = n;
    emxEnsureCapacity_real_T(theta, i0);
    if (n > 0) {
      theta->data[0] = theta_step;
      if (n > 1) {
        theta->data[n - 1] = apnd;
        ixstart = (n - 1) / 2;
        for (ix = 1; ix < ixstart; ix++) {
          r_max = (double)ix * theta_step;
          theta->data[ix] = theta_step + r_max;
          theta->data[(n - ix) - 1] = apnd - r_max;
        }

        if (ixstart << 1 == n - 1) {
          theta->data[ixstart] = (theta_step + apnd) / 2.0;
        } else {
          r_max = (double)ixstart * theta_step;
          theta->data[ixstart] = theta_step + r_max;
          theta->data[ixstart + 1] = apnd - r_max;
        }
      }
    }
  }

  emxInit_real_T(&r_matrix, 2);
  i0 = r_matrix->size[0] * r_matrix->size[1];
  r_matrix->size[0] = theta->size[1];
  r_matrix->size[1] = r->size[1];
  emxEnsureCapacity_real_T(r_matrix, i0);
  ix = theta->size[1] * r->size[1];
  for (i0 = 0; i0 < ix; i0++) {
    r_matrix->data[i0] = 0.0;
  }

  emxInit_real_T(&theta_matrix, 2);
  i0 = theta_matrix->size[0] * theta_matrix->size[1];
  theta_matrix->size[0] = r->size[1];
  theta_matrix->size[1] = theta->size[1];
  emxEnsureCapacity_real_T(theta_matrix, i0);
  ix = r->size[1] * theta->size[1];
  for (i0 = 0; i0 < ix; i0++) {
    theta_matrix->data[i0] = 0.0;
  }

  i = 0;
  emxInit_int32_T(&r0, 1);
  while (i <= theta->size[1] - 1) {
    i0 = r_matrix->size[0];
    i1 = i + 1;
    if (!((i1 >= 1) && (i1 <= i0))) {
      rtDynamicBoundsError(i1, 1, i0, &b_emlrtBCI);
    }

    ix = r_matrix->size[1];
    i0 = r0->size[0];
    r0->size[0] = ix;
    emxEnsureCapacity_int32_T(r0, i0);
    for (i0 = 0; i0 < ix; i0++) {
      r0->data[i0] = i0;
    }

    radialProfile2[0] = 1;
    radialProfile2[1] = r0->size[0];
    rtSubAssignSizeCheck(&radialProfile2[0], 2, &(*(int (*)[2])r->size)[0], 2,
                         &b_emlrtECI);
    ix = r->size[1];
    for (i0 = 0; i0 < ix; i0++) {
      r_matrix->data[i + r_matrix->size[0] * r0->data[i0]] = r->data[r->size[0] *
        i0];
    }

    i++;
  }

  for (i = 0; i < r->size[1]; i++) {
    i0 = theta_matrix->size[0];
    i1 = i + 1;
    if (!((i1 >= 1) && (i1 <= i0))) {
      rtDynamicBoundsError(i1, 1, i0, &emlrtBCI);
    }

    ix = theta_matrix->size[1];
    i0 = r0->size[0];
    r0->size[0] = ix;
    emxEnsureCapacity_int32_T(r0, i0);
    for (i0 = 0; i0 < ix; i0++) {
      r0->data[i0] = i0;
    }

    radialProfile2[0] = 1;
    radialProfile2[1] = r0->size[0];
    rtSubAssignSizeCheck(&radialProfile2[0], 2, &(*(int (*)[2])theta->size)[0],
                         2, &emlrtECI);
    ix = theta->size[1];
    for (i0 = 0; i0 < ix; i0++) {
      theta_matrix->data[i + theta_matrix->size[0] * r0->data[i0]] = theta->
        data[theta->size[0] * i0];
    }
  }

  emxFree_int32_T(&r0);
  emxInit_real_T(&b_theta_matrix, 2);
  i0 = b_theta_matrix->size[0] * b_theta_matrix->size[1];
  b_theta_matrix->size[0] = theta_matrix->size[1];
  b_theta_matrix->size[1] = theta_matrix->size[0];
  emxEnsureCapacity_real_T(b_theta_matrix, i0);
  ix = theta_matrix->size[0];
  for (i0 = 0; i0 < ix; i0++) {
    ixstart = theta_matrix->size[1];
    for (i1 = 0; i1 < ixstart; i1++) {
      b_theta_matrix->data[i1 + b_theta_matrix->size[0] * i0] =
        theta_matrix->data[i0 + theta_matrix->size[0] * i1];
    }
  }

  i0 = theta_matrix->size[0] * theta_matrix->size[1];
  theta_matrix->size[0] = b_theta_matrix->size[0];
  theta_matrix->size[1] = b_theta_matrix->size[1];
  emxEnsureCapacity_real_T(theta_matrix, i0);
  ix = b_theta_matrix->size[1];
  for (i0 = 0; i0 < ix; i0++) {
    ixstart = b_theta_matrix->size[0];
    for (i1 = 0; i1 < ixstart; i1++) {
      theta_matrix->data[i1 + theta_matrix->size[0] * i0] = b_theta_matrix->
        data[i1 + b_theta_matrix->size[0] * i0];
    }
  }

  emxFree_real_T(&b_theta_matrix);
  emxInit_real_T(&radial_result, 2);

  /*  x = xc+r_matrix.*cos(theta_matrix); */
  /*  y = yc+r_matrix.*sin(theta_matrix); */
  /*  x1=floor(x); */
  /*  y1=floor(y); */
  /*  x2=x1+1; */
  /*  y2=y1+1; */
  /*  % 第三步， */
  /*    radial_result = zeros(size(theta,2),size(r,2)); */
  /*  parfor i = 1:size(theta,2) */
  /*      radial_result2 = zeros(1,size(r,2)); */
  /*      for j = 1:size(r,2) */
  /*          radial_result2(j) = img_array(x1(i,j),y1(i,j))*(x2(i,j)-x(i,j))*(y2(i,j)-y(i,j))+img_array(x1(i,j),y2(i,j))*(x2(i,j)-x(i,j))*(y(i,j)-y1(i,j))... */
  /*              +img_array(x2(i,j),y1(i,j))*(x(i,j)-x1(i,j))*(y2(i,j)-y(i,j))+img_array(x2(i,j),y2(i,j))*(x(i,j)-x1(i,j))*(y(i,j)-y1(i,j)); */
  /*      end */
  /*      radial_result(i,:)=radial_result2; */
  /*  end */
  i0 = radial_result->size[0] * radial_result->size[1];
  radial_result->size[0] = theta->size[1];
  radial_result->size[1] = r->size[1];
  emxEnsureCapacity_real_T(radial_result, i0);
  ix = theta->size[1] * r->size[1];
  for (i0 = 0; i0 < ix; i0++) {
    radial_result->data[i0] = 0.0;
  }

  for (i = 0; i < theta->size[1]; i++) {
    for (ixstart = 0; ixstart < r->size[1]; ixstart++) {
      i0 = theta_matrix->size[0];
      i1 = i + 1;
      if (!((i1 >= 1) && (i1 <= i0))) {
        rtDynamicBoundsError(i1, 1, i0, &c_emlrtBCI);
      }

      i0 = theta_matrix->size[1];
      i1 = ixstart + 1;
      if (!((i1 >= 1) && (i1 <= i0))) {
        rtDynamicBoundsError(i1, 1, i0, &d_emlrtBCI);
      }

      i0 = r_matrix->size[0];
      i1 = 1 + i;
      if (!((i1 >= 1) && (i1 <= i0))) {
        rtDynamicBoundsError(i1, 1, i0, &q_emlrtBCI);
      }

      i0 = r_matrix->size[1];
      i2 = 1 + ixstart;
      if (!((i2 >= 1) && (i2 <= i0))) {
        rtDynamicBoundsError(i2, 1, i0, &r_emlrtBCI);
      }

      x = xc + r_matrix->data[(i1 + r_matrix->size[0] * (i2 - 1)) - 1] * cos
        (theta_matrix->data[i + theta_matrix->size[0] * ixstart]);
      i0 = theta_matrix->size[0];
      i1 = i + 1;
      if (!((i1 >= 1) && (i1 <= i0))) {
        rtDynamicBoundsError(i1, 1, i0, &e_emlrtBCI);
      }

      i0 = theta_matrix->size[1];
      i1 = ixstart + 1;
      if (!((i1 >= 1) && (i1 <= i0))) {
        rtDynamicBoundsError(i1, 1, i0, &f_emlrtBCI);
      }

      i0 = r_matrix->size[0];
      i1 = 1 + i;
      if (!((i1 >= 1) && (i1 <= i0))) {
        rtDynamicBoundsError(i1, 1, i0, &s_emlrtBCI);
      }

      i0 = r_matrix->size[1];
      i2 = 1 + ixstart;
      if (!((i2 >= 1) && (i2 <= i0))) {
        rtDynamicBoundsError(i2, 1, i0, &t_emlrtBCI);
      }

      theta_step = yc + r_matrix->data[(i1 + r_matrix->size[0] * (i2 - 1)) - 1] *
        sin(theta_matrix->data[i + theta_matrix->size[0] * ixstart]);
      r_max = floor(x);
      ndbl = floor(theta_step);
      if (r_max != (int)r_max) {
        rtIntegerError(r_max, &h_emlrtDCI);
      }

      i0 = (int)r_max;
      if (!((i0 >= 1) && (i0 <= 80))) {
        rtDynamicBoundsError(i0, 1, 80, &u_emlrtBCI);
      }

      if (ndbl != (int)ndbl) {
        rtIntegerError(ndbl, &i_emlrtDCI);
      }

      i1 = (int)ndbl;
      if (!((i1 >= 1) && (i1 <= 80))) {
        rtDynamicBoundsError(i1, 1, 80, &v_emlrtBCI);
      }

      if (r_max != (int)r_max) {
        rtIntegerError(r_max, &j_emlrtDCI);
      }

      i2 = (int)r_max;
      if (!((i2 >= 1) && (i2 <= 80))) {
        rtDynamicBoundsError(i2, 1, 80, &w_emlrtBCI);
      }

      if (ndbl + 1.0 != (int)(ndbl + 1.0)) {
        rtIntegerError(ndbl + 1.0, &k_emlrtDCI);
      }

      i3 = (int)(ndbl + 1.0);
      if (!((i3 >= 1) && (i3 <= 80))) {
        rtDynamicBoundsError(i3, 1, 80, &x_emlrtBCI);
      }

      if (r_max + 1.0 != (int)(r_max + 1.0)) {
        rtIntegerError(r_max + 1.0, &l_emlrtDCI);
      }

      ix = (int)(r_max + 1.0);
      if (!((ix >= 1) && (ix <= 80))) {
        rtDynamicBoundsError(ix, 1, 80, &y_emlrtBCI);
      }

      if (ndbl != (int)ndbl) {
        rtIntegerError(ndbl, &m_emlrtDCI);
      }

      n = (int)ndbl;
      if (!((n >= 1) && (n <= 80))) {
        rtDynamicBoundsError(n, 1, 80, &ab_emlrtBCI);
      }

      if (r_max + 1.0 != (int)(r_max + 1.0)) {
        rtIntegerError(r_max + 1.0, &n_emlrtDCI);
      }

      i4 = (int)(r_max + 1.0);
      if (!((i4 >= 1) && (i4 <= 80))) {
        rtDynamicBoundsError(i4, 1, 80, &bb_emlrtBCI);
      }

      if (ndbl + 1.0 != (int)(ndbl + 1.0)) {
        rtIntegerError(ndbl + 1.0, &o_emlrtDCI);
      }

      i5 = (int)(ndbl + 1.0);
      if (!((i5 >= 1) && (i5 <= 80))) {
        rtDynamicBoundsError(i5, 1, 80, &cb_emlrtBCI);
      }

      i6 = radial_result->size[0];
      i7 = 1 + i;
      if (!((i7 >= 1) && (i7 <= i6))) {
        rtDynamicBoundsError(i7, 1, i6, &db_emlrtBCI);
      }

      i6 = radial_result->size[1];
      i8 = 1 + ixstart;
      if (!((i8 >= 1) && (i8 <= i6))) {
        rtDynamicBoundsError(i8, 1, i6, &eb_emlrtBCI);
      }

      radial_result->data[(i7 + radial_result->size[0] * (i8 - 1)) - 1] =
        ((b_img_array[(i0 + 80 * (i1 - 1)) - 1] * ((r_max + 1.0) - x) * ((ndbl +
            1.0) - theta_step) + b_img_array[(i2 + 80 * (i3 - 1)) - 1] * ((r_max
            + 1.0) - x) * (theta_step - ndbl)) + b_img_array[(ix + 80 * (n - 1))
         - 1] * (x - r_max) * ((ndbl + 1.0) - theta_step)) + b_img_array[(i4 +
        80 * (i5 - 1)) - 1] * (x - r_max) * (theta_step - ndbl);
    }
  }

  emxFree_real_T(&theta_matrix);

  /*  将计算结果按四个象限平均。 */
  if (1.0 > theta_num_perQ) {
    ix = 0;
  } else {
    i0 = radial_result->size[0];
    if (!(1 <= i0)) {
      rtDynamicBoundsError(1, 1, i0, &g_emlrtBCI);
    }

    if (theta_num_perQ != (int)floor(theta_num_perQ)) {
      rtIntegerError(theta_num_perQ, &emlrtDCI);
    }

    i0 = radial_result->size[0];
    ix = (int)theta_num_perQ;
    if (!((ix >= 1) && (ix <= i0))) {
      rtDynamicBoundsError(ix, 1, i0, &h_emlrtBCI);
    }
  }

  ixstart = radial_result->size[1];
  i0 = r_matrix->size[0] * r_matrix->size[1];
  r_matrix->size[0] = ix;
  r_matrix->size[1] = ixstart;
  emxEnsureCapacity_real_T(r_matrix, i0);
  for (i0 = 0; i0 < ixstart; i0++) {
    for (i1 = 0; i1 < ix; i1++) {
      r_matrix->data[i1 + r_matrix->size[0] * i0] = radial_result->data[i1 +
        radial_result->size[0] * i0];
    }
  }

  mean(r_matrix, theta);
  r_max = 2.0 * theta_num_perQ;
  if (theta_num_perQ + 1.0 > r_max) {
    i0 = 0;
    i2 = 0;
  } else {
    if (theta_num_perQ + 1.0 != (int)floor(theta_num_perQ + 1.0)) {
      rtIntegerError(theta_num_perQ + 1.0, &b_emlrtDCI);
    }

    i0 = radial_result->size[0];
    i1 = (int)(theta_num_perQ + 1.0);
    if (!((i1 >= 1) && (i1 <= i0))) {
      rtDynamicBoundsError(i1, 1, i0, &i_emlrtBCI);
    }

    i0 = i1 - 1;
    if (r_max != (int)floor(r_max)) {
      rtIntegerError(r_max, &c_emlrtDCI);
    }

    i1 = radial_result->size[0];
    i2 = (int)r_max;
    if (!((i2 >= 1) && (i2 <= i1))) {
      rtDynamicBoundsError(i2, 1, i1, &j_emlrtBCI);
    }
  }

  ix = radial_result->size[1];
  i1 = r_matrix->size[0] * r_matrix->size[1];
  r_matrix->size[0] = i2 - i0;
  r_matrix->size[1] = ix;
  emxEnsureCapacity_real_T(r_matrix, i1);
  for (i1 = 0; i1 < ix; i1++) {
    ixstart = i2 - i0;
    for (i3 = 0; i3 < ixstart; i3++) {
      r_matrix->data[i3 + r_matrix->size[0] * i1] = radial_result->data[(i0 + i3)
        + radial_result->size[0] * i1];
    }
  }

  emxInit_real_T(&b_radialProfile2, 2);
  mean(r_matrix, b_radialProfile2);
  r_max = 2.0 * theta_num_perQ + 1.0;
  theta_step = 3.0 * theta_num_perQ;
  if (r_max > theta_step) {
    i0 = 0;
    i2 = 0;
  } else {
    if (r_max != (int)floor(r_max)) {
      rtIntegerError(r_max, &d_emlrtDCI);
    }

    i0 = radial_result->size[0];
    i1 = (int)r_max;
    if (!((i1 >= 1) && (i1 <= i0))) {
      rtDynamicBoundsError(i1, 1, i0, &k_emlrtBCI);
    }

    i0 = i1 - 1;
    if (theta_step != (int)floor(theta_step)) {
      rtIntegerError(theta_step, &e_emlrtDCI);
    }

    i1 = radial_result->size[0];
    i2 = (int)theta_step;
    if (!((i2 >= 1) && (i2 <= i1))) {
      rtDynamicBoundsError(i2, 1, i1, &l_emlrtBCI);
    }
  }

  ix = radial_result->size[1];
  i1 = r_matrix->size[0] * r_matrix->size[1];
  r_matrix->size[0] = i2 - i0;
  r_matrix->size[1] = ix;
  emxEnsureCapacity_real_T(r_matrix, i1);
  for (i1 = 0; i1 < ix; i1++) {
    ixstart = i2 - i0;
    for (i3 = 0; i3 < ixstart; i3++) {
      r_matrix->data[i3 + r_matrix->size[0] * i1] = radial_result->data[(i0 + i3)
        + radial_result->size[0] * i1];
    }
  }

  emxInit_real_T(&radialProfile3, 2);
  mean(r_matrix, radialProfile3);
  r_max = 3.0 * theta_num_perQ + 1.0;
  theta_step = 4.0 * theta_num_perQ;
  if (r_max > theta_step) {
    i0 = 0;
    i2 = 0;
  } else {
    if (r_max != (int)floor(r_max)) {
      rtIntegerError(r_max, &f_emlrtDCI);
    }

    i0 = radial_result->size[0];
    i1 = (int)r_max;
    if (!((i1 >= 1) && (i1 <= i0))) {
      rtDynamicBoundsError(i1, 1, i0, &m_emlrtBCI);
    }

    i0 = i1 - 1;
    if (theta_step != (int)floor(theta_step)) {
      rtIntegerError(theta_step, &g_emlrtDCI);
    }

    i1 = radial_result->size[0];
    i2 = (int)theta_step;
    if (!((i2 >= 1) && (i2 <= i1))) {
      rtDynamicBoundsError(i2, 1, i1, &n_emlrtBCI);
    }
  }

  ix = radial_result->size[1];
  i1 = r_matrix->size[0] * r_matrix->size[1];
  r_matrix->size[0] = i2 - i0;
  r_matrix->size[1] = ix;
  emxEnsureCapacity_real_T(r_matrix, i1);
  for (i1 = 0; i1 < ix; i1++) {
    ixstart = i2 - i0;
    for (i3 = 0; i3 < ixstart; i3++) {
      r_matrix->data[i3 + r_matrix->size[0] * i1] = radial_result->data[(i0 + i3)
        + radial_result->size[0] * i1];
    }
  }

  emxFree_real_T(&radial_result);
  emxInit_real_T(&radialProfile4, 2);
  mean(r_matrix, radialProfile4);

  /*  分别计算X Y 方向的相关曲线，及其下标 */
  emxFree_real_T(&r_matrix);
  for (i0 = 0; i0 < 2; i0++) {
    radialProfile2[i0] = b_radialProfile2->size[i0];
  }

  for (i0 = 0; i0 < 2; i0++) {
    b_radialProfile3[i0] = radialProfile3->size[i0];
  }

  if ((radialProfile2[0] != b_radialProfile3[0]) || (radialProfile2[1] !=
       b_radialProfile3[1])) {
    rtSizeEqNDCheck(&radialProfile2[0], &b_radialProfile3[0], &c_emlrtECI);
  }

  i0 = r->size[0] * r->size[1];
  r->size[0] = 1;
  r->size[1] = b_radialProfile2->size[1];
  emxEnsureCapacity_real_T(r, i0);
  ix = b_radialProfile2->size[0] * b_radialProfile2->size[1];
  for (i0 = 0; i0 < ix; i0++) {
    r->data[i0] = b_radialProfile2->data[i0] + radialProfile3->data[i0];
  }

  for (i0 = 0; i0 < 2; i0++) {
    b_radialProfile3[i0] = theta->size[i0];
  }

  for (i0 = 0; i0 < 2; i0++) {
    radialProfile2[i0] = radialProfile4->size[i0];
  }

  if ((b_radialProfile3[0] != radialProfile2[0]) || (b_radialProfile3[1] !=
       radialProfile2[1])) {
    rtSizeEqNDCheck(&b_radialProfile3[0], &radialProfile2[0], &d_emlrtECI);
  }

  if (2 > r->size[1]) {
    i0 = 0;
    i2 = 0;
  } else {
    i0 = 1;
    i1 = r->size[1];
    i2 = r->size[1];
    if (!((i2 >= 1) && (i2 <= i1))) {
      rtDynamicBoundsError(i2, 1, i1, &o_emlrtBCI);
    }
  }

  emxInit_real_T(&r1, 2);
  i1 = r1->size[0] * r1->size[1];
  r1->size[0] = 1;
  r1->size[1] = i2 - i0;
  emxEnsureCapacity_real_T(r1, i1);
  ix = i2 - i0;
  for (i1 = 0; i1 < ix; i1++) {
    r1->data[r1->size[0] * i1] = r->data[i0 + i1];
  }

  emxInit_real_T(&radial_x, 2);
  flip(r1);
  i0 = radial_x->size[0] * radial_x->size[1];
  radial_x->size[0] = 1;
  radial_x->size[1] = r1->size[1] + theta->size[1];
  emxEnsureCapacity_real_T(radial_x, i0);
  ix = r1->size[1];
  for (i0 = 0; i0 < ix; i0++) {
    radial_x->data[radial_x->size[0] * i0] = r1->data[r1->size[0] * i0];
  }

  ix = theta->size[1];
  for (i0 = 0; i0 < ix; i0++) {
    radial_x->data[radial_x->size[0] * (i0 + r1->size[1])] = theta->data
      [theta->size[0] * i0] + radialProfile4->data[radialProfile4->size[0] * i0];
  }

  i0 = r->size[0] * r->size[1];
  r->size[0] = 1;
  r->size[1] = radial_x->size[1];
  emxEnsureCapacity_real_T(r, i0);
  ix = radial_x->size[0] * radial_x->size[1];
  for (i0 = 0; i0 < ix; i0++) {
    r->data[i0] = radial_x->data[i0];
  }

  flip(r);
  xcorr(radial_x, r, corr_X);
  for (i0 = 0; i0 < 2; i0++) {
    b_radialProfile3[i0] = theta->size[i0];
  }

  for (i0 = 0; i0 < 2; i0++) {
    radialProfile2[i0] = b_radialProfile2->size[i0];
  }

  if ((b_radialProfile3[0] != radialProfile2[0]) || (b_radialProfile3[1] !=
       radialProfile2[1])) {
    rtSizeEqNDCheck(&b_radialProfile3[0], &radialProfile2[0], &e_emlrtECI);
  }

  i0 = theta->size[0] * theta->size[1];
  theta->size[0] = 1;
  emxEnsureCapacity_real_T(theta, i0);
  ixstart = theta->size[0];
  ix = theta->size[1];
  ix *= ixstart;
  for (i0 = 0; i0 < ix; i0++) {
    theta->data[i0] += b_radialProfile2->data[i0];
  }

  emxFree_real_T(&b_radialProfile2);
  for (i0 = 0; i0 < 2; i0++) {
    b_radialProfile3[i0] = radialProfile3->size[i0];
  }

  for (i0 = 0; i0 < 2; i0++) {
    radialProfile2[i0] = radialProfile4->size[i0];
  }

  if ((b_radialProfile3[0] != radialProfile2[0]) || (b_radialProfile3[1] !=
       radialProfile2[1])) {
    rtSizeEqNDCheck(&b_radialProfile3[0], &radialProfile2[0], &f_emlrtECI);
  }

  if (2 > theta->size[1]) {
    i0 = 0;
    i2 = 0;
  } else {
    i0 = 1;
    i1 = theta->size[1];
    i2 = theta->size[1];
    if (!((i2 >= 1) && (i2 <= i1))) {
      rtDynamicBoundsError(i2, 1, i1, &p_emlrtBCI);
    }
  }

  i1 = r1->size[0] * r1->size[1];
  r1->size[0] = 1;
  r1->size[1] = i2 - i0;
  emxEnsureCapacity_real_T(r1, i1);
  ix = i2 - i0;
  for (i1 = 0; i1 < ix; i1++) {
    r1->data[r1->size[0] * i1] = theta->data[i0 + i1];
  }

  flip(r1);
  i0 = theta->size[0] * theta->size[1];
  theta->size[0] = 1;
  theta->size[1] = r1->size[1] + radialProfile3->size[1];
  emxEnsureCapacity_real_T(theta, i0);
  ix = r1->size[1];
  for (i0 = 0; i0 < ix; i0++) {
    theta->data[theta->size[0] * i0] = r1->data[r1->size[0] * i0];
  }

  ix = radialProfile3->size[1];
  for (i0 = 0; i0 < ix; i0++) {
    theta->data[theta->size[0] * (i0 + r1->size[1])] = radialProfile3->
      data[radialProfile3->size[0] * i0] + radialProfile4->data
      [radialProfile4->size[0] * i0];
  }

  emxFree_real_T(&r1);
  emxFree_real_T(&radialProfile4);
  emxFree_real_T(&radialProfile3);
  i0 = r->size[0] * r->size[1];
  r->size[0] = 1;
  r->size[1] = theta->size[1];
  emxEnsureCapacity_real_T(r, i0);
  ix = theta->size[0] * theta->size[1];
  for (i0 = 0; i0 < ix; i0++) {
    r->data[i0] = theta->data[i0];
  }

  flip(r);
  xcorr(theta, r, corr_Y);

  /*  下标换算 */
  emxFree_real_T(&theta);
  emxFree_real_T(&r);
  if (radial_x->size[1] - 1 < 1 - radial_x->size[1]) {
    i0 = r_index->size[0] * r_index->size[1];
    r_index->size[0] = 1;
    r_index->size[1] = 0;
    emxEnsureCapacity_real_T(r_index, i0);
  } else {
    i0 = 1 - radial_x->size[1];
    i1 = radial_x->size[1];
    i2 = r_index->size[0] * r_index->size[1];
    r_index->size[0] = 1;
    r_index->size[1] = i1 - i0;
    emxEnsureCapacity_real_T(r_index, i2);
    ix = i1 - i0;
    for (i1 = 0; i1 < ix; i1++) {
      r_index->data[r_index->size[0] * i1] = i0 + i1;
    }
  }

  emxFree_real_T(&radial_x);

  /*  寻找相关曲线最高点，拟合计算偏移量 */
}

/*
 * File trailer for QI_par.c
 *
 * [EOF]
 */
