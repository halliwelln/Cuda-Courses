
__global__ void deviceKernel(int *a, int N)
{
  int idx = threadIdx.x + blockIdx.x * blockDim.x;
  int stride = blockDim.x * gridDim.x;

  for (int i = idx; i < N; i += stride)
  {
    a[i] = 1;
  }
}

void hostFunction(int *a, int N)
{
  for (int i = 0; i < N; ++i)
  {
    a[i] = 1;
  }
}

int main()
{

  int N = 2<<24;
  size_t size = N * sizeof(int);
  int *a;
  cudaMallocManaged(&a, size);

  /*
   * Conduct experiments to learn more about the behavior of
   * `cudaMallocManaged`.
   *
   * What happens when unified memory is accessed only by the GPU? 241 page faults

    deviceKernel<<<256, 256>>>(a, N);
    cudaDeviceSynchronize();
    cudaFree(a);

   * What happens when unified memory is accessed only by the CPU? 384 page faults

      hostFunction(a, N);
      cudaFree(a);

   * What happens when unified memory is accessed first by the GPU then the CPU? 234 page faults

    deviceKernel<<<256, 256>>>(a, N);
    cudaDeviceSynchronize();
    hostFunction(a, N);
    cudaFree(a);

   * What happens when unified memory is accessed first by the CPU then the GPU? 384 page faults

    hostFunction(a, N);
    deviceKernel<<<256, 256>>>(a, N);
    cudaDeviceSynchronize();
    cudaFree(a);
   * Hypothesize about UM behavior, page faulting specificially, before each
   * experiement, and then verify by running `nvprof`.
   */
  deviceKernel<<<256, 256>>>(a, N);
  cudaDeviceSynchronize();
  hostFunction(a,N);
  cudaFree(a);
}