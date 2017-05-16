#ifdef C2NIM
  #skipifndef __cdecl
  #def CURANDAPI __cdecl

  #mangle CURAND_H_ CURAND_H

  #dynlib libName
  #private libName
  #cdecl
  #if defined(windows)
  #  define libName "curand.dll"
  #elif defined(macosx)
  #  define libName "libcurand.dylib"
  #else
  #  define libName "libcurand.so"
  #endif

  #skipinclude
#endif
