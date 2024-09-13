#ifdef C2NIM
  #mangle CUBLAS_API_H_ CUBLAS_API_H

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

  typedef struct {
     unsigned short x;
  } __half;

  typedef struct {
     unsigned int x;
  } __half2;



  #assumendef CUBLAS_API_H

  #include "library_types.h"
  // #include "cuComplex.h"
  //#skipinclude
#endif
