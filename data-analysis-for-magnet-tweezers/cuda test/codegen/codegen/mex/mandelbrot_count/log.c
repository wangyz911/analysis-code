/*
 * log.c
 *
 * Code generation for function 'log'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "mandelbrot_count.h"
#include "log.h"
#include "error.h"

/* Variable Definitions */
static emlrtRSInfo b_emlrtRSI = { 13,  /* lineNo */
  "log",                               /* fcnName */
  "D:\\Program Files\\MATLAB\\R2017b\\toolbox\\eml\\lib\\matlab\\elfun\\log.m"/* pathName */
};

/* Function Definitions */
void b_log(const emlrtStack *sp, real_T x[1000000])
{
  boolean_T p;
  int32_T k;
  emlrtStack st;
  emlrtStack b_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  p = false;
  for (k = 0; k < 1000000; k++) {
    if (p || (x[k] < 0.0)) {
      p = true;
    } else {
      p = false;
    }
  }

  if (p) {
    st.site = &b_emlrtRSI;
    b_st.site = &b_emlrtRSI;
    error(&b_st);
  }

  for (k = 0; k < 1000000; k++) {
    x[k] = muDoubleScalarLog(x[k]);
  }
}

/* End of code generation (log.c) */
