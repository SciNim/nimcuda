#ifdef C2NIM
  #mangle CUBLAS_V2_H_ CUBLAS_V2_H

  #assumendef __CUDACC__
  #def CUBLASAPI
#endif
