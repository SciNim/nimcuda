#ifdef C2NIM
  #mangle CUBLAS_V2_H_ CUBLAS_V2_H
  #mangle CUBLAS_H_ CUBLAS_H

  #assumendef __CUDACC__
  #assumendef CUBLAS_V2_H
  #def CUBLASAPI
#endif
