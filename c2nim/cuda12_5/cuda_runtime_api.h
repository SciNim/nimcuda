#ifdef C2NIM
  #assumendef __CUDA_RUNTIME_API_H__
  #assumendef __CUDA_INCLUDE_COMPILER_INTERNAL_HEADERS__

  #assumendef _WIN32
  #assumendef __CUDA_API_VERSION_INTERNAL
  #assumedef __CUDACC_INTEGRATED__
  #assumendef CUDA_API_PER_THREAD_DEFAULT_STREAM

  #def CUDARTAPI
  #def __host__
  #def __cudart_builtin__
  #def CUDART_CB
  #def __dv(v)

  #mangle __CUDA_API_VER_MAJOR__ CUDA_API_VER_MAJOR
  #mangle __CUDA_API_VER_MINOR__ CUDA_API_VER_MINOR
  #mangle __CUDA_API_VER_MAJOR__ CUDA_API_VER_MAJOR
  #mangle __CUDART_API_VERSION CUDART_API_VERSION
  #mangle __DOXYGEN_ONLY__ DOXYGEN_ONLY
  #mangle __CUDACC_RTC_MINIMAL__ CUDACC_RTC_MINIMAL
  #mangle __CUDACC_RDC__ CUDACC_RDC
  #mangle __CUDACC_EWP__ CUDACC_EWP
  #mangle __CUDACC_RTC__ CUDACC_RTC
  #mangle __CUDACC_RTC_MINIMAL__ CUDACC_RTC_MINIMAL

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
