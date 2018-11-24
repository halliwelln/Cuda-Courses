#include <stdio.h>

/*
Print:
'Hello from the GPU.'
'Hello from the CPU.'
*/

void helloCPU()
{
  printf("Hello from the CPU.\n");
}


__global__ void helloGPU()
{
  printf("Hello from the GPU.\n");
}

int main()
{

  helloGPU<<<1,1>>>();

  cudaDeviceSynchronize();

  helloCPU();
}
