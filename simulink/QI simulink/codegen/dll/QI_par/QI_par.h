/*
 * File: QI_par.h
 *
 * MATLAB Coder version            : 3.4
 * C/C++ source code generated on  : 23-Jun-2018 15:45:59
 */

#ifndef QI_PAR_H
#define QI_PAR_H

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

  extern void QI_par(const unsigned char img_array[6400], double xc, double yc,
                     double r_step, double theta_num_perQ, emxArray_real_T
                     *corr_X, emxArray_real_T *corr_Y, emxArray_real_T *r_index);

#ifdef __cplusplus

}
#endif
#endif

/*
 * File trailer for QI_par.h
 *
 * [EOF]
 */
