/*
 * File: mandelbrot_count.cu
 *
 * GPU Coder version                    : 1.0
 * CUDA/C/C++ source code generated on  : 26-Dec-2017 22:57:54
 */

/* Include Files */
#include "rt_nonfinite.h"
#include "mandelbrot_count.h"

/* Function Declarations */
static __global__ void mandelbrot_count_kernel1(const real_T *yGrid, const
  real_T *xGrid, creal_T *z, real_T *count, creal_T *z0);
static __global__ void mandelbrot_count_kernel2(real_T *count);
static __global__ void mandelbrot_count_kernel3(creal_T *z0, real_T *count,
  real_T *y, creal_T *z);
static __device__ real_T rt_hypotd_snf(real_T u0, real_T u1);

/* Function Definitions */

/*
 * Arguments    : uint3 blockArg
 *                uint3 gridArg
 *                const real_T *yGrid
 *                const real_T *xGrid
 *                creal_T *z
 *                real_T *count
 *                creal_T *z0
 * Return Type  : void
 */
static __global__ __launch_bounds__(512, 1) void mandelbrot_count_kernel1(const
  real_T *yGrid, const real_T *xGrid, creal_T *z, real_T *count, creal_T *z0)
{
  int32_T k;
  ;
  ;
  k = (int32_T)(((((gridDim.x * gridDim.y * blockIdx.z + gridDim.x * blockIdx.y)
                   + blockIdx.x) * (blockDim.x * blockDim.y * blockDim.z) +
                  threadIdx.z * blockDim.x * blockDim.y) + threadIdx.y *
                 blockDim.x) + threadIdx.x);
  if (!(k >= 1000000)) {
    /*  Add Kernelfun pragma to trigger kernel creation */
    z0[k].re = xGrid[k] + 0.0 * yGrid[k];
    z0[k].im = yGrid[k];
    count[k] = 1.0;
    z[k] = z0[k];
  }
}

/*
 * Arguments    : uint3 blockArg
 *                uint3 gridArg
 *                real_T *count
 * Return Type  : void
 */
static __global__ __launch_bounds__(512, 1) void mandelbrot_count_kernel2(real_T
  *count)
{
  int32_T k;
  ;
  ;
  k = (int32_T)(((((gridDim.x * gridDim.y * blockIdx.z + gridDim.x * blockIdx.y)
                   + blockIdx.x) * (blockDim.x * blockDim.y * blockDim.z) +
                  threadIdx.z * blockDim.x * blockDim.y) + threadIdx.y *
                 blockDim.x) + threadIdx.x);
  if (!(k >= 1000000)) {
    count[k] = log(count[k]);
  }
}

/*
 * Arguments    : uint3 blockArg
 *                uint3 gridArg
 *                creal_T *z0
 *                real_T *count
 *                real_T *y
 *                creal_T *z
 * Return Type  : void
 */
static __global__ __launch_bounds__(512, 1) void mandelbrot_count_kernel3
  (creal_T *z0, real_T *count, real_T *y, creal_T *z)
{
  real_T z_im;
  int32_T k;
  ;
  ;
  k = (int32_T)(((((gridDim.x * gridDim.y * blockIdx.z + gridDim.x * blockIdx.y)
                   + blockIdx.x) * (blockDim.x * blockDim.y * blockDim.z) +
                  threadIdx.z * blockDim.x * blockDim.y) + threadIdx.y *
                 blockDim.x) + threadIdx.x);
  if (!(k >= 1000000)) {
    z_im = z[k].re * z[k].im + z[k].im * z[k].re;
    z[k].re = (z[k].re * z[k].re - z[k].im * z[k].im) + z0[k].re;
    z[k].im = z_im + z0[k].im;
    y[k] = rt_hypotd_snf(z[k].re, z[k].im);
    count[k] += (real_T)(y[k] <= 2.0);
  }
}

/*
 * Arguments    : real_T u0
 *                real_T u1
 * Return Type  : real_T
 */
static __device__ real_T rt_hypotd_snf(real_T u0, real_T u1)
{
  real_T y;
  real_T a;
  real_T b;
  a = fabs(u0);
  b = fabs(u1);
  if (a < b) {
    a /= b;
    y = b * sqrt(a * a + 1.0);
  } else if (a > b) {
    b /= a;
    y = a * sqrt(b * b + 1.0);
  } else if (isnan(b)) {
    y = b;
  } else {
    y = a * 1.4142135623730951;
  }

  return y;
}

/*
 * mandelbrot computation
 * Arguments    : real_T maxIterations
 *                const real_T xGrid[1000000]
 *                const real_T yGrid[1000000]
 *                real_T count[1000000]
 * Return Type  : void
 */
void mandelbrot_count(real_T maxIterations, const real_T xGrid[1000000], const
                      real_T yGrid[1000000], real_T count[1000000])
{
  int32_T n;
  real_T *gpu_yGrid;
  real_T *gpu_xGrid;
  creal_T *gpu_z;
  real_T *gpu_count;
  creal_T *gpu_z0;
  real_T *gpu_y;
  cudaMalloc(&gpu_y, 8000000ULL);
  cudaMalloc(&gpu_z0, 16000000ULL);
  cudaMalloc(&gpu_z, 16000000ULL);
  cudaMalloc(&gpu_count, 8000000ULL);
  cudaMalloc(&gpu_xGrid, 8000000ULL);
  cudaMalloc(&gpu_yGrid, 8000000ULL);

  /*  Add Kernelfun pragma to trigger kernel creation */
  cudaMemcpy((void *)gpu_yGrid, (void *)&yGrid[0], 8000000ULL,
             cudaMemcpyHostToDevice);
  cudaMemcpy((void *)gpu_xGrid, (void *)&xGrid[0], 8000000ULL,
             cudaMemcpyHostToDevice);
  mandelbrot_count_kernel1<<<dim3(1954U, 1U, 1U), dim3(512U, 1U, 1U)>>>
    (gpu_yGrid, gpu_xGrid, gpu_z, gpu_count, gpu_z0);
  for (n = 0; n < (int32_T)(maxIterations + 1.0); n++) {
    mandelbrot_count_kernel3<<<dim3(1954U, 1U, 1U), dim3(512U, 1U, 1U)>>>(gpu_z0,
      gpu_count, gpu_y, gpu_z);
  }

  mandelbrot_count_kernel2<<<dim3(1954U, 1U, 1U), dim3(512U, 1U, 1U)>>>
    (gpu_count);
  cudaMemcpy((void *)&count[0], (void *)gpu_count, 8000000ULL,
             cudaMemcpyDeviceToHost);
  cudaFree(gpu_yGrid);
  cudaFree(gpu_xGrid);
  cudaFree(gpu_count);
  cudaFree(gpu_z);
  cudaFree(gpu_z0);
  cudaFree(gpu_y);
}

/*
 * File trailer for mandelbrot_count.cu
 *
 * [EOF]
 */
