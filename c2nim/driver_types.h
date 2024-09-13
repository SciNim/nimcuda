#ifdef C2NIM
  #assumendef __DRIVER_TYPES_H__
  #assumedef __CUDA_INCLUDE_COMPILER_INTERNAL_HEADERS__
  #assumendef __CUDA_INTERNAL_COMPILATION__
  #assumendef __UNDEF_CUDA_INCLUDE_COMPILER_INTERNAL_HEADERS_DRIVER_TYPES_H__

  #mangle __CUDACC_RTC_MINIMAL__ CUDACC_RTC_MINIMAL
  #mangle __DOXYGEN_ONLY__ DOXYGEN_ONLY
  #mangle __CUDACC_RTC__ CUDACC_RTC
  #mangle _WIN32 WIN32

  #def __device_builtin__

  #pp cudaDevicePropDontCare



  //#skipinclude


#endif
