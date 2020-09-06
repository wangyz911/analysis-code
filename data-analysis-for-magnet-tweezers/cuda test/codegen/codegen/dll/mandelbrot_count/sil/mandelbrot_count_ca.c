/*
 * File: mandelbrot_count_ca.c
 *
 * Abstract: Tests assumptions in the generated code.
 */

#include "mandelbrot_count_ca.h"

CA_HWImpl_TestResults CA_mandelbrot_count_HWRes;
CA_PWS_TestResults CA_mandelbrot_count_PWSRes;
const CA_HWImpl CA_mandelbrot_count_ExpHW = {
  8,                                   /* BitPerChar */
  16,                                  /* BitPerShort */
  32,                                  /* BitPerInt */
  32,                                  /* BitPerLong */
  64,                                  /* BitPerLongLong */
  32,                                  /* BitPerFloat */
  64,                                  /* BitPerDouble */
  64,                                  /* BitPerPointer */
  64,                                  /* BitPerSizeT */
  64,                                  /* BitPerPtrDiffT */
  CA_LITTLE_ENDIAN,                    /* Endianess */
  CA_ZERO,                             /* IntDivRoundTo */
  1,                                   /* ShiftRightIntArith */
  1,                                   /* LongLongMode */
  0,                                   /* PortableWordSizes */
  "Generic->MATLAB Host Computer"      /* HWDeviceType */
};

CA_HWImpl CA_mandelbrot_count_ActHW;
void mandelbrot_count_caRunTests(void)
{
  /* verify hardware implementation */
  caVerifyPortableWordSizes(&CA_mandelbrot_count_ActHW,
    &CA_mandelbrot_count_ExpHW, &CA_mandelbrot_count_PWSRes);
  if (!CA_mandelbrot_count_ActHW.portableWordSizes) {
    caVerifyHWImpl(&CA_mandelbrot_count_ActHW, &CA_mandelbrot_count_ExpHW,
                   &CA_mandelbrot_count_HWRes);
  }                                    /* if */
}
