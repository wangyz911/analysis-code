###########################################################################
## Makefile generated for MATLAB file/project 'mandelbrot_count'. 
## 
## Makefile     : mandelbrot_count_rtw.mk
## Generated on : Tue Dec 26 22:58:20 2017
## MATLAB Coder version: 3.4 (R2017b)
## 
## Build Info:
## 
## Final product: mandelbrot_count.exe
## Product type : executable
## 
###########################################################################

###########################################################################
## MACROS
###########################################################################

# Macro Descriptions:
# PRODUCT_NAME            Name of the system to build
# MAKEFILE                Name of this makefile
# COMPUTER                Computer type. See the MATLAB "computer" command.

PRODUCT_NAME              = mandelbrot_count
MAKEFILE                  = mandelbrot_count_rtw.mk
COMPUTER                  = PCWIN64
MATLAB_ROOT               = D:\PROGRA~2\MATLAB\R2017b
MATLAB_BIN                = D:\PROGRA~2\MATLAB\R2017b\bin
MATLAB_ARCH_BIN           = $(MATLAB_BIN)\win64
MASTER_ANCHOR_DIR         = 
START_DIR                 = E:\ANALYS~1\DATA-A~1\CUDATE~1
ARCH                      = win64
RELATIVE_PATH_TO_ANCHOR   = ..\.
C_STANDARD_OPTS           = 
CPP_STANDARD_OPTS         = 
NODEBUG                   = 1

###########################################################################
## TOOLCHAIN SPECIFICATIONS
###########################################################################

# Toolchain Name:          NVIDIA CUDA  (w/Microsoft Visual C++ 2013)  | nmake (64-bit Windows)
# Supported Version(s):    12.0
# ToolchainInfo Version:   R2018a Prerelease
# Specification Revision:  1.0
# 
#-------------------------------------------
# Macros assumed to be defined elsewhere
#-------------------------------------------

# NODEBUG
# cvarsdll
# cvarsmt
# conlibsmt
# ldebug
# conflags
# cflags
# C_STANDARD_OPTS
# CPP_STANDARD_OPTS
# CUDA_PATH

#-----------
# MACROS
#-----------

MEX_OPTS_FILE      = $(MATLAB_ROOT)\bin\$(ARCH)\mexopts\msvc2013.xml
MW_EXTERNLIB_DIR   = $(MATLAB_ROOT)\extern\lib\win64\microsoft
MW_LIB_DIR         = $(MATLAB_ROOT)\lib\win64
WARN_FLAGS         = -Wall -W -Wwrite-strings -Winline -Wstrict-prototypes -Wnested-externs -Wpointer-arith -Wcast-align
WARN_FLAGS_MAX     = $(WARN_FLAGS) -Wcast-qual -Wshadow
CPP_WARN_FLAGS     = -Wall -W -Wwrite-strings -Winline -Wpointer-arith -Wcast-align
CPP_WARN_FLAGS_MAX = $(CPP_WARN_FLAGS) -Wcast-qual -Wshadow

TOOLCHAIN_SRCS = 
TOOLCHAIN_INCS = 
TOOLCHAIN_LIBS = 

#------------------------
# BUILD TOOL COMMANDS
#------------------------

# C Compiler: NVIDIA CUDA C Compiler Driver
CC = nvcc

# Linker: NVIDIA CUDA C Compiler Driver
LD = nvcc

# C++ Compiler: NVIDIA CUDA C++ Compiler Driver
CPP = nvcc

# C++ Linker: NVIDIA CUDA C++ Compiler Driver
CPP_LD = nvcc

# Archiver: Microsoft Visual C/C++ Archiver
AR = lib

# MEX Tool: MEX Tool
MEX_PATH = $(MATLAB_ARCH_BIN)
MEX = "$(MEX_PATH)\mex"

# Download: Download
DOWNLOAD =

# Execute: Execute
EXECUTE = $(PRODUCT)

# Builder: NMAKE Utility
MAKE = nmake


#-------------------------
# Directives/Utilities
#-------------------------

CDEBUG              = -g -G 
C_OUTPUT_FLAG       = -o 
LDDEBUG             = -g -G 
OUTPUT_FLAG         = -o 
CPPDEBUG            = -g -G 
CPP_OUTPUT_FLAG     = -o 
CPPLDDEBUG          = -g -G 
OUTPUT_FLAG         = -o 
ARDEBUG             =
STATICLIB_OUTPUT_FLAG = -out:
MEX_DEBUG           = -g
RM                  = @del
ECHO                = @echo
MV                  = @ren
RUN                 = @cmd /C

