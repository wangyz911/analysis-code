/*
 * File: QI_par_initialize.c
 *
 * MATLAB Coder version            : 3.4
 * C/C++ source code generated on  : 23-Jun-2018 15:45:59
 */

/* Include Files */
#include "rt_nonfinite.h"
#include "QI_par.h"
#include "QI_par_initialize.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Function Definitions */

/*
 * Arguments    : void
 * Return Type  : void
 */
void QI_par_initialize(void)
{
  rt_InitInfAndNaN(8U);
}

/*
 * File trailer for QI_par_initialize.c
 *
 * [EOF]
 */
