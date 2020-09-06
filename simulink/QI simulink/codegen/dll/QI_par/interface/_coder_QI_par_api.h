/*
 * File: _coder_QI_par_api.h
 *
 * MATLAB Coder version            : 3.4
 * C/C++ source code generated on  : 23-Jun-2018 15:45:59
 */

#ifndef _CODER_QI_PAR_API_H
#define _CODER_QI_PAR_API_H

/* Include Files */
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"
#include <stddef.h>
#include <stdlib.h>
#include "_coder_QI_par_api.h"

/* Type Definitions */
#ifndef struct_emxArray_real_T
#define struct_emxArray_real_T

struct emxArray_real_T
{
  real_T *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

#endif                                 /*struct_emxArray_real_T*/

#ifndef typedef_emxArray_real_T
#define typedef_emxArray_real_T

typedef struct emxArray_real_T emxArray_real_T;

#endif                                 /*typedef_emxArray_real_T*/

/* Variable Declarations */
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

/* Function Declarations */
#ifdef __cplusplus

extern "C" {

#endif

  extern void QI_par(uint8_T img_array[6400], real_T xc, real_T yc, real_T
                     r_step, real_T theta_num_perQ, emxArray_real_T *corr_X,
                     emxArray_real_T *corr_Y, emxArray_real_T *r_index);
  extern void QI_par_api(const mxArray * const prhs[5], const mxArray *plhs[3]);
  extern void QI_par_atexit(void);
  extern void QI_par_initialize(void);
  extern void QI_par_terminate(void);
  extern void QI_par_xil_terminate(void);

#ifdef __cplusplus

}
#endif
#endif

/*
 * File trailer for _coder_QI_par_api.h
 *
 * [EOF]
 */