#----------------------------------------
# "Faster Builds" Build Configuration
#----------------------------------------

ARFLAGS              =
CFLAGS               = -c $(C_STANDARD_OPTS) -Xcompiler "/wd 4819" -rdc=true -Xcudafe "--diag_suppress=unsigned_compare_with_zero" \
                       -O0
CPPFLAGS             = -c $(CPP_STANDARD_OPTS) -Xcompiler "/wd 4819" -rdc=true -Xcudafe "--diag_suppress=unsigned_compare_with_zero" \
                       -O0
CPP_LDFLAGS          = -Xnvlink -w -L"$(CUDA_PATH)\lib\x64" -Xarchive "/IGNORE:4006" -Xarchive "/IGNORE:4221" $(conlibs) cufft.lib cudart.lib cublas.lib cusolver.lib -Wno-deprecated-gpu-targets
CPP_SHAREDLIB_LDFLAGS  = -shared -Xnvlink -w -L"$(CUDA_PATH)\lib\x64" -Xarchive "/IGNORE:4006" -Xarchive "/IGNORE:4221" cufft.lib cudart.lib cublas.lib cusolver.lib -Wno-deprecated-gpu-targets -Xlinker -dll -Xlinker -def:$(DEF_FILE)
DOWNLOAD_FLAGS       =
EXECUTE_FLAGS        =
LDFLAGS              = -Xnvlink -w -L"$(CUDA_PATH)\lib\x64" -Xarchive "/IGNORE:4006" -Xarchive "/IGNORE:4221" $(conlibs) cufft.lib cudart.lib cublas.lib cusolver.lib -Wno-deprecated-gpu-targets
MEX_CPPFLAGS         =
MEX_CPPLDFLAGS       =
MEX_CFLAGS           = -MATLAB_ARCH=$(ARCH) $(INCLUDES) \
                         \
                       COPTIMFLAGS="$(C_STANDARD_OPTS)  \
                       -O0 \
                        $(DEFINES)" \
                         \
                       -silent
MEX_LDFLAGS          = LDFLAGS=='$$LDFLAGS'
MAKE_FLAGS           = -f $(MAKEFILE)
SHAREDLIB_LDFLAGS    = -shared -Xnvlink -w -L"$(CUDA_PATH)\lib\x64" -Xarchive "/IGNORE:4006" -Xarchive "/IGNORE:4221" cufft.lib cudart.lib cublas.lib cusolver.lib -Wno-deprecated-gpu-targets -Xlinker -dll -Xlinker -def:$(DEF_FILE)

#--------------------
# File extensions
#--------------------

H_EXT               = .h
OBJ_EXT             = .obj
C_EXT               = .cu
C_EXT               = .c
EXE_EXT             = .exe
SHAREDLIB_EXT       = .dll
HPP_EXT             = .hpp
OBJ_EXT             = .obj
CPP_EXT             = .cu
CPP_EXT             = .cpp
EXE_EXT             = .exe
SHAREDLIB_EXT       = .dll
STATICLIB_EXT       = .lib
MEX_EXT             = .mexw64
MAKE_EXT            = .mk


###########################################################################
## OUTPUT INFO
###########################################################################

PRODUCT = mandelbrot_count.exe
PRODUCT_TYPE = "executable"
BUILD_TYPE = "Executable"

###########################################################################
## INCLUDE PATHS
###########################################################################

INCLUDES_BUILDINFO = $(START_DIR)\codegen\dll\mandelbrot_count;$(START_DIR);$(MATLAB_ROOT)\extern\include;$(MATLAB_ROOT)\simulink\include;$(MATLAB_ROOT)\rtw\c\src;$(MATLAB_ROOT)\rtw\c\src\ext_mode\common;$(MATLAB_ROOT)\rtw\c\ert;$(MATLAB_ROOT)\toolbox\rtw\targets\pil\c;$(START_DIR)\codegen\dll\mandelbrot_count\sil;$(MATLAB_ROOT)\extern\include\coder\connectivity\XILTgtAppSvc;$(MATLAB_ROOT)\toolbox\coder\rtiostream\src\utils;$(MATLAB_ROOT)\extern\include\coder\connectivity\CoderAssumpTgtAppSvc;$(START_DIR)\codegen\dll\mandelbrot_count\target

