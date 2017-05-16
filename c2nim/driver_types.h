#ifdef C2NIM
  #mangle __DRIVER_TYPES_H__ DRIVER_TYPES_H
  #mangle __CUDA_INTERNAL_COMPILATION__ CUDA_INTERNAL_COMPILATION
  #mangle __CUDACC_RTC__ CUDACC_RTC

  #def __device_builtin__

  #pp cudaDevicePropDontCare

  typedef void* cudaStream_t;

  #skipinclude
#endif
