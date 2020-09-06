/*
 * cuda_1.cu
 *
 * Code generation for function 'cuda_1'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "cuda_1.h"
#include "cuda_1_data.h"

/* Function Declarations */
static void checkCudaError(cudaError_t errCode, const char * file, uint32_T line);
static __global__ void cuda_1_kernel1(const real_T *x, real_T *y_data);

/* Function Definitions */
static void checkCudaError(cudaError_t errCode, const char * file, uint32_T line)
{
  emlrtRTEInfo rtInfo;
  char_T *pn;
  char_T *fn;
  char_T *brk;
  uint32_T len;
  if (errCode != cudaSuccess) {
    len = strlen(file);
    pn = (char_T *)calloc(len + 1U, 1U);
    fn = (char_T *)calloc(len + 1U, 1U);
    memcpy(pn, file, len);
    memcpy(fn, file, len);
    brk = strrchr(fn, '.');
    *brk = '\x00';
    brk = strrchr(fn, '/');
    if (brk == NULL) {
      brk = strrchr(fn, '\\');
    }

    brk++;
    rtInfo.lineNo = (int32_T)line;
    rtInfo.colNo = (int32_T)0U;
    rtInfo.fName = brk;
    rtInfo.pName = pn;
    emlrtCUDAError(errCode, cudaGetErrorName(errCode), cudaGetErrorString
                   (errCode), &rtInfo, emlrtRootTLSGlobal);
  }
}

static __global__ __launch_bounds__(512, 1) void cuda_1_kernel1(const real_T *x,
  real_T *y_data)
{
  uint32_T threadId;
  int32_T i;
  int32_T j;
  ;
  ;
  threadId = ((((gridDim.x * gridDim.y * blockIdx.z + gridDim.x * blockIdx.y) +
                blockIdx.x) * (blockDim.x * blockDim.y * blockDim.z) +
               threadIdx.z * blockDim.x * blockDim.y) + threadIdx.y * blockDim.x)
    + threadIdx.x;
  i = (int32_T)(threadId / 1000U);
  j = (int32_T)(threadId - (uint32_T)i * 1000U);
  if ((!(j >= 1000)) && (!(i >= 1000))) {
    y_data[i + 1000 * j] = x[i + 1000 * j] * x[i + 1000 * j] / ((real_T)(i + j)
      + 2.0);
  }
}

void cuda_1(const real_T x[1000000], real_T n, real_T y_data[], int32_T y_size[2])
{
  int32_T j;
  int32_T i;
  real_T *gpu_x;
  real_T *gpu_y_data;
  boolean_T y_data_dirtyOnGpu;

#define CUDACHECK(errCall)             checkCudaError(errCall, __FILE__, __LINE__)

  checkCudaError(cudaGetLastError(), __FILE__, __LINE__);
  CUDACHECK(cudaMalloc(&gpu_y_data, 1000000U * sizeof(real_T)));
  CUDACHECK(cudaMalloc(&gpu_x, 8000000ULL));
  y_data_dirtyOnGpu = false;

  /*  并行测试第一轮，先用范例测试GPU是否正常工作 */
  y_size[0] = 1;
  y_size[1] = 1;
  y_data[0] = 0.0;
  if (n == 1.0) {
    y_size[0] = 1000;
    y_size[1] = 1000;
    for (j = 0; j < 1000000; j++) {
      y_data[j] = 0.0;
    }

    for (i = 0; i < 1000; i++) {
      for (j = 0; j < 1000; j++) {
        y_data[i + 1000 * j] = x[i + 1000 * j] * x[i + 1000 * j] / ((real_T)(i +
          j) + 2.0);
      }
    }
  } else {
    if (n == 2.0) {
      y_size[0] = 1000;
      y_size[1] = 1000;
      CUDACHECK(cudaMemcpy((void *)gpu_x, (void *)&x[0], 8000000ULL,
                           cudaMemcpyHostToDevice));
      CUDACHECK(cudaMemcpy((void *)gpu_y_data, (void *)&y_data[0], 1000000U *
                           sizeof(real_T), cudaMemcpyHostToDevice));
      cuda_1_kernel1<<<dim3(1954U, 1U, 1U), dim3(512U, 1U, 1U)>>>(gpu_x,
        gpu_y_data);
      CUDACHECK(cudaGetLastError());
      y_data_dirtyOnGpu = true;
    }
  }

  if (y_data_dirtyOnGpu) {
    CUDACHECK(cudaMemcpy((void *)&y_data[0], (void *)gpu_y_data, y_size[0] *
                         y_size[1] * sizeof(real_T), cudaMemcpyDeviceToHost));
  }

  CUDACHECK(cudaFree(gpu_x));
  CUDACHECK(cudaFree(gpu_y_data));

#undef CUDACHECK

}

/* End of code generation (cuda_1.cu) */
