/*
 * _coder_cuda_1_api.cu
 *
 * Code generation for function '_coder_cuda_1_api'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "cuda_1.h"
#include "_coder_cuda_1_api.h"
#include "cuda_1_data.h"

/* Function Declarations */
static real_T (*b_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId))[1000000];
static real_T c_emlrt_marshallIn(const mxArray *n, const char_T *identifier);
static real_T d_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId);
static real_T (*e_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *
  msgId))[1000000];
static real_T (*emlrt_marshallIn(const mxArray *x, const char_T *identifier))
  [1000000];
static const mxArray *emlrt_marshallOut(const real_T u_data[], const int32_T
  u_size[2]);
static real_T f_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId);

/* Function Definitions */
static real_T (*b_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId))[1000000]
{
  real_T (*y)[1000000];
  y = e_emlrt_marshallIn(emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}
  static real_T c_emlrt_marshallIn(const mxArray *n, const char_T *identifier)
{
  real_T y;
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = d_emlrt_marshallIn(emlrtAlias(n), &thisId);
  emlrtDestroyArray(&n);
  return y;
}

static real_T d_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId)
{
  real_T y;
  y = f_emlrt_marshallIn(emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static real_T (*e_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *
  msgId))[1000000]
{
  real_T (*ret)[1000000];
  static const int32_T dims[2] = { 1000, 1000 };

  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 2U,
    dims);
  ret = (real_T (*)[1000000])emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}
  static real_T (*emlrt_marshallIn(const mxArray *x, const char_T *identifier))
  [1000000]
{
  real_T (*y)[1000000];
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = b_emlrt_marshallIn(emlrtAlias(x), &thisId);
  emlrtDestroyArray(&x);
  return y;
}

static const mxArray *emlrt_marshallOut(const real_T u_data[], const int32_T
  u_size[2])
{
  const mxArray *y;
  const mxArray *m0;
  static const int32_T iv0[2] = { 0, 0 };

  y = NULL;
  m0 = emlrtCreateNumericArray(2, iv0, mxDOUBLE_CLASS, mxREAL);
  emlrtMxSetData((mxArray *)m0, (void *)&u_data[0]);
  emlrtSetDimensions((mxArray *)m0, u_size, 2);
  emlrtAssign(&y, m0);
  return y;
}

static real_T f_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId)
{
  real_T ret;
  static const int32_T dims = 0;
  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 0U,
    &dims);
  ret = *(real_T *)emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

void cuda_1_api(const mxArray * const prhs[2], const mxArray *plhs[1])
{
  real_T (*y_data)[1000000];
  real_T (*x)[1000000];
  real_T n;
  int32_T y_size[2];
  y_data = (real_T (*)[1000000])mxMalloc(sizeof(real_T [1000000]));

  /* Marshall function inputs */
  x = emlrt_marshallIn(emlrtAlias(prhs[0]), "x");
  n = c_emlrt_marshallIn(emlrtAliasP(prhs[1]), "n");

  /* Invoke the target function */
  cuda_1(*x, n, *y_data, y_size);

  /* Marshall function outputs */
  plhs[0] = emlrt_marshallOut(*y_data, y_size);
}

/* End of code generation (_coder_cuda_1_api.cu) */
