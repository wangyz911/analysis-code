/*
 * File: _coder_mandelbrot_count_api.c
 *
 * GPU Coder version                    : 1.0
 * CUDA/C/C++ source code generated on  : 26-Dec-2017 22:57:54
 */

/* Include Files */
#include "tmwtypes.h"
#include "_coder_mandelbrot_count_api.h"
#include "_coder_mandelbrot_count_mex.h"

/* Variable Definitions */
emlrtCTX emlrtRootTLSGlobal = NULL;
static boolean_T xilAlreadyInited;
emlrtContext emlrtContextGlobal = { true,/* bFirstTime */
  false,                               /* bInitialized */
  131451U,                             /* fVersionInfo */
  NULL,                                /* fErrorFunction */
  "mandelbrot_count",                  /* fFunctionName */
  NULL,                                /* fRTCallStack */
  false,                               /* bDebugMode */
  { 2045744189U, 2170104910U, 2743257031U, 4284093946U },/* fSigWrd */
  NULL                                 /* fSigMem */
};

/* Function Declarations */
static real_T b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId);
static void b_xilHostSerializer(const real_T b[1000000]);
static real_T (*c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *xGrid,
  const char_T *identifier))[1000000];
static real_T (*d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId))[1000000];
static real_T e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId);
static real_T emlrt_marshallIn(const emlrtStack *sp, const mxArray
  *maxIterations, const char_T *identifier);
static const mxArray *emlrt_marshallOut(const real_T u[1000000]);
static real_T (*f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[1000000];
static void mandelbrot_count_once(void);
static void xilHostDeserializer(real_T b[1000000]);
static void xilHostSerializer(const real_T *b);

/* Function Definitions */

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 * Return Type  : real_T
 */
static real_T b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId)
{
  real_T y;
  y = e_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

/*
 * Arguments    : const real_T b[1000000]
 * Return Type  : void
 */
static void b_xilHostSerializer(const real_T b[1000000])
{
  xilWriteData((uint8_T *)b, (size_t)1000000, MEM_UNIT_DOUBLE_TYPE);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *xGrid
 *                const char_T *identifier
 * Return Type  : real_T (*)[1000000]
 */
static real_T (*c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *xGrid,
  const char_T *identifier))[1000000]
{
  real_T (*y)[1000000];
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = d_emlrt_marshallIn(sp, emlrtAlias(xGrid), &thisId);
  emlrtDestroyArray(&xGrid);
  return y;
}
/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 * Return Type  : real_T (*)[1000000]
 */
  static real_T (*d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
  const emlrtMsgIdentifier *parentId))[1000000]
{
  real_T (*y)[1000000];
  y = f_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 * Return Type  : real_T
 */
static real_T e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId)
{
  real_T ret;
  static const int32_T dims = 0;
  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 0U, &dims);
  ret = *(real_T *)emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *maxIterations
 *                const char_T *identifier
 * Return Type  : real_T
 */
static real_T emlrt_marshallIn(const emlrtStack *sp, const mxArray
  *maxIterations, const char_T *identifier)
{
  real_T y;
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = b_emlrt_marshallIn(sp, emlrtAlias(maxIterations), &thisId);
  emlrtDestroyArray(&maxIterations);
  return y;
}

/*
 * Arguments    : const real_T u[1000000]
 * Return Type  : const mxArray *
 */
static const mxArray *emlrt_marshallOut(const real_T u[1000000])
{
  const mxArray *y;
  const mxArray *m0;
  static const int32_T iv0[2] = { 0, 0 };

  static const int32_T iv1[2] = { 1000, 1000 };

  y = NULL;
  m0 = emlrtCreateNumericArray(2, iv0, mxDOUBLE_CLASS, mxREAL);
  emlrtMxSetData((mxArray *)m0, (void *)&u[0]);
  emlrtSetDimensions((mxArray *)m0, iv1, 2);
  emlrtAssign(&y, m0);
  return y;
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 * Return Type  : real_T (*)[1000000]
 */
static real_T (*f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[1000000]
{
  real_T (*ret)[1000000];
  static const int32_T dims[2] = { 1000, 1000 };

  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 2U, dims);
  ret = (real_T (*)[1000000])emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}
/*
 * Arguments    : void
 * Return Type  : void
 */
  static void mandelbrot_count_once(void)
{
  xilAlreadyInited = false;
}

/*
 * Arguments    : real_T b[1000000]
 * Return Type  : void
 */
static void xilHostDeserializer(real_T b[1000000])
{
  xilReadData((uint8_T *)b, (size_t)1000000, MEM_UNIT_DOUBLE_TYPE);
}

/*
 * Arguments    : const real_T *b
 * Return Type  : void
 */
static void xilHostSerializer(const real_T *b)
{
  xilWriteData((uint8_T *)b, (size_t)1, MEM_UNIT_DOUBLE_TYPE);
}

/*
 * Arguments    : real_T maxIterations
 *                const real_T xGrid[1000000]
 *                const real_T yGrid[1000000]
 *                real_T count[1000000]
 * Return Type  : void
 */
void mandelbrot_countXilWrapper(real_T maxIterations, const real_T xGrid[1000000],
  const real_T yGrid[1000000], real_T count[1000000])
{
  /* Serialize function input argument maxIterations. */
  xilHostSerializer(&maxIterations);

  /* Serialize function input argument xGrid. */
  b_xilHostSerializer(xGrid);

  /* Serialize function input argument yGrid. */
  b_xilHostSerializer(yGrid);

  /* Calling XIL to invoke target side. */
  xilEntryPointHost(1U);

  /* Deserialize function output argument count. */
  xilHostDeserializer(count);
}

/*
 * Arguments    : const mxArray * const prhs[3]
 *                const mxArray *plhs[1]
 * Return Type  : void
 */
void mandelbrot_count_api(const mxArray * const prhs[3], const mxArray *plhs[1])
{
  real_T (*count)[1000000];
  real_T maxIterations;
  real_T (*xGrid)[1000000];
  real_T (*yGrid)[1000000];
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;
  count = (real_T (*)[1000000])mxMalloc(sizeof(real_T [1000000]));

  /* Marshall function inputs */
  maxIterations = emlrt_marshallIn(&st, emlrtAliasP(prhs[0]), "maxIterations");
  xGrid = c_emlrt_marshallIn(&st, emlrtAlias(prhs[1]), "xGrid");
  yGrid = c_emlrt_marshallIn(&st, emlrtAlias(prhs[2]), "yGrid");

  /* Calling XIL to setup. */
  xilPreEntryPointHost(1U);

  /* Invoke the wrapper function */
  mandelbrot_countXilWrapper(maxIterations, *xGrid, *yGrid, *count);

  /* Calling Xil to clean-up. */
  xilPostEntryPointHost(1U);

  /* Marshall function outputs */
  plhs[0] = emlrt_marshallOut(*count);
}

/*
 * Arguments    : void
 * Return Type  : void
 */
void mandelbrot_count_atexit(void)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtEnterRtStackR2012b(&st);
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  mandelbrot_count_xil_terminate();
}

/*
 * Arguments    : void
 * Return Type  : void
 */
void mandelbrot_count_initialize(void)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtClearAllocCountR2012b(&st, false, 0U, 0);
  emlrtEnterRtStackR2012b(&st);
  if (emlrtFirstTimeR2012b(emlrtRootTLSGlobal)) {
    mandelbrot_count_once();
  }

  if (!xilAlreadyInited) {
    xilInitializeHost(xil_terminate);
    xilAlreadyInited = true;
  }
}

/*
 * Arguments    : void
 * Return Type  : void
 */
void mandelbrot_count_terminate(void)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/*
 * Arguments    : void
 * Return Type  : void
 */
void xil_terminate(void)
{
  xilAlreadyInited = false;
  mandelbrot_count_terminate();
}

/*
 * File trailer for _coder_mandelbrot_count_api.c
 *
 * [EOF]
 */
