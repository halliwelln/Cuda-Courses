#include <stdio.h>


/*
Print:
'Hello from GPU'
'Hello from CPU'
'Hello from GPU'
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

  helloGPU<<<1,1>>>();

  cudaDeviceSynchronize();

  helloCPU();

  helloGPU<<<1,1>>>();

  cudaDeviceSynchronize();


}
