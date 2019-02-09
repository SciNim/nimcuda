 {.deadCodeElim: on.}
when defined(windows):
  import os
  #{.passL: "\"" & os.getEnv("CUDA_PATH") / "lib/x64" / "cudnn.lib" & "\"".}
  {.pragma: dyn.}
elif defined(macosx):
  const
    libName = "libcudnn.dylib"
  {.pragma: dyn, dynlib: libName.}
else:
  const
    libName = "libcudnn.so"
  {.pragma: dyn, dynlib: libName.}
type
  cudnnTensorStruct = object
  
  cudnnConvolutionStruct = object
  
  cudnnPoolingStruct = object
  
  cudnnFilterStruct = object
  
  cudnnLRNStruct = object
  
  cudnnActivationStruct = object
  
  cudnnSpatialTransformerStruct = object
  
  cudnnOpTensorStruct = object
  
  cudnnDropoutStruct = object
  

##    cudnn : Neural Networks Library
## 
## 

when not defined(CUDNN_H):
  const
    CUDNN_H* = true
    CUDNN_MAJOR* = 5
    CUDNN_MINOR* = 1
    CUDNN_PATCHLEVEL* = 10
    CUDNN_VERSION* = (CUDNN_MAJOR * 1000 + CUDNN_MINOR * 100 + CUDNN_PATCHLEVEL)
  import
    driver_types

  type
    cudnnContext* = object
    
  type
    cudnnHandle_t* = ptr cudnnContext
  proc cudnnGetVersion*(): csize {.cdecl, importc: "cudnnGetVersion", dyn.}
  ## 
  ##  CUDNN return codes
  ## 
  type
    cudnnStatus_t* {.size: sizeof(cint).} = enum
      CUDNN_STATUS_SUCCESS = 0, CUDNN_STATUS_NOT_INITIALIZED = 1,
      CUDNN_STATUS_ALLOC_FAILED = 2, CUDNN_STATUS_BAD_PARAM = 3,
      CUDNN_STATUS_INTERNAL_ERROR = 4, CUDNN_STATUS_INVALID_VALUE = 5,
      CUDNN_STATUS_ARCH_MISMATCH = 6, CUDNN_STATUS_MAPPING_ERROR = 7,
      CUDNN_STATUS_EXECUTION_FAILED = 8, CUDNN_STATUS_NOT_SUPPORTED = 9,
      CUDNN_STATUS_LICENSE_ERROR = 10
  ##  human-readable error messages
  proc cudnnGetErrorString*(status: cudnnStatus_t): cstring {.cdecl,
      importc: "cudnnGetErrorString", dyn.}
  proc cudnnCreate*(handle: ptr cudnnHandle_t): cudnnStatus_t {.cdecl,
      importc: "cudnnCreate", dyn.}
  proc cudnnDestroy*(handle: cudnnHandle_t): cudnnStatus_t {.cdecl,
      importc: "cudnnDestroy", dyn.}
  proc cudnnSetStream*(handle: cudnnHandle_t; streamId: cudaStream_t): cudnnStatus_t {.
      cdecl, importc: "cudnnSetStream", dyn.}
  proc cudnnGetStream*(handle: cudnnHandle_t; streamId: ptr cudaStream_t): cudnnStatus_t {.
      cdecl, importc: "cudnnGetStream", dyn.}
  ##  Data structures to represent Image/Filter and the Neural Network Layer
  type
    cudnnTensorDescriptor_t* = ptr cudnnTensorStruct
    cudnnConvolutionDescriptor_t* = ptr cudnnConvolutionStruct
    cudnnPoolingDescriptor_t* = ptr cudnnPoolingStruct
    cudnnFilterDescriptor_t* = ptr cudnnFilterStruct
    cudnnLRNDescriptor_t* = ptr cudnnLRNStruct
    cudnnActivationDescriptor_t* = ptr cudnnActivationStruct
    cudnnSpatialTransformerDescriptor_t* = ptr cudnnSpatialTransformerStruct
    cudnnOpTensorDescriptor_t* = ptr cudnnOpTensorStruct
  ## 
  ##  CUDNN data type
  ## 
  type
    cudnnDataType_t* {.size: sizeof(cint).} = enum
      CUDNN_DATA_FLOAT = 0, CUDNN_DATA_DOUBLE = 1, CUDNN_DATA_HALF = 2
  ## 
  ##  CUDNN propagate Nan
  ## 
  type
    cudnnNanPropagation_t* {.size: sizeof(cint).} = enum
      CUDNN_NOT_PROPAGATE_NAN = 0, CUDNN_PROPAGATE_NAN = 1
  ##  Maximum supported number of tensor dimensions
  const
    CUDNN_DIM_MAX* = 8
  ##  Create an instance of a generic Tensor descriptor
  proc cudnnCreateTensorDescriptor*(tensorDesc: ptr cudnnTensorDescriptor_t): cudnnStatus_t {.
      cdecl, importc: "cudnnCreateTensorDescriptor", dyn.}
  type
    cudnnTensorFormat_t* {.size: sizeof(cint).} = enum
      CUDNN_TENSOR_NCHW = 0,    ##  row major (wStride = 1, hStride = w)
      CUDNN_TENSOR_NHWC = 1
  proc cudnnSetTensor4dDescriptor*(tensorDesc: cudnnTensorDescriptor_t;
                                  format: cudnnTensorFormat_t;
                                  dataType: cudnnDataType_t; n: cint; c: cint;
                                  h: cint; w: cint): cudnnStatus_t {.cdecl,
      importc: "cudnnSetTensor4dDescriptor", dyn.}
    ##  image data type
    ##  number of inputs (batch size)
    ##  number of input feature maps
    ##  height of input section
  ##  width of input section
  proc cudnnSetTensor4dDescriptorEx*(tensorDesc: cudnnTensorDescriptor_t;
                                    dataType: cudnnDataType_t; n: cint; c: cint;
                                    h: cint; w: cint; nStride: cint; cStride: cint;
                                    hStride: cint; wStride: cint): cudnnStatus_t {.
      cdecl, importc: "cudnnSetTensor4dDescriptorEx", dyn.}
    ##  image data type
    ##  number of inputs (batch size)
    ##  number of input feature maps
    ##  height of input section
    ##  width of input section
  proc cudnnGetTensor4dDescriptor*(tensorDesc: cudnnTensorDescriptor_t;
                                  dataType: ptr cudnnDataType_t; n: ptr cint;
                                  c: ptr cint; h: ptr cint; w: ptr cint;
                                  nStride: ptr cint; cStride: ptr cint;
                                  hStride: ptr cint; wStride: ptr cint): cudnnStatus_t {.
      cdecl, importc: "cudnnGetTensor4dDescriptor", dyn.}
    ##  image data type
    ##  number of inputs (batch size)
    ##  number of input feature maps
    ##  height of input section
    ##  width of input section
  proc cudnnSetTensorNdDescriptor*(tensorDesc: cudnnTensorDescriptor_t;
                                  dataType: cudnnDataType_t; nbDims: cint;
                                  dimA: ptr cint; strideA: ptr cint): cudnnStatus_t {.
      cdecl, importc: "cudnnSetTensorNdDescriptor", dyn.}
  proc cudnnGetTensorNdDescriptor*(tensorDesc: cudnnTensorDescriptor_t;
                                  nbDimsRequested: cint;
                                  dataType: ptr cudnnDataType_t; nbDims: ptr cint;
                                  dimA: ptr cint; strideA: ptr cint): cudnnStatus_t {.
      cdecl, importc: "cudnnGetTensorNdDescriptor", dyn.}
  ##  PixelOffset( n, c, h, w ) = n *input_stride + c * feature_stride + h * h_stride + w * w_stride
  ## 
  ##    1)Example of all images in row major order one batch of features after the other (with an optional padding on row)
  ##    input_stride :  c x h x h_stride
  ##    feature_stride : h x h_stride
  ##    h_stride  :  >= w  ( h_stride = w if no padding)
  ##    w_stride  : 1
  ## 
  ## 
  ##    2)Example of all images in row major with features maps interleaved
  ##    input_stride :  c x h x h_stride
  ##    feature_stride : 1
  ##    h_stride  :  w x c
  ##    w_stride  : c
  ## 
  ##    3)Example of all images in column major order one batch of features after the other (with optional padding on column)
  ##    input_stride :  c x w x w_stride
  ##    feature_stride : w x w_stride
  ##    h_stride  :  1
  ##    w_stride  :  >= h
  ## 
  ## 
  ##  Destroy an instance of Tensor4d descriptor
  proc cudnnDestroyTensorDescriptor*(tensorDesc: cudnnTensorDescriptor_t): cudnnStatus_t {.
      cdecl, importc: "cudnnDestroyTensorDescriptor", dyn.}
  ##  Tensor layout conversion helper (y = alpha * x + beta * y)
  proc cudnnTransformTensor*(handle: cudnnHandle_t; alpha: pointer;
                            xDesc: cudnnTensorDescriptor_t; x: pointer;
                            beta: pointer; yDesc: cudnnTensorDescriptor_t;
                            y: pointer): cudnnStatus_t {.cdecl,
      importc: "cudnnTransformTensor", dyn.}
  ##  Tensor Bias addition : C = alpha * A + beta * C
  proc cudnnAddTensor*(handle: cudnnHandle_t; alpha: pointer;
                      aDesc: cudnnTensorDescriptor_t; A: pointer; beta: pointer;
                      cDesc: cudnnTensorDescriptor_t; C: pointer): cudnnStatus_t {.
      cdecl, importc: "cudnnAddTensor", dyn.}
  ## 
  ##  CUDNN OpTensor op type
  ## 
  type
    cudnnOpTensorOp_t* {.size: sizeof(cint).} = enum
      CUDNN_OP_TENSOR_ADD = 0, CUDNN_OP_TENSOR_MUL = 1, CUDNN_OP_TENSOR_MIN = 2,
      CUDNN_OP_TENSOR_MAX = 3
  proc cudnnCreateOpTensorDescriptor*(opTensorDesc: ptr cudnnOpTensorDescriptor_t): cudnnStatus_t {.
      cdecl, importc: "cudnnCreateOpTensorDescriptor", dyn.}
  proc cudnnSetOpTensorDescriptor*(opTensorDesc: cudnnOpTensorDescriptor_t;
                                  opTensorOp: cudnnOpTensorOp_t;
                                  opTensorCompType: cudnnDataType_t;
                                  opTensorNanOpt: cudnnNanPropagation_t): cudnnStatus_t {.
      cdecl, importc: "cudnnSetOpTensorDescriptor", dyn.}
  proc cudnnGetOpTensorDescriptor*(opTensorDesc: cudnnOpTensorDescriptor_t;
                                  opTensorOp: ptr cudnnOpTensorOp_t;
                                  opTensorCompType: ptr cudnnDataType_t;
                                  opTensorNanOpt: ptr cudnnNanPropagation_t): cudnnStatus_t {.
      cdecl, importc: "cudnnGetOpTensorDescriptor", dyn.}
  proc cudnnDestroyOpTensorDescriptor*(opTensorDesc: cudnnOpTensorDescriptor_t): cudnnStatus_t {.
      cdecl, importc: "cudnnDestroyOpTensorDescriptor", dyn.}
  ##  Tensor Bias operation : C = op( alpha1 * A, alpha2 * B ) + beta * C
  proc cudnnOpTensor*(handle: cudnnHandle_t;
                     opTensorDesc: cudnnOpTensorDescriptor_t; alpha1: pointer;
                     aDesc: cudnnTensorDescriptor_t; A: pointer; alpha2: pointer;
                     bDesc: cudnnTensorDescriptor_t; B: pointer; beta: pointer;
                     cDesc: cudnnTensorDescriptor_t; C: pointer): cudnnStatus_t {.
      cdecl, importc: "cudnnOpTensor", dyn.}
  ##  Set all values of a tensor to a given value : y[i] = value[0]
  proc cudnnSetTensor*(handle: cudnnHandle_t; yDesc: cudnnTensorDescriptor_t;
                      y: pointer; valuePtr: pointer): cudnnStatus_t {.cdecl,
      importc: "cudnnSetTensor", dyn.}
  ##  Scale all values of a tensor by a given factor : y[i] = alpha * y[i]
  proc cudnnScaleTensor*(handle: cudnnHandle_t; yDesc: cudnnTensorDescriptor_t;
                        y: pointer; alpha: pointer): cudnnStatus_t {.cdecl,
      importc: "cudnnScaleTensor", dyn.}
  ## 
  ##   convolution mode
  ## 
  type
    cudnnConvolutionMode_t* {.size: sizeof(cint).} = enum
      CUDNN_CONVOLUTION = 0, CUDNN_CROSS_CORRELATION = 1
  ##  Create an instance of FilterStruct
  proc cudnnCreateFilterDescriptor*(filterDesc: ptr cudnnFilterDescriptor_t): cudnnStatus_t {.
      cdecl, importc: "cudnnCreateFilterDescriptor", dyn.}
  proc cudnnSetFilter4dDescriptor*(filterDesc: cudnnFilterDescriptor_t;
                                  dataType: cudnnDataType_t;
                                  format: cudnnTensorFormat_t; k: cint; c: cint;
                                  h: cint; w: cint): cudnnStatus_t {.cdecl,
      importc: "cudnnSetFilter4dDescriptor", dyn.}
    ##  image data type
    ##  number of output feature maps
    ##  number of input feature maps
    ##  height of each input filter
  ##  width of  each input filter
  proc cudnnGetFilter4dDescriptor*(filterDesc: cudnnFilterDescriptor_t;
                                  dataType: ptr cudnnDataType_t;
                                  format: ptr cudnnTensorFormat_t; k: ptr cint;
                                  c: ptr cint; h: ptr cint; w: ptr cint): cudnnStatus_t {.
      cdecl, importc: "cudnnGetFilter4dDescriptor", dyn.}
    ##  image data type
    ##  number of output feature maps
    ##  number of input feature maps
    ##  height of each input filter
  ##  width of  each input filter
  proc cudnnSetFilterNdDescriptor*(filterDesc: cudnnFilterDescriptor_t;
                                  dataType: cudnnDataType_t;
                                  format: cudnnTensorFormat_t; nbDims: cint;
                                  filterDimA: ptr cint): cudnnStatus_t {.cdecl,
      importc: "cudnnSetFilterNdDescriptor", dyn.}
    ##  image data type
  proc cudnnGetFilterNdDescriptor*(filterDesc: cudnnFilterDescriptor_t;
                                  nbDimsRequested: cint;
                                  dataType: ptr cudnnDataType_t;
                                  format: ptr cudnnTensorFormat_t;
                                  nbDims: ptr cint; filterDimA: ptr cint): cudnnStatus_t {.
      cdecl, importc: "cudnnGetFilterNdDescriptor", dyn.}
    ##  image data type
  proc cudnnDestroyFilterDescriptor*(filterDesc: cudnnFilterDescriptor_t): cudnnStatus_t {.
      cdecl, importc: "cudnnDestroyFilterDescriptor", dyn.}
  ##  Create an instance of convolution descriptor
  proc cudnnCreateConvolutionDescriptor*(convDesc: ptr cudnnConvolutionDescriptor_t): cudnnStatus_t {.
      cdecl, importc: "cudnnCreateConvolutionDescriptor", dyn.}
  proc cudnnSetConvolution2dDescriptor*(convDesc: cudnnConvolutionDescriptor_t;
                                       pad_h: cint; pad_w: cint; u: cint; v: cint;
                                       upscalex: cint; upscaley: cint;
                                       mode: cudnnConvolutionMode_t): cudnnStatus_t {.
      cdecl, importc: "cudnnSetConvolution2dDescriptor", dyn.}
    ##  zero-padding height
    ##  zero-padding width
    ##  vertical filter stride
    ##  horizontal filter stride
    ##  upscale the input in x-direction
    ##  upscale the input in y-direction
  proc cudnnSetConvolution2dDescriptor_v5*(
      convDesc: cudnnConvolutionDescriptor_t; pad_h: cint; pad_w: cint; u: cint;
      v: cint; upscalex: cint; upscaley: cint; mode: cudnnConvolutionMode_t;
      dataType: cudnnDataType_t): cudnnStatus_t {.cdecl,
      importc: "cudnnSetConvolution2dDescriptor_v5", dyn.}
    ##  zero-padding height
    ##  zero-padding width
    ##  vertical filter stride
    ##  horizontal filter stride
    ##  upscale the input in x-direction
    ##  upscale the input in y-direction
  proc cudnnGetConvolution2dDescriptor*(convDesc: cudnnConvolutionDescriptor_t;
                                       pad_h: ptr cint; pad_w: ptr cint; u: ptr cint;
                                       v: ptr cint; upscalex: ptr cint;
                                       upscaley: ptr cint;
                                       mode: ptr cudnnConvolutionMode_t): cudnnStatus_t {.
      cdecl, importc: "cudnnGetConvolution2dDescriptor", dyn.}
    ##  zero-padding height
    ##  zero-padding width
    ##  vertical filter stride
    ##  horizontal filter stride
    ##  upscale the input in x-direction
    ##  upscale the input in y-direction
  proc cudnnGetConvolution2dDescriptor_v5*(
      convDesc: cudnnConvolutionDescriptor_t; pad_h: ptr cint; pad_w: ptr cint;
      u: ptr cint; v: ptr cint; upscalex: ptr cint; upscaley: ptr cint;
      mode: ptr cudnnConvolutionMode_t; dataType: ptr cudnnDataType_t): cudnnStatus_t {.
      cdecl, importc: "cudnnGetConvolution2dDescriptor_v5", dyn.}
    ##  zero-padding height
    ##  zero-padding width
    ##  vertical filter stride
    ##  horizontal filter stride
    ##  upscale the input in x-direction
    ##  upscale the input in y-direction
  ##  Helper function to return the dimensions of the output tensor given a convolution descriptor
  proc cudnnGetConvolution2dForwardOutputDim*(
      convDesc: cudnnConvolutionDescriptor_t;
      inputTensorDesc: cudnnTensorDescriptor_t;
      filterDesc: cudnnFilterDescriptor_t; n: ptr cint; c: ptr cint; h: ptr cint;
      w: ptr cint): cudnnStatus_t {.cdecl, importc: "cudnnGetConvolution2dForwardOutputDim",
                                dyn.}
  proc cudnnSetConvolutionNdDescriptor*(convDesc: cudnnConvolutionDescriptor_t;
                                       arrayLength: cint; padA: ptr cint;
                                       filterStrideA: ptr cint; upscaleA: ptr cint;
                                       mode: cudnnConvolutionMode_t;
                                       dataType: cudnnDataType_t): cudnnStatus_t {.
      cdecl, importc: "cudnnSetConvolutionNdDescriptor", dyn.}
    ##  nbDims-2 size
  ##  convolution data type
  proc cudnnGetConvolutionNdDescriptor*(convDesc: cudnnConvolutionDescriptor_t;
                                       arrayLengthRequested: cint;
                                       arrayLength: ptr cint; padA: ptr cint;
                                       strideA: ptr cint; upscaleA: ptr cint;
                                       mode: ptr cudnnConvolutionMode_t;
                                       dataType: ptr cudnnDataType_t): cudnnStatus_t {.
      cdecl, importc: "cudnnGetConvolutionNdDescriptor", dyn.}
  ##  convolution data type
  ##  Helper function to return the dimensions of the output tensor given a convolution descriptor
  proc cudnnGetConvolutionNdForwardOutputDim*(
      convDesc: cudnnConvolutionDescriptor_t;
      inputTensorDesc: cudnnTensorDescriptor_t;
      filterDesc: cudnnFilterDescriptor_t; nbDims: cint; tensorOuputDimA: ptr cint): cudnnStatus_t {.
      cdecl, importc: "cudnnGetConvolutionNdForwardOutputDim", dyn.}
  ##  Destroy an instance of convolution descriptor
  proc cudnnDestroyConvolutionDescriptor*(convDesc: cudnnConvolutionDescriptor_t): cudnnStatus_t {.
      cdecl, importc: "cudnnDestroyConvolutionDescriptor", dyn.}
  ##  helper function to provide the convolution algo that fit best the requirement
  type
    cudnnConvolutionFwdPreference_t* {.size: sizeof(cint).} = enum
      CUDNN_CONVOLUTION_FWD_NO_WORKSPACE = 0,
      CUDNN_CONVOLUTION_FWD_PREFER_FASTEST = 1,
      CUDNN_CONVOLUTION_FWD_SPECIFY_WORKSPACE_LIMIT = 2
    cudnnConvolutionFwdAlgo_t* {.size: sizeof(cint).} = enum
      CUDNN_CONVOLUTION_FWD_ALGO_IMPLICIT_GEMM = 0,
      CUDNN_CONVOLUTION_FWD_ALGO_IMPLICIT_PRECOMP_GEMM = 1,
      CUDNN_CONVOLUTION_FWD_ALGO_GEMM = 2, CUDNN_CONVOLUTION_FWD_ALGO_DIRECT = 3,
      CUDNN_CONVOLUTION_FWD_ALGO_FFT = 4,
      CUDNN_CONVOLUTION_FWD_ALGO_FFT_TILING = 5,
      CUDNN_CONVOLUTION_FWD_ALGO_WINOGRAD = 6,
      CUDNN_CONVOLUTION_FWD_ALGO_WINOGRAD_NONFUSED = 7
    cudnnConvolutionFwdAlgoPerf_t* = object
      algo*: cudnnConvolutionFwdAlgo_t
      status*: cudnnStatus_t
      time*: cfloat
      memory*: csize

  proc cudnnFindConvolutionForwardAlgorithm*(handle: cudnnHandle_t;
      xDesc: cudnnTensorDescriptor_t; wDesc: cudnnFilterDescriptor_t;
      convDesc: cudnnConvolutionDescriptor_t; yDesc: cudnnTensorDescriptor_t;
      requestedAlgoCount: cint; returnedAlgoCount: ptr cint;
      perfResults: ptr cudnnConvolutionFwdAlgoPerf_t): cudnnStatus_t {.cdecl,
      importc: "cudnnFindConvolutionForwardAlgorithm", dyn.}
  proc cudnnFindConvolutionForwardAlgorithmEx*(handle: cudnnHandle_t;
      xDesc: cudnnTensorDescriptor_t; x: pointer; wDesc: cudnnFilterDescriptor_t;
      w: pointer; convDesc: cudnnConvolutionDescriptor_t;
      yDesc: cudnnTensorDescriptor_t; y: pointer; requestedAlgoCount: cint;
      returnedAlgoCount: ptr cint; perfResults: ptr cudnnConvolutionFwdAlgoPerf_t;
      workSpace: pointer; workSpaceSizeInBytes: csize): cudnnStatus_t {.cdecl,
      importc: "cudnnFindConvolutionForwardAlgorithmEx", dyn.}
  proc cudnnGetConvolutionForwardAlgorithm*(handle: cudnnHandle_t;
      xDesc: cudnnTensorDescriptor_t; wDesc: cudnnFilterDescriptor_t;
      convDesc: cudnnConvolutionDescriptor_t; yDesc: cudnnTensorDescriptor_t;
      preference: cudnnConvolutionFwdPreference_t; memoryLimitInBytes: csize;
      algo: ptr cudnnConvolutionFwdAlgo_t): cudnnStatus_t {.cdecl,
      importc: "cudnnGetConvolutionForwardAlgorithm", dyn.}
  ## 
  ##   convolution algorithm (which requires potentially some workspace)
  ## 
  ##  Helper function to return the minimum size of the workspace to be passed to the convolution given an algo
  proc cudnnGetConvolutionForwardWorkspaceSize*(handle: cudnnHandle_t;
      xDesc: cudnnTensorDescriptor_t; wDesc: cudnnFilterDescriptor_t;
      convDesc: cudnnConvolutionDescriptor_t; yDesc: cudnnTensorDescriptor_t;
      algo: cudnnConvolutionFwdAlgo_t; sizeInBytes: ptr csize): cudnnStatus_t {.cdecl,
      importc: "cudnnGetConvolutionForwardWorkspaceSize", dyn.}
  ##  Convolution functions: All of the form "output = alpha * Op(inputs) + beta * output"
  ##  Function to perform the forward pass for batch convolution
  proc cudnnConvolutionForward*(handle: cudnnHandle_t; alpha: pointer;
                               xDesc: cudnnTensorDescriptor_t; x: pointer;
                               wDesc: cudnnFilterDescriptor_t; w: pointer;
                               convDesc: cudnnConvolutionDescriptor_t;
                               algo: cudnnConvolutionFwdAlgo_t;
                               workSpace: pointer; workSpaceSizeInBytes: csize;
                               beta: pointer; yDesc: cudnnTensorDescriptor_t;
                               y: pointer): cudnnStatus_t {.cdecl,
      importc: "cudnnConvolutionForward", dyn.}
  ##  Function to compute the bias gradient for batch convolution
  proc cudnnConvolutionBackwardBias*(handle: cudnnHandle_t; alpha: pointer;
                                    dyDesc: cudnnTensorDescriptor_t; dy: pointer;
                                    beta: pointer;
                                    dbDesc: cudnnTensorDescriptor_t; db: pointer): cudnnStatus_t {.
      cdecl, importc: "cudnnConvolutionBackwardBias", dyn.}
  ##  helper function to provide the convolution algo that fit best the requirement
  type
    cudnnConvolutionBwdFilterPreference_t* {.size: sizeof(cint).} = enum
      CUDNN_CONVOLUTION_BWD_FILTER_NO_WORKSPACE = 0,
      CUDNN_CONVOLUTION_BWD_FILTER_PREFER_FASTEST = 1,
      CUDNN_CONVOLUTION_BWD_FILTER_SPECIFY_WORKSPACE_LIMIT = 2
    cudnnConvolutionBwdFilterAlgo_t* {.size: sizeof(cint).} = enum
      CUDNN_CONVOLUTION_BWD_FILTER_ALGO_0 = 0, ##  non-deterministic
      CUDNN_CONVOLUTION_BWD_FILTER_ALGO_1 = 1,
      CUDNN_CONVOLUTION_BWD_FILTER_ALGO_FFT = 2, CUDNN_CONVOLUTION_BWD_FILTER_ALGO_3 = 3, ##  non-deterministic, algo0 with workspace
                                                                                    ##  CUDNN_CONVOLUTION_BWD_FILTER_ALGO_WINOGRAD  = 4, // not implemented
      CUDNN_CONVOLUTION_BWD_FILTER_ALGO_WINOGRAD_NONFUSED = 5
    cudnnConvolutionBwdFilterAlgoPerf_t* = object
      algo*: cudnnConvolutionBwdFilterAlgo_t
      status*: cudnnStatus_t
      time*: cfloat
      memory*: csize

  proc cudnnFindConvolutionBackwardFilterAlgorithm*(handle: cudnnHandle_t;
      xDesc: cudnnTensorDescriptor_t; dyDesc: cudnnTensorDescriptor_t;
      convDesc: cudnnConvolutionDescriptor_t; dwDesc: cudnnFilterDescriptor_t;
      requestedAlgoCount: cint; returnedAlgoCount: ptr cint;
      perfResults: ptr cudnnConvolutionBwdFilterAlgoPerf_t): cudnnStatus_t {.cdecl,
      importc: "cudnnFindConvolutionBackwardFilterAlgorithm", dyn.}
  proc cudnnFindConvolutionBackwardFilterAlgorithmEx*(handle: cudnnHandle_t;
      xDesc: cudnnTensorDescriptor_t; x: pointer; dyDesc: cudnnTensorDescriptor_t;
      y: pointer; convDesc: cudnnConvolutionDescriptor_t;
      dwDesc: cudnnFilterDescriptor_t; dw: pointer; requestedAlgoCount: cint;
      returnedAlgoCount: ptr cint;
      perfResults: ptr cudnnConvolutionBwdFilterAlgoPerf_t; workSpace: pointer;
      workSpaceSizeInBytes: csize): cudnnStatus_t {.cdecl,
      importc: "cudnnFindConvolutionBackwardFilterAlgorithmEx", dyn.}
  proc cudnnGetConvolutionBackwardFilterAlgorithm*(handle: cudnnHandle_t;
      xDesc: cudnnTensorDescriptor_t; dyDesc: cudnnTensorDescriptor_t;
      convDesc: cudnnConvolutionDescriptor_t; dwDesc: cudnnFilterDescriptor_t;
      preference: cudnnConvolutionBwdFilterPreference_t;
      memoryLimitInBytes: csize; algo: ptr cudnnConvolutionBwdFilterAlgo_t): cudnnStatus_t {.
      cdecl, importc: "cudnnGetConvolutionBackwardFilterAlgorithm", dyn.}
  ## 
  ##   convolution algorithm (which requires potentially some workspace)
  ## 
  ##  Helper function to return the minimum size of the workspace to be passed to the convolution given an algo
  proc cudnnGetConvolutionBackwardFilterWorkspaceSize*(handle: cudnnHandle_t;
      xDesc: cudnnTensorDescriptor_t; dyDesc: cudnnTensorDescriptor_t;
      convDesc: cudnnConvolutionDescriptor_t; gradDesc: cudnnFilterDescriptor_t;
      algo: cudnnConvolutionBwdFilterAlgo_t; sizeInBytes: ptr csize): cudnnStatus_t {.
      cdecl, importc: "cudnnGetConvolutionBackwardFilterWorkspaceSize",
      dyn.}
  proc cudnnConvolutionBackwardFilter*(handle: cudnnHandle_t; alpha: pointer;
                                      xDesc: cudnnTensorDescriptor_t; x: pointer;
                                      dyDesc: cudnnTensorDescriptor_t;
                                      dy: pointer;
                                      convDesc: cudnnConvolutionDescriptor_t;
                                      algo: cudnnConvolutionBwdFilterAlgo_t;
                                      workSpace: pointer;
                                      workSpaceSizeInBytes: csize; beta: pointer;
                                      dwDesc: cudnnFilterDescriptor_t; dw: pointer): cudnnStatus_t {.
      cdecl, importc: "cudnnConvolutionBackwardFilter", dyn.}
  ## *******************************************************
  ##  helper function to provide the convolution algo that fit best the requirement
  type
    cudnnConvolutionBwdDataPreference_t* {.size: sizeof(cint).} = enum
      CUDNN_CONVOLUTION_BWD_DATA_NO_WORKSPACE = 0,
      CUDNN_CONVOLUTION_BWD_DATA_PREFER_FASTEST = 1,
      CUDNN_CONVOLUTION_BWD_DATA_SPECIFY_WORKSPACE_LIMIT = 2
    cudnnConvolutionBwdDataAlgo_t* {.size: sizeof(cint).} = enum
      CUDNN_CONVOLUTION_BWD_DATA_ALGO_0 = 0, ##  non-deterministic
      CUDNN_CONVOLUTION_BWD_DATA_ALGO_1 = 1,
      CUDNN_CONVOLUTION_BWD_DATA_ALGO_FFT = 2,
      CUDNN_CONVOLUTION_BWD_DATA_ALGO_FFT_TILING = 3,
      CUDNN_CONVOLUTION_BWD_DATA_ALGO_WINOGRAD = 4,
      CUDNN_CONVOLUTION_BWD_DATA_ALGO_WINOGRAD_NONFUSED = 5
    cudnnConvolutionBwdDataAlgoPerf_t* = object
      algo*: cudnnConvolutionBwdDataAlgo_t
      status*: cudnnStatus_t
      time*: cfloat
      memory*: csize

  proc cudnnFindConvolutionBackwardDataAlgorithm*(handle: cudnnHandle_t;
      wDesc: cudnnFilterDescriptor_t; dyDesc: cudnnTensorDescriptor_t;
      convDesc: cudnnConvolutionDescriptor_t; dxDesc: cudnnTensorDescriptor_t;
      requestedAlgoCount: cint; returnedAlgoCount: ptr cint;
      perfResults: ptr cudnnConvolutionBwdDataAlgoPerf_t): cudnnStatus_t {.cdecl,
      importc: "cudnnFindConvolutionBackwardDataAlgorithm", dyn.}
  proc cudnnFindConvolutionBackwardDataAlgorithmEx*(handle: cudnnHandle_t;
      wDesc: cudnnFilterDescriptor_t; w: pointer; dyDesc: cudnnTensorDescriptor_t;
      dy: pointer; convDesc: cudnnConvolutionDescriptor_t;
      dxDesc: cudnnTensorDescriptor_t; dx: pointer; requestedAlgoCount: cint;
      returnedAlgoCount: ptr cint;
      perfResults: ptr cudnnConvolutionBwdDataAlgoPerf_t; workSpace: pointer;
      workSpaceSizeInBytes: csize): cudnnStatus_t {.cdecl,
      importc: "cudnnFindConvolutionBackwardDataAlgorithmEx", dyn.}
  proc cudnnGetConvolutionBackwardDataAlgorithm*(handle: cudnnHandle_t;
      wDesc: cudnnFilterDescriptor_t; dyDesc: cudnnTensorDescriptor_t;
      convDesc: cudnnConvolutionDescriptor_t; dxDesc: cudnnTensorDescriptor_t;
      preference: cudnnConvolutionBwdDataPreference_t; memoryLimitInBytes: csize;
      algo: ptr cudnnConvolutionBwdDataAlgo_t): cudnnStatus_t {.cdecl,
      importc: "cudnnGetConvolutionBackwardDataAlgorithm", dyn.}
  ##  Helper function to return the minimum size of the workspace to be passed to the convolution given an algo
  proc cudnnGetConvolutionBackwardDataWorkspaceSize*(handle: cudnnHandle_t;
      wDesc: cudnnFilterDescriptor_t; dyDesc: cudnnTensorDescriptor_t;
      convDesc: cudnnConvolutionDescriptor_t; dxDesc: cudnnTensorDescriptor_t;
      algo: cudnnConvolutionBwdDataAlgo_t; sizeInBytes: ptr csize): cudnnStatus_t {.
      cdecl, importc: "cudnnGetConvolutionBackwardDataWorkspaceSize",
      dyn.}
  proc cudnnConvolutionBackwardData*(handle: cudnnHandle_t; alpha: pointer;
                                    wDesc: cudnnFilterDescriptor_t; w: pointer;
                                    dyDesc: cudnnTensorDescriptor_t; dy: pointer;
                                    convDesc: cudnnConvolutionDescriptor_t;
                                    algo: cudnnConvolutionBwdDataAlgo_t;
                                    workSpace: pointer;
                                    workSpaceSizeInBytes: csize; beta: pointer;
                                    dxDesc: cudnnTensorDescriptor_t; dx: pointer): cudnnStatus_t {.
      cdecl, importc: "cudnnConvolutionBackwardData", dyn.}
  proc cudnnIm2Col*(handle: cudnnHandle_t; xDesc: cudnnTensorDescriptor_t;
                   x: pointer; wDesc: cudnnFilterDescriptor_t;
                   convDesc: cudnnConvolutionDescriptor_t; colBuffer: pointer): cudnnStatus_t {.
      cdecl, importc: "cudnnIm2Col", dyn.}
  ## 
  ##   softmax algorithm
  ## 
  type
    cudnnSoftmaxAlgorithm_t* {.size: sizeof(cint).} = enum
      CUDNN_SOFTMAX_FAST = 0,   ##  straightforward implementation
      CUDNN_SOFTMAX_ACCURATE = 1, ##  subtract max from every point to avoid overflow
      CUDNN_SOFTMAX_LOG = 2
    cudnnSoftmaxMode_t* {.size: sizeof(cint).} = enum
      CUDNN_SOFTMAX_MODE_INSTANCE = 0, ##  compute the softmax over all C, H, W for each N
      CUDNN_SOFTMAX_MODE_CHANNEL = 1
  ##  Softmax functions: All of the form "output = alpha * Op(inputs) + beta * output"
  ##  Function to perform forward softmax
  proc cudnnSoftmaxForward*(handle: cudnnHandle_t; algo: cudnnSoftmaxAlgorithm_t;
                           mode: cudnnSoftmaxMode_t; alpha: pointer;
                           xDesc: cudnnTensorDescriptor_t; x: pointer;
                           beta: pointer; yDesc: cudnnTensorDescriptor_t; y: pointer): cudnnStatus_t {.
      cdecl, importc: "cudnnSoftmaxForward", dyn.}
  ##  Function to perform backward softmax
  proc cudnnSoftmaxBackward*(handle: cudnnHandle_t; algo: cudnnSoftmaxAlgorithm_t;
                            mode: cudnnSoftmaxMode_t; alpha: pointer;
                            yDesc: cudnnTensorDescriptor_t; y: pointer;
                            dyDesc: cudnnTensorDescriptor_t; dy: pointer;
                            beta: pointer; dxDesc: cudnnTensorDescriptor_t;
                            dx: pointer): cudnnStatus_t {.cdecl,
      importc: "cudnnSoftmaxBackward", dyn.}
  ## 
  ##   pooling mode
  ## 
  type
    cudnnPoolingMode_t* {.size: sizeof(cint).} = enum
      CUDNN_POOLING_MAX = 0, CUDNN_POOLING_AVERAGE_COUNT_INCLUDE_PADDING = 1, ##  count for average includes padded values
      CUDNN_POOLING_AVERAGE_COUNT_EXCLUDE_PADDING = 2
  ##  Create an instance of pooling descriptor
  proc cudnnCreatePoolingDescriptor*(poolingDesc: ptr cudnnPoolingDescriptor_t): cudnnStatus_t {.
      cdecl, importc: "cudnnCreatePoolingDescriptor", dyn.}
  proc cudnnSetPooling2dDescriptor*(poolingDesc: cudnnPoolingDescriptor_t;
                                   mode: cudnnPoolingMode_t;
                                   maxpoolingNanOpt: cudnnNanPropagation_t;
                                   windowHeight: cint; windowWidth: cint;
                                   verticalPadding: cint; horizontalPadding: cint;
                                   verticalStride: cint; horizontalStride: cint): cudnnStatus_t {.
      cdecl, importc: "cudnnSetPooling2dDescriptor", dyn.}
  proc cudnnGetPooling2dDescriptor*(poolingDesc: cudnnPoolingDescriptor_t;
                                   mode: ptr cudnnPoolingMode_t;
                                   maxpoolingNanOpt: ptr cudnnNanPropagation_t;
                                   windowHeight: ptr cint; windowWidth: ptr cint;
                                   verticalPadding: ptr cint;
                                   horizontalPadding: ptr cint;
                                   verticalStride: ptr cint;
                                   horizontalStride: ptr cint): cudnnStatus_t {.
      cdecl, importc: "cudnnGetPooling2dDescriptor", dyn.}
  proc cudnnSetPoolingNdDescriptor*(poolingDesc: cudnnPoolingDescriptor_t;
                                   mode: cudnnPoolingMode_t;
                                   maxpoolingNanOpt: cudnnNanPropagation_t;
                                   nbDims: cint; windowDimA: ptr cint;
                                   paddingA: ptr cint; strideA: ptr cint): cudnnStatus_t {.
      cdecl, importc: "cudnnSetPoolingNdDescriptor", dyn.}
  proc cudnnGetPoolingNdDescriptor*(poolingDesc: cudnnPoolingDescriptor_t;
                                   nbDimsRequested: cint;
                                   mode: ptr cudnnPoolingMode_t;
                                   maxpoolingNanOpt: ptr cudnnNanPropagation_t;
                                   nbDims: ptr cint; windowDimA: ptr cint;
                                   paddingA: ptr cint; strideA: ptr cint): cudnnStatus_t {.
      cdecl, importc: "cudnnGetPoolingNdDescriptor", dyn.}
  proc cudnnGetPoolingNdForwardOutputDim*(poolingDesc: cudnnPoolingDescriptor_t;
      inputTensorDesc: cudnnTensorDescriptor_t; nbDims: cint;
      outputTensorDimA: ptr cint): cudnnStatus_t {.cdecl,
      importc: "cudnnGetPoolingNdForwardOutputDim", dyn.}
  proc cudnnGetPooling2dForwardOutputDim*(poolingDesc: cudnnPoolingDescriptor_t;
      inputTensorDesc: cudnnTensorDescriptor_t; n: ptr cint; c: ptr cint; h: ptr cint;
      w: ptr cint): cudnnStatus_t {.cdecl,
                                importc: "cudnnGetPooling2dForwardOutputDim",
                                dyn.}
  ##  Destroy an instance of pooling descriptor
  proc cudnnDestroyPoolingDescriptor*(poolingDesc: cudnnPoolingDescriptor_t): cudnnStatus_t {.
      cdecl, importc: "cudnnDestroyPoolingDescriptor", dyn.}
  ##  Pooling functions: All of the form "output = alpha * Op(inputs) + beta * output"
  ##  Function to perform forward pooling
  proc cudnnPoolingForward*(handle: cudnnHandle_t;
                           poolingDesc: cudnnPoolingDescriptor_t; alpha: pointer;
                           xDesc: cudnnTensorDescriptor_t; x: pointer;
                           beta: pointer; yDesc: cudnnTensorDescriptor_t; y: pointer): cudnnStatus_t {.
      cdecl, importc: "cudnnPoolingForward", dyn.}
  ##  Function to perform backward pooling
  proc cudnnPoolingBackward*(handle: cudnnHandle_t;
                            poolingDesc: cudnnPoolingDescriptor_t; alpha: pointer;
                            yDesc: cudnnTensorDescriptor_t; y: pointer;
                            dyDesc: cudnnTensorDescriptor_t; dy: pointer;
                            xDesc: cudnnTensorDescriptor_t; x: pointer;
                            beta: pointer; dxDesc: cudnnTensorDescriptor_t;
                            dx: pointer): cudnnStatus_t {.cdecl,
      importc: "cudnnPoolingBackward", dyn.}
  ## 
  ##  activation mode
  ## 
  type
    cudnnActivationMode_t* {.size: sizeof(cint).} = enum
      CUDNN_ACTIVATION_SIGMOID = 0, CUDNN_ACTIVATION_RELU = 1,
      CUDNN_ACTIVATION_TANH = 2, CUDNN_ACTIVATION_CLIPPED_RELU = 3
  ##  Activation functions: All of the form "output = alpha * Op(inputs) + beta * output"
  proc cudnnCreateActivationDescriptor*(activationDesc: ptr cudnnActivationDescriptor_t): cudnnStatus_t {.
      cdecl, importc: "cudnnCreateActivationDescriptor", dyn.}
  proc cudnnSetActivationDescriptor*(activationDesc: cudnnActivationDescriptor_t;
                                    mode: cudnnActivationMode_t;
                                    reluNanOpt: cudnnNanPropagation_t;
                                    reluCeiling: cdouble): cudnnStatus_t {.cdecl,
      importc: "cudnnSetActivationDescriptor", dyn.}
  proc cudnnGetActivationDescriptor*(activationDesc: cudnnActivationDescriptor_t;
                                    mode: ptr cudnnActivationMode_t;
                                    reluNanOpt: ptr cudnnNanPropagation_t;
                                    reluCeiling: ptr cdouble): cudnnStatus_t {.
      cdecl, importc: "cudnnGetActivationDescriptor", dyn.}
  proc cudnnDestroyActivationDescriptor*(activationDesc: cudnnActivationDescriptor_t): cudnnStatus_t {.
      cdecl, importc: "cudnnDestroyActivationDescriptor", dyn.}
  ##  Function to perform forward activation
  proc cudnnActivationForward*(handle: cudnnHandle_t;
                              activationDesc: cudnnActivationDescriptor_t;
                              alpha: pointer; xDesc: cudnnTensorDescriptor_t;
                              x: pointer; beta: pointer;
                              yDesc: cudnnTensorDescriptor_t; y: pointer): cudnnStatus_t {.
      cdecl, importc: "cudnnActivationForward", dyn.}
  ##  Function to perform backward activation
  proc cudnnActivationBackward*(handle: cudnnHandle_t;
                               activationDesc: cudnnActivationDescriptor_t;
                               alpha: pointer; yDesc: cudnnTensorDescriptor_t;
                               y: pointer; dyDesc: cudnnTensorDescriptor_t;
                               dy: pointer; xDesc: cudnnTensorDescriptor_t;
                               x: pointer; beta: pointer;
                               dxDesc: cudnnTensorDescriptor_t; dx: pointer): cudnnStatus_t {.
      cdecl, importc: "cudnnActivationBackward", dyn.}
  ##  
  ##  Create an instance of LRN (Local Response Normalization) descriptor
  ##  Uses lrnN=5, lrnAlpha=1e-4, lrnBeta=0.75, lrnK=2.0 as defaults from Krizhevsky'12 ImageNet paper
  ## 
  proc cudnnCreateLRNDescriptor*(normDesc: ptr cudnnLRNDescriptor_t): cudnnStatus_t {.
      cdecl, importc: "cudnnCreateLRNDescriptor", dyn.}
  const
    CUDNN_LRN_MIN_N* = 1
    CUDNN_LRN_MAX_N* = 16
    CUDNN_LRN_MIN_K* = 1e-05
    CUDNN_LRN_MIN_BETA* = 0.01
  ##  LRN layer mode
  type
    cudnnLRNMode_t* {.size: sizeof(cint).} = enum
      CUDNN_LRN_CROSS_CHANNEL_DIM1 = 0 ##  Normalize across tensor's dimA[1] dimension
  ## 
  ##  Uses a window [center-lookBehind, center+lookAhead], where
  ##  lookBehind = floor( (lrnN-1)/2 ), lookAhead = lrnN-lookBehind-1.
  ##  Values of double parameters cast to tensor data type.
  ## 
  proc cudnnSetLRNDescriptor*(normDesc: cudnnLRNDescriptor_t; lrnN: cuint;
                             lrnAlpha: cdouble; lrnBeta: cdouble; lrnK: cdouble): cudnnStatus_t {.
      cdecl, importc: "cudnnSetLRNDescriptor", dyn.}
  ## 
  ##  Retrieve the settings currently stored in an LRN layer descriptor
  ##  Any of the provided pointers can be NULL (no corresponding value will be returned)
  ## 
  proc cudnnGetLRNDescriptor*(normDesc: cudnnLRNDescriptor_t; lrnN: ptr cuint;
                             lrnAlpha: ptr cdouble; lrnBeta: ptr cdouble;
                             lrnK: ptr cdouble): cudnnStatus_t {.cdecl,
      importc: "cudnnGetLRNDescriptor", dyn.}
  ##  Destroy an instance of LRN descriptor
  proc cudnnDestroyLRNDescriptor*(lrnDesc: cudnnLRNDescriptor_t): cudnnStatus_t {.
      cdecl, importc: "cudnnDestroyLRNDescriptor", dyn.}
  ##  LRN functions: output = alpha * normalize(x) + beta * old_y
  ##  LRN cross-channel forward computation. Double parameters cast to tensor data type
  proc cudnnLRNCrossChannelForward*(handle: cudnnHandle_t;
                                   normDesc: cudnnLRNDescriptor_t;
                                   lrnMode: cudnnLRNMode_t; alpha: pointer;
                                   xDesc: cudnnTensorDescriptor_t; x: pointer;
                                   beta: pointer; yDesc: cudnnTensorDescriptor_t;
                                   y: pointer): cudnnStatus_t {.cdecl,
      importc: "cudnnLRNCrossChannelForward", dyn.}
  ##  LRN cross-channel backward computation. Double parameters cast to tensor data type
  proc cudnnLRNCrossChannelBackward*(handle: cudnnHandle_t;
                                    normDesc: cudnnLRNDescriptor_t;
                                    lrnMode: cudnnLRNMode_t; alpha: pointer;
                                    yDesc: cudnnTensorDescriptor_t; y: pointer;
                                    dyDesc: cudnnTensorDescriptor_t; dy: pointer;
                                    xDesc: cudnnTensorDescriptor_t; x: pointer;
                                    beta: pointer;
                                    dxDesc: cudnnTensorDescriptor_t; dx: pointer): cudnnStatus_t {.
      cdecl, importc: "cudnnLRNCrossChannelBackward", dyn.}
  type
    cudnnDivNormMode_t* {.size: sizeof(cint).} = enum
      CUDNN_DIVNORM_PRECOMPUTED_MEANS = 0
  ##  LCN/divisive normalization functions: y = alpha * normalize(x) + beta * y
  proc cudnnDivisiveNormalizationForward*(handle: cudnnHandle_t;
      normDesc: cudnnLRNDescriptor_t; mode: cudnnDivNormMode_t; alpha: pointer;
      xDesc: cudnnTensorDescriptor_t; x: pointer; means: pointer; temp: pointer;
      temp2: pointer; beta: pointer; yDesc: cudnnTensorDescriptor_t; y: pointer): cudnnStatus_t {.
      cdecl, importc: "cudnnDivisiveNormalizationForward", dyn.}
    ##  same desc for means, temp, temp2
    ##  if NULL, means are assumed to be zero
  proc cudnnDivisiveNormalizationBackward*(handle: cudnnHandle_t;
      normDesc: cudnnLRNDescriptor_t; mode: cudnnDivNormMode_t; alpha: pointer;
      xDesc: cudnnTensorDescriptor_t; x: pointer; means: pointer; dy: pointer;
      temp: pointer; temp2: pointer; beta: pointer;
      dXdMeansDesc: cudnnTensorDescriptor_t; dx: pointer; dMeans: pointer): cudnnStatus_t {.
      cdecl, importc: "cudnnDivisiveNormalizationBackward", dyn.}
    ##  same desc for x, means, dy, temp, temp2
    ##  if NULL, means are assumed to be zero
    ##  same desc for dx, dMeans
    ##  output x differential
  ##  output means differential, can be NULL
  type                        ##  bnScale, bnBias tensor dims are 1xCxHxWx.. (one value per CHW...-slice, normalized over N slice)
    cudnnBatchNormMode_t* {.size: sizeof(cint).} = enum
      CUDNN_BATCHNORM_PER_ACTIVATION = 0, ## bnScale, bnBias tensor dims are 1xCx1x1 (one value per C-dim normalized over Nx1xHxW subtensors)
      CUDNN_BATCHNORM_SPATIAL = 1
  const
    CUDNN_BN_MIN_EPSILON* = 1e-05
  ## 
  ##  Derives a tensor descriptor from layer data descriptor for BatchNormalization 
  ##  scale, invVariance, bnBias, bnScale tensors. Use this tensor desc for 
  ##  bnScaleBiasMeanVarDesc and bnScaleBiasDiffDesc in Batch Normalization forward and backward functions.
  ## 
  proc cudnnDeriveBNTensorDescriptor*(derivedBnDesc: cudnnTensorDescriptor_t;
                                     xDesc: cudnnTensorDescriptor_t;
                                     mode: cudnnBatchNormMode_t): cudnnStatus_t {.
      cdecl, importc: "cudnnDeriveBNTensorDescriptor", dyn.}
  ##  Computes y = BN(x). Also accumulates moving averages of mean and inverse variances
  proc cudnnBatchNormalizationForwardTraining*(handle: cudnnHandle_t;
      mode: cudnnBatchNormMode_t; alpha: pointer; beta: pointer;
      xDesc: cudnnTensorDescriptor_t; x: pointer; yDesc: cudnnTensorDescriptor_t;
      y: pointer; bnScaleBiasMeanVarDesc: cudnnTensorDescriptor_t; bnScale: pointer;
      bnBias: pointer; exponentialAverageFactor: cdouble;
      resultRunningMean: pointer; resultRunningVariance: pointer; epsilon: cdouble;
      resultSaveMean: pointer; resultSaveInvVariance: pointer): cudnnStatus_t {.
      cdecl, importc: "cudnnBatchNormalizationForwardTraining", dyn.}
    ##  alpha[0] = result blend factor
    ##  beta[0] = dest layer blend factor
    ##  NxCxHxW
    ##  NxCxHxW
    ##  Shared desc for the next 6 tensors in the argument list.
    ##                                    Data type to be set as follows:
    ##                                    type = (typeOf(x) == double) ? double : float
    ##                                    Dimensions for this descriptor depend on normalization mode
    ##                                    - Spatial Normalization : tensors are expected to have dims 1xCx1x1
    ##                                     (normalization is performed across NxHxW)
    ##                                    - Per-Activation Normalization : tensors are expected to have dims of 1xCxHxW 
    ##                                     (normalization is performed across N)
    ##  'Gamma' and 'Beta' respectively in Ioffe and Szegedy's paper's notation
    ##  MUST use factor=1 in the very first call of a complete training cycle.
    ##                                    Use a factor=1/(1+n) at N-th call to the function to get
    ##                                    Cumulative Moving Average (CMA) behavior
    ##                                    CMA[n] = (x[1]+...+x[n])/n
    ##                                    Since CMA[n+1] = (n*CMA[n]+x[n+1])/(n+1) =
    ##                                    ((n+1)*CMA[n]-CMA[n])/(n+1) + x[n+1]/(n+1) =
    ##                                    CMA[n]*(1-1/(n+1)) + x[n+1]*1/(n+1)
    ##  Used in Training phase only. 
    ##                                    runningMean = newMean*factor + runningMean*(1-factor)
    ##  Output in training mode, input in inference. Is the moving average
    ##                                    of  variance[x] (factor is applied in the same way as for runningMean)
    ##  Has to be >= CUDNN_BN_MIN_EPSILON. Should be the same in forward and backward functions.
    ##  Optionally save intermediate results from the forward pass here
    ##                                    - can be reused to speed up backward pass. NULL if unused
  ## 
  ##  Performs Batch Normalization during Inference: 
  ##  y[i] = bnScale[k]*(x[i]-estimatedMean[k])/sqrt(epsilon+estimatedVariance[k]) + bnBias[k]
  ##  with bnScale, bnBias, runningMean, runningInvVariance tensors indexed
  ##  according to spatial or per-activation mode. Refer to cudnnBatchNormalizationForwardTraining
  ##  above for notes on function arguments.
  ## 
  proc cudnnBatchNormalizationForwardInference*(handle: cudnnHandle_t;
      mode: cudnnBatchNormMode_t; alpha: pointer; beta: pointer;
      xDesc: cudnnTensorDescriptor_t; x: pointer; yDesc: cudnnTensorDescriptor_t;
      y: pointer; bnScaleBiasMeanVarDesc: cudnnTensorDescriptor_t; bnScale: pointer;
      bnBias: pointer; estimatedMean: pointer; estimatedVariance: pointer;
      epsilon: cdouble): cudnnStatus_t {.cdecl, importc: "cudnnBatchNormalizationForwardInference",
                                      dyn.}
    ##  alpha[0] = result blend factor
    ##  beta[0] = dest layer blend factor
    ##  NxCxHxW
    ##  NxCxHxW
  ##  Performs backward pass of Batch Normalization layer. Returns x gradient,
  ##  bnScale gradient and bnBias gradient
  proc cudnnBatchNormalizationBackward*(handle: cudnnHandle_t;
                                       mode: cudnnBatchNormMode_t;
                                       alphaDataDiff: pointer;
                                       betaDataDiff: pointer;
                                       alphaParamDiff: pointer;
                                       betaParamDiff: pointer;
                                       xDesc: cudnnTensorDescriptor_t; x: pointer;
                                       dyDesc: cudnnTensorDescriptor_t;
                                       dy: pointer;
                                       dxDesc: cudnnTensorDescriptor_t;
                                       dx: pointer; dBnScaleBiasDesc: cudnnTensorDescriptor_t;
                                       bnScale: pointer; dBnScaleResult: pointer;
                                       dBnBiasResult: pointer; epsilon: cdouble;
                                       savedMean: pointer;
                                       savedInvVariance: pointer): cudnnStatus_t {.
      cdecl, importc: "cudnnBatchNormalizationBackward", dyn.}
    ##  same desc for x, dx, dy
    ##  Shared tensor desc for the 4 tensors below
    ##  bnBias doesn't affect backpropagation
    ##  scale and bias diff are not backpropagated below this layer
    ##  Same epsilon as forward pass
    ##  Optionally cached intermediate results from
    ##                                    forward pass
  ##  APIs for spatial transformer network
  type
    cudnnSamplerType_t* {.size: sizeof(cint).} = enum
      CUDNN_SAMPLER_BILINEAR = 0
  proc cudnnCreateSpatialTransformerDescriptor*(
      stDesc: ptr cudnnSpatialTransformerDescriptor_t): cudnnStatus_t {.cdecl,
      importc: "cudnnCreateSpatialTransformerDescriptor", dyn.}
  proc cudnnSetSpatialTransformerNdDescriptor*(
      stDesc: cudnnSpatialTransformerDescriptor_t;
      samplerType: cudnnSamplerType_t; dataType: cudnnDataType_t; nbDims: cint;
      dimA: ptr cint): cudnnStatus_t {.cdecl, importc: "cudnnSetSpatialTransformerNdDescriptor",
                                   dyn.}
  proc cudnnDestroySpatialTransformerDescriptor*(
      stDesc: cudnnSpatialTransformerDescriptor_t): cudnnStatus_t {.cdecl,
      importc: "cudnnDestroySpatialTransformerDescriptor", dyn.}
  proc cudnnSpatialTfGridGeneratorForward*(handle: cudnnHandle_t;
      stDesc: cudnnSpatialTransformerDescriptor_t; theta: pointer; grid: pointer): cudnnStatus_t {.
      cdecl, importc: "cudnnSpatialTfGridGeneratorForward", dyn.}
  proc cudnnSpatialTfGridGeneratorBackward*(handle: cudnnHandle_t;
      stDesc: cudnnSpatialTransformerDescriptor_t; dgrid: pointer; dtheta: pointer): cudnnStatus_t {.
      cdecl, importc: "cudnnSpatialTfGridGeneratorBackward", dyn.}
  proc cudnnSpatialTfSamplerForward*(handle: cudnnHandle_t; stDesc: cudnnSpatialTransformerDescriptor_t;
                                    alpha: pointer;
                                    xDesc: cudnnTensorDescriptor_t; x: pointer;
                                    grid: pointer; beta: pointer;
                                    yDesc: cudnnTensorDescriptor_t; y: pointer): cudnnStatus_t {.
      cdecl, importc: "cudnnSpatialTfSamplerForward", dyn.}
  proc cudnnSpatialTfSamplerBackward*(handle: cudnnHandle_t; stDesc: cudnnSpatialTransformerDescriptor_t;
                                     alpha: pointer;
                                     xDesc: cudnnTensorDescriptor_t; x: pointer;
                                     beta: pointer;
                                     dxDesc: cudnnTensorDescriptor_t; dx: pointer;
                                     alphaDgrid: pointer;
                                     dyDesc: cudnnTensorDescriptor_t; dy: pointer;
                                     grid: pointer; betaDgrid: pointer;
                                     dgrid: pointer): cudnnStatus_t {.cdecl,
      importc: "cudnnSpatialTfSamplerBackward", dyn.}
  type
    cudnnDropoutDescriptor_t* = ptr cudnnDropoutStruct
  proc cudnnCreateDropoutDescriptor*(dropoutDesc: ptr cudnnDropoutDescriptor_t): cudnnStatus_t {.
      cdecl, importc: "cudnnCreateDropoutDescriptor", dyn.}
  proc cudnnDestroyDropoutDescriptor*(dropoutDesc: cudnnDropoutDescriptor_t): cudnnStatus_t {.
      cdecl, importc: "cudnnDestroyDropoutDescriptor", dyn.}
  ## helper function to determine size of the states to be passed to cudnnSetDropoutDescriptor
  proc cudnnDropoutGetStatesSize*(handle: cudnnHandle_t; sizeInBytes: ptr csize): cudnnStatus_t {.
      cdecl, importc: "cudnnDropoutGetStatesSize", dyn.}
  ## helper function to determine size of the reserve space to be passed to dropout forward/backward calls
  proc cudnnDropoutGetReserveSpaceSize*(xdesc: cudnnTensorDescriptor_t;
                                       sizeInBytes: ptr csize): cudnnStatus_t {.
      cdecl, importc: "cudnnDropoutGetReserveSpaceSize", dyn.}
  proc cudnnSetDropoutDescriptor*(dropoutDesc: cudnnDropoutDescriptor_t;
                                 handle: cudnnHandle_t; dropout: cfloat;
                                 states: pointer; stateSizeInBytes: csize;
                                 seed: culonglong): cudnnStatus_t {.cdecl,
      importc: "cudnnSetDropoutDescriptor", dyn.}
  proc cudnnDropoutForward*(handle: cudnnHandle_t;
                           dropoutDesc: cudnnDropoutDescriptor_t;
                           xdesc: cudnnTensorDescriptor_t; x: pointer;
                           ydesc: cudnnTensorDescriptor_t; y: pointer;
                           reserveSpace: pointer; reserveSpaceSizeInBytes: csize): cudnnStatus_t {.
      cdecl, importc: "cudnnDropoutForward", dyn.}
  proc cudnnDropoutBackward*(handle: cudnnHandle_t;
                            dropoutDesc: cudnnDropoutDescriptor_t;
                            dydesc: cudnnTensorDescriptor_t; dy: pointer;
                            dxdesc: cudnnTensorDescriptor_t; dx: pointer;
                            reserveSpace: pointer; reserveSpaceSizeInBytes: csize): cudnnStatus_t {.
      cdecl, importc: "cudnnDropoutBackward", dyn.}
  ##  RNN API
  type
    cudnnRNNMode_t* {.size: sizeof(cint).} = enum
      CUDNN_RNN_RELU = 0,       ##  Stock RNN with ReLu activation
      CUDNN_RNN_TANH = 1,       ##  Stock RNN with tanh activation
      CUDNN_LSTM = 2,           ##  LSTM with no peephole connections
      CUDNN_GRU = 3
    cudnnDirectionMode_t* {.size: sizeof(cint).} = enum
      CUDNN_UNIDIRECTIONAL = 0, CUDNN_BIDIRECTIONAL = 1
    cudnnRNNInputMode_t* {.size: sizeof(cint).} = enum
      CUDNN_LINEAR_INPUT = 0, CUDNN_SKIP_INPUT = 1
  type
    cudnnRNNStruct* = object
    
  type
    cudnnRNNDescriptor_t* = ptr cudnnRNNStruct
  proc cudnnCreateRNNDescriptor*(rnnDesc: ptr cudnnRNNDescriptor_t): cudnnStatus_t {.
      cdecl, importc: "cudnnCreateRNNDescriptor", dyn.}
  proc cudnnDestroyRNNDescriptor*(rnnDesc: cudnnRNNDescriptor_t): cudnnStatus_t {.
      cdecl, importc: "cudnnDestroyRNNDescriptor", dyn.}
  proc cudnnSetRNNDescriptor*(rnnDesc: cudnnRNNDescriptor_t; hiddenSize: cint;
                             numLayers: cint;
                             dropoutDesc: cudnnDropoutDescriptor_t;
                             inputMode: cudnnRNNInputMode_t;
                             direction: cudnnDirectionMode_t;
                             mode: cudnnRNNMode_t; dataType: cudnnDataType_t): cudnnStatus_t {.
      cdecl, importc: "cudnnSetRNNDescriptor", dyn.}
    ##  Between layers, not between recurrent steps.
  ##  dataType in the RNN descriptor is used to determine math precision
  ##  dataType in weight descriptors and input descriptors is used to describe storage
  proc cudnnGetRNNWorkspaceSize*(handle: cudnnHandle_t;
                                rnnDesc: cudnnRNNDescriptor_t; seqLength: cint;
                                xDesc: ptr cudnnTensorDescriptor_t;
                                sizeInBytes: ptr csize): cudnnStatus_t {.cdecl,
      importc: "cudnnGetRNNWorkspaceSize", dyn.}
  proc cudnnGetRNNTrainingReserveSize*(handle: cudnnHandle_t;
                                      rnnDesc: cudnnRNNDescriptor_t;
                                      seqLength: cint;
                                      xDesc: ptr cudnnTensorDescriptor_t;
                                      sizeInBytes: ptr csize): cudnnStatus_t {.
      cdecl, importc: "cudnnGetRNNTrainingReserveSize", dyn.}
  proc cudnnGetRNNParamsSize*(handle: cudnnHandle_t; rnnDesc: cudnnRNNDescriptor_t;
                             xDesc: cudnnTensorDescriptor_t;
                             sizeInBytes: ptr csize; dataType: cudnnDataType_t): cudnnStatus_t {.
      cdecl, importc: "cudnnGetRNNParamsSize", dyn.}
  proc cudnnGetRNNLinLayerMatrixParams*(handle: cudnnHandle_t;
                                       rnnDesc: cudnnRNNDescriptor_t; layer: cint;
                                       xDesc: cudnnTensorDescriptor_t;
                                       wDesc: cudnnFilterDescriptor_t; w: pointer;
                                       linLayerID: cint; linLayerMatDesc: cudnnFilterDescriptor_t;
                                       linLayerMat: ptr pointer): cudnnStatus_t {.
      cdecl, importc: "cudnnGetRNNLinLayerMatrixParams", dyn.}
  proc cudnnGetRNNLinLayerBiasParams*(handle: cudnnHandle_t;
                                     rnnDesc: cudnnRNNDescriptor_t; layer: cint;
                                     xDesc: cudnnTensorDescriptor_t;
                                     wDesc: cudnnFilterDescriptor_t; w: pointer;
                                     linLayerID: cint;
                                     linLayerBiasDesc: cudnnFilterDescriptor_t;
                                     linLayerBias: ptr pointer): cudnnStatus_t {.
      cdecl, importc: "cudnnGetRNNLinLayerBiasParams", dyn.}
  proc cudnnRNNForwardInference*(handle: cudnnHandle_t;
                                rnnDesc: cudnnRNNDescriptor_t; seqLength: cint;
                                xDesc: ptr cudnnTensorDescriptor_t; x: pointer;
                                hxDesc: cudnnTensorDescriptor_t; hx: pointer;
                                cxDesc: cudnnTensorDescriptor_t; cx: pointer;
                                wDesc: cudnnFilterDescriptor_t; w: pointer;
                                yDesc: ptr cudnnTensorDescriptor_t; y: pointer;
                                hyDesc: cudnnTensorDescriptor_t; hy: pointer;
                                cyDesc: cudnnTensorDescriptor_t; cy: pointer;
                                workspace: pointer; workSpaceSizeInBytes: csize): cudnnStatus_t {.
      cdecl, importc: "cudnnRNNForwardInference", dyn.}
  proc cudnnRNNForwardTraining*(handle: cudnnHandle_t;
                               rnnDesc: cudnnRNNDescriptor_t; seqLength: cint;
                               xDesc: ptr cudnnTensorDescriptor_t; x: pointer;
                               hxDesc: cudnnTensorDescriptor_t; hx: pointer;
                               cxDesc: cudnnTensorDescriptor_t; cx: pointer;
                               wDesc: cudnnFilterDescriptor_t; w: pointer;
                               yDesc: ptr cudnnTensorDescriptor_t; y: pointer;
                               hyDesc: cudnnTensorDescriptor_t; hy: pointer;
                               cyDesc: cudnnTensorDescriptor_t; cy: pointer;
                               workspace: pointer; workSpaceSizeInBytes: csize;
                               reserveSpace: pointer;
                               reserveSpaceSizeInBytes: csize): cudnnStatus_t {.
      cdecl, importc: "cudnnRNNForwardTraining", dyn.}
  proc cudnnRNNBackwardData*(handle: cudnnHandle_t; rnnDesc: cudnnRNNDescriptor_t;
                            seqLength: cint; yDesc: ptr cudnnTensorDescriptor_t;
                            y: pointer; dyDesc: ptr cudnnTensorDescriptor_t;
                            dy: pointer; dhyDesc: cudnnTensorDescriptor_t;
                            dhy: pointer; dcyDesc: cudnnTensorDescriptor_t;
                            dcy: pointer; wDesc: cudnnFilterDescriptor_t;
                            w: pointer; hxDesc: cudnnTensorDescriptor_t;
                            hx: pointer; cxDesc: cudnnTensorDescriptor_t;
                            cx: pointer; dxDesc: ptr cudnnTensorDescriptor_t;
                            dx: pointer; dhxDesc: cudnnTensorDescriptor_t;
                            dhx: pointer; dcxDesc: cudnnTensorDescriptor_t;
                            dcx: pointer; workspace: pointer;
                            workSpaceSizeInBytes: csize; reserveSpace: pointer;
                            reserveSpaceSizeInBytes: csize): cudnnStatus_t {.cdecl,
      importc: "cudnnRNNBackwardData", dyn.}
  proc cudnnRNNBackwardWeights*(handle: cudnnHandle_t;
                               rnnDesc: cudnnRNNDescriptor_t; seqLength: cint;
                               xDesc: ptr cudnnTensorDescriptor_t; x: pointer;
                               hxDesc: cudnnTensorDescriptor_t; hx: pointer;
                               yDesc: ptr cudnnTensorDescriptor_t; y: pointer;
                               workspace: pointer; workSpaceSizeInBytes: csize;
                               dwDesc: cudnnFilterDescriptor_t; dw: pointer;
                               reserveSpace: pointer;
                               reserveSpaceSizeInBytes: csize): cudnnStatus_t {.
      cdecl, importc: "cudnnRNNBackwardWeights", dyn.}
  ##  DEPRECATED routines to be removed next release : 
  ##    User should use the non-suffixed version (which has the API and functionality of _v4 version)
  ##    Routines with _v3 suffix has the functionality of the non-suffixed routines in the CUDNN V4
  ## 
  proc cudnnSetFilter4dDescriptor_v3*(filterDesc: cudnnFilterDescriptor_t;
                                     dataType: cudnnDataType_t; k: cint; c: cint;
                                     h: cint; w: cint): cudnnStatus_t {.cdecl,
      importc: "cudnnSetFilter4dDescriptor_v3", dyn.}
    ##  image data type
    ##  number of output feature maps
    ##  number of input feature maps
    ##  height of each input filter
  ##  width of  each input filter
  proc cudnnSetFilter4dDescriptor_v4*(filterDesc: cudnnFilterDescriptor_t;
                                     dataType: cudnnDataType_t;
                                     format: cudnnTensorFormat_t; k: cint; c: cint;
                                     h: cint; w: cint): cudnnStatus_t {.cdecl,
      importc: "cudnnSetFilter4dDescriptor_v4", dyn.}
    ##  image data type
    ##  number of output feature maps
    ##  number of input feature maps
    ##  height of each input filter
  ##  width of  each input filter
  proc cudnnGetFilter4dDescriptor_v3*(filterDesc: cudnnFilterDescriptor_t;
                                     dataType: ptr cudnnDataType_t; k: ptr cint;
                                     c: ptr cint; h: ptr cint; w: ptr cint): cudnnStatus_t {.
      cdecl, importc: "cudnnGetFilter4dDescriptor_v3", dyn.}
    ##  image data type
    ##  number of output feature maps
    ##  number of input feature maps
    ##  height of each input filter
  ##  width of  each input filter
  proc cudnnGetFilter4dDescriptor_v4*(filterDesc: cudnnFilterDescriptor_t;
                                     dataType: ptr cudnnDataType_t;
                                     format: ptr cudnnTensorFormat_t; k: ptr cint;
                                     c: ptr cint; h: ptr cint; w: ptr cint): cudnnStatus_t {.
      cdecl, importc: "cudnnGetFilter4dDescriptor_v4", dyn.}
    ##  image data type
    ##  number of output feature maps
    ##  number of input feature maps
    ##  height of each input filter
  ##  width of  each input filter
  proc cudnnSetFilterNdDescriptor_v3*(filterDesc: cudnnFilterDescriptor_t;
                                     dataType: cudnnDataType_t; nbDims: cint;
                                     filterDimA: ptr cint): cudnnStatus_t {.cdecl,
      importc: "cudnnSetFilterNdDescriptor_v3", dyn.}
    ##  image data type
  proc cudnnSetFilterNdDescriptor_v4*(filterDesc: cudnnFilterDescriptor_t;
                                     dataType: cudnnDataType_t;
                                     format: cudnnTensorFormat_t; nbDims: cint;
                                     filterDimA: ptr cint): cudnnStatus_t {.cdecl,
      importc: "cudnnSetFilterNdDescriptor_v4", dyn.}
    ##  image data type
  proc cudnnGetFilterNdDescriptor_v3*(filterDesc: cudnnFilterDescriptor_t;
                                     nbDimsRequested: cint;
                                     dataType: ptr cudnnDataType_t;
                                     nbDims: ptr cint; filterDimA: ptr cint): cudnnStatus_t {.
      cdecl, importc: "cudnnGetFilterNdDescriptor_v3", dyn.}
    ##  image data type
  proc cudnnGetFilterNdDescriptor_v4*(filterDesc: cudnnFilterDescriptor_t;
                                     nbDimsRequested: cint;
                                     dataType: ptr cudnnDataType_t;
                                     format: ptr cudnnTensorFormat_t;
                                     nbDims: ptr cint; filterDimA: ptr cint): cudnnStatus_t {.
      cdecl, importc: "cudnnGetFilterNdDescriptor_v4", dyn.}
    ##  image data type
  proc cudnnSetPooling2dDescriptor_v3*(poolingDesc: cudnnPoolingDescriptor_t;
                                      mode: cudnnPoolingMode_t;
                                      windowHeight: cint; windowWidth: cint;
                                      verticalPadding: cint;
                                      horizontalPadding: cint;
                                      verticalStride: cint; horizontalStride: cint): cudnnStatus_t {.
      cdecl, importc: "cudnnSetPooling2dDescriptor_v3", dyn.}
  proc cudnnSetPooling2dDescriptor_v4*(poolingDesc: cudnnPoolingDescriptor_t;
                                      mode: cudnnPoolingMode_t;
                                      maxpoolingNanOpt: cudnnNanPropagation_t;
                                      windowHeight: cint; windowWidth: cint;
                                      verticalPadding: cint;
                                      horizontalPadding: cint;
                                      verticalStride: cint; horizontalStride: cint): cudnnStatus_t {.
      cdecl, importc: "cudnnSetPooling2dDescriptor_v4", dyn.}
  proc cudnnGetPooling2dDescriptor_v3*(poolingDesc: cudnnPoolingDescriptor_t;
                                      mode: ptr cudnnPoolingMode_t;
                                      windowHeight: ptr cint;
                                      windowWidth: ptr cint;
                                      verticalPadding: ptr cint;
                                      horizontalPadding: ptr cint;
                                      verticalStride: ptr cint;
                                      horizontalStride: ptr cint): cudnnStatus_t {.
      cdecl, importc: "cudnnGetPooling2dDescriptor_v3", dyn.}
  proc cudnnGetPooling2dDescriptor_v4*(poolingDesc: cudnnPoolingDescriptor_t;
                                      mode: ptr cudnnPoolingMode_t;
      maxpoolingNanOpt: ptr cudnnNanPropagation_t; windowHeight: ptr cint;
                                      windowWidth: ptr cint;
                                      verticalPadding: ptr cint;
                                      horizontalPadding: ptr cint;
                                      verticalStride: ptr cint;
                                      horizontalStride: ptr cint): cudnnStatus_t {.
      cdecl, importc: "cudnnGetPooling2dDescriptor_v4", dyn.}
  proc cudnnSetPoolingNdDescriptor_v3*(poolingDesc: cudnnPoolingDescriptor_t;
                                      mode: cudnnPoolingMode_t; nbDims: cint;
                                      windowDimA: ptr cint; paddingA: ptr cint;
                                      strideA: ptr cint): cudnnStatus_t {.cdecl,
      importc: "cudnnSetPoolingNdDescriptor_v3", dyn.}
  proc cudnnSetPoolingNdDescriptor_v4*(poolingDesc: cudnnPoolingDescriptor_t;
                                      mode: cudnnPoolingMode_t;
                                      maxpoolingNanOpt: cudnnNanPropagation_t;
                                      nbDims: cint; windowDimA: ptr cint;
                                      paddingA: ptr cint; strideA: ptr cint): cudnnStatus_t {.
      cdecl, importc: "cudnnSetPoolingNdDescriptor_v4", dyn.}
  proc cudnnGetPoolingNdDescriptor_v3*(poolingDesc: cudnnPoolingDescriptor_t;
                                      nbDimsRequested: cint;
                                      mode: ptr cudnnPoolingMode_t;
                                      nbDims: ptr cint; windowDimA: ptr cint;
                                      paddingA: ptr cint; strideA: ptr cint): cudnnStatus_t {.
      cdecl, importc: "cudnnGetPoolingNdDescriptor_v3", dyn.}
  proc cudnnGetPoolingNdDescriptor_v4*(poolingDesc: cudnnPoolingDescriptor_t;
                                      nbDimsRequested: cint;
                                      mode: ptr cudnnPoolingMode_t;
      maxpoolingNanOpt: ptr cudnnNanPropagation_t; nbDims: ptr cint;
                                      windowDimA: ptr cint; paddingA: ptr cint;
                                      strideA: ptr cint): cudnnStatus_t {.cdecl,
      importc: "cudnnGetPoolingNdDescriptor_v4", dyn.}
  proc cudnnActivationForward_v3*(handle: cudnnHandle_t;
                                 mode: cudnnActivationMode_t; alpha: pointer;
                                 xDesc: cudnnTensorDescriptor_t; x: pointer;
                                 beta: pointer; yDesc: cudnnTensorDescriptor_t;
                                 y: pointer): cudnnStatus_t {.cdecl,
      importc: "cudnnActivationForward_v3", dyn.}
  proc cudnnActivationForward_v4*(handle: cudnnHandle_t;
                                 activationDesc: cudnnActivationDescriptor_t;
                                 alpha: pointer; xDesc: cudnnTensorDescriptor_t;
                                 x: pointer; beta: pointer;
                                 yDesc: cudnnTensorDescriptor_t; y: pointer): cudnnStatus_t {.
      cdecl, importc: "cudnnActivationForward_v4", dyn.}
  proc cudnnActivationBackward_v3*(handle: cudnnHandle_t;
                                  mode: cudnnActivationMode_t; alpha: pointer;
                                  yDesc: cudnnTensorDescriptor_t; y: pointer;
                                  dyDesc: cudnnTensorDescriptor_t; dy: pointer;
                                  xDesc: cudnnTensorDescriptor_t; x: pointer;
                                  beta: pointer; dxDesc: cudnnTensorDescriptor_t;
                                  dx: pointer): cudnnStatus_t {.cdecl,
      importc: "cudnnActivationBackward_v3", dyn.}
  proc cudnnActivationBackward_v4*(handle: cudnnHandle_t;
                                  activationDesc: cudnnActivationDescriptor_t;
                                  alpha: pointer; yDesc: cudnnTensorDescriptor_t;
                                  y: pointer; dyDesc: cudnnTensorDescriptor_t;
                                  dy: pointer; xDesc: cudnnTensorDescriptor_t;
                                  x: pointer; beta: pointer;
                                  dxDesc: cudnnTensorDescriptor_t; dx: pointer): cudnnStatus_t {.
      cdecl, importc: "cudnnActivationBackward_v4", dyn.}