#include <stdio.h>

/*
 * Refactor `loop` to be a CUDA Kernel. The new kernel should
 * only do the work of 1 iteration of the original loop.
 */

__global__ void loop()
{
printf("This is iteration number %d\n", threadIdx.x + blockIdx.x * blockDim.x);
}

int main()
{
  /*
   * When refactoring `loop` to launch as a kernel, be sure
   * to use the execution configuration to control how many
   * "iterations" to perform.
   *
   * For this exercise, be sure to use at least 2 blocks in
   * the execution configuration.
   */

  loop<<<2,5>>>();
  
  cudaDeviceSynchronize();
}
