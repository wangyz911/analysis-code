/*
 * File: isequal.c
 *
 * MATLAB Coder version            : 3.4
 * C/C++ source code generated on  : 23-Jun-2018 15:45:59
 */

/* Include Files */
#include "rt_nonfinite.h"
#include "QI_par.h"
#include "isequal.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Function Definitions */

/*
 * Arguments    : const emxArray_real_T *varargin_1
 * Return Type  : boolean_T
 */
boolean_T isequal(const emxArray_real_T *varargin_1)
{
  boolean_T p;
  boolean_T b_p;
  p = false;
  b_p = false;
  if ((varargin_1->size[0] != 0) || (varargin_1->size[1] != 0)) {
  } else {
    b_p = true;
  }

  if (b_p) {
    p = true;
  }

  return p;
}

/*
 * File trailer for isequal.c
 *
 * [EOF]
 */