INCLUDES = $(INCLUDES_BUILDINFO)

###########################################################################
## DEFINES
###########################################################################

DEFINES_OPTS = -D XIL_SIGNAL_HANDLER=1 -D CA_CHECK_LONG_LONG_ENABLED=1 -D CA_CHECK_FLOATING_POINT_ENABLED=1 -D CODER_ASSUMPTIONS_ENABLED=1 -D RTIOSTREAM_RX_BUFFER_BYTE_SIZE=50000 -D RTIOSTREAM_TX_BUFFER_BYTE_SIZE=50000 -D MEM_UNIT_BYTES=1 -D MemUnit_T=uint8_T
DEFINES_STANDARD = -D MODEL=mandelbrot_count -D HAVESTDIO -D USE_RTMODEL

DEFINES = $(DEFINES_OPTS) $(DEFINES_STANDARD)

###########################################################################
## SOURCE FILES
###########################################################################

SRCS = $(MATLAB_ROOT)\toolbox\rtw\targets\pil\c\xil_interface_lib.c $(MATLAB_ROOT)\toolbox\rtw\targets\pil\c\xil_data_stream.c $(MATLAB_ROOT)\toolbox\rtw\targets\pil\c\xil_services.c $(START_DIR)\codegen\dll\mandelbrot_count\sil\xil_interface.c $(MATLAB_ROOT)\toolbox\rtw\targets\pil\c\xilcomms_rtiostream.c $(MATLAB_ROOT)\toolbox\rtw\targets\pil\c\xil_rtiostream.c $(MATLAB_ROOT)\toolbox\coder\rtiostream\src\utils\rtiostream_utils.c $(MATLAB_ROOT)\toolbox\rtw\targets\pil\c\coder_assumptions_app.c $(MATLAB_ROOT)\toolbox\rtw\targets\pil\c\coder_assumptions_data_stream.c $(MATLAB_ROOT)\toolbox\rtw\targets\pil\c\coder_assumptions_hwimpl.c $(START_DIR)\codegen\dll\mandelbrot_count\sil\mandelbrot_count_ca.c $(MATLAB_ROOT)\toolbox\rtw\targets\pil\c\coder_assumptions_rtiostream.c $(MATLAB_ROOT)\toolbox\rtw\targets\pil\c\sil_main.c $(MATLAB_ROOT)\toolbox\rtw\targets\pil\c\target_io.c $(MATLAB_ROOT)\rtw\c\src\rtiostream\rtiostreamtcpip\rtiostream_tcpip.c $(START_DIR)\codegen\dll\mandelbrot_count\target\_coder_mandelbrot_count_target.c

ALL_SRCS = $(SRCS)

###########################################################################
## OBJECTS
###########################################################################

OBJS = xil_interface_lib.obj xil_data_stream.obj xil_services.obj xil_interface.obj xilcomms_rtiostream.obj xil_rtiostream.obj rtiostream_utils.obj coder_assumptions_app.obj coder_assumptions_data_stream.obj coder_assumptions_hwimpl.obj mandelbrot_count_ca.obj coder_assumptions_rtiostream.obj sil_main.obj target_io.obj rtiostream_tcpip.obj _coder_mandelbrot_count_target.obj

ALL_OBJS = $(OBJS)

###########################################################################
## PREBUILT OBJECT FILES
###########################################################################

PREBUILT_OBJS = 

###########################################################################
## LIBRARIES
###########################################################################

MODELREF_LIBS = $(START_DIR)\codegen\dll\mandelbrot_count\sil\..\mandelbrot_count.lib

LIBS = 

###########################################################################
## SYSTEM LIBRARIES
###########################################################################

SYSTEM_LIBS = 

###########################################################################
## ADDITIONAL TOOLCHAIN FLAGS
###########################################################################

#---------------
# C Compiler
#---------------

CFLAGS_CU_OPTS = -arch sm_35 
CFLAGS_BASIC = $(DEFINES) 

CFLAGS = $(CFLAGS) $(CFLAGS_CU_OPTS) $(CFLAGS_BASIC)

#-----------------
# C++ Compiler
#-----------------

