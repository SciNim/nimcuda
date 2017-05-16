#ifdef C2NIM
  #mangle __CUDA_RUNTIME_API_H__ CUDA_RUNTIME_API_H

  #def CUDARTAPI
  #def __host__
  #def __cudart_builtin__
  #def CUDART_CB
  #def __dv(v)

  #skipifdef _WIN32
  #skipifdef __CUDA_API_VERSION_INTERNAL

  #dynlib libName
  #private libName
  #cdecl
  #if defined(windows)
  #  stdcall
  #  define libName "cudart.dll"
  #elif defined(macosx)
  #  define libName "libcudart.dylib"
  #else
  #  define libName "libcudart.so"
  #endif

  #include "vector_types.h"
  #include "driver_types.h"
  #include "surface_types.h"
  #include "texture_types.h"
  #skipinclude
#endif
