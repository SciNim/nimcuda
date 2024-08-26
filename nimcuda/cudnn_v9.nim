when defined(windows):
  const
    libName = "cudnn.dll"
elif defined(macosx):
  const
    libName = "libcudnn.dylib"
else:
  const
    libName = "libcudnn.so"
type
  cudnnTensorStruct {.bycopy.} = object

  cudnnConvolutionStruct {.bycopy.} = object

  cudnnPoolingStruct {.bycopy.} = object

  cudnnFilterStruct {.bycopy.} = object

  cudnnLRNStruct {.bycopy.} = object

  cudnnActivationStruct {.bycopy.} = object

  cudnnSpatialTransformerStruct {.bycopy.} = object

  cudnnOpTensorStruct {.bycopy.} = object

  cudnnDropoutStruct {.bycopy.} = object


##    cudnn : Neural Networks Library

when not defined(CUDNN_H):
  import
    cudnn_version_v9, cudnn_graph_v9, cudnn_ops_v9, cudnn_adv_v9, cudnn_cnn_v9
