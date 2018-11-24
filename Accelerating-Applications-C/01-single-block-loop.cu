#include <stdio.h>

/*
  'Loop from 0 to 9'
 */

__global__ void loop()
{
    printf("This is iteration number %d\n", threadIdx.x);
}

int main()
{
  /*
   * When refactoring `loop` to launch as a kernel, be sure
   * to use the execution configuration to control how many
   * "iterations" to perform.
   *
   * For this exercise, only use 1 block of threads.
   */
  loop<<<1,10>>>();
  
  cudaDeviceSynchronize();
}
