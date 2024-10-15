
#ifdef C2NIM
  #assumendef __cuda_cuda_h__

  #mangle cuuint32_t cint
  #mangle cuuclonglong culonglong
  #mangle default_ defaultUnderScore
  #mangle _oversize underScoreOversize
  #mangle _internal_padding underScoreInternal_padding

  #def __device_builtin__

  #def __CUDA_DEPRECATED

  #skipinclude

  #dynlib libName
  #private libName
  #cdecl
  #if defined(windows)
  #  stdcall
  #  define libName "cuda.dll" // dont know that this is right
  #elif defined(macosx)
  #  define libName "libcuda.dylib"
  #else
  #  define libName "libcuda.so"
  #endif



#endif

