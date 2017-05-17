#ifdef C2NIM
  #skipifndef CUDNNWINAPI
  #def CUDNNWINAPI

  #mangle CUDNN_H_ CUDNN_H

  #dynlib libName
  #private libName
  #cdecl
  #if defined(windows)
  #  define libName "cudnn.dll"
  #elif defined(macosx)
  #  define libName "libcudnn.dylib"
  #else
  #  define libName "libcudnn.so"
  #endif

  #private cudnnTensorStruct
  #private cudnnConvolutionStruct
  #private cudnnPoolingStruct
  #private cudnnFilterStruct
  #private cudnnLRNStruct
  #private cudnnActivationStruct
  #private cudnnSpatialTransformerStruct
  #private cudnnOpTensorStruct
  #private cudnnDropoutStruct

  struct cudnnTensorStruct {};
  struct cudnnConvolutionStruct {};
  struct cudnnPoolingStruct {};
  struct cudnnFilterStruct {};
  struct cudnnLRNStruct {};
  struct cudnnActivationStruct {};
  struct cudnnSpatialTransformerStruct {};
  struct cudnnOpTensorStruct {};
  struct cudnnDropoutStruct {};

#endif