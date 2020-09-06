/*
 * File: ifft.c
 *
 * MATLAB Coder version            : 3.4
 * C/C++ source code generated on  : 23-Jun-2018 15:45:59
 */

/* Include Files */
#include "rt_nonfinite.h"
#include "QI_par.h"
#include "ifft.h"
#include "QI_par_emxutil.h"
#include "fft1.h"
#include "eml_int_forloop_overflow_check.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Function Definitions */

/*
 * Arguments    : const emxArray_creal_T *x
 *                emxArray_creal_T *y
 * Return Type  : void
 */
void ifft(const emxArray_creal_T *x, emxArray_creal_T *y)
{
  int n1;
  emxArray_real_T *costab;
  int rt;
  emxArray_real_T *sintab;
  emxArray_real_T *sintabinv;
  boolean_T useRadix2;
  int N2blue;
  int idx;
  emxArray_creal_T *wwc;
  int nInt2m1;
  int nInt2;
  int k;
  int b_y;
  double denom_im;
  double denom_re;
  double fy_im;
  double wwc_re;
  double fv_im;
  emxArray_creal_T *fy;
  double wwc_im;
  emxArray_creal_T *fv;
  double fv_re;
  double b_fv_im;
  double b_fv_re;
  n1 = x->size[0];
  if (x->size[0] == 0) {
    rt = y->size[0];
    y->size[0] = 0;
    emxEnsureCapacity_creal_T(y, rt);
  } else {
    emxInit_real_T(&costab, 2);
    emxInit_real_T(&sintab, 2);
    emxInit_real_T(&sintabinv, 2);
    useRadix2 = ((x->size[0] & (x->size[0] - 1)) == 0);
    get_algo_sizes(x->size[0], useRadix2, &N2blue, &idx);
    b_generate_twiddle_tables(idx, useRadix2, costab, sintab, sintabinv);
    if (useRadix2) {
      r2br_r2dit_trig(x, x->size[0], costab, sintab, y);
    } else {
      emxInit_creal_T(&wwc, 1);
      nInt2m1 = (x->size[0] + x->size[0]) - 1;
      rt = wwc->size[0];
      wwc->size[0] = nInt2m1;
      emxEnsureCapacity_creal_T(wwc, rt);
      idx = x->size[0];
      rt = 0;
      wwc->data[x->size[0] - 1].re = 1.0;
      wwc->data[x->size[0] - 1].im = 0.0;
      nInt2 = x->size[0] << 1;
      for (k = 1; k < n1; k++) {
        b_y = (k << 1) - 1;
        if (nInt2 - rt <= b_y) {
          rt += b_y - nInt2;
        } else {
          rt += b_y;
        }

        denom_im = 3.1415926535897931 * (double)rt / (double)x->size[0];
        if (denom_im == 0.0) {
          denom_re = 1.0;
          denom_im = 0.0;
        } else {
          denom_re = cos(denom_im);
          denom_im = sin(denom_im);
        }

        wwc->data[idx - 2].re = denom_re;
        wwc->data[idx - 2].im = -denom_im;
        idx--;
      }

      idx = 0;
      for (k = nInt2m1 - 1; k >= n1; k--) {
        wwc->data[k] = wwc->data[idx];
        idx++;
      }

      nInt2 = x->size[0];
      idx = x->size[0];
      rt = y->size[0];
      y->size[0] = idx;
      emxEnsureCapacity_creal_T(y, rt);
      idx = 0;
      if (nInt2 > 2147483646) {
        check_forloop_overflow_error();
      }

      for (k = 0; k + 1 <= nInt2; k++) {
        denom_re = wwc->data[(n1 + k) - 1].re;
        denom_im = wwc->data[(n1 + k) - 1].im;
        fy_im = x->data[idx].re;
        wwc_re = x->data[idx].im;
        fv_im = x->data[idx].im;
        wwc_im = x->data[idx].re;
        y->data[k].re = denom_re * fy_im + denom_im * wwc_re;
        y->data[k].im = denom_re * fv_im - denom_im * wwc_im;
        idx++;
      }

      useRadix2 = ((!(nInt2 + 1 > x->size[0])) && (x->size[0] > 2147483646));
      if (useRadix2) {
        check_forloop_overflow_error();
      }

      while (nInt2 + 1 <= n1) {
        y->data[nInt2].re = 0.0;
        y->data[nInt2].im = 0.0;
        nInt2++;
      }

      emxInit_creal_T(&fy, 1);
      emxInit_creal_T(&fv, 1);
      r2br_r2dit_trig_impl(y, N2blue, costab, sintab, fy);
      b_r2br_r2dit_trig_impl(wwc, N2blue, costab, sintab, fv);
      rt = fy->size[0];
      emxEnsureCapacity_creal_T(fy, rt);
      idx = fy->size[0];
      for (rt = 0; rt < idx; rt++) {
        denom_im = fy->data[rt].re;
        fy_im = fy->data[rt].im;
        fv_re = fv->data[rt].re;
        b_fv_im = fv->data[rt].im;
        fy->data[rt].re = denom_im * fv_re - fy_im * b_fv_im;
        fy->data[rt].im = denom_im * b_fv_im + fy_im * fv_re;
      }

      r2br_r2dit_trig(fy, N2blue, costab, sintabinv, fv);
      idx = 0;
      denom_re = x->size[0];
      emxFree_creal_T(&fy);
      useRadix2 = ((!(x->size[0] > wwc->size[0])) && (wwc->size[0] > 2147483646));
      if (useRadix2) {
        check_forloop_overflow_error();
      }

      for (k = x->size[0] - 1; k + 1 <= wwc->size[0]; k++) {
        fy_im = wwc->data[k].re;
        fv_re = fv->data[k].re;
        denom_im = wwc->data[k].im;
        b_fv_im = fv->data[k].im;
        wwc_re = wwc->data[k].re;
        fv_im = fv->data[k].im;
        wwc_im = wwc->data[k].im;
        b_fv_re = fv->data[k].re;
        y->data[idx].re = fy_im * fv_re + denom_im * b_fv_im;
        y->data[idx].im = wwc_re * fv_im - wwc_im * b_fv_re;
        fy_im = wwc->data[k].re;
        fv_re = fv->data[k].re;
        denom_im = wwc->data[k].im;
        b_fv_im = fv->data[k].im;
        wwc_re = wwc->data[k].re;
        fv_im = fv->data[k].im;
        wwc_im = wwc->data[k].im;
        b_fv_re = fv->data[k].re;
        y->data[idx].re = fy_im * fv_re + denom_im * b_fv_im;
        y->data[idx].im = wwc_re * fv_im - wwc_im * b_fv_re;
        denom_im = y->data[idx].re;
        fy_im = y->data[idx].im;
        if (fy_im == 0.0) {
          y->data[idx].re = denom_im / denom_re;
          y->data[idx].im = 0.0;
        } else if (denom_im == 0.0) {
          y->data[idx].re = 0.0;
          y->data[idx].im = fy_im / denom_re;
        } else {
          y->data[idx].re = denom_im / denom_re;
          y->data[idx].im = fy_im / denom_re;
        }

        idx++;
      }

      emxFree_creal_T(&fv);
      emxFree_creal_T(&wwc);
    }

    emxFree_real_T(&sintabinv);
    emxFree_real_T(&sintab);
    emxFree_real_T(&costab);
  }
}

/*
 * File trailer for ifft.c
 *
 * [EOF]
 */
