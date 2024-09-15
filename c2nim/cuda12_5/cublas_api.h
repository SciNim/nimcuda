#ifdef C2NIM
  #def CUBLASWINAPI
  #def CUBLASAPI

  #mangle __half half
  #mangle __half2 half2

  #dynlib libName
  #private libName
  #cdecl
  #if defined(windows)
  #  define libName "cublas.dll"
  #elif defined(macosx)
  #  define libName "libcublas.dylib"
  #else
  #  define libName "libcublas.so"
  #endif

  #assumendef CUBLAS_API_H_

  #include "library_types.h"
#endif
