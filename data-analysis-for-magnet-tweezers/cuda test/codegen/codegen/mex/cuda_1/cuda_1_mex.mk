START_DIR = E:\ANALYS~1\DATA-A~1\CUDATE~1

MATLAB_ROOT = D:\PROGRA~2\MATLAB\R2017b
MAKEFILE = cuda_1_mex.mk

include cuda_1_mex.mki


SRC_FILES =  \
	cuda_1_data.cu \
	cuda_1_initialize.cu \
	cuda_1_terminate.cu \
	cuda_1.cu \
	_coder_cuda_1_info.cu \
	_coder_cuda_1_api.cu \
	_coder_cuda_1_mex.cu \
	c_mexapi_version.c

MEX_FILE_NAME_WO_EXT = cuda_1_mex
MEX_FILE_NAME = $(MEX_FILE_NAME_WO_EXT).mexw64
TARGET = $(MEX_FILE_NAME)

SYS_LIBS = 


#
#====================================================================
# gmake makefile fragment for building MEX functions using MSVC
# Copyright 2007-2016 The MathWorks, Inc.
#====================================================================
#
SHELL = cmd
OBJEXT = obj
CC = $(COMPILER)
#LD = $(LINKER)
.SUFFIXES: .$(OBJEXT) .cu

OBJLISTC = $(SRC_FILES:.c=.$(OBJEXT))
OBJLISTCPP  = $(OBJLISTC:.cpp=.$(OBJEXT))
OBJLIST  = $(OBJLISTCPP:.cu=.$(OBJEXT))

TARGETMT = $(TARGET).manifest
MEX = $(TARGETMT)
STRICTFP = /fp:strict

target: $(MEX)

MATLAB_INCLUDES = -I "$(MATLAB_ROOT)\simulink\include"
MATLAB_INCLUDES+= -I "$(MATLAB_ROOT)\toolbox\shared\simtargets"
SYS_INCLUDE = $(MATLAB_INCLUDES)

# Additional includes

SYS_INCLUDE += -I "$(START_DIR)\codegen\mex\cuda_1"
SYS_INCLUDE += -I "$(START_DIR)"
SYS_INCLUDE += -I ".\interface"
SYS_INCLUDE += -I "$(MATLAB_ROOT)\extern\include"
SYS_INCLUDE += -I "."

CUDA_LIBS = -L"$(CUDA_PATH)\lib\x64" cuda.lib cudart.lib cublas.lib cusolver.lib cufft.lib
SYS_LIBS += $(CUDA_LIBS) $(CLIBS)

COMMA=,
DIRECTIVES = $(MEX_FILE_NAME_WO_EXT)_mex.arf
COMP_FLAGS = $(COMPFLAGS) $(OMPFLAGS)
LINK_FLAGS = $(filter-out /export:mexFunction, $(LINKFLAGS))
LINK_FLAGSX = $(patsubst /LIBPATH:%,-L%, $(LINKFLAGS))
LINK_FLAGS = $(patsubst /%,-Xlinker /%, $(LINK_FLAGSX))
LINK_FLAGS += -Xnvlink -w  -Wno-deprecated-gpu-targets
LINK_FLAGS += -Xlinker /NODEFAULTLIB:libcmt.lib

ifeq ($(EMC_CONFIG),optim)
  COMP_FLAGS += $(OPTIMFLAGS) $(STRICTFP)
  LINK_FLAGS += $(LINKOPTIMFLAGS)
else
  COMP_FLAGS += $(DEBUGFLAGS)
  LINK_FLAGS += $(LINKDEBUGFLAGS)
endif
LINK_FLAGS += $(OMPLINKFLAGS)
LINK_FLAGS += -o $(TARGET)
LINK_FLAGS += 

CFLAGS = $(COMP_FLAGS)   $(USER_INCLUDE) $(SYS_INCLUDE)
CPPFLAGS = $(COMP_FLAGS)   $(USER_INCLUDE) $(SYS_INCLUDE)
NVCCFLAGS =  $(CUDA_FLAGS)   -arch sm_35 $(USER_INCLUDE) $(SYS_INCLUDE)

%.$(OBJEXT) : %.c
	$(CC) $(CFLAGS) "$<"

%.$(OBJEXT) : %.cpp
	$(CC) $(CPPFLAGS) "$<"

# Additional sources

%.$(OBJEXT) : $(START_DIR)/%.cu
	$(NVCC) $(NVCCFLAGS) "$<"
%.$(OBJEXT) : $(START_DIR)\codegen\mex\cuda_1/%.cu
	$(NVCC) $(NVCCFLAGS) "$<"
%.$(OBJEXT) : interface/%.cu
	$(NVCC) $(NVCCFLAGS) "$<"


%.$(OBJEXT) : $(START_DIR)/%.c
	$(NVCC) $(NVCCFLAGS) "$<"
%.$(OBJEXT) : $(START_DIR)\codegen\mex\cuda_1/%.c
	$(NVCC) $(NVCCFLAGS) "$<"
%.$(OBJEXT) : interface/%.c
	$(NVCC) $(NVCCFLAGS) "$<"


%.$(OBJEXT) : $(START_DIR)/%.cpp
	$(CC) $(CPPFLAGS) "$<"
%.$(OBJEXT) : $(START_DIR)\codegen\mex\cuda_1/%.cpp
	$(CC) $(CPPFLAGS) "$<"
%.$(OBJEXT) : interface/%.cpp
	$(CC) $(CPPFLAGS) "$<"



$(TARGET): $(OBJLIST) $(MAKEFILE)
	$(LD) $(LINK_FLAGS) $(OBJLIST) $(USER_LIBS) $(SYS_LIBS) -Xlinker $(MAPLIBS)
	@cmd /C "echo Build completed using compiler $(EMC_COMPILER)"

$(TARGETMT): $(TARGET)
	mt -outputresource:"$(TARGET);2" -manifest "$(TARGET).manifest"

#====================================================================
