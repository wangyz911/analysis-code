/*
 * File: QI_par_rtwutil.c
 *
 * MATLAB Coder version            : 3.4
 * C/C++ source code generated on  : 23-Jun-2018 15:45:59
 */

/* Include Files */
#include "rt_nonfinite.h"
#include "QI_par.h"
#include "QI_par_rtwutil.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Function Declarations */
static void rtAddSizeString(char *aBuf, const int aDim);
static void rtGenSizeString(const int aNDims, const int *aDims, char *aBuf);
static boolean_T rtIsNullOrEmptyString(const char *aString);
static void rtReportErrorLocation(const char * aFcnName, const int aLineNo);

/* Function Definitions */

/*
 * Arguments    : char *aBuf
 *                const int aDim
 * Return Type  : void
 */
static void rtAddSizeString(char *aBuf, const int aDim)
{
  char dimStr[1024];
  sprintf(dimStr, "[%d]", aDim);
  if (strlen(aBuf) + strlen(dimStr) < 1024) {
    strcat(aBuf, dimStr);
  }
}

/*
 * Arguments    : const int aNDims
 *                const int *aDims
 *                char *aBuf
 * Return Type  : void
 */
static void rtGenSizeString(const int aNDims, const int *aDims, char *aBuf)
{
  int i;
  aBuf[0] = '\x00';
  for (i = 0; i < aNDims; i++) {
    rtAddSizeString(aBuf, aDims[i]);
  }
}

/*
 * Arguments    : const char *aString
 * Return Type  : boolean_T
 */
static boolean_T rtIsNullOrEmptyString(const char *aString)
{
  return (aString == NULL) || (*aString == '\x00');
}

/*
 * Arguments    : const char * aFcnName
 *                const int aLineNo
 * Return Type  : void
 */
static void rtReportErrorLocation(const char * aFcnName, const int aLineNo)
{
  fprintf(stderr, "Error in %s (line %d)", aFcnName, aLineNo);
  fprintf(stderr, "\n");
}

/*
 * Arguments    : const int b
 *                const char *c
 *                const rtRunTimeErrorInfo *aInfo
 * Return Type  : void
 */
void b_rtErrorWithMessageID(const int b, const char *c, const rtRunTimeErrorInfo
  *aInfo)
{
  fprintf(stderr,
          "The loop variable of class %.*s might overflow on the last iteration of the for loop. This could lead to an infinite loop.",
          b, c);
  fprintf(stderr, "\n");
  if (aInfo != NULL) {
    rtReportErrorLocation(aInfo->fName, aInfo->lineNo);
  }

  fflush(stderr);
  abort();
}

/*
 * Arguments    : const rtRunTimeErrorInfo *aInfo
 * Return Type  : void
 */
void c_rtErrorWithMessageID(const rtRunTimeErrorInfo *aInfo)
{
  fprintf(stderr,
          "If the input is a variable-size array, it cannot be 0-by-0 at run time.");
  fprintf(stderr, "\n");
  if (aInfo != NULL) {
    rtReportErrorLocation(aInfo->fName, aInfo->lineNo);
  }

  fflush(stderr);
  abort();
}

/*
 * Arguments    : const rtRunTimeErrorInfo *aInfo
 * Return Type  : void
 */
void d_rtErrorWithMessageID(const rtRunTimeErrorInfo *aInfo)
{
  fprintf(stderr,
          "The working dimension was selected automatically, is variable-length, and has length 1 at run time. This is not supported. Manua"
          "lly select the working dimension by supplying the DIM argument.");
  fprintf(stderr, "\n");
  if (aInfo != NULL) {
    rtReportErrorLocation(aInfo->fName, aInfo->lineNo);
  }

  fflush(stderr);
  abort();
}

/*
 * Arguments    : const int b
 *                const char *c
 *                const rtRunTimeErrorInfo *aInfo
 * Return Type  : void
 */
