/*
 * File: mandelbrot_count_ca.h
 *
 * Abstract: Tests assumptions in the generated code.
 */

#ifndef MANDELBROT_COUNT_CA_H
#define MANDELBROT_COUNT_CA_H

/* preprocessor validation checks */
#include "mandelbrot_count_ca_preproc.h"
#include "coder_assumptions_hwimpl.h"

/* variables holding test results */
extern CA_HWImpl_TestResults CA_mandelbrot_count_HWRes;
extern CA_PWS_TestResults CA_mandelbrot_count_PWSRes;

/* variables holding "expected" and "actual" hardware implementation */
extern const CA_HWImpl CA_mandelbrot_count_ExpHW;
extern CA_HWImpl CA_mandelbrot_count_ActHW;

/* entry point function to run tests */
void mandelbrot_count_caRunTests(void);

#endif                                 /* MANDELBROT_COUNT_CA_H */
