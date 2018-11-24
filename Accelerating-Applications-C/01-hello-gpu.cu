#include <stdio.h>

/*
Print:
'Hello from the CPU.'
'Hello from the GPU.'
*/

void helloCPU()
{
  printf("Hello from the CPU.\n");
}


__global__ void helloGPU()
{
  printf("Hello also from the GPU.\n");
}

int main()
{

  helloCPU();

  helloGPU<<<1,1>>>();

  cudaDeviceSynchronize();
}
