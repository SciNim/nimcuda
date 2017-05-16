#ifdef C2NIM
  #skipifndef __cdecl
  #def CUSPARSEAPI __cdecl

  #mangle cudaDataType_t cudaDataType
  #mangle CUSPARSE_H_ CUSPARSE_H

  #prefix cusparse
  #prefix cusparse_

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

  #include "library_types.h"
  #skipinclude
#endif
