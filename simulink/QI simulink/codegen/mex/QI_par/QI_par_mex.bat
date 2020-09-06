@echo off
set MATLAB=D:\PROGRA~2\MATLAB\R2017b
set MATLAB_ARCH=win64
set MATLAB_BIN="D:\Program Files\MATLAB\R2017b\bin"
set ENTRYPOINT=mexFunction
set OUTDIR=.\
set LIB_NAME=QI_par_mex
set MEX_NAME=QI_par_mex
set MEX_EXT=.mexw64
call setEnv.bat
echo # Make settings for QI_par > QI_par_mex.mki
echo COMPILER=%COMPILER%>> QI_par_mex.mki
echo COMPFLAGS=%COMPFLAGS%>> QI_par_mex.mki
echo OPTIMFLAGS=%OPTIMFLAGS%>> QI_par_mex.mki
echo DEBUGFLAGS=%DEBUGFLAGS%>> QI_par_mex.mki
echo LINKER=%LINKER%>> QI_par_mex.mki
echo LINKFLAGS=%LINKFLAGS%>> QI_par_mex.mki
echo LINKOPTIMFLAGS=%LINKOPTIMFLAGS%>> QI_par_mex.mki
echo LINKDEBUGFLAGS=%LINKDEBUGFLAGS%>> QI_par_mex.mki
echo MATLAB_ARCH=%MATLAB_ARCH%>> QI_par_mex.mki
echo BORLAND=%BORLAND%>> QI_par_mex.mki
echo NVCC=nvcc >> QI_par_mex.mki
echo CUDA_FLAGS= -c -rdc=true -Xcompiler "/wd 4819" -Xcudafe "--diag_suppress=unsigned_compare_with_zero --diag_suppress=useless_type_qualifier_on_return_type" -D_GNU_SOURCE -DMATLAB_MEX_FILE >> QI_par_mex.mki
echo LD=nvcc >> QI_par_mex.mki
echo MAPLIBS=libemlrt.lib,libcovrt.lib,libut.lib,libmwmathutil.lib,/export:mexFunction,/export:emlrtMexFcnProperties,/export:QI_par,/export:emxEnsureCapacity_creal_T,/export:emxEnsureCapacity_int32_T,/export:emxEnsureCapacity_real_T,/export:emxEnsureCapacity_real_T1,/export:emxFree_creal_T,/export:emxFree_int32_T,/export:emxFree_real_T,/export:emxInit_creal_T,/export:emxInit_int32_T,/export:emxInit_real_T,/export:emxInit_real_T1,/export:QI_par_initialize,/export:QI_par_terminate,/export:QI_par_atexit >> QI_par_mex.mki
echo OMPFLAGS= >> QI_par_mex.mki
echo OMPLINKFLAGS= >> QI_par_mex.mki
echo EMC_COMPILER=msvc120>> QI_par_mex.mki
echo EMC_CONFIG=optim>> QI_par_mex.mki
"D:\Program Files\MATLAB\R2017b\bin\win64\gmake" -B -f QI_par_mex.mk
