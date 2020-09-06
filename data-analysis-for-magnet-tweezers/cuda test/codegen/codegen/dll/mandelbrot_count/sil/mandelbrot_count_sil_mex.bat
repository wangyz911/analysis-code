@echo off
set MATLAB=D:\PROGRA~2\MATLAB\R2017b
set MATLAB_ARCH=win64
set MATLAB_BIN="D:\Program Files\MATLAB\R2017b\bin"
set ENTRYPOINT=mexFunction
set OUTDIR=.\
set LIB_NAME=mandelbrot_count_sil
set MEX_NAME=mandelbrot_count_sil
set MEX_EXT=.mexw64
call setEnv.bat
echo # Make settings for mandelbrot_count_sil > mandelbrot_count_sil_mex.mki
echo COMPILER=%COMPILER%>> mandelbrot_count_sil_mex.mki
echo COMPFLAGS=%COMPFLAGS%>> mandelbrot_count_sil_mex.mki
echo OPTIMFLAGS=%OPTIMFLAGS%>> mandelbrot_count_sil_mex.mki
echo DEBUGFLAGS=%DEBUGFLAGS%>> mandelbrot_count_sil_mex.mki
echo LINKER=%LINKER%>> mandelbrot_count_sil_mex.mki
echo LINKFLAGS=%LINKFLAGS%>> mandelbrot_count_sil_mex.mki
echo LINKOPTIMFLAGS=%LINKOPTIMFLAGS%>> mandelbrot_count_sil_mex.mki
echo LINKDEBUGFLAGS=%LINKDEBUGFLAGS%>> mandelbrot_count_sil_mex.mki
echo MATLAB_ARCH=%MATLAB_ARCH%>> mandelbrot_count_sil_mex.mki
echo OMPFLAGS= >> mandelbrot_count_sil_mex.mki
echo OMPLINKFLAGS= >> mandelbrot_count_sil_mex.mki
echo EMC_COMPILER=msvc120>> mandelbrot_count_sil_mex.mki
echo EMC_CONFIG=optim>> mandelbrot_count_sil_mex.mki
"D:\Program Files\MATLAB\R2017b\bin\win64\gmake" -B -f mandelbrot_count_sil_mex.mk