void e_rtErrorWithMessageID(const int b, const char *c, const rtRunTimeErrorInfo
  *aInfo)
{
  fprintf(stderr,
          "For code generation, the dimension to operate along must not change. When %.*s is a vector input, consider passing in |-RunTimeV"
          "alue-|(:) or |-RunTimeValue-|(:).\' instead.", b, c);
  fprintf(stderr, "\n");
  if (aInfo != NULL) {
    rtReportErrorLocation(aInfo->fName, aInfo->lineNo);
  }

  fflush(stderr);
  abort();
}

/*
 * Arguments    : const rtRunTimeErrorInfo *aInfo
 * Return Type  : void
 */
void f_rtErrorWithMessageID(const rtRunTimeErrorInfo *aInfo)
{
  fprintf(stderr,
          "To RESHAPE the number of elements must not change, and if the input is empty, the maximum dimension length cannot be increased u"
          "nless the output size is fixed.");
  fprintf(stderr, "\n");
  if (aInfo != NULL) {
    rtReportErrorLocation(aInfo->fName, aInfo->lineNo);
  }

  fflush(stderr);
  abort();
}

/*
 * Arguments    : const rtRunTimeErrorInfo *aInfo
 * Return Type  : void
 */
void g_rtErrorWithMessageID(const rtRunTimeErrorInfo *aInfo)
{
  fprintf(stderr, "Assertion failed.");
  fprintf(stderr, "\n");
  if (aInfo != NULL) {
    rtReportErrorLocation(aInfo->fName, aInfo->lineNo);
  }

  fflush(stderr);
  abort();
}

/*
 * Arguments    : const rtRunTimeErrorInfo *aInfo
 * Return Type  : void
 */
void h_rtErrorWithMessageID(const rtRunTimeErrorInfo *aInfo)
{
  fprintf(stderr,
          "Code generation assumption about size violated. Unexpected run-time scalar changed predicted orientation.");
  fprintf(stderr, "\n");
  if (aInfo != NULL) {
    rtReportErrorLocation(aInfo->fName, aInfo->lineNo);
  }

  fflush(stderr);
  abort();
}

/*
 * Arguments    : int aIndexValue
 *                int aLoBound
 *                int aHiBound
 *                const rtBoundsCheckInfo *aInfo
 * Return Type  : void
 */
void rtDynamicBoundsError(int aIndexValue, int aLoBound, int aHiBound, const
  rtBoundsCheckInfo *aInfo)
{
  if (aLoBound == 0) {
    aIndexValue++;
    aLoBound = 1;
    aHiBound++;
  }

  if (rtIsNullOrEmptyString(aInfo->aName)) {
    fprintf(stderr,
            "Index exceeds array dimensions.  Index value %d exceeds valid range [%d-%d].",
            aIndexValue, aLoBound, aHiBound);
    fprintf(stderr, "\n");
  } else {
    fprintf(stderr,
            "Index exceeds array dimensions.  Index value %d exceeds valid range [%d-%d] of array %s.",
            aIndexValue, aLoBound, aHiBound, aInfo->aName);
    fprintf(stderr, "\n");
  }

  if (aInfo != NULL) {
    rtReportErrorLocation(aInfo->fName, aInfo->lineNo);
  }

  fflush(stderr);
  abort();
}

/*
 * Arguments    : const rtRunTimeErrorInfo *aInfo
 * Return Type  : void
 */
void rtErrorWithMessageID(const rtRunTimeErrorInfo *aInfo)
{
  fprintf(stderr, "Maximum variable size allowed by the program is exceeded.");
  fprintf(stderr, "\n");
  if (aInfo != NULL) {
    rtReportErrorLocation(aInfo->fName, aInfo->lineNo);
  }

  fflush(stderr);
  abort();
}

/*
 * Arguments    : const double aInteger
 *                const rtDoubleCheckInfo *aInfo
 * Return Type  : void
 */
