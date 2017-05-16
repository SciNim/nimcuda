#ifdef C2NIM
  #mangle CUSOLVER_COMMON_H_ CUSOLVER_COMMON_H

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

  #include "library_types.h"
  #skipinclude
#endif
