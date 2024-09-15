#ifdef C2NIM
  #mangle __cuda_occupancy_h__ cuda_occupancy_h
  #mangle __CUDA_OCC_MAJOR__ CUDA_OCC_MAJOR
  #mangle __CUDA_OCC_MINOR__ CUDA_OCC_MINOR
  #mangle __occMin occMin
  #mangle __occDivideRoundUp occDivideRoundUp
  #mangle __occRoundUp occRoundUp

  #assumendef __CUDACC__
  #def __OCC_INLINE inline

  // typedef struct {} cudaOccResult;
  // typedef struct {} cudaOccDeviceProp;
  // typedef struct {} cudaOccFuncAttributes;
  // typedef struct {} cudaOccDeviceState;
#endif