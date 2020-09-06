/*
 * File: QI_par_types.h
 *
 * MATLAB Coder version            : 3.4
 * C/C++ source code generated on  : 23-Jun-2018 15:45:59
 */

#ifndef QI_PAR_TYPES_H
#define QI_PAR_TYPES_H

/* Include Files */
#include "rtwtypes.h"

/* Type Definitions */
#ifndef struct_emxArray_creal_T
#define struct_emxArray_creal_T

struct emxArray_creal_T
{
  creal_T *data;
  int *size;
  int allocatedSize;
  int numDimensions;
  boolean_T canFreeData;
};

#endif                                 /*struct_emxArray_creal_T*/

#ifndef typedef_emxArray_creal_T
#define typedef_emxArray_creal_T

typedef struct emxArray_creal_T emxArray_creal_T;

#endif                                 /*typedef_emxArray_creal_T*/

#ifndef struct_emxArray_int32_T
#define struct_emxArray_int32_T

struct emxArray_int32_T
{
  int *data;
  int *size;
  int allocatedSize;
  int numDimensions;
  boolean_T canFreeData;
};

#endif                                 /*struct_emxArray_int32_T*/

#ifndef typedef_emxArray_int32_T
#define typedef_emxArray_int32_T

typedef struct emxArray_int32_T emxArray_int32_T;

#endif                                 /*typedef_emxArray_int32_T*/

#ifndef struct_emxArray_real_T
#define struct_emxArray_real_T

struct emxArray_real_T
{
  double *data;
  int *size;
  int allocatedSize;
  int numDimensions;
  boolean_T canFreeData;
};

#endif                                 /*struct_emxArray_real_T*/

#ifndef typedef_emxArray_real_T
#define typedef_emxArray_real_T

typedef struct emxArray_real_T emxArray_real_T;

#endif                                 /*typedef_emxArray_real_T*/

#ifndef typedef_rtBoundsCheckInfo
#define typedef_rtBoundsCheckInfo

typedef struct {
  int iFirst;
  int iLast;
  int lineNo;
  int colNo;
  const char * aName;
  const char * fName;
  const char * pName;
  int checkKind;
} rtBoundsCheckInfo;

#endif                                 /*typedef_rtBoundsCheckInfo*/

#ifndef typedef_rtDoubleCheckInfo
#define typedef_rtDoubleCheckInfo

typedef struct {
  int lineNo;
  int colNo;
  const char * fName;
  const char * pName;
  int checkKind;
} rtDoubleCheckInfo;

#endif                                 /*typedef_rtDoubleCheckInfo*/

#ifndef typedef_rtEqualityCheckInfo
#define typedef_rtEqualityCheckInfo

typedef struct {
  int nDims;
  int lineNo;
  int colNo;
  const char * fName;
  const char * pName;
} rtEqualityCheckInfo;

#endif                                 /*typedef_rtEqualityCheckInfo*/

#ifndef typedef_rtRunTimeErrorInfo
#define typedef_rtRunTimeErrorInfo

typedef struct {
  int lineNo;
  int colNo;
  const char * fName;
  const char * pName;
} rtRunTimeErrorInfo;

#endif                                 /*typedef_rtRunTimeErrorInfo*/
#endif

/*
 * File trailer for QI_par_types.h
 *
 * [EOF]
 */