void rtIntegerError(const double aInteger, const rtDoubleCheckInfo *aInfo)
{
  fprintf(stderr,
          "Expected a value representable in the C type \'int\'.  Found %g instead.",
          aInteger);
  fprintf(stderr, "\n");
  if (aInfo != NULL) {
    rtReportErrorLocation(aInfo->fName, aInfo->lineNo);
  }

  fflush(stderr);
  abort();
}

/*
 * Arguments    : const double aPositive
 *                const rtDoubleCheckInfo *aInfo
 * Return Type  : void
 */
void rtNonNegativeError(const double aPositive, const rtDoubleCheckInfo *aInfo)
{
  fprintf(stderr,
          "Value %g is not greater than or equal to zero.\nExiting to prevent memory corruption.",
          aPositive);
  fprintf(stderr, "\n");
  if (aInfo != NULL) {
    rtReportErrorLocation(aInfo->fName, aInfo->lineNo);
  }

  fflush(stderr);
  abort();
}

/*
 * Arguments    : const int aDim1
 *                const int aDim2
 *                const rtEqualityCheckInfo *aInfo
 * Return Type  : void
 */
void rtSizeEq1DError(const int aDim1, const int aDim2, const rtEqualityCheckInfo
                     *aInfo)
{
  fprintf(stderr, "Sizes mismatch: %d ~= %d.", aDim1, aDim2);
  fprintf(stderr, "\n");
  if (aInfo != NULL) {
    rtReportErrorLocation(aInfo->fName, aInfo->lineNo);
  }

  fflush(stderr);
  abort();
}

/*
 * Arguments    : const int *aDims1
 *                const int *aDims2
 *                const rtEqualityCheckInfo *aInfo
 * Return Type  : void
 */
void rtSizeEqNDCheck(const int *aDims1, const int *aDims2, const
                     rtEqualityCheckInfo *aInfo)
{
  int i;
  char dims1Str[1024];
  char dims2Str[1024];
  for (i = 0; i < aInfo->nDims; i++) {
    if (aDims1[i] != aDims2[i]) {
      rtGenSizeString(aInfo->nDims, aDims1, dims1Str);
      rtGenSizeString(aInfo->nDims, aDims2, dims2Str);
      fprintf(stderr, "Sizes mismatch: %s ~= %s.", dims1Str, dims2Str);
      fprintf(stderr, "\n");
      if (aInfo != NULL) {
        rtReportErrorLocation(aInfo->fName, aInfo->lineNo);
      }

      fflush(stderr);
      abort();
    }
  }
}

/*
 * Arguments    : const int *aDims1
 *                const int aNDims1
 *                const int *aDims2
 *                const int aNDims2
 *                const rtEqualityCheckInfo *aInfo
 * Return Type  : void
 */
void rtSubAssignSizeCheck(const int *aDims1, const int aNDims1, const int
  *aDims2, const int aNDims2, const rtEqualityCheckInfo *aInfo)
{
  int i;
  int j;
  char dims1Str[1024];
  char dims2Str[1024];
  i = 0;
  j = 0;
  while ((i < aNDims1) && (j < aNDims2)) {
    while ((i < aNDims1) && (aDims1[i] == 1)) {
      i++;
    }

    while ((j < aNDims2) && (aDims2[j] == 1)) {
      j++;
    }

    if (((i < aNDims1) || (j < aNDims2)) && ((i == aNDims1) || ((j == aNDims2) ||
          ((aDims1[i] != -1) && ((aDims2[j] != -1) && (aDims1[i] != aDims2[j]))))))
    {
      rtGenSizeString(aNDims1, aDims1, dims1Str);
      rtGenSizeString(aNDims2, aDims2, dims2Str);
      fprintf(stderr, "Subscripted assignment dimension mismatch: %s ~= %s.",
              dims1Str, dims2Str);
      fprintf(stderr, "\n");
      if (aInfo != NULL) {
        rtReportErrorLocation(aInfo->fName, aInfo->lineNo);
      }

      fflush(stderr);
      abort();
    }

    i++;
    j++;
  }
}

/*
 * File trailer for QI_par_rtwutil.c
 *
 * [EOF]
 */
