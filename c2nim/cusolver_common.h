#ifdef C2NIM
  #mangle CUSOLVER_COMMON_H_ CUSOLVER_COMMON_H
  #mangle _MSC_FULL_VER MSC_FULL_VER
  #mangle __cplusplus cplusplus
  #mangle _MSVC_LANG MSVC_LANG

  #def CUSOLVERAPI

  #assumendef _MSC_VER

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
