#ifdef C2NIM
  #asssumendef CUSOLVERDN_H_

  #def CUSOLVERAPI

  #define CUSOLVER_DEPRECATED(new_func)

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
  #include "cublas_api.h"
  #include "cusolver_common.h"
  #include "library_types.h"
  #include "driver_types.h"
  #skipinclude
#endif
