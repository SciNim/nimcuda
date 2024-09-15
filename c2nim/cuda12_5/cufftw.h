#ifdef C2NIM
  #assumendef _CUFFTW_H_

  #def CUFFTAPI

  #dynlib libName
  #private libName
  #cdecl
  #if defined(windows)
  #  stdcall
  #  define libName "cufftw.dll"
  #elif defined(macosx)
  #  define libName "libcufftw.dylib"
  #else
  #  define libName "libcufftw.so"
  #endif

  #skipinclude
#endif
