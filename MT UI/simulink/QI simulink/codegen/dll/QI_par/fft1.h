/*
 * File: fft1.h
 *
 * MATLAB Coder version            : 3.4
 * C/C++ source code generated on  : 23-Jun-2018 15:45:59
 */

#ifndef FFT1_H
#define FFT1_H

/* Include Files */
#include <math.h>
#include <stddef.h>
#include <stdlib.h>
#include <string.h>
#include "rt_nonfinite.h"
#include "rtwtypes.h"
#include "QI_par_types.h"

/* Function Declarations */
#ifdef __cplusplus

extern "C" {

#endif

  extern void b_generate_twiddle_tables(int nRows, boolean_T useRadix2,
    emxArray_real_T *costab, emxArray_real_T *sintab, emxArray_real_T *sintabinv);
  extern void b_r2br_r2dit_trig_impl(const emxArray_creal_T *x, int
    unsigned_nRows, const emxArray_real_T *costab, const emxArray_real_T *sintab,
    emxArray_creal_T *y);
  extern void generate_twiddle_tables(int nRows, boolean_T useRadix2,
    emxArray_real_T *costab, emxArray_real_T *sintab, emxArray_real_T *sintabinv);
  extern void get_algo_sizes(int n1, boolean_T useRadix2, int *N2blue, int
    *nRows);
  extern void r2br_r2dit_trig(const emxArray_creal_T *x, int n1_unsigned, const
    emxArray_real_T *costab, const emxArray_real_T *sintab, emxArray_creal_T *y);
  extern void r2br_r2dit_trig_impl(const emxArray_creal_T *x, int unsigned_nRows,
    const emxArray_real_T *costab, const emxArray_real_T *sintab,
    emxArray_creal_T *y);

#ifdef __cplusplus

}
#endif
#endif

/*
 * File trailer for fft1.h
 *
 * [EOF]
 */
