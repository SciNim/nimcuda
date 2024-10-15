
#ifdef C2NIM
  #assumendef __NVRTC_H__

  #def __device_builtin__

  #mangle _nvrtcProgram nvrtcProgramObj

  #skipinclude

  #dynlib libName
  #private libName
  #cdecl
  #if defined(windows)
  #  stdcall
  #  define libName "nvrtc64.dll" // dont know that this is right
  #elif defined(macosx)
  #  define libName "libnvrtc.dylib"
  #else
  #  define libName "libnvrtc.so"
  #endif

#@
type nvrtcProgramObj {.noDecl, incompleteStruct.} = object
@#

#endif

