# Copyright 2017 UniCredit S.p.A.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import ./cublas_api
import ./cublas_v2
import ./cuComplex
import ./cuda_occupancy
import ./cuda_runtime_api
import ./cudnn
import ./cufft
import ./curand
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
  CudaOccError* = object of IOError
  CufftError* = object of IOError
  CublasError* = object of IOError
  CusparseError* = object of IOError
  CusolverError* = object of IOError
  CurandError* = object of IOError
  CudnnError* = object of IOError
  NVGraphError* = object of IOError

template check*(a: cudaError_t) =
  if a != cudaSuccess:
    raise newException(CudaError, $a & " " & $int(a))

template check*(a: cudaOccError) =
  if a != CUDA_OCC_SUCCESS:
    raise newException(CudaOccError, $a & " " & $int(a))

template check*(a: cublasStatus_t) =
  if a != CUBLAS_STATUS_SUCCESS:
    raise newException(CublasError, $a & " " & $int(a))

template check*(a: cufftResult) =
  if a != CUFFT_SUCCESS:
    raise newException(CufftError, $a & " " & $int(a))

template check*(a: cusparseStatus_t) =
  if a != CUSPARSE_STATUS_SUCCESS:
    raise newException(CusparseError, $a & " " & $int(a))

template check*(a: cusolverStatus_t) =
  if a != CUSOLVER_STATUS_SUCCESS:
    raise newException(CusolverError, $a & " " & $int(a))

template check*(a: curandStatus) =
  if a != CURAND_STATUS_SUCCESS:
    raise newException(CurandError, $a & " " & $int(a))

template check*(a: cudnnStatus_t) =
  if a != CUDNN_STATUS_SUCCESS:
    raise newException(CudnnError, $a & " " & $int(a))

template check*(a: nvgraphStatus_t) =
  if a != NVGRAPH_STATUS_SUCCESS:
    raise newException(NVGraphError, $a & " " & $int(a))