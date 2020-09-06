/*
 * File: _coder_mandelbrot_count_target.c
 *
 * GPU Coder version                    : 1.0
 * CUDA/C/C++ source code generated on  : 26-Dec-2017 22:57:54
 */

/* Include Files */
#include "rt_nonfinite.h"
#include "mandelbrot_count.h"
#include "_coder_mandelbrot_count_target.h"

/* Function Declarations */
static void b_xilTargetDeserializer(real_T b[1000000]);
static void xilTargetDeserializer(real_T *b);
static void xilTargetSerializer(const real_T b[1000000]);

/* Function Definitions */

/*
 * Arguments    : real_T b[1000000]
 * Return Type  : void
 */
static void b_xilTargetDeserializer(real_T b[1000000])
{
  xilReadData((MemUnit_T *)b, (uint32_T)(1000000 * (int32_T)sizeof(real_T)));
}

/*
 * Arguments    : real_T *b
 * Return Type  : void
 */
static void xilTargetDeserializer(real_T *b)
{
  xilReadData((MemUnit_T *)b, sizeof(real_T));
}

/*
 * Arguments    : const real_T b[1000000]
 * Return Type  : void
 */
static void xilTargetSerializer(const real_T b[1000000])
{
  xilWriteData((MemUnit_T *)b, (uint32_T)(1000000 * (int32_T)sizeof(real_T)));
}

/*
 * Arguments    : uint32_T fcnId
 * Return Type  : XIL_PROCESSDATA_ERROR_CODE
 */
XIL_PROCESSDATA_ERROR_CODE xilTarget_mandelbrot_count(uint32_T fcnId)
{
  XIL_PROCESSDATA_ERROR_CODE error_id;
  real_T maxIterations;
  static real_T xGrid[1000000];
  static real_T yGrid[1000000];
  static real_T count[1000000];

  /* Deserialize function input maxIterations argument. */
  xilTargetDeserializer(&maxIterations);

  /* Deserialize function input xGrid argument. */
  b_xilTargetDeserializer(xGrid);

  /* Deserialize function input yGrid argument. */
  b_xilTargetDeserializer(yGrid);

  /* Calling XIL API before invoke entry point. */
  xilPreEntryPoint(fcnId);

  /* Invoke target entry point. */
  mandelbrot_count(maxIterations, xGrid, yGrid, count);

  /* Calling XIL API after invoke entry point. */
  if (xilPostEntryPoint(fcnId) == XIL_INTERFACE_SUCCESS) {
    /* Serialize function output argument count. */
    xilTargetSerializer(count);
    error_id = XIL_PROCESSDATA_SUCCESS;
  } else {
    error_id = XIL_PROCESSDATA_DATA_STREAM_ERROR;
  }

  return error_id;
}

/*
 * File trailer for _coder_mandelbrot_count_target.c
 *
 * [EOF]
 */
