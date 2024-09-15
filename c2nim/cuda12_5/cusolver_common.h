#ifdef C2NIM
  #assumendef CUSOLVER_COMMON_H_
  #mangle __int64 int64

  #def CUSOLVERAPI

  // #assumendef _MSC_VER

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
