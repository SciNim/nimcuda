#ifdef C2NIM
  #assumendef CUSOLVERSP_H_

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
  #include "driver_types.h"
  #include "cusolver_common.h"
  #include "cusparse.h"
  #skipinclude
#endif
