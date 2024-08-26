#ifdef C2NIM
  #def CUSPARSEAPI

  #mangle cudaDataType_t cudaDataType
  #mangle CUSPARSE_H_ CUSPARSE_H
  #mangle _MSC_VER MSC_VER
  #mangle __cplusplus cplusplus

  // #prefix cusparse
  // #prefix cusparse_

  #dynlib libName
  #private libName
  #cdecl
  #if defined(windows)
  #  define libName "cusparse.dll"
  #elif defined(macosx)
  #  define libName "libcusparse.dylib"
  #else
  #  define libName "libcusparse.so"
  #endif

  #define DISABLE_CUSPARSE_DEPRECATED

  typedef void* cudaStream_t;

  #include "library_types.h"
  #include "cuComplex.h"
  #skipinclude
#endif
