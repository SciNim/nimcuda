#ifdef C2NIM
  #def CUSPARSEAPI

  #assumendef CUSPARSE_H_
  #assumendef _MSC_VER

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

  #def CUSPARSE_DEPRECATED_REPLACE_WITH(new_func)
  #def CUSPARSE_DEPRECATED
  #def CUSPARSE_DEPRECATED_TYPE
  #def CUSPARSE_DEPRECATED_TYPE_MSVC
  #def CUSPARSE_DEPRECATED_ENUM_REPLACE_WITH(new_enum)
  #def CUSPARSE_DEPRECATED_ENUM

  #include "library_types.h"
  #include "driver_types.h"
  #include "cuComplex.h"
  #skipinclude
#endif
