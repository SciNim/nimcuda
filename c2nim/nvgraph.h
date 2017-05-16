#ifdef C2NIM
  #skipifndef NVGRAPH_API
  #def NVGRAPH_API

  #mangle cudaDataType_t cudaDataType

  // #prefix nvgraph
  // #prefix NVGRAPH_

  #dynlib libName
  #private libName
  #cdecl
  #if defined(windows)
  #  define libName "nvgraph.dll"
  #elif defined(macosx)
  #  define libName "libnvgraph.dylib"
  #else
  #  define libName "libnvgraph.so"
  #endif

  #include "library_types.h"
  #skipinclude
#endif
