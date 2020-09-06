/*
 * File: fft.c
 *
 * MATLAB Coder version            : 3.4
 * C/C++ source code generated on  : 23-Jun-2018 15:45:59
 */

/* Include Files */
#include "rt_nonfinite.h"
#include "QI_par.h"
#include "fft.h"
#include "QI_par_emxutil.h"
#include "eml_int_forloop_overflow_check.h"
#include "fft1.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Function Definitions */

/*
 * Arguments    : const emxArray_real_T *x
 *                double varargin_1
 *                emxArray_creal_T *y
 * Return Type  : void
 */
void fft(const emxArray_real_T *x, double varargin_1, emxArray_creal_T *y)
{
  emxArray_real_T *costab;
  emxArray_real_T *sintab;
  emxArray_real_T *sintabinv;
  emxArray_creal_T *wwc;
  emxArray_creal_T *fy;
  emxArray_creal_T *fv;
  boolean_T useRadix2;
  int nInt2;
  int N2blue;
  int idx;
  int nInt2m1;
  int ihi;
  int nRowsD2;
  int nRowsD4;
  int rt;
  int j;
  double nt_im;
  double nt_re;
  double temp_re;
  double temp_im;
  double fv_re;
  double fv_im;
  double wwc_im;
  double b_fv_re;
  emxInit_real_T(&costab, 2);
  emxInit_real_T(&sintab, 2);
  emxInit_real_T(&sintabinv, 2);
  emxInit_creal_T(&wwc, 1);
  emxInit_creal_T(&fy, 1);
  emxInit_creal_T(&fv, 1);
  if ((x->size[0] == 0) || ((int)varargin_1 == 0)) {
    nInt2 = y->size[0];
    y->size[0] = (int)varargin_1;
    emxEnsureCapacity_creal_T(y, nInt2);
    if ((int)varargin_1 > x->size[0]) {
      ihi = y->size[0];
      nInt2 = y->size[0];
      y->size[0] = ihi;
      emxEnsureCapacity_creal_T(y, nInt2);
      for (nInt2 = 0; nInt2 < ihi; nInt2++) {
        y->data[nInt2].re = 0.0;
        y->data[nInt2].im = 0.0;
      }
    }
  } else {
    useRadix2 = (((int)varargin_1 & ((int)varargin_1 - 1)) == 0);
    get_algo_sizes((int)varargin_1, useRadix2, &N2blue, &idx);
    generate_twiddle_tables(idx, useRadix2, costab, sintab, sintabinv);
    if (useRadix2) {
      if (x->size[0] < (int)varargin_1) {
        nInt2m1 = x->size[0] - 1;
      } else {
        nInt2m1 = (int)varargin_1 - 1;
      }

      nRowsD2 = (int)varargin_1 / 2;
      nRowsD4 = nRowsD2 / 2;
      nInt2 = y->size[0];
      y->size[0] = (int)varargin_1;
      emxEnsureCapacity_creal_T(y, nInt2);
      if ((int)varargin_1 > x->size[0]) {
        ihi = y->size[0];
        nInt2 = y->size[0];
        y->size[0] = ihi;
        emxEnsureCapacity_creal_T(y, nInt2);
        for (nInt2 = 0; nInt2 < ihi; nInt2++) {
          y->data[nInt2].re = 0.0;
          y->data[nInt2].im = 0.0;
        }
      }

      rt = 0;
      nInt2 = 0;
      idx = 0;
      if ((!(1 > nInt2m1)) && (nInt2m1 > 2147483646)) {
        check_forloop_overflow_error();
      }

      for (N2blue = 1; N2blue <= nInt2m1; N2blue++) {
        y->data[idx].re = x->data[rt];
        y->data[idx].im = 0.0;
        idx = (int)varargin_1;
        useRadix2 = true;
        while (useRadix2) {
          idx >>= 1;
          nInt2 ^= idx;
          useRadix2 = ((nInt2 & idx) == 0);
        }

        idx = nInt2;
        rt++;
      }

      y->data[idx].re = x->data[rt];
      y->data[idx].im = 0.0;
      if ((int)varargin_1 > 1) {
        for (N2blue = 0; N2blue <= (int)varargin_1 - 2; N2blue += 2) {
          temp_re = y->data[N2blue + 1].re;
          temp_im = y->data[N2blue + 1].im;
          y->data[N2blue + 1].re = y->data[N2blue].re - y->data[N2blue + 1].re;
          y->data[N2blue + 1].im = y->data[N2blue].im - y->data[N2blue + 1].im;
          y->data[N2blue].re += temp_re;
          y->data[N2blue].im += temp_im;
        }
      }

      idx = 2;
      rt = 4;
      nInt2 = 1 + ((nRowsD4 - 1) << 2);
      while (nRowsD4 > 0) {
        for (N2blue = 0; N2blue < nInt2; N2blue += rt) {
          temp_re = y->data[N2blue + idx].re;
          temp_im = y->data[N2blue + idx].im;
          y->data[N2blue + idx].re = y->data[N2blue].re - temp_re;
          y->data[N2blue + idx].im = y->data[N2blue].im - temp_im;
          y->data[N2blue].re += temp_re;
          y->data[N2blue].im += temp_im;
        }

        nInt2m1 = 1;
        for (j = nRowsD4; j < nRowsD2; j += nRowsD4) {
          nt_re = costab->data[j];
          nt_im = sintab->data[j];
          N2blue = nInt2m1;
          ihi = nInt2m1 + nInt2;
          while (N2blue < ihi) {
            temp_re = nt_re * y->data[N2blue + idx].re - nt_im * y->data[N2blue
              + idx].im;
            temp_im = nt_re * y->data[N2blue + idx].im + nt_im * y->data[N2blue
              + idx].re;
            y->data[N2blue + idx].re = y->data[N2blue].re - temp_re;
            y->data[N2blue + idx].im = y->data[N2blue].im - temp_im;
            y->data[N2blue].re += temp_re;
            y->data[N2blue].im += temp_im;
            N2blue += rt;
          }

          nInt2m1++;
        }

        nRowsD4 /= 2;
        idx = rt;
        rt += rt;
        nInt2 -= idx;
      }
    } else {
      nInt2m1 = ((int)varargin_1 + (int)varargin_1) - 1;
      nInt2 = wwc->size[0];
      wwc->size[0] = nInt2m1;
      emxEnsureCapacity_creal_T(wwc, nInt2);
      idx = (int)varargin_1;
      rt = 0;
      wwc->data[(int)varargin_1 - 1].re = 1.0;
      wwc->data[(int)varargin_1 - 1].im = 0.0;
      nInt2 = (int)varargin_1 << 1;
      if ((!(1 > (int)varargin_1 - 1)) && ((int)varargin_1 - 1 > 2147483646)) {
        check_forloop_overflow_error();
      }

      for (j = 1; j < (int)varargin_1; j++) {
        ihi = (j << 1) - 1;
        if (nInt2 - rt <= ihi) {
          rt += ihi - nInt2;
        } else {
          rt += ihi;
        }

        nt_im = -3.1415926535897931 * (double)rt / (double)(int)varargin_1;
        if (nt_im == 0.0) {
          nt_re = 1.0;
          nt_im = 0.0;
        } else {
          nt_re = cos(nt_im);
          nt_im = sin(nt_im);
        }

        wwc->data[idx - 2].re = nt_re;
        wwc->data[idx - 2].im = -nt_im;
        idx--;
      }

      idx = 0;
      for (j = nInt2m1 - 1; j >= (int)varargin_1; j--) {
        wwc->data[j] = wwc->data[idx];
        idx++;
      }

      idx = (int)varargin_1;
      rt = x->size[0];
      if (idx < rt) {
        rt = idx;
      }

      nInt2 = y->size[0];
      y->size[0] = (int)varargin_1;
      emxEnsureCapacity_creal_T(y, nInt2);
      if ((int)varargin_1 > x->size[0]) {
        ihi = y->size[0];
        nInt2 = y->size[0];
        y->size[0] = ihi;
        emxEnsureCapacity_creal_T(y, nInt2);
        for (nInt2 = 0; nInt2 < ihi; nInt2++) {
          y->data[nInt2].re = 0.0;
          y->data[nInt2].im = 0.0;
        }
      }

      idx = 0;
      if ((!(1 > rt)) && (rt > 2147483646)) {
        check_forloop_overflow_error();
      }

      for (j = 0; j + 1 <= rt; j++) {
        nt_re = wwc->data[((int)varargin_1 + j) - 1].re;
        nt_im = wwc->data[((int)varargin_1 + j) - 1].im;
        y->data[j].re = nt_re * x->data[idx];
        y->data[j].im = nt_im * -x->data[idx];
        idx++;
      }

      if ((!(rt + 1 > (int)varargin_1)) && ((int)varargin_1 > 2147483646)) {
        check_forloop_overflow_error();
      }

      while (rt + 1 <= (int)varargin_1) {
        y->data[rt].re = 0.0;
        y->data[rt].im = 0.0;
        rt++;
      }

      r2br_r2dit_trig_impl(y, N2blue, costab, sintab, fy);
      b_r2br_r2dit_trig_impl(wwc, N2blue, costab, sintab, fv);
      nInt2 = fy->size[0];
      emxEnsureCapacity_creal_T(fy, nInt2);
      idx = fy->size[0];
      for (nInt2 = 0; nInt2 < idx; nInt2++) {
        nt_re = fy->data[nInt2].re;
        nt_im = fy->data[nInt2].im;
        fv_re = fv->data[nInt2].re;
        fv_im = fv->data[nInt2].im;
        fy->data[nInt2].re = nt_re * fv_re - nt_im * fv_im;
        fy->data[nInt2].im = nt_re * fv_im + nt_im * fv_re;
      }

      r2br_r2dit_trig(fy, N2blue, costab, sintabinv, fv);
      idx = 0;
      useRadix2 = ((!((int)varargin_1 > wwc->size[0])) && (wwc->size[0] >
        2147483646));
      if (useRadix2) {
        check_forloop_overflow_error();
      }

      for (j = (int)varargin_1 - 1; j + 1 <= wwc->size[0]; j++) {
        nt_re = wwc->data[j].re;
        fv_re = fv->data[j].re;
        nt_im = wwc->data[j].im;
        fv_im = fv->data[j].im;
        temp_re = wwc->data[j].re;
        temp_im = fv->data[j].im;
        wwc_im = wwc->data[j].im;
        b_fv_re = fv->data[j].re;
        y->data[idx].re = nt_re * fv_re + nt_im * fv_im;
        y->data[idx].im = temp_re * temp_im - wwc_im * b_fv_re;
        idx++;
      }
    }
  }

  emxFree_creal_T(&fv);
  emxFree_creal_T(&fy);
  emxFree_creal_T(&wwc);
  emxFree_real_T(&sintabinv);
  emxFree_real_T(&sintab);
  emxFree_real_T(&costab);
}

/*
 * File trailer for fft.c
 *
 * [EOF]
 */
