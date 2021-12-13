
#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>
#include <thrust/reduce.h>
#include <thrust/extrema.h>
#include <thrust/execution_policy.h>
#include <thrust/device_ptr.h>

__global__
void check(char *x, int n, bool* z)
{
  char str [] ="em`hzugbst@oDy`nomdPeTHNS``sbihuddsvqf|"; 
  // s = flag{thatsAnExampleOfSIMT_architecture} -> 
  /* 
  k = ''
  for i in range(len(s)):
	add = (i % 2) * 2 - 1
	k += chr(ord(s[i]) + add)
	*/
  int i = blockIdx.x * blockDim.x + threadIdx.x;
  int additive = (i & 1) * 2 - 1;
  if (i < n)
  {
	  z[i] = true;
	  if (str[i] - additive != x[i])
		  z[i] = false;
  }
}

int main(void)
{
  char *d_s;
  bool *f;
  
  std::string s;
  std::cin >> s;
  
  cudaMalloc(&d_s, s.length() * sizeof(char)); 
  cudaMalloc(&f, s.length() * sizeof(bool));


  cudaMemcpy(d_s, s.c_str(), s.length()*sizeof(char), cudaMemcpyHostToDevice);

  check<<<1, 1024>>>(d_s, s.length(), f);
  
  thrust::device_ptr<bool> dp = thrust::device_pointer_cast(f);
  thrust::device_ptr<bool> pos = thrust::min_element(thrust::device, dp, dp + s.length());
  


  unsigned int pos_index = thrust::distance(dp, pos);
  bool min_val;
  cudaMemcpy(&min_val, &f[pos_index], sizeof(bool), cudaMemcpyDeviceToHost);
  
  
  std::cout << min_val << "\n";

  cudaFree(d_s);
  cudaFree(f);
}