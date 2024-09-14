#ifdef C2NIM
  #assumendef NVBLAS_H_

  #dynlib libName
  #private libName
  #cdecl
  #if defined(windows)
  #  define libName "nvblas.dll"
  #elif defined(macosx)
  #  define libName "libnvblas.dylib"
  #else
  #  define libName "libnvblas.so"
  #endif

  #include "cuComplex.h"
  #skipinclude
#endif
