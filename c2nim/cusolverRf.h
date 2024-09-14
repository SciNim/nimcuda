#ifdef C2NIM
  #assumendef CUSOLVERRF_H_

  #def CUSOLVERAPI

  #dynlib libName
  #private libName
  #cdecl
  #if defined(windows)
  #  define libName "cusolver.dll"
  #elif defined(macosx)
  #  define libName "libcusolver.dylib"
  #else
  #  define libName "libcusolver.so"
  #endif

  #include "cusolver_common.h"
  #skipinclude
#endif
