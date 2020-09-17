/*
 * File: flip.c
 *
 * MATLAB Coder version            : 3.4
 * C/C++ source code generated on  : 23-Jun-2018 15:45:59
 */

/* Include Files */
#include "rt_nonfinite.h"
#include "QI_par.h"
#include "flip.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Function Definitions */

/*
 * Arguments    : emxArray_real_T *x
 * Return Type  : void
 */
void flip(emxArray_real_T *x)
{
  int n;
  int nd2;
  int k;
  double tmp;
  if ((!(x->size[1] == 0)) && (x->size[1] > 1)) {
    n = x->size[1];
    nd2 = x->size[1] >> 1;
    for (k = 1; k <= nd2; k++) {
      tmp = x->data[k - 1];
      x->data[k - 1] = x->data[n - k];
      x->data[n - k] = tmp;
    }
  }
}

/*
 * File trailer for flip.c
 *
 * [EOF]
 */