CPPFLAGS_CU_OPTS = -arch sm_35 
CPPFLAGS_BASIC = $(DEFINES) 

CPPFLAGS = $(CPPFLAGS) $(CPPFLAGS_CU_OPTS) $(CPPFLAGS_BASIC)

###########################################################################
## INLINED COMMANDS
###########################################################################


!include $(MATLAB_ROOT)\rtw\c\tools\vcdefs.mak
.SUFFIXES: .cu


###########################################################################
## PHONY TARGETS
###########################################################################

.PHONY : all build buildobj clean info prebuild download execute set_environment_variables


all : build
	@cmd /C "@echo ### Successfully generated all binary outputs."


build : set_environment_variables prebuild $(PRODUCT)


buildobj : set_environment_variables prebuild $(OBJS) $(PREBUILT_OBJS) $(MODELREF_LIBS)
	@cmd /C "@echo ### Successfully generated all binary outputs."


prebuild : 


download : build


execute : download
	@cmd /C "@echo ### Invoking postbuild tool "Execute" ..."
	$(EXECUTE) $(EXECUTE_FLAGS)
	@cmd /C "@echo ### Done invoking postbuild tool."


set_environment_variables : 
	@set INCLUDE=$(INCLUDES);$(INCLUDE)
	@set LIB=$(LIB)


###########################################################################
## FINAL TARGET
###########################################################################

#-------------------------------------------
# Create a standalone executable            
#-------------------------------------------

$(PRODUCT) : $(OBJS) $(PREBUILT_OBJS) $(MODELREF_LIBS)
	@cmd /C "@echo ### Creating standalone executable "$(PRODUCT)" ..."
	$(LD) $(LDFLAGS) -o $(PRODUCT) $(OBJS) -Xlinker --start-group  $(MODELREF_LIBS) -Xlinker --end-group  $(SYSTEM_LIBS) $(TOOLCHAIN_LIBS)
	@cmd /C "@echo ### Created: $(PRODUCT)"


###########################################################################
## INTERMEDIATE TARGETS
###########################################################################

#---------------------
# SOURCE-TO-OBJECT
#---------------------

.cu.obj :
	$(CC) $(CFLAGS) -o  "$@" "$<"


.c.obj :
	$(CC) $(CFLAGS) -o  "$@" "$<"


.cu.obj :
	$(CPP) $(CPPFLAGS) -o  "$@" "$<"


.cpp.obj :
	$(CPP) $(CPPFLAGS) -o  "$@" "$<"


{$(RELATIVE_PATH_TO_ANCHOR)}.cu.obj :
	$(CC) $(CFLAGS) -o  "$@" "$<"


{$(RELATIVE_PATH_TO_ANCHOR)}.c.obj :
	$(CC) $(CFLAGS) -o  "$@" "$<"


{$(RELATIVE_PATH_TO_ANCHOR)}.cu.obj :
	$(CPP) $(CPPFLAGS) -o  "$@" "$<"


{$(RELATIVE_PATH_TO_ANCHOR)}.cpp.obj :
	$(CPP) $(CPPFLAGS) -o  "$@" "$<"


{$(MATLAB_ROOT)\toolbox\rtw\targets\pil\c}.cu.obj :
	$(CC) $(CFLAGS) -o  "$@" "$<"


{$(MATLAB_ROOT)\toolbox\rtw\targets\pil\c}.c.obj :
	$(CC) $(CFLAGS) -o  "$@" "$<"


{$(MATLAB_ROOT)\toolbox\rtw\targets\pil\c}.cu.obj :
	$(CPP) $(CPPFLAGS) -o  "$@" "$<"


{$(MATLAB_ROOT)\toolbox\rtw\targets\pil\c}.cpp.obj :
	$(CPP) $(CPPFLAGS) -o  "$@" "$<"


{$(MATLAB_ROOT)\toolbox\coder\rtiostream\src\utils}.cu.obj :
	$(CC) $(CFLAGS) -o  "$@" "$<"


{$(MATLAB_ROOT)\toolbox\coder\rtiostream\src\utils}.c.obj :
	$(CC) $(CFLAGS) -o  "$@" "$<"


{$(MATLAB_ROOT)\toolbox\coder\rtiostream\src\utils}.cu.obj :
	$(CPP) $(CPPFLAGS) -o  "$@" "$<"


