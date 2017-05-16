#ifdef C2NIM
  #mangle NVBLAS_H_ NVBLAS_H
  #mangle sgemm_ sgemm1
  #mangle dgemm_ dgemm1
  #mangle cgemm_ cgemm1
  #mangle zgemm_ zgemm1
  #mangle ssyrk_ ssyrk1
  #mangle dsyrk_ dsyrk1
  #mangle csyrk_ csyrk1
  #mangle zsyrk_ zsyrk1
  #mangle cherk_ cherk1
  #mangle zherk_ zherk1
  #mangle strsm_ strsm1
  #mangle dtrsm_ dtrsm1
  #mangle ctrsm_ ctrsm1
  #mangle ztrsm_ ztrsm1
  #mangle ssymm_ ssymm1
  #mangle dsymm_ dsymm1
  #mangle csymm_ csymm1
  #mangle zsymm_ zsymm1
  #mangle chemm_ chemm1
  #mangle zhemm_ zhemm1
  #mangle ssyr2k_ ssyr2k1
  #mangle dsyr2k_ dsyr2k1
  #mangle csyr2k_ csyr2k1
  #mangle zsyr2k_ zsyr2k1
  #mangle cher2k_ cher2k1
  #mangle zher2k_ zher2k1
  #mangle strmm_ strmm1
  #mangle dtrmm_ dtrmm1
  #mangle ctrmm_ ctrmm1
  #mangle ztrmm_ ztrmm1

  #dynlib libName
  #private libName
  #cdecl
  #if defined(windows)
  #  define libName "nvblas.dll"
  #elif defined(macosx)
  #  define libName "libnvblas.dylib"
  #else
  #  define libName "libnvblas.so"
  #endif

  #include "cuComplex.h"
  #skipinclude
#endif
