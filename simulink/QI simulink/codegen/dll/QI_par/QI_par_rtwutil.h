/*
 * File: QI_par_rtwutil.h
 *
 * MATLAB Coder version            : 3.4
 * C/C++ source code generated on  : 23-Jun-2018 15:45:59
 */

#ifndef QI_PAR_RTWUTIL_H
#define QI_PAR_RTWUTIL_H

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

  extern void b_rtErrorWithMessageID(const int b, const char *c, const
    rtRunTimeErrorInfo *aInfo);
  extern void c_rtErrorWithMessageID(const rtRunTimeErrorInfo *aInfo);
  extern void d_rtErrorWithMessageID(const rtRunTimeErrorInfo *aInfo);
  extern void e_rtErrorWithMessageID(const int b, const char *c, const
    rtRunTimeErrorInfo *aInfo);
  extern void f_rtErrorWithMessageID(const rtRunTimeErrorInfo *aInfo);
  extern void g_rtErrorWithMessageID(const rtRunTimeErrorInfo *aInfo);
  extern void h_rtErrorWithMessageID(const rtRunTimeErrorInfo *aInfo);
  extern void rtDynamicBoundsError(int aIndexValue, int aLoBound, int aHiBound,
    const rtBoundsCheckInfo *aInfo);
  extern void rtErrorWithMessageID(const rtRunTimeErrorInfo *aInfo);
  extern void rtIntegerError(const double aInteger, const rtDoubleCheckInfo
    *aInfo);
  extern void rtNonNegativeError(const double aPositive, const rtDoubleCheckInfo
    *aInfo);
  extern void rtSizeEq1DError(const int aDim1, const int aDim2, const
    rtEqualityCheckInfo *aInfo);
  extern void rtSizeEqNDCheck(const int *aDims1, const int *aDims2, const
    rtEqualityCheckInfo *aInfo);
  extern void rtSubAssignSizeCheck(const int *aDims1, const int aNDims1, const
    int *aDims2, const int aNDims2, const rtEqualityCheckInfo *aInfo);

#ifdef __cplusplus

}
#endif
#endif

/*
 * File trailer for QI_par_rtwutil.h
 *
 * [EOF]
 */