{$(MATLAB_ROOT)\toolbox\coder\rtiostream\src\utils}.cpp.obj :
	$(CPP) $(CPPFLAGS) -o  "$@" "$<"


{$(MATLAB_ROOT)\rtw\c\src\rtiostream\rtiostreamtcpip}.cu.obj :
	$(CC) $(CFLAGS) -o  "$@" "$<"


{$(MATLAB_ROOT)\rtw\c\src\rtiostream\rtiostreamtcpip}.c.obj :
	$(CC) $(CFLAGS) -o  "$@" "$<"


{$(MATLAB_ROOT)\rtw\c\src\rtiostream\rtiostreamtcpip}.cu.obj :
	$(CPP) $(CPPFLAGS) -o  "$@" "$<"


{$(MATLAB_ROOT)\rtw\c\src\rtiostream\rtiostreamtcpip}.cpp.obj :
	$(CPP) $(CPPFLAGS) -o  "$@" "$<"


{$(START_DIR)\codegen\dll\mandelbrot_count\sil}.c.obj :
	$(CC) $(CFLAGS) -o  "$@" "$<"


{$(START_DIR)\codegen\dll\mandelbrot_count\sil}.c.obj :
	$(CC) $(CFLAGS) -o  "$@" "$<"


{$(START_DIR)\codegen\dll\mandelbrot_count\target}.c.obj :
	$(CC) $(CFLAGS) -o  "$@" "$<"


###########################################################################
## DEPENDENCIES
###########################################################################

$(ALL_OBJS) : $(MAKEFILE) rtw_proj.tmw


###########################################################################
## MISCELLANEOUS TARGETS
###########################################################################

info : 
	@cmd /C "@echo ### PRODUCT = $(PRODUCT)"
	@cmd /C "@echo ### PRODUCT_TYPE = $(PRODUCT_TYPE)"
	@cmd /C "@echo ### BUILD_TYPE = $(BUILD_TYPE)"
	@cmd /C "@echo ### INCLUDES = $(INCLUDES)"
	@cmd /C "@echo ### DEFINES = $(DEFINES)"
	@cmd /C "@echo ### ALL_SRCS = $(ALL_SRCS)"
	@cmd /C "@echo ### ALL_OBJS = $(ALL_OBJS)"
	@cmd /C "@echo ### LIBS = $(LIBS)"
	@cmd /C "@echo ### MODELREF_LIBS = $(MODELREF_LIBS)"
	@cmd /C "@echo ### SYSTEM_LIBS = $(SYSTEM_LIBS)"
	@cmd /C "@echo ### TOOLCHAIN_LIBS = $(TOOLCHAIN_LIBS)"
	@cmd /C "@echo ### CFLAGS = $(CFLAGS)"
	@cmd /C "@echo ### LDFLAGS = $(LDFLAGS)"
	@cmd /C "@echo ### SHAREDLIB_LDFLAGS = $(SHAREDLIB_LDFLAGS)"
	@cmd /C "@echo ### CPPFLAGS = $(CPPFLAGS)"
	@cmd /C "@echo ### CPP_LDFLAGS = $(CPP_LDFLAGS)"
	@cmd /C "@echo ### CPP_SHAREDLIB_LDFLAGS = $(CPP_SHAREDLIB_LDFLAGS)"
	@cmd /C "@echo ### ARFLAGS = $(ARFLAGS)"
	@cmd /C "@echo ### MEX_CFLAGS = $(MEX_CFLAGS)"
	@cmd /C "@echo ### MEX_CPPFLAGS = $(MEX_CPPFLAGS)"
	@cmd /C "@echo ### MEX_LDFLAGS = $(MEX_LDFLAGS)"
	@cmd /C "@echo ### MEX_CPPLDFLAGS = $(MEX_CPPLDFLAGS)"
	@cmd /C "@echo ### DOWNLOAD_FLAGS = $(DOWNLOAD_FLAGS)"
	@cmd /C "@echo ### EXECUTE_FLAGS = $(EXECUTE_FLAGS)"
	@cmd /C "@echo ### MAKE_FLAGS = $(MAKE_FLAGS)"


clean : 
	$(ECHO) "### Deleting all derived files..."
	@if exist $(PRODUCT) $(RM) $(PRODUCT)
	$(RM) $(ALL_OBJS)
	$(ECHO) "### Deleted all derived files."


