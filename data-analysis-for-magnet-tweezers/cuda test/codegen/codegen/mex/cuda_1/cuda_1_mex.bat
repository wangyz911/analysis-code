@echo off
set MATLAB=D:\PROGRA~2\MATLAB\R2017b
set MATLAB_ARCH=win64
set MATLAB_BIN="D:\Program Files\MATLAB\R2017b\bin"
set ENTRYPOINT=mexFunction
set OUTDIR=.\
set LIB_NAME=cuda_1_mex
set MEX_NAME=cuda_1_mex
set MEX_EXT=.mexw64
call setEnv.bat
echo # Make settings for cuda_1 > cuda_1_mex.mki
echo COMPILER=%COMPILER%>> cuda_1_mex.mki
echo COMPFLAGS=%COMPFLAGS%>> cuda_1_mex.mki
echo OPTIMFLAGS=%OPTIMFLAGS%>> cuda_1_mex.mki
echo DEBUGFLAGS=%DEBUGFLAGS%>> cuda_1_mex.mki
echo LINKER=%LINKER%>> cuda_1_mex.mki
echo LINKFLAGS=%LINKFLAGS%>> cuda_1_mex.mki
echo LINKOPTIMFLAGS=%LINKOPTIMFLAGS%>> cuda_1_mex.mki
echo LINKDEBUGFLAGS=%LINKDEBUGFLAGS%>> cuda_1_mex.mki
echo MATLAB_ARCH=%MATLAB_ARCH%>> cuda_1_mex.mki
echo BORLAND=%BORLAND%>> cuda_1_mex.mki
echo NVCC=nvcc >> cuda_1_mex.mki
echo CUDA_FLAGS= -c -rdc=true -Xcompiler "/wd 4819" -Xcudafe "--diag_suppress=unsigned_compare_with_zero --diag_suppress=useless_type_qualifier_on_return_type" -D_GNU_SOURCE -DMATLAB_MEX_FILE >> cuda_1_mex.mki
echo LD=nvcc >> cuda_1_mex.mki
echo MAPLIBS=libemlrt.lib,libcovrt.lib,libut.lib,libmwmathutil.lib,/export:mexFunction,/export:emlrtMexFcnProperties,/export:cuda_1,/export:cuda_1_initialize,/export:cuda_1_terminate,/export:cuda_1_atexit >> cuda_1_mex.mki
echo OMPFLAGS= >> cuda_1_mex.mki
echo OMPLINKFLAGS= >> cuda_1_mex.mki
echo EMC_COMPILER=msvc140>> cuda_1_mex.mki
echo EMC_CONFIG=optim>> cuda_1_mex.mki
"D:\Program Files\MATLAB\R2017b\bin\win64\gmake" -B -f cuda_1_mex.mk
