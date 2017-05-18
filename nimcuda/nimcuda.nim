import ./cublas_api
import ./cublas_v2
import ./cuComplex
import ./cuda_runtime_api
import ./cufft
import ./cusolver_common
import ./cusolverDn
import ./cusolverRf
import ./cusolverSp
import ./cusparse
import ./driver_types
import ./library_types
import ./nvblas
import ./nvgraph
import ./surface_types
import ./texture_types
import ./vector_types

type
  CudaError* = object of IOError
  CufftError* = object of IOError
  CusparseError* = object of IOError
  NVGraphError* = object of IOError

template check*(a: cudaError_t) =
  if a != cudaSuccess:
    raise newException(CudaError, $a & " " & $int(a))

template check*(a: cufftResult) =
  if a != CUFFT_SUCCESS:
    raise newException(CufftError, $a & " " & $int(a))

template check*(a: cusparseStatus_t) =
  if a != CUSPARSE_STATUS_SUCCESS:
    raise newException(CusparseError, $a & " " & $int(a))

template check*(a: nvgraphStatus_t) =
  if a != NVGRAPH_STATUS_SUCCESS:
    raise newException(NVGraphError, $a & " " & $int(a))