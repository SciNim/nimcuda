#ifdef C2NIM
  #mangle CUSOLVERRF_H_ CUSOLVERRF_H

  #skipifndef CUSOLVERAPI
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

  #include "cuComplex.h"
  #include "cusolver_common.h"
  #skipinclude
#endif
