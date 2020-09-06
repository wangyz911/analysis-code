/*
 * File: coder_assumptions.h
 *
 * Abstract: Coder assumptions header file
 */

#ifndef CODER_ASSUMPTIONS_H
#define CODER_ASSUMPTIONS_H

/* include model specific checks */
#include "mandelbrot_count_ca.h"

/* global results variable mapping for static code */
#define CA_Expected_HWImpl             CA_mandelbrot_count_ExpHW
#define CA_Actual_HWImpl               CA_mandelbrot_count_ActHW
#define CA_HWImpl_Results              CA_mandelbrot_count_HWRes
#define CA_PortableWordSizes_Results   CA_mandelbrot_count_PWSRes

/* entry point function mapping for static code */
#define CA_Run_Tests                   mandelbrot_count_caRunTests
#endif                                 /* CODER_ASSUMPTIONS_H */
