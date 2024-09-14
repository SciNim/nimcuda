when defined(windows):
  const
    libName = "cublas.dll"
elif defined(macosx):
  const
    libName = "libcublas.dylib"
else:
  const
    libName = "libcublas.so"
import
  library_types

##
##  Copyright 1993-2022 NVIDIA Corporation. All rights reserved.
##
##  NOTICE TO LICENSEE:
##
##  This source code and/or documentation ("Licensed Deliverables") are
##  subject to NVIDIA intellectual property rights under U.S. and
##  international Copyright laws.
##
##  These Licensed Deliverables contained herein is PROPRIETARY and
##  CONFIDENTIAL to NVIDIA and is being provided under the terms and
##  conditions of a form of NVIDIA software license agreement by and
##  between NVIDIA and Licensee ("License Agreement") or electronically
##  accepted by Licensee.  Notwithstanding any terms or conditions to
##  the contrary in the License Agreement, reproduction or disclosure
##  of the Licensed Deliverables to any third party without the express
##  written consent of NVIDIA is prohibited.
##
##  NOTWITHSTANDING ANY TERMS OR CONDITIONS TO THE CONTRARY IN THE
##  LICENSE AGREEMENT, NVIDIA MAKES NO REPRESENTATION ABOUT THE
##  SUITABILITY OF THESE LICENSED DELIVERABLES FOR ANY PURPOSE.  IT IS
##  PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY OF ANY KIND.
##  NVIDIA DISCLAIMS ALL WARRANTIES WITH REGARD TO THESE LICENSED
##  DELIVERABLES, INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY,
##  NONINFRINGEMENT, AND FITNESS FOR A PARTICULAR PURPOSE.
##  NOTWITHSTANDING ANY TERMS OR CONDITIONS TO THE CONTRARY IN THE
##  LICENSE AGREEMENT, IN NO EVENT SHALL NVIDIA BE LIABLE FOR ANY
##  SPECIAL, INDIRECT, INCIDENTAL, OR CONSEQUENTIAL DAMAGES, OR ANY
##  DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS,
##  WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS
##  ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE
##  OF THESE LICENSED DELIVERABLES.
##
##  U.S. Government End Users.  These Licensed Deliverables are a
##  "commercial item" as that term is defined at 48 C.F.R. 2.101 (OCT
##  1995), consisting of "commercial computer software" and "commercial
##  computer software documentation" as such terms are used in 48
##  C.F.R. 12.212 (SEPT 1995) and is provided to the U.S. Government
##  only as a commercial end item.  Consistent with 48 C.F.R.12.212 and
##  48 C.F.R. 227.7202-1 through 227.7202-4 (JUNE 1995), all
##  U.S. Government End Users acquire the Licensed Deliverables with
##  only those rights set forth herein.
##
##  Any use of the Licensed Deliverables in individual and commercial
##  software must include, in the user documentation and internal
##  comments to the code, the above Disclaimer and U.S. Government End
##  Users Notice.
##
##
##  This is the public header file for the CUBLAS library, defining the API
##
##  CUBLAS is an implementation of BLAS (Basic Linear Algebra Subroutines)
##  on top of the CUDA runtime.
##

import
  driver_types, cuComplex

const                         ##  import complex data type
  CUBLAS_VER_MAJOR* = 12
  CUBLAS_VER_MINOR* = 5
  CUBLAS_VER_PATCH* = 3
  CUBLAS_VER_BUILD* = 2
  CUBLAS_VERSION* = (
    CUBLAS_VER_MAJOR * 10000 + CUBLAS_VER_MINOR * 100 + CUBLAS_VER_PATCH)

##  CUBLAS status type returns

type
  cublasStatus_t* {.size: sizeof(cint).} = enum
    CUBLAS_STATUS_SUCCESS = 0, CUBLAS_STATUS_NOT_INITIALIZED = 1,
    CUBLAS_STATUS_ALLOC_FAILED = 3, CUBLAS_STATUS_INVALID_VALUE = 7,
    CUBLAS_STATUS_ARCH_MISMATCH = 8, CUBLAS_STATUS_MAPPING_ERROR = 11,
    CUBLAS_STATUS_EXECUTION_FAILED = 13, CUBLAS_STATUS_INTERNAL_ERROR = 14,
    CUBLAS_STATUS_NOT_SUPPORTED = 15, CUBLAS_STATUS_LICENSE_ERROR = 16
  cublasFillMode_t* {.size: sizeof(cint).} = enum
    CUBLAS_FILL_MODE_LOWER = 0, CUBLAS_FILL_MODE_UPPER = 1, CUBLAS_FILL_MODE_FULL = 2
  cublasDiagType_t* {.size: sizeof(cint).} = enum
    CUBLAS_DIAG_NON_UNIT = 0, CUBLAS_DIAG_UNIT = 1
  cublasSideMode_t* {.size: sizeof(cint).} = enum
    CUBLAS_SIDE_LEFT = 0, CUBLAS_SIDE_RIGHT = 1
  cublasOperation_t* {.size: sizeof(cint).} = enum
    CUBLAS_OP_N = 0, CUBLAS_OP_T = 1, CUBLAS_OP_C = 2, CUBLAS_OP_CONJG = 3 ##  conjugate, placeholder - not supported in the current release
  cublasPointerMode_t* {.size: sizeof(cint).} = enum
    CUBLAS_POINTER_MODE_HOST = 0, CUBLAS_POINTER_MODE_DEVICE = 1
  cublasAtomicsMode_t* {.size: sizeof(cint).} = enum
    CUBLAS_ATOMICS_NOT_ALLOWED = 0, CUBLAS_ATOMICS_ALLOWED = 1





const
  CUBLAS_OP_HERMITAN = CUBLAS_OP_C



## For different GEMM algorithm

type
  cublasGemmAlgo_t* {.size: sizeof(cint).} = enum
    CUBLAS_GEMM_DFALT = -1, CUBLAS_GEMM_ALGO0 = 0, CUBLAS_GEMM_ALGO1 = 1,
    CUBLAS_GEMM_ALGO2 = 2, CUBLAS_GEMM_ALGO3 = 3, CUBLAS_GEMM_ALGO4 = 4,
    CUBLAS_GEMM_ALGO5 = 5, CUBLAS_GEMM_ALGO6 = 6, CUBLAS_GEMM_ALGO7 = 7,
    CUBLAS_GEMM_ALGO8 = 8, CUBLAS_GEMM_ALGO9 = 9, CUBLAS_GEMM_ALGO10 = 10,
    CUBLAS_GEMM_ALGO11 = 11, CUBLAS_GEMM_ALGO12 = 12, CUBLAS_GEMM_ALGO13 = 13,
    CUBLAS_GEMM_ALGO14 = 14, CUBLAS_GEMM_ALGO15 = 15, CUBLAS_GEMM_ALGO16 = 16,
    CUBLAS_GEMM_ALGO17 = 17, CUBLAS_GEMM_ALGO18 = 18, ##  sliced 32x32
    CUBLAS_GEMM_ALGO19 = 19,    ##  sliced 64x32
    CUBLAS_GEMM_ALGO20 = 20,    ##  sliced 128x32
    CUBLAS_GEMM_ALGO21 = 21,    ##  sliced 32x32  -splitK
    CUBLAS_GEMM_ALGO22 = 22,    ##  sliced 64x32  -splitK
    CUBLAS_GEMM_ALGO23 = 23,    ##  sliced 128x32 -splitK
    CUBLAS_GEMM_DEFAULT_TENSOR_OP = 99, CUBLAS_GEMM_ALGO0_TENSOR_OP = 100,
    CUBLAS_GEMM_ALGO1_TENSOR_OP = 101, CUBLAS_GEMM_ALGO2_TENSOR_OP = 102,
    CUBLAS_GEMM_ALGO3_TENSOR_OP = 103, CUBLAS_GEMM_ALGO4_TENSOR_OP = 104,
    CUBLAS_GEMM_ALGO5_TENSOR_OP = 105, CUBLAS_GEMM_ALGO6_TENSOR_OP = 106,
    CUBLAS_GEMM_ALGO7_TENSOR_OP = 107, CUBLAS_GEMM_ALGO8_TENSOR_OP = 108,
    CUBLAS_GEMM_ALGO9_TENSOR_OP = 109, CUBLAS_GEMM_ALGO10_TENSOR_OP = 110,
    CUBLAS_GEMM_ALGO11_TENSOR_OP = 111, CUBLAS_GEMM_ALGO12_TENSOR_OP = 112,
    CUBLAS_GEMM_ALGO13_TENSOR_OP = 113, CUBLAS_GEMM_ALGO14_TENSOR_OP = 114,
    CUBLAS_GEMM_ALGO15_TENSOR_OP = 115

const
  CUBLAS_GEMM_DEFAULT = CUBLAS_GEMM_DFALT
  CUBLAS_GEMM_DFALT_TENSOR_OP = CUBLAS_GEMM_DEFAULT_TENSOR_OP

## Enum for default math mode/tensor operation

type
  cublasMath_t* {.size: sizeof(cint).} = enum
    CUBLAS_DEFAULT_MATH = 0,    ##  deprecated, same effect as using CUBLAS_COMPUTE_32F_FAST_16F, will be removed in a future release
    CUBLAS_TENSOR_OP_MATH = 1, ##  same as using matching _PEDANTIC compute type when using cublas<T>routine calls or cublasEx() calls with
                            ##      cudaDataType as compute type
    CUBLAS_PEDANTIC_MATH = 2,   ##  allow accelerating single precision routines using TF32 tensor cores
    CUBLAS_TF32_TENSOR_OP_MATH = 3, ##  flag to force any reductons to use the accumulator type and not output type in case of mixed precision routines
                                 ##      with lower size output type
    CUBLAS_MATH_DISALLOW_REDUCED_PRECISION_REDUCTION = 16


##  For backward compatibility purposes

type
  cublasDataType_t* = cudaDataType

##  Enum for compute type
##
##  - default types provide best available performance using all available hardware features
##    and guarantee internal storage precision with at least the same precision and range;
##  - _PEDANTIC types ensure standard arithmetic and exact specified internal storage format;
##  - _FAST types allow for some loss of precision to enable higher throughput arithmetic.
##

type
  cublasComputeType_t* {.size: sizeof(cint).} = enum
    CUBLAS_COMPUTE_16F = 64,    ##  half - default
    CUBLAS_COMPUTE_16F_PEDANTIC = 65, ##  half - pedantic
    CUBLAS_COMPUTE_32F = 68,    ##  float - default
    CUBLAS_COMPUTE_32F_PEDANTIC = 69, ##  float - pedantic
    CUBLAS_COMPUTE_64F = 70,    ##  double - default
    CUBLAS_COMPUTE_64F_PEDANTIC = 71, ##  double - pedantic
    CUBLAS_COMPUTE_32I = 72,    ##  signed 32-bit int - default
    CUBLAS_COMPUTE_32I_PEDANTIC = 73, ##  signed 32-bit int - pedantic
    CUBLAS_COMPUTE_32F_FAST_16F = 74, ##  float - fast, allows down-converting inputs to half or TF32
    CUBLAS_COMPUTE_32F_FAST_16BF = 75, ##  float - fast, allows down-converting inputs to bfloat16 or TF32
    CUBLAS_COMPUTE_32F_FAST_TF32 = 77 ##  float - fast, allows down-converting inputs to TF32


##  Opaque structure holding CUBLAS library context

type cublasContext {.nodecl.} = object
type
  cublasHandle_t* = ptr cublasContext

##  Cublas logging

type
  cublasLogCallback* = proc (msg: cstring) {.cdecl.}

##  cuBLAS Exported API {{{
##  --------------- CUBLAS Helper Functions  ----------------

proc cublasCreate_v2*(handle: ptr cublasHandle_t): cublasStatus_t {.cdecl,
    importc: "cublasCreate_v2", dynlib: libName.}
proc cublasDestroy_v2*(handle: cublasHandle_t): cublasStatus_t {.cdecl,
    importc: "cublasDestroy_v2", dynlib: libName.}
proc cublasGetVersion_v2*(handle: cublasHandle_t; version: ptr cint): cublasStatus_t {.
    cdecl, importc: "cublasGetVersion_v2", dynlib: libName.}
proc cublasGetProperty*(`type`: libraryPropertyType; value: ptr cint): cublasStatus_t {.
    cdecl, importc: "cublasGetProperty", dynlib: libName.}
proc cublasGetCudartVersion*(): csize_t {.cdecl, importc: "cublasGetCudartVersion",
                                       dynlib: libName.}
proc cublasSetWorkspace_v2*(handle: cublasHandle_t; workspace: pointer;
                           workspaceSizeInBytes: csize_t): cublasStatus_t {.cdecl,
    importc: "cublasSetWorkspace_v2", dynlib: libName.}
proc cublasSetStream_v2*(handle: cublasHandle_t; streamId: cudaStream_t): cublasStatus_t {.
    cdecl, importc: "cublasSetStream_v2", dynlib: libName.}
proc cublasGetStream_v2*(handle: cublasHandle_t; streamId: ptr cudaStream_t): cublasStatus_t {.
    cdecl, importc: "cublasGetStream_v2", dynlib: libName.}
proc cublasGetPointerMode_v2*(handle: cublasHandle_t; mode: ptr cublasPointerMode_t): cublasStatus_t {.
    cdecl, importc: "cublasGetPointerMode_v2", dynlib: libName.}
proc cublasSetPointerMode_v2*(handle: cublasHandle_t; mode: cublasPointerMode_t): cublasStatus_t {.
    cdecl, importc: "cublasSetPointerMode_v2", dynlib: libName.}
proc cublasGetAtomicsMode*(handle: cublasHandle_t; mode: ptr cublasAtomicsMode_t): cublasStatus_t {.
    cdecl, importc: "cublasGetAtomicsMode", dynlib: libName.}
proc cublasSetAtomicsMode*(handle: cublasHandle_t; mode: cublasAtomicsMode_t): cublasStatus_t {.
    cdecl, importc: "cublasSetAtomicsMode", dynlib: libName.}
proc cublasGetMathMode*(handle: cublasHandle_t; mode: ptr cublasMath_t): cublasStatus_t {.
    cdecl, importc: "cublasGetMathMode", dynlib: libName.}
proc cublasSetMathMode*(handle: cublasHandle_t; mode: cublasMath_t): cublasStatus_t {.
    cdecl, importc: "cublasSetMathMode", dynlib: libName.}
proc cublasGetSmCountTarget*(handle: cublasHandle_t; smCountTarget: ptr cint): cublasStatus_t {.
    cdecl, importc: "cublasGetSmCountTarget", dynlib: libName.}
proc cublasSetSmCountTarget*(handle: cublasHandle_t; smCountTarget: cint): cublasStatus_t {.
    cdecl, importc: "cublasSetSmCountTarget", dynlib: libName.}
proc cublasGetStatusName*(status: cublasStatus_t): cstring {.cdecl,
    importc: "cublasGetStatusName", dynlib: libName.}
proc cublasGetStatusString*(status: cublasStatus_t): cstring {.cdecl,
    importc: "cublasGetStatusString", dynlib: libName.}
proc cublasLoggerConfigure*(logIsOn: cint; logToStdOut: cint; logToStdErr: cint;
                           logFileName: cstring): cublasStatus_t {.cdecl,
    importc: "cublasLoggerConfigure", dynlib: libName.}
proc cublasSetLoggerCallback*(userCallback: cublasLogCallback): cublasStatus_t {.
    cdecl, importc: "cublasSetLoggerCallback", dynlib: libName.}
proc cublasGetLoggerCallback*(userCallback: ptr cublasLogCallback): cublasStatus_t {.
    cdecl, importc: "cublasGetLoggerCallback", dynlib: libName.}
proc cublasSetVector*(n: cint; elemSize: cint; x: pointer; incx: cint;
                     devicePtr: pointer; incy: cint): cublasStatus_t {.cdecl,
    importc: "cublasSetVector", dynlib: libName.}
proc cublasSetVector_64*(n: clonglong; elemSize: clonglong; x: pointer;
                        incx: clonglong; devicePtr: pointer; incy: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasSetVector_64", dynlib: libName.}
proc cublasGetVector*(n: cint; elemSize: cint; x: pointer; incx: cint; y: pointer;
                     incy: cint): cublasStatus_t {.cdecl,
    importc: "cublasGetVector", dynlib: libName.}
proc cublasGetVector_64*(n: clonglong; elemSize: clonglong; x: pointer;
                        incx: clonglong; y: pointer; incy: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasGetVector_64", dynlib: libName.}
proc cublasSetMatrix*(rows: cint; cols: cint; elemSize: cint; A: pointer; lda: cint;
                     B: pointer; ldb: cint): cublasStatus_t {.cdecl,
    importc: "cublasSetMatrix", dynlib: libName.}
proc cublasSetMatrix_64*(rows: clonglong; cols: clonglong; elemSize: clonglong;
                        A: pointer; lda: clonglong; B: pointer; ldb: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasSetMatrix_64", dynlib: libName.}
proc cublasGetMatrix*(rows: cint; cols: cint; elemSize: cint; A: pointer; lda: cint;
                     B: pointer; ldb: cint): cublasStatus_t {.cdecl,
    importc: "cublasGetMatrix", dynlib: libName.}
proc cublasGetMatrix_64*(rows: clonglong; cols: clonglong; elemSize: clonglong;
                        A: pointer; lda: clonglong; B: pointer; ldb: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasGetMatrix_64", dynlib: libName.}
proc cublasSetVectorAsync*(n: cint; elemSize: cint; hostPtr: pointer; incx: cint;
                          devicePtr: pointer; incy: cint; stream: cudaStream_t): cublasStatus_t {.
    cdecl, importc: "cublasSetVectorAsync", dynlib: libName.}
proc cublasSetVectorAsync_64*(n: clonglong; elemSize: clonglong; hostPtr: pointer;
                             incx: clonglong; devicePtr: pointer; incy: clonglong;
                             stream: cudaStream_t): cublasStatus_t {.cdecl,
    importc: "cublasSetVectorAsync_64", dynlib: libName.}
proc cublasGetVectorAsync*(n: cint; elemSize: cint; devicePtr: pointer; incx: cint;
                          hostPtr: pointer; incy: cint; stream: cudaStream_t): cublasStatus_t {.
    cdecl, importc: "cublasGetVectorAsync", dynlib: libName.}
proc cublasGetVectorAsync_64*(n: clonglong; elemSize: clonglong; devicePtr: pointer;
                             incx: clonglong; hostPtr: pointer; incy: clonglong;
                             stream: cudaStream_t): cublasStatus_t {.cdecl,
    importc: "cublasGetVectorAsync_64", dynlib: libName.}
proc cublasSetMatrixAsync*(rows: cint; cols: cint; elemSize: cint; A: pointer; lda: cint;
                          B: pointer; ldb: cint; stream: cudaStream_t): cublasStatus_t {.
    cdecl, importc: "cublasSetMatrixAsync", dynlib: libName.}
proc cublasSetMatrixAsync_64*(rows: clonglong; cols: clonglong; elemSize: clonglong;
                             A: pointer; lda: clonglong; B: pointer; ldb: clonglong;
                             stream: cudaStream_t): cublasStatus_t {.cdecl,
    importc: "cublasSetMatrixAsync_64", dynlib: libName.}
proc cublasGetMatrixAsync*(rows: cint; cols: cint; elemSize: cint; A: pointer; lda: cint;
                          B: pointer; ldb: cint; stream: cudaStream_t): cublasStatus_t {.
    cdecl, importc: "cublasGetMatrixAsync", dynlib: libName.}
proc cublasGetMatrixAsync_64*(rows: clonglong; cols: clonglong; elemSize: clonglong;
                             A: pointer; lda: clonglong; B: pointer; ldb: clonglong;
                             stream: cudaStream_t): cublasStatus_t {.cdecl,
    importc: "cublasGetMatrixAsync_64", dynlib: libName.}
proc cublasXerbla*(srName: cstring; info: cint) {.cdecl, importc: "cublasXerbla",
    dynlib: libName.}
##  --------------- CUBLAS BLAS1 Functions  ----------------

proc cublasNrm2Ex*(handle: cublasHandle_t; n: cint; x: pointer; xType: cudaDataType;
                  incx: cint; resultNotKeyWord: pointer; resultType: cudaDataType;
                  executionType: cudaDataType): cublasStatus_t {.cdecl,
    importc: "cublasNrm2Ex", dynlib: libName.}
proc cublasNrm2Ex_64*(handle: cublasHandle_t; n: clonglong; x: pointer;
                     xType: cudaDataType; incx: clonglong; resultNotKeyWord: pointer;
                     resultType: cudaDataType; executionType: cudaDataType): cublasStatus_t {.
    cdecl, importc: "cublasNrm2Ex_64", dynlib: libName.}
proc cublasSnrm2_v2*(handle: cublasHandle_t; n: cint; x: ptr cfloat; incx: cint;
                    resultNotKeyWord: ptr cfloat): cublasStatus_t {.cdecl,
    importc: "cublasSnrm2_v2", dynlib: libName.}
proc cublasSnrm2_v2_64*(handle: cublasHandle_t; n: clonglong; x: ptr cfloat;
                       incx: clonglong; resultNotKeyWord: ptr cfloat): cublasStatus_t {.cdecl,
    importc: "cublasSnrm2_v2_64", dynlib: libName.}
proc cublasDnrm2_v2*(handle: cublasHandle_t; n: cint; x: ptr cdouble; incx: cint;
                    resultNotKeyWord: ptr cdouble): cublasStatus_t {.cdecl,
    importc: "cublasDnrm2_v2", dynlib: libName.}
proc cublasDnrm2_v2_64*(handle: cublasHandle_t; n: clonglong; x: ptr cdouble;
                       incx: clonglong; resultNotKeyWord: ptr cdouble): cublasStatus_t {.cdecl,
    importc: "cublasDnrm2_v2_64", dynlib: libName.}
proc cublasScnrm2_v2*(handle: cublasHandle_t; n: cint; x: ptr cuComplex; incx: cint;
                     resultNotKeyWord: ptr cfloat): cublasStatus_t {.cdecl,
    importc: "cublasScnrm2_v2", dynlib: libName.}
proc cublasScnrm2_v2_64*(handle: cublasHandle_t; n: clonglong; x: ptr cuComplex;
                        incx: clonglong; resultNotKeyWord: ptr cfloat): cublasStatus_t {.cdecl,
    importc: "cublasScnrm2_v2_64", dynlib: libName.}
proc cublasDznrm2_v2*(handle: cublasHandle_t; n: cint; x: ptr cuDoubleComplex;
                     incx: cint; resultNotKeyWord: ptr cdouble): cublasStatus_t {.cdecl,
    importc: "cublasDznrm2_v2", dynlib: libName.}
proc cublasDznrm2_v2_64*(handle: cublasHandle_t; n: clonglong;
                        x: ptr cuDoubleComplex; incx: clonglong; resultNotKeyWord: ptr cdouble): cublasStatus_t {.
    cdecl, importc: "cublasDznrm2_v2_64", dynlib: libName.}
proc cublasDotEx*(handle: cublasHandle_t; n: cint; x: pointer; xType: cudaDataType;
                 incx: cint; y: pointer; yType: cudaDataType; incy: cint;
                 resultNotKeyWord: pointer; resultType: cudaDataType;
                 executionType: cudaDataType): cublasStatus_t {.cdecl,
    importc: "cublasDotEx", dynlib: libName.}
proc cublasDotEx_64*(handle: cublasHandle_t; n: clonglong; x: pointer;
                    xType: cudaDataType; incx: clonglong; y: pointer;
                    yType: cudaDataType; incy: clonglong; resultNotKeyWord: pointer;
                    resultType: cudaDataType; executionType: cudaDataType): cublasStatus_t {.
    cdecl, importc: "cublasDotEx_64", dynlib: libName.}
proc cublasDotcEx*(handle: cublasHandle_t; n: cint; x: pointer; xType: cudaDataType;
                  incx: cint; y: pointer; yType: cudaDataType; incy: cint;
                  resultNotKeyWord: pointer; resultType: cudaDataType;
                  executionType: cudaDataType): cublasStatus_t {.cdecl,
    importc: "cublasDotcEx", dynlib: libName.}
proc cublasDotcEx_64*(handle: cublasHandle_t; n: clonglong; x: pointer;
                     xType: cudaDataType; incx: clonglong; y: pointer;
                     yType: cudaDataType; incy: clonglong; resultNotKeyWord: pointer;
                     resultType: cudaDataType; executionType: cudaDataType): cublasStatus_t {.
    cdecl, importc: "cublasDotcEx_64", dynlib: libName.}
proc cublasSdot_v2*(handle: cublasHandle_t; n: cint; x: ptr cfloat; incx: cint;
                   y: ptr cfloat; incy: cint; resultNotKeyWord: ptr cfloat): cublasStatus_t {.
    cdecl, importc: "cublasSdot_v2", dynlib: libName.}
proc cublasSdot_v2_64*(handle: cublasHandle_t; n: clonglong; x: ptr cfloat;
                      incx: clonglong; y: ptr cfloat; incy: clonglong;
                      resultNotKeyWord: ptr cfloat): cublasStatus_t {.cdecl,
    importc: "cublasSdot_v2_64", dynlib: libName.}
proc cublasDdot_v2*(handle: cublasHandle_t; n: cint; x: ptr cdouble; incx: cint;
                   y: ptr cdouble; incy: cint; resultNotKeyWord: ptr cdouble): cublasStatus_t {.
    cdecl, importc: "cublasDdot_v2", dynlib: libName.}
proc cublasDdot_v2_64*(handle: cublasHandle_t; n: clonglong; x: ptr cdouble;
                      incx: clonglong; y: ptr cdouble; incy: clonglong;
                      resultNotKeyWord: ptr cdouble): cublasStatus_t {.cdecl,
    importc: "cublasDdot_v2_64", dynlib: libName.}
proc cublasCdotu_v2*(handle: cublasHandle_t; n: cint; x: ptr cuComplex; incx: cint;
                    y: ptr cuComplex; incy: cint; resultNotKeyWord: ptr cuComplex): cublasStatus_t {.
    cdecl, importc: "cublasCdotu_v2", dynlib: libName.}
proc cublasCdotu_v2_64*(handle: cublasHandle_t; n: clonglong; x: ptr cuComplex;
                       incx: clonglong; y: ptr cuComplex; incy: clonglong;
                       resultNotKeyWord: ptr cuComplex): cublasStatus_t {.cdecl,
    importc: "cublasCdotu_v2_64", dynlib: libName.}
proc cublasCdotc_v2*(handle: cublasHandle_t; n: cint; x: ptr cuComplex; incx: cint;
                    y: ptr cuComplex; incy: cint; resultNotKeyWord: ptr cuComplex): cublasStatus_t {.
    cdecl, importc: "cublasCdotc_v2", dynlib: libName.}
proc cublasCdotc_v2_64*(handle: cublasHandle_t; n: clonglong; x: ptr cuComplex;
                       incx: clonglong; y: ptr cuComplex; incy: clonglong;
                       resultNotKeyWord: ptr cuComplex): cublasStatus_t {.cdecl,
    importc: "cublasCdotc_v2_64", dynlib: libName.}
proc cublasZdotu_v2*(handle: cublasHandle_t; n: cint; x: ptr cuDoubleComplex;
                    incx: cint; y: ptr cuDoubleComplex; incy: cint;
                    resultNotKeyWord: ptr cuDoubleComplex): cublasStatus_t {.cdecl,
    importc: "cublasZdotu_v2", dynlib: libName.}
proc cublasZdotu_v2_64*(handle: cublasHandle_t; n: clonglong; x: ptr cuDoubleComplex;
                       incx: clonglong; y: ptr cuDoubleComplex; incy: clonglong;
                       resultNotKeyWord: ptr cuDoubleComplex): cublasStatus_t {.cdecl,
    importc: "cublasZdotu_v2_64", dynlib: libName.}
proc cublasZdotc_v2*(handle: cublasHandle_t; n: cint; x: ptr cuDoubleComplex;
                    incx: cint; y: ptr cuDoubleComplex; incy: cint;
                    resultNotKeyWord: ptr cuDoubleComplex): cublasStatus_t {.cdecl,
    importc: "cublasZdotc_v2", dynlib: libName.}
proc cublasZdotc_v2_64*(handle: cublasHandle_t; n: clonglong; x: ptr cuDoubleComplex;
                       incx: clonglong; y: ptr cuDoubleComplex; incy: clonglong;
                       resultNotKeyWord: ptr cuDoubleComplex): cublasStatus_t {.cdecl,
    importc: "cublasZdotc_v2_64", dynlib: libName.}
proc cublasScalEx*(handle: cublasHandle_t; n: cint; alpha: pointer;
                  alphaType: cudaDataType; x: pointer; xType: cudaDataType;
                  incx: cint; executionType: cudaDataType): cublasStatus_t {.cdecl,
    importc: "cublasScalEx", dynlib: libName.}
proc cublasScalEx_64*(handle: cublasHandle_t; n: clonglong; alpha: pointer;
                     alphaType: cudaDataType; x: pointer; xType: cudaDataType;
                     incx: clonglong; executionType: cudaDataType): cublasStatus_t {.
    cdecl, importc: "cublasScalEx_64", dynlib: libName.}
proc cublasSscal_v2*(handle: cublasHandle_t; n: cint; alpha: ptr cfloat; x: ptr cfloat;
                    incx: cint): cublasStatus_t {.cdecl, importc: "cublasSscal_v2",
    dynlib: libName.}
proc cublasSscal_v2_64*(handle: cublasHandle_t; n: clonglong; alpha: ptr cfloat;
                       x: ptr cfloat; incx: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasSscal_v2_64", dynlib: libName.}
proc cublasDscal_v2*(handle: cublasHandle_t; n: cint; alpha: ptr cdouble;
                    x: ptr cdouble; incx: cint): cublasStatus_t {.cdecl,
    importc: "cublasDscal_v2", dynlib: libName.}
proc cublasDscal_v2_64*(handle: cublasHandle_t; n: clonglong; alpha: ptr cdouble;
                       x: ptr cdouble; incx: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasDscal_v2_64", dynlib: libName.}
proc cublasCscal_v2*(handle: cublasHandle_t; n: cint; alpha: ptr cuComplex;
                    x: ptr cuComplex; incx: cint): cublasStatus_t {.cdecl,
    importc: "cublasCscal_v2", dynlib: libName.}
proc cublasCscal_v2_64*(handle: cublasHandle_t; n: clonglong; alpha: ptr cuComplex;
                       x: ptr cuComplex; incx: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasCscal_v2_64", dynlib: libName.}
proc cublasCsscal_v2*(handle: cublasHandle_t; n: cint; alpha: ptr cfloat;
                     x: ptr cuComplex; incx: cint): cublasStatus_t {.cdecl,
    importc: "cublasCsscal_v2", dynlib: libName.}
proc cublasCsscal_v2_64*(handle: cublasHandle_t; n: clonglong; alpha: ptr cfloat;
                        x: ptr cuComplex; incx: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasCsscal_v2_64", dynlib: libName.}
proc cublasZscal_v2*(handle: cublasHandle_t; n: cint; alpha: ptr cuDoubleComplex;
                    x: ptr cuDoubleComplex; incx: cint): cublasStatus_t {.cdecl,
    importc: "cublasZscal_v2", dynlib: libName.}
proc cublasZscal_v2_64*(handle: cublasHandle_t; n: clonglong;
                       alpha: ptr cuDoubleComplex; x: ptr cuDoubleComplex;
                       incx: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasZscal_v2_64", dynlib: libName.}
proc cublasZdscal_v2*(handle: cublasHandle_t; n: cint; alpha: ptr cdouble;
                     x: ptr cuDoubleComplex; incx: cint): cublasStatus_t {.cdecl,
    importc: "cublasZdscal_v2", dynlib: libName.}
proc cublasZdscal_v2_64*(handle: cublasHandle_t; n: clonglong; alpha: ptr cdouble;
                        x: ptr cuDoubleComplex; incx: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasZdscal_v2_64", dynlib: libName.}
proc cublasAxpyEx*(handle: cublasHandle_t; n: cint; alpha: pointer;
                  alphaType: cudaDataType; x: pointer; xType: cudaDataType;
                  incx: cint; y: pointer; yType: cudaDataType; incy: cint;
                  executiontype: cudaDataType): cublasStatus_t {.cdecl,
    importc: "cublasAxpyEx", dynlib: libName.}
proc cublasAxpyEx_64*(handle: cublasHandle_t; n: clonglong; alpha: pointer;
                     alphaType: cudaDataType; x: pointer; xType: cudaDataType;
                     incx: clonglong; y: pointer; yType: cudaDataType;
                     incy: clonglong; executiontype: cudaDataType): cublasStatus_t {.
    cdecl, importc: "cublasAxpyEx_64", dynlib: libName.}
proc cublasSaxpy_v2*(handle: cublasHandle_t; n: cint; alpha: ptr cfloat; x: ptr cfloat;
                    incx: cint; y: ptr cfloat; incy: cint): cublasStatus_t {.cdecl,
    importc: "cublasSaxpy_v2", dynlib: libName.}
proc cublasSaxpy_v2_64*(handle: cublasHandle_t; n: clonglong; alpha: ptr cfloat;
                       x: ptr cfloat; incx: clonglong; y: ptr cfloat; incy: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasSaxpy_v2_64", dynlib: libName.}
proc cublasDaxpy_v2*(handle: cublasHandle_t; n: cint; alpha: ptr cdouble;
                    x: ptr cdouble; incx: cint; y: ptr cdouble; incy: cint): cublasStatus_t {.
    cdecl, importc: "cublasDaxpy_v2", dynlib: libName.}
proc cublasDaxpy_v2_64*(handle: cublasHandle_t; n: clonglong; alpha: ptr cdouble;
                       x: ptr cdouble; incx: clonglong; y: ptr cdouble; incy: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasDaxpy_v2_64", dynlib: libName.}
proc cublasCaxpy_v2*(handle: cublasHandle_t; n: cint; alpha: ptr cuComplex;
                    x: ptr cuComplex; incx: cint; y: ptr cuComplex; incy: cint): cublasStatus_t {.
    cdecl, importc: "cublasCaxpy_v2", dynlib: libName.}
proc cublasCaxpy_v2_64*(handle: cublasHandle_t; n: clonglong; alpha: ptr cuComplex;
                       x: ptr cuComplex; incx: clonglong; y: ptr cuComplex;
                       incy: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasCaxpy_v2_64", dynlib: libName.}
proc cublasZaxpy_v2*(handle: cublasHandle_t; n: cint; alpha: ptr cuDoubleComplex;
                    x: ptr cuDoubleComplex; incx: cint; y: ptr cuDoubleComplex;
                    incy: cint): cublasStatus_t {.cdecl, importc: "cublasZaxpy_v2",
    dynlib: libName.}
proc cublasZaxpy_v2_64*(handle: cublasHandle_t; n: clonglong;
                       alpha: ptr cuDoubleComplex; x: ptr cuDoubleComplex;
                       incx: clonglong; y: ptr cuDoubleComplex; incy: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasZaxpy_v2_64", dynlib: libName.}
proc cublasCopyEx*(handle: cublasHandle_t; n: cint; x: pointer; xType: cudaDataType;
                  incx: cint; y: pointer; yType: cudaDataType; incy: cint): cublasStatus_t {.
    cdecl, importc: "cublasCopyEx", dynlib: libName.}
proc cublasCopyEx_64*(handle: cublasHandle_t; n: clonglong; x: pointer;
                     xType: cudaDataType; incx: clonglong; y: pointer;
                     yType: cudaDataType; incy: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasCopyEx_64", dynlib: libName.}
proc cublasScopy_v2*(handle: cublasHandle_t; n: cint; x: ptr cfloat; incx: cint;
                    y: ptr cfloat; incy: cint): cublasStatus_t {.cdecl,
    importc: "cublasScopy_v2", dynlib: libName.}
proc cublasScopy_v2_64*(handle: cublasHandle_t; n: clonglong; x: ptr cfloat;
                       incx: clonglong; y: ptr cfloat; incy: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasScopy_v2_64", dynlib: libName.}
proc cublasDcopy_v2*(handle: cublasHandle_t; n: cint; x: ptr cdouble; incx: cint;
                    y: ptr cdouble; incy: cint): cublasStatus_t {.cdecl,
    importc: "cublasDcopy_v2", dynlib: libName.}
proc cublasDcopy_v2_64*(handle: cublasHandle_t; n: clonglong; x: ptr cdouble;
                       incx: clonglong; y: ptr cdouble; incy: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasDcopy_v2_64", dynlib: libName.}
proc cublasCcopy_v2*(handle: cublasHandle_t; n: cint; x: ptr cuComplex; incx: cint;
                    y: ptr cuComplex; incy: cint): cublasStatus_t {.cdecl,
    importc: "cublasCcopy_v2", dynlib: libName.}
proc cublasCcopy_v2_64*(handle: cublasHandle_t; n: clonglong; x: ptr cuComplex;
                       incx: clonglong; y: ptr cuComplex; incy: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasCcopy_v2_64", dynlib: libName.}
proc cublasZcopy_v2*(handle: cublasHandle_t; n: cint; x: ptr cuDoubleComplex;
                    incx: cint; y: ptr cuDoubleComplex; incy: cint): cublasStatus_t {.
    cdecl, importc: "cublasZcopy_v2", dynlib: libName.}
proc cublasZcopy_v2_64*(handle: cublasHandle_t; n: clonglong; x: ptr cuDoubleComplex;
                       incx: clonglong; y: ptr cuDoubleComplex; incy: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasZcopy_v2_64", dynlib: libName.}
proc cublasSswap_v2*(handle: cublasHandle_t; n: cint; x: ptr cfloat; incx: cint;
                    y: ptr cfloat; incy: cint): cublasStatus_t {.cdecl,
    importc: "cublasSswap_v2", dynlib: libName.}
proc cublasSswap_v2_64*(handle: cublasHandle_t; n: clonglong; x: ptr cfloat;
                       incx: clonglong; y: ptr cfloat; incy: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasSswap_v2_64", dynlib: libName.}
proc cublasDswap_v2*(handle: cublasHandle_t; n: cint; x: ptr cdouble; incx: cint;
                    y: ptr cdouble; incy: cint): cublasStatus_t {.cdecl,
    importc: "cublasDswap_v2", dynlib: libName.}
proc cublasDswap_v2_64*(handle: cublasHandle_t; n: clonglong; x: ptr cdouble;
                       incx: clonglong; y: ptr cdouble; incy: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasDswap_v2_64", dynlib: libName.}
proc cublasCswap_v2*(handle: cublasHandle_t; n: cint; x: ptr cuComplex; incx: cint;
                    y: ptr cuComplex; incy: cint): cublasStatus_t {.cdecl,
    importc: "cublasCswap_v2", dynlib: libName.}
proc cublasCswap_v2_64*(handle: cublasHandle_t; n: clonglong; x: ptr cuComplex;
                       incx: clonglong; y: ptr cuComplex; incy: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasCswap_v2_64", dynlib: libName.}
proc cublasZswap_v2*(handle: cublasHandle_t; n: cint; x: ptr cuDoubleComplex;
                    incx: cint; y: ptr cuDoubleComplex; incy: cint): cublasStatus_t {.
    cdecl, importc: "cublasZswap_v2", dynlib: libName.}
proc cublasZswap_v2_64*(handle: cublasHandle_t; n: clonglong; x: ptr cuDoubleComplex;
                       incx: clonglong; y: ptr cuDoubleComplex; incy: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasZswap_v2_64", dynlib: libName.}
proc cublasSwapEx*(handle: cublasHandle_t; n: cint; x: pointer; xType: cudaDataType;
                  incx: cint; y: pointer; yType: cudaDataType; incy: cint): cublasStatus_t {.
    cdecl, importc: "cublasSwapEx", dynlib: libName.}
proc cublasSwapEx_64*(handle: cublasHandle_t; n: clonglong; x: pointer;
                     xType: cudaDataType; incx: clonglong; y: pointer;
                     yType: cudaDataType; incy: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasSwapEx_64", dynlib: libName.}
proc cublasIsamax_v2*(handle: cublasHandle_t; n: cint; x: ptr cfloat; incx: cint;
                     resultNotKeyWord: ptr cint): cublasStatus_t {.cdecl,
    importc: "cublasIsamax_v2", dynlib: libName.}
proc cublasIsamax_v2_64*(handle: cublasHandle_t; n: clonglong; x: ptr cfloat;
                        incx: clonglong; resultNotKeyWord: ptr clonglong): cublasStatus_t {.
    cdecl, importc: "cublasIsamax_v2_64", dynlib: libName.}
proc cublasIdamax_v2*(handle: cublasHandle_t; n: cint; x: ptr cdouble; incx: cint;
                     resultNotKeyWord: ptr cint): cublasStatus_t {.cdecl,
    importc: "cublasIdamax_v2", dynlib: libName.}
proc cublasIdamax_v2_64*(handle: cublasHandle_t; n: clonglong; x: ptr cdouble;
                        incx: clonglong; resultNotKeyWord: ptr clonglong): cublasStatus_t {.
    cdecl, importc: "cublasIdamax_v2_64", dynlib: libName.}
proc cublasIcamax_v2*(handle: cublasHandle_t; n: cint; x: ptr cuComplex; incx: cint;
                     resultNotKeyWord: ptr cint): cublasStatus_t {.cdecl,
    importc: "cublasIcamax_v2", dynlib: libName.}
proc cublasIcamax_v2_64*(handle: cublasHandle_t; n: clonglong; x: ptr cuComplex;
                        incx: clonglong; resultNotKeyWord: ptr clonglong): cublasStatus_t {.
    cdecl, importc: "cublasIcamax_v2_64", dynlib: libName.}
proc cublasIzamax_v2*(handle: cublasHandle_t; n: cint; x: ptr cuDoubleComplex;
                     incx: cint; resultNotKeyWord: ptr cint): cublasStatus_t {.cdecl,
    importc: "cublasIzamax_v2", dynlib: libName.}
proc cublasIzamax_v2_64*(handle: cublasHandle_t; n: clonglong;
                        x: ptr cuDoubleComplex; incx: clonglong;
                        resultNotKeyWord: ptr clonglong): cublasStatus_t {.cdecl,
    importc: "cublasIzamax_v2_64", dynlib: libName.}
proc cublasIamaxEx*(handle: cublasHandle_t; n: cint; x: pointer; xType: cudaDataType;
                   incx: cint; resultNotKeyWord: ptr cint): cublasStatus_t {.cdecl,
    importc: "cublasIamaxEx", dynlib: libName.}
proc cublasIamaxEx_64*(handle: cublasHandle_t; n: clonglong; x: pointer;
                      xType: cudaDataType; incx: clonglong; resultNotKeyWord: ptr clonglong): cublasStatus_t {.
    cdecl, importc: "cublasIamaxEx_64", dynlib: libName.}
proc cublasIsamin_v2*(handle: cublasHandle_t; n: cint; x: ptr cfloat; incx: cint;
                     resultNotKeyWord: ptr cint): cublasStatus_t {.cdecl,
    importc: "cublasIsamin_v2", dynlib: libName.}
proc cublasIsamin_v2_64*(handle: cublasHandle_t; n: clonglong; x: ptr cfloat;
                        incx: clonglong; resultNotKeyWord: ptr clonglong): cublasStatus_t {.
    cdecl, importc: "cublasIsamin_v2_64", dynlib: libName.}
proc cublasIdamin_v2*(handle: cublasHandle_t; n: cint; x: ptr cdouble; incx: cint;
                     resultNotKeyWord: ptr cint): cublasStatus_t {.cdecl,
    importc: "cublasIdamin_v2", dynlib: libName.}
proc cublasIdamin_v2_64*(handle: cublasHandle_t; n: clonglong; x: ptr cdouble;
                        incx: clonglong; resultNotKeyWord: ptr clonglong): cublasStatus_t {.
    cdecl, importc: "cublasIdamin_v2_64", dynlib: libName.}
proc cublasIcamin_v2*(handle: cublasHandle_t; n: cint; x: ptr cuComplex; incx: cint;
                     resultNotKeyWord: ptr cint): cublasStatus_t {.cdecl,
    importc: "cublasIcamin_v2", dynlib: libName.}
proc cublasIcamin_v2_64*(handle: cublasHandle_t; n: clonglong; x: ptr cuComplex;
                        incx: clonglong; resultNotKeyWord: ptr clonglong): cublasStatus_t {.
    cdecl, importc: "cublasIcamin_v2_64", dynlib: libName.}
proc cublasIzamin_v2*(handle: cublasHandle_t; n: cint; x: ptr cuDoubleComplex;
                     incx: cint; resultNotKeyWord: ptr cint): cublasStatus_t {.cdecl,
    importc: "cublasIzamin_v2", dynlib: libName.}
proc cublasIzamin_v2_64*(handle: cublasHandle_t; n: clonglong;
                        x: ptr cuDoubleComplex; incx: clonglong;
                        resultNotKeyWord: ptr clonglong): cublasStatus_t {.cdecl,
    importc: "cublasIzamin_v2_64", dynlib: libName.}
proc cublasIaminEx*(handle: cublasHandle_t; n: cint; x: pointer; xType: cudaDataType;
                   incx: cint; resultNotKeyWord: ptr cint): cublasStatus_t {.cdecl,
    importc: "cublasIaminEx", dynlib: libName.}
proc cublasIaminEx_64*(handle: cublasHandle_t; n: clonglong; x: pointer;
                      xType: cudaDataType; incx: clonglong; resultNotKeyWord: ptr clonglong): cublasStatus_t {.
    cdecl, importc: "cublasIaminEx_64", dynlib: libName.}
proc cublasAsumEx*(handle: cublasHandle_t; n: cint; x: pointer; xType: cudaDataType;
                  incx: cint; resultNotKeyWord: pointer; resultType: cudaDataType;
                  executiontype: cudaDataType): cublasStatus_t {.cdecl,
    importc: "cublasAsumEx", dynlib: libName.}
proc cublasAsumEx_64*(handle: cublasHandle_t; n: clonglong; x: pointer;
                     xType: cudaDataType; incx: clonglong; resultNotKeyWord: pointer;
                     resultType: cudaDataType; executiontype: cudaDataType): cublasStatus_t {.
    cdecl, importc: "cublasAsumEx_64", dynlib: libName.}
proc cublasSasum_v2*(handle: cublasHandle_t; n: cint; x: ptr cfloat; incx: cint;
                    resultNotKeyWord: ptr cfloat): cublasStatus_t {.cdecl,
    importc: "cublasSasum_v2", dynlib: libName.}
proc cublasSasum_v2_64*(handle: cublasHandle_t; n: clonglong; x: ptr cfloat;
                       incx: clonglong; resultNotKeyWord: ptr cfloat): cublasStatus_t {.cdecl,
    importc: "cublasSasum_v2_64", dynlib: libName.}
proc cublasDasum_v2*(handle: cublasHandle_t; n: cint; x: ptr cdouble; incx: cint;
                    resultNotKeyWord: ptr cdouble): cublasStatus_t {.cdecl,
    importc: "cublasDasum_v2", dynlib: libName.}
proc cublasDasum_v2_64*(handle: cublasHandle_t; n: clonglong; x: ptr cdouble;
                       incx: clonglong; resultNotKeyWord: ptr cdouble): cublasStatus_t {.cdecl,
    importc: "cublasDasum_v2_64", dynlib: libName.}
proc cublasScasum_v2*(handle: cublasHandle_t; n: cint; x: ptr cuComplex; incx: cint;
                     resultNotKeyWord: ptr cfloat): cublasStatus_t {.cdecl,
    importc: "cublasScasum_v2", dynlib: libName.}
proc cublasScasum_v2_64*(handle: cublasHandle_t; n: clonglong; x: ptr cuComplex;
                        incx: clonglong; resultNotKeyWord: ptr cfloat): cublasStatus_t {.cdecl,
    importc: "cublasScasum_v2_64", dynlib: libName.}
proc cublasDzasum_v2*(handle: cublasHandle_t; n: cint; x: ptr cuDoubleComplex;
                     incx: cint; resultNotKeyWord: ptr cdouble): cublasStatus_t {.cdecl,
    importc: "cublasDzasum_v2", dynlib: libName.}
proc cublasDzasum_v2_64*(handle: cublasHandle_t; n: clonglong;
                        x: ptr cuDoubleComplex; incx: clonglong; resultNotKeyWord: ptr cdouble): cublasStatus_t {.
    cdecl, importc: "cublasDzasum_v2_64", dynlib: libName.}
proc cublasSrot_v2*(handle: cublasHandle_t; n: cint; x: ptr cfloat; incx: cint;
                   y: ptr cfloat; incy: cint; c: ptr cfloat; s: ptr cfloat): cublasStatus_t {.
    cdecl, importc: "cublasSrot_v2", dynlib: libName.}
proc cublasSrot_v2_64*(handle: cublasHandle_t; n: clonglong; x: ptr cfloat;
                      incx: clonglong; y: ptr cfloat; incy: clonglong; c: ptr cfloat;
                      s: ptr cfloat): cublasStatus_t {.cdecl,
    importc: "cublasSrot_v2_64", dynlib: libName.}
proc cublasDrot_v2*(handle: cublasHandle_t; n: cint; x: ptr cdouble; incx: cint;
                   y: ptr cdouble; incy: cint; c: ptr cdouble; s: ptr cdouble): cublasStatus_t {.
    cdecl, importc: "cublasDrot_v2", dynlib: libName.}
proc cublasDrot_v2_64*(handle: cublasHandle_t; n: clonglong; x: ptr cdouble;
                      incx: clonglong; y: ptr cdouble; incy: clonglong; c: ptr cdouble;
                      s: ptr cdouble): cublasStatus_t {.cdecl,
    importc: "cublasDrot_v2_64", dynlib: libName.}
proc cublasCrot_v2*(handle: cublasHandle_t; n: cint; x: ptr cuComplex; incx: cint;
                   y: ptr cuComplex; incy: cint; c: ptr cfloat; s: ptr cuComplex): cublasStatus_t {.
    cdecl, importc: "cublasCrot_v2", dynlib: libName.}
proc cublasCrot_v2_64*(handle: cublasHandle_t; n: clonglong; x: ptr cuComplex;
                      incx: clonglong; y: ptr cuComplex; incy: clonglong;
                      c: ptr cfloat; s: ptr cuComplex): cublasStatus_t {.cdecl,
    importc: "cublasCrot_v2_64", dynlib: libName.}
proc cublasCsrot_v2*(handle: cublasHandle_t; n: cint; x: ptr cuComplex; incx: cint;
                    y: ptr cuComplex; incy: cint; c: ptr cfloat; s: ptr cfloat): cublasStatus_t {.
    cdecl, importc: "cublasCsrot_v2", dynlib: libName.}
proc cublasCsrot_v2_64*(handle: cublasHandle_t; n: clonglong; x: ptr cuComplex;
                       incx: clonglong; y: ptr cuComplex; incy: clonglong;
                       c: ptr cfloat; s: ptr cfloat): cublasStatus_t {.cdecl,
    importc: "cublasCsrot_v2_64", dynlib: libName.}
proc cublasZrot_v2*(handle: cublasHandle_t; n: cint; x: ptr cuDoubleComplex; incx: cint;
                   y: ptr cuDoubleComplex; incy: cint; c: ptr cdouble;
                   s: ptr cuDoubleComplex): cublasStatus_t {.cdecl,
    importc: "cublasZrot_v2", dynlib: libName.}
proc cublasZrot_v2_64*(handle: cublasHandle_t; n: clonglong; x: ptr cuDoubleComplex;
                      incx: clonglong; y: ptr cuDoubleComplex; incy: clonglong;
                      c: ptr cdouble; s: ptr cuDoubleComplex): cublasStatus_t {.cdecl,
    importc: "cublasZrot_v2_64", dynlib: libName.}
proc cublasZdrot_v2*(handle: cublasHandle_t; n: cint; x: ptr cuDoubleComplex;
                    incx: cint; y: ptr cuDoubleComplex; incy: cint; c: ptr cdouble;
                    s: ptr cdouble): cublasStatus_t {.cdecl,
    importc: "cublasZdrot_v2", dynlib: libName.}
proc cublasZdrot_v2_64*(handle: cublasHandle_t; n: clonglong; x: ptr cuDoubleComplex;
                       incx: clonglong; y: ptr cuDoubleComplex; incy: clonglong;
                       c: ptr cdouble; s: ptr cdouble): cublasStatus_t {.cdecl,
    importc: "cublasZdrot_v2_64", dynlib: libName.}
proc cublasRotEx*(handle: cublasHandle_t; n: cint; x: pointer; xType: cudaDataType;
                 incx: cint; y: pointer; yType: cudaDataType; incy: cint; c: pointer;
                 s: pointer; csType: cudaDataType; executiontype: cudaDataType): cublasStatus_t {.
    cdecl, importc: "cublasRotEx", dynlib: libName.}
proc cublasRotEx_64*(handle: cublasHandle_t; n: clonglong; x: pointer;
                    xType: cudaDataType; incx: clonglong; y: pointer;
                    yType: cudaDataType; incy: clonglong; c: pointer; s: pointer;
                    csType: cudaDataType; executiontype: cudaDataType): cublasStatus_t {.
    cdecl, importc: "cublasRotEx_64", dynlib: libName.}
proc cublasSrotg_v2*(handle: cublasHandle_t; a: ptr cfloat; b: ptr cfloat; c: ptr cfloat;
                    s: ptr cfloat): cublasStatus_t {.cdecl,
    importc: "cublasSrotg_v2", dynlib: libName.}
proc cublasDrotg_v2*(handle: cublasHandle_t; a: ptr cdouble; b: ptr cdouble;
                    c: ptr cdouble; s: ptr cdouble): cublasStatus_t {.cdecl,
    importc: "cublasDrotg_v2", dynlib: libName.}
proc cublasCrotg_v2*(handle: cublasHandle_t; a: ptr cuComplex; b: ptr cuComplex;
                    c: ptr cfloat; s: ptr cuComplex): cublasStatus_t {.cdecl,
    importc: "cublasCrotg_v2", dynlib: libName.}
proc cublasZrotg_v2*(handle: cublasHandle_t; a: ptr cuDoubleComplex;
                    b: ptr cuDoubleComplex; c: ptr cdouble; s: ptr cuDoubleComplex): cublasStatus_t {.
    cdecl, importc: "cublasZrotg_v2", dynlib: libName.}
proc cublasRotgEx*(handle: cublasHandle_t; a: pointer; b: pointer;
                  abType: cudaDataType; c: pointer; s: pointer; csType: cudaDataType;
                  executiontype: cudaDataType): cublasStatus_t {.cdecl,
    importc: "cublasRotgEx", dynlib: libName.}
proc cublasSrotm_v2*(handle: cublasHandle_t; n: cint; x: ptr cfloat; incx: cint;
                    y: ptr cfloat; incy: cint; param: ptr cfloat): cublasStatus_t {.
    cdecl, importc: "cublasSrotm_v2", dynlib: libName.}
proc cublasSrotm_v2_64*(handle: cublasHandle_t; n: clonglong; x: ptr cfloat;
                       incx: clonglong; y: ptr cfloat; incy: clonglong;
                       param: ptr cfloat): cublasStatus_t {.cdecl,
    importc: "cublasSrotm_v2_64", dynlib: libName.}
proc cublasDrotm_v2*(handle: cublasHandle_t; n: cint; x: ptr cdouble; incx: cint;
                    y: ptr cdouble; incy: cint; param: ptr cdouble): cublasStatus_t {.
    cdecl, importc: "cublasDrotm_v2", dynlib: libName.}
proc cublasDrotm_v2_64*(handle: cublasHandle_t; n: clonglong; x: ptr cdouble;
                       incx: clonglong; y: ptr cdouble; incy: clonglong;
                       param: ptr cdouble): cublasStatus_t {.cdecl,
    importc: "cublasDrotm_v2_64", dynlib: libName.}
proc cublasRotmEx*(handle: cublasHandle_t; n: cint; x: pointer; xType: cudaDataType;
                  incx: cint; y: pointer; yType: cudaDataType; incy: cint;
                  param: pointer; paramType: cudaDataType;
                  executiontype: cudaDataType): cublasStatus_t {.cdecl,
    importc: "cublasRotmEx", dynlib: libName.}
proc cublasRotmEx_64*(handle: cublasHandle_t; n: clonglong; x: pointer;
                     xType: cudaDataType; incx: clonglong; y: pointer;
                     yType: cudaDataType; incy: clonglong; param: pointer;
                     paramType: cudaDataType; executiontype: cudaDataType): cublasStatus_t {.
    cdecl, importc: "cublasRotmEx_64", dynlib: libName.}
proc cublasSrotmg_v2*(handle: cublasHandle_t; d1: ptr cfloat; d2: ptr cfloat;
                     x1: ptr cfloat; y1: ptr cfloat; param: ptr cfloat): cublasStatus_t {.
    cdecl, importc: "cublasSrotmg_v2", dynlib: libName.}
proc cublasDrotmg_v2*(handle: cublasHandle_t; d1: ptr cdouble; d2: ptr cdouble;
                     x1: ptr cdouble; y1: ptr cdouble; param: ptr cdouble): cublasStatus_t {.
    cdecl, importc: "cublasDrotmg_v2", dynlib: libName.}
proc cublasRotmgEx*(handle: cublasHandle_t; d1: pointer; d1Type: cudaDataType;
                   d2: pointer; d2Type: cudaDataType; x1: pointer;
                   x1Type: cudaDataType; y1: pointer; y1Type: cudaDataType;
                   param: pointer; paramType: cudaDataType;
                   executiontype: cudaDataType): cublasStatus_t {.cdecl,
    importc: "cublasRotmgEx", dynlib: libName.}
##  --------------- CUBLAS BLAS2 Functions  ----------------
##  GEMV

proc cublasSgemv_v2*(handle: cublasHandle_t; trans: cublasOperation_t; m: cint;
                    n: cint; alpha: ptr cfloat; A: ptr cfloat; lda: cint; x: ptr cfloat;
                    incx: cint; beta: ptr cfloat; y: ptr cfloat; incy: cint): cublasStatus_t {.
    cdecl, importc: "cublasSgemv_v2", dynlib: libName.}
proc cublasSgemv_v2_64*(handle: cublasHandle_t; trans: cublasOperation_t;
                       m: clonglong; n: clonglong; alpha: ptr cfloat; A: ptr cfloat;
                       lda: clonglong; x: ptr cfloat; incx: clonglong;
                       beta: ptr cfloat; y: ptr cfloat; incy: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasSgemv_v2_64", dynlib: libName.}
proc cublasDgemv_v2*(handle: cublasHandle_t; trans: cublasOperation_t; m: cint;
                    n: cint; alpha: ptr cdouble; A: ptr cdouble; lda: cint;
                    x: ptr cdouble; incx: cint; beta: ptr cdouble; y: ptr cdouble;
                    incy: cint): cublasStatus_t {.cdecl, importc: "cublasDgemv_v2",
    dynlib: libName.}
proc cublasDgemv_v2_64*(handle: cublasHandle_t; trans: cublasOperation_t;
                       m: clonglong; n: clonglong; alpha: ptr cdouble; A: ptr cdouble;
                       lda: clonglong; x: ptr cdouble; incx: clonglong;
                       beta: ptr cdouble; y: ptr cdouble; incy: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasDgemv_v2_64", dynlib: libName.}
proc cublasCgemv_v2*(handle: cublasHandle_t; trans: cublasOperation_t; m: cint;
                    n: cint; alpha: ptr cuComplex; A: ptr cuComplex; lda: cint;
                    x: ptr cuComplex; incx: cint; beta: ptr cuComplex; y: ptr cuComplex;
                    incy: cint): cublasStatus_t {.cdecl, importc: "cublasCgemv_v2",
    dynlib: libName.}
proc cublasCgemv_v2_64*(handle: cublasHandle_t; trans: cublasOperation_t;
                       m: clonglong; n: clonglong; alpha: ptr cuComplex;
                       A: ptr cuComplex; lda: clonglong; x: ptr cuComplex;
                       incx: clonglong; beta: ptr cuComplex; y: ptr cuComplex;
                       incy: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasCgemv_v2_64", dynlib: libName.}
proc cublasZgemv_v2*(handle: cublasHandle_t; trans: cublasOperation_t; m: cint;
                    n: cint; alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex;
                    lda: cint; x: ptr cuDoubleComplex; incx: cint;
                    beta: ptr cuDoubleComplex; y: ptr cuDoubleComplex; incy: cint): cublasStatus_t {.
    cdecl, importc: "cublasZgemv_v2", dynlib: libName.}
proc cublasZgemv_v2_64*(handle: cublasHandle_t; trans: cublasOperation_t;
                       m: clonglong; n: clonglong; alpha: ptr cuDoubleComplex;
                       A: ptr cuDoubleComplex; lda: clonglong;
                       x: ptr cuDoubleComplex; incx: clonglong;
                       beta: ptr cuDoubleComplex; y: ptr cuDoubleComplex;
                       incy: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasZgemv_v2_64", dynlib: libName.}
##  GBMV

proc cublasSgbmv_v2*(handle: cublasHandle_t; trans: cublasOperation_t; m: cint;
                    n: cint; kl: cint; ku: cint; alpha: ptr cfloat; A: ptr cfloat;
                    lda: cint; x: ptr cfloat; incx: cint; beta: ptr cfloat; y: ptr cfloat;
                    incy: cint): cublasStatus_t {.cdecl, importc: "cublasSgbmv_v2",
    dynlib: libName.}
proc cublasSgbmv_v2_64*(handle: cublasHandle_t; trans: cublasOperation_t;
                       m: clonglong; n: clonglong; kl: clonglong; ku: clonglong;
                       alpha: ptr cfloat; A: ptr cfloat; lda: clonglong; x: ptr cfloat;
                       incx: clonglong; beta: ptr cfloat; y: ptr cfloat; incy: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasSgbmv_v2_64", dynlib: libName.}
proc cublasDgbmv_v2*(handle: cublasHandle_t; trans: cublasOperation_t; m: cint;
                    n: cint; kl: cint; ku: cint; alpha: ptr cdouble; A: ptr cdouble;
                    lda: cint; x: ptr cdouble; incx: cint; beta: ptr cdouble;
                    y: ptr cdouble; incy: cint): cublasStatus_t {.cdecl,
    importc: "cublasDgbmv_v2", dynlib: libName.}
proc cublasDgbmv_v2_64*(handle: cublasHandle_t; trans: cublasOperation_t;
                       m: clonglong; n: clonglong; kl: clonglong; ku: clonglong;
                       alpha: ptr cdouble; A: ptr cdouble; lda: clonglong;
                       x: ptr cdouble; incx: clonglong; beta: ptr cdouble;
                       y: ptr cdouble; incy: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasDgbmv_v2_64", dynlib: libName.}
proc cublasCgbmv_v2*(handle: cublasHandle_t; trans: cublasOperation_t; m: cint;
                    n: cint; kl: cint; ku: cint; alpha: ptr cuComplex; A: ptr cuComplex;
                    lda: cint; x: ptr cuComplex; incx: cint; beta: ptr cuComplex;
                    y: ptr cuComplex; incy: cint): cublasStatus_t {.cdecl,
    importc: "cublasCgbmv_v2", dynlib: libName.}
proc cublasCgbmv_v2_64*(handle: cublasHandle_t; trans: cublasOperation_t;
                       m: clonglong; n: clonglong; kl: clonglong; ku: clonglong;
                       alpha: ptr cuComplex; A: ptr cuComplex; lda: clonglong;
                       x: ptr cuComplex; incx: clonglong; beta: ptr cuComplex;
                       y: ptr cuComplex; incy: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasCgbmv_v2_64", dynlib: libName.}
proc cublasZgbmv_v2*(handle: cublasHandle_t; trans: cublasOperation_t; m: cint;
                    n: cint; kl: cint; ku: cint; alpha: ptr cuDoubleComplex;
                    A: ptr cuDoubleComplex; lda: cint; x: ptr cuDoubleComplex;
                    incx: cint; beta: ptr cuDoubleComplex; y: ptr cuDoubleComplex;
                    incy: cint): cublasStatus_t {.cdecl, importc: "cublasZgbmv_v2",
    dynlib: libName.}
proc cublasZgbmv_v2_64*(handle: cublasHandle_t; trans: cublasOperation_t;
                       m: clonglong; n: clonglong; kl: clonglong; ku: clonglong;
                       alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex;
                       lda: clonglong; x: ptr cuDoubleComplex; incx: clonglong;
                       beta: ptr cuDoubleComplex; y: ptr cuDoubleComplex;
                       incy: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasZgbmv_v2_64", dynlib: libName.}
##  TRMV

proc cublasStrmv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                    trans: cublasOperation_t; diag: cublasDiagType_t; n: cint;
                    A: ptr cfloat; lda: cint; x: ptr cfloat; incx: cint): cublasStatus_t {.
    cdecl, importc: "cublasStrmv_v2", dynlib: libName.}
proc cublasStrmv_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                       trans: cublasOperation_t; diag: cublasDiagType_t;
                       n: clonglong; A: ptr cfloat; lda: clonglong; x: ptr cfloat;
                       incx: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasStrmv_v2_64", dynlib: libName.}
proc cublasDtrmv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                    trans: cublasOperation_t; diag: cublasDiagType_t; n: cint;
                    A: ptr cdouble; lda: cint; x: ptr cdouble; incx: cint): cublasStatus_t {.
    cdecl, importc: "cublasDtrmv_v2", dynlib: libName.}
proc cublasDtrmv_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                       trans: cublasOperation_t; diag: cublasDiagType_t;
                       n: clonglong; A: ptr cdouble; lda: clonglong; x: ptr cdouble;
                       incx: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasDtrmv_v2_64", dynlib: libName.}
proc cublasCtrmv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                    trans: cublasOperation_t; diag: cublasDiagType_t; n: cint;
                    A: ptr cuComplex; lda: cint; x: ptr cuComplex; incx: cint): cublasStatus_t {.
    cdecl, importc: "cublasCtrmv_v2", dynlib: libName.}
proc cublasCtrmv_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                       trans: cublasOperation_t; diag: cublasDiagType_t;
                       n: clonglong; A: ptr cuComplex; lda: clonglong;
                       x: ptr cuComplex; incx: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasCtrmv_v2_64", dynlib: libName.}
proc cublasZtrmv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                    trans: cublasOperation_t; diag: cublasDiagType_t; n: cint;
                    A: ptr cuDoubleComplex; lda: cint; x: ptr cuDoubleComplex;
                    incx: cint): cublasStatus_t {.cdecl, importc: "cublasZtrmv_v2",
    dynlib: libName.}
proc cublasZtrmv_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                       trans: cublasOperation_t; diag: cublasDiagType_t;
                       n: clonglong; A: ptr cuDoubleComplex; lda: clonglong;
                       x: ptr cuDoubleComplex; incx: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasZtrmv_v2_64", dynlib: libName.}
##  TBMV

proc cublasStbmv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                    trans: cublasOperation_t; diag: cublasDiagType_t; n: cint;
                    k: cint; A: ptr cfloat; lda: cint; x: ptr cfloat; incx: cint): cublasStatus_t {.
    cdecl, importc: "cublasStbmv_v2", dynlib: libName.}
proc cublasStbmv_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                       trans: cublasOperation_t; diag: cublasDiagType_t;
                       n: clonglong; k: clonglong; A: ptr cfloat; lda: clonglong;
                       x: ptr cfloat; incx: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasStbmv_v2_64", dynlib: libName.}
proc cublasDtbmv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                    trans: cublasOperation_t; diag: cublasDiagType_t; n: cint;
                    k: cint; A: ptr cdouble; lda: cint; x: ptr cdouble; incx: cint): cublasStatus_t {.
    cdecl, importc: "cublasDtbmv_v2", dynlib: libName.}
proc cublasDtbmv_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                       trans: cublasOperation_t; diag: cublasDiagType_t;
                       n: clonglong; k: clonglong; A: ptr cdouble; lda: clonglong;
                       x: ptr cdouble; incx: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasDtbmv_v2_64", dynlib: libName.}
proc cublasCtbmv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                    trans: cublasOperation_t; diag: cublasDiagType_t; n: cint;
                    k: cint; A: ptr cuComplex; lda: cint; x: ptr cuComplex; incx: cint): cublasStatus_t {.
    cdecl, importc: "cublasCtbmv_v2", dynlib: libName.}
proc cublasCtbmv_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                       trans: cublasOperation_t; diag: cublasDiagType_t;
                       n: clonglong; k: clonglong; A: ptr cuComplex; lda: clonglong;
                       x: ptr cuComplex; incx: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasCtbmv_v2_64", dynlib: libName.}
proc cublasZtbmv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                    trans: cublasOperation_t; diag: cublasDiagType_t; n: cint;
                    k: cint; A: ptr cuDoubleComplex; lda: cint; x: ptr cuDoubleComplex;
                    incx: cint): cublasStatus_t {.cdecl, importc: "cublasZtbmv_v2",
    dynlib: libName.}
proc cublasZtbmv_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                       trans: cublasOperation_t; diag: cublasDiagType_t;
                       n: clonglong; k: clonglong; A: ptr cuDoubleComplex;
                       lda: clonglong; x: ptr cuDoubleComplex; incx: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasZtbmv_v2_64", dynlib: libName.}
##  TPMV

proc cublasStpmv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                    trans: cublasOperation_t; diag: cublasDiagType_t; n: cint;
                    AP: ptr cfloat; x: ptr cfloat; incx: cint): cublasStatus_t {.cdecl,
    importc: "cublasStpmv_v2", dynlib: libName.}
proc cublasStpmv_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                       trans: cublasOperation_t; diag: cublasDiagType_t;
                       n: clonglong; AP: ptr cfloat; x: ptr cfloat; incx: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasStpmv_v2_64", dynlib: libName.}
proc cublasDtpmv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                    trans: cublasOperation_t; diag: cublasDiagType_t; n: cint;
                    AP: ptr cdouble; x: ptr cdouble; incx: cint): cublasStatus_t {.cdecl,
    importc: "cublasDtpmv_v2", dynlib: libName.}
proc cublasDtpmv_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                       trans: cublasOperation_t; diag: cublasDiagType_t;
                       n: clonglong; AP: ptr cdouble; x: ptr cdouble; incx: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasDtpmv_v2_64", dynlib: libName.}
proc cublasCtpmv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                    trans: cublasOperation_t; diag: cublasDiagType_t; n: cint;
                    AP: ptr cuComplex; x: ptr cuComplex; incx: cint): cublasStatus_t {.
    cdecl, importc: "cublasCtpmv_v2", dynlib: libName.}
proc cublasCtpmv_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                       trans: cublasOperation_t; diag: cublasDiagType_t;
                       n: clonglong; AP: ptr cuComplex; x: ptr cuComplex;
                       incx: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasCtpmv_v2_64", dynlib: libName.}
proc cublasZtpmv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                    trans: cublasOperation_t; diag: cublasDiagType_t; n: cint;
                    AP: ptr cuDoubleComplex; x: ptr cuDoubleComplex; incx: cint): cublasStatus_t {.
    cdecl, importc: "cublasZtpmv_v2", dynlib: libName.}
proc cublasZtpmv_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                       trans: cublasOperation_t; diag: cublasDiagType_t;
                       n: clonglong; AP: ptr cuDoubleComplex; x: ptr cuDoubleComplex;
                       incx: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasZtpmv_v2_64", dynlib: libName.}
##  TRSV

proc cublasStrsv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                    trans: cublasOperation_t; diag: cublasDiagType_t; n: cint;
                    A: ptr cfloat; lda: cint; x: ptr cfloat; incx: cint): cublasStatus_t {.
    cdecl, importc: "cublasStrsv_v2", dynlib: libName.}
proc cublasStrsv_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                       trans: cublasOperation_t; diag: cublasDiagType_t;
                       n: clonglong; A: ptr cfloat; lda: clonglong; x: ptr cfloat;
                       incx: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasStrsv_v2_64", dynlib: libName.}
proc cublasDtrsv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                    trans: cublasOperation_t; diag: cublasDiagType_t; n: cint;
                    A: ptr cdouble; lda: cint; x: ptr cdouble; incx: cint): cublasStatus_t {.
    cdecl, importc: "cublasDtrsv_v2", dynlib: libName.}
proc cublasDtrsv_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                       trans: cublasOperation_t; diag: cublasDiagType_t;
                       n: clonglong; A: ptr cdouble; lda: clonglong; x: ptr cdouble;
                       incx: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasDtrsv_v2_64", dynlib: libName.}
proc cublasCtrsv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                    trans: cublasOperation_t; diag: cublasDiagType_t; n: cint;
                    A: ptr cuComplex; lda: cint; x: ptr cuComplex; incx: cint): cublasStatus_t {.
    cdecl, importc: "cublasCtrsv_v2", dynlib: libName.}
proc cublasCtrsv_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                       trans: cublasOperation_t; diag: cublasDiagType_t;
                       n: clonglong; A: ptr cuComplex; lda: clonglong;
                       x: ptr cuComplex; incx: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasCtrsv_v2_64", dynlib: libName.}
proc cublasZtrsv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                    trans: cublasOperation_t; diag: cublasDiagType_t; n: cint;
                    A: ptr cuDoubleComplex; lda: cint; x: ptr cuDoubleComplex;
                    incx: cint): cublasStatus_t {.cdecl, importc: "cublasZtrsv_v2",
    dynlib: libName.}
proc cublasZtrsv_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                       trans: cublasOperation_t; diag: cublasDiagType_t;
                       n: clonglong; A: ptr cuDoubleComplex; lda: clonglong;
                       x: ptr cuDoubleComplex; incx: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasZtrsv_v2_64", dynlib: libName.}
##  TPSV

proc cublasStpsv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                    trans: cublasOperation_t; diag: cublasDiagType_t; n: cint;
                    AP: ptr cfloat; x: ptr cfloat; incx: cint): cublasStatus_t {.cdecl,
    importc: "cublasStpsv_v2", dynlib: libName.}
proc cublasStpsv_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                       trans: cublasOperation_t; diag: cublasDiagType_t;
                       n: clonglong; AP: ptr cfloat; x: ptr cfloat; incx: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasStpsv_v2_64", dynlib: libName.}
proc cublasDtpsv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                    trans: cublasOperation_t; diag: cublasDiagType_t; n: cint;
                    AP: ptr cdouble; x: ptr cdouble; incx: cint): cublasStatus_t {.cdecl,
    importc: "cublasDtpsv_v2", dynlib: libName.}
proc cublasDtpsv_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                       trans: cublasOperation_t; diag: cublasDiagType_t;
                       n: clonglong; AP: ptr cdouble; x: ptr cdouble; incx: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasDtpsv_v2_64", dynlib: libName.}
proc cublasCtpsv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                    trans: cublasOperation_t; diag: cublasDiagType_t; n: cint;
                    AP: ptr cuComplex; x: ptr cuComplex; incx: cint): cublasStatus_t {.
    cdecl, importc: "cublasCtpsv_v2", dynlib: libName.}
proc cublasCtpsv_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                       trans: cublasOperation_t; diag: cublasDiagType_t;
                       n: clonglong; AP: ptr cuComplex; x: ptr cuComplex;
                       incx: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasCtpsv_v2_64", dynlib: libName.}
proc cublasZtpsv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                    trans: cublasOperation_t; diag: cublasDiagType_t; n: cint;
                    AP: ptr cuDoubleComplex; x: ptr cuDoubleComplex; incx: cint): cublasStatus_t {.
    cdecl, importc: "cublasZtpsv_v2", dynlib: libName.}
proc cublasZtpsv_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                       trans: cublasOperation_t; diag: cublasDiagType_t;
                       n: clonglong; AP: ptr cuDoubleComplex; x: ptr cuDoubleComplex;
                       incx: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasZtpsv_v2_64", dynlib: libName.}
##  TBSV

proc cublasStbsv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                    trans: cublasOperation_t; diag: cublasDiagType_t; n: cint;
                    k: cint; A: ptr cfloat; lda: cint; x: ptr cfloat; incx: cint): cublasStatus_t {.
    cdecl, importc: "cublasStbsv_v2", dynlib: libName.}
proc cublasStbsv_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                       trans: cublasOperation_t; diag: cublasDiagType_t;
                       n: clonglong; k: clonglong; A: ptr cfloat; lda: clonglong;
                       x: ptr cfloat; incx: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasStbsv_v2_64", dynlib: libName.}
proc cublasDtbsv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                    trans: cublasOperation_t; diag: cublasDiagType_t; n: cint;
                    k: cint; A: ptr cdouble; lda: cint; x: ptr cdouble; incx: cint): cublasStatus_t {.
    cdecl, importc: "cublasDtbsv_v2", dynlib: libName.}
proc cublasDtbsv_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                       trans: cublasOperation_t; diag: cublasDiagType_t;
                       n: clonglong; k: clonglong; A: ptr cdouble; lda: clonglong;
                       x: ptr cdouble; incx: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasDtbsv_v2_64", dynlib: libName.}
proc cublasCtbsv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                    trans: cublasOperation_t; diag: cublasDiagType_t; n: cint;
                    k: cint; A: ptr cuComplex; lda: cint; x: ptr cuComplex; incx: cint): cublasStatus_t {.
    cdecl, importc: "cublasCtbsv_v2", dynlib: libName.}
proc cublasCtbsv_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                       trans: cublasOperation_t; diag: cublasDiagType_t;
                       n: clonglong; k: clonglong; A: ptr cuComplex; lda: clonglong;
                       x: ptr cuComplex; incx: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasCtbsv_v2_64", dynlib: libName.}
proc cublasZtbsv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                    trans: cublasOperation_t; diag: cublasDiagType_t; n: cint;
                    k: cint; A: ptr cuDoubleComplex; lda: cint; x: ptr cuDoubleComplex;
                    incx: cint): cublasStatus_t {.cdecl, importc: "cublasZtbsv_v2",
    dynlib: libName.}
proc cublasZtbsv_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                       trans: cublasOperation_t; diag: cublasDiagType_t;
                       n: clonglong; k: clonglong; A: ptr cuDoubleComplex;
                       lda: clonglong; x: ptr cuDoubleComplex; incx: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasZtbsv_v2_64", dynlib: libName.}
##  SYMV/HEMV

proc cublasSsymv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                    alpha: ptr cfloat; A: ptr cfloat; lda: cint; x: ptr cfloat; incx: cint;
                    beta: ptr cfloat; y: ptr cfloat; incy: cint): cublasStatus_t {.cdecl,
    importc: "cublasSsymv_v2", dynlib: libName.}
proc cublasSsymv_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: clonglong;
                       alpha: ptr cfloat; A: ptr cfloat; lda: clonglong; x: ptr cfloat;
                       incx: clonglong; beta: ptr cfloat; y: ptr cfloat; incy: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasSsymv_v2_64", dynlib: libName.}
proc cublasDsymv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                    alpha: ptr cdouble; A: ptr cdouble; lda: cint; x: ptr cdouble;
                    incx: cint; beta: ptr cdouble; y: ptr cdouble; incy: cint): cublasStatus_t {.
    cdecl, importc: "cublasDsymv_v2", dynlib: libName.}
proc cublasDsymv_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: clonglong;
                       alpha: ptr cdouble; A: ptr cdouble; lda: clonglong;
                       x: ptr cdouble; incx: clonglong; beta: ptr cdouble;
                       y: ptr cdouble; incy: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasDsymv_v2_64", dynlib: libName.}
proc cublasCsymv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                    alpha: ptr cuComplex; A: ptr cuComplex; lda: cint; x: ptr cuComplex;
                    incx: cint; beta: ptr cuComplex; y: ptr cuComplex; incy: cint): cublasStatus_t {.
    cdecl, importc: "cublasCsymv_v2", dynlib: libName.}
proc cublasCsymv_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: clonglong;
                       alpha: ptr cuComplex; A: ptr cuComplex; lda: clonglong;
                       x: ptr cuComplex; incx: clonglong; beta: ptr cuComplex;
                       y: ptr cuComplex; incy: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasCsymv_v2_64", dynlib: libName.}
proc cublasZsymv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                    alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex; lda: cint;
                    x: ptr cuDoubleComplex; incx: cint; beta: ptr cuDoubleComplex;
                    y: ptr cuDoubleComplex; incy: cint): cublasStatus_t {.cdecl,
    importc: "cublasZsymv_v2", dynlib: libName.}
proc cublasZsymv_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: clonglong;
                       alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex;
                       lda: clonglong; x: ptr cuDoubleComplex; incx: clonglong;
                       beta: ptr cuDoubleComplex; y: ptr cuDoubleComplex;
                       incy: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasZsymv_v2_64", dynlib: libName.}
proc cublasChemv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                    alpha: ptr cuComplex; A: ptr cuComplex; lda: cint; x: ptr cuComplex;
                    incx: cint; beta: ptr cuComplex; y: ptr cuComplex; incy: cint): cublasStatus_t {.
    cdecl, importc: "cublasChemv_v2", dynlib: libName.}
proc cublasChemv_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: clonglong;
                       alpha: ptr cuComplex; A: ptr cuComplex; lda: clonglong;
                       x: ptr cuComplex; incx: clonglong; beta: ptr cuComplex;
                       y: ptr cuComplex; incy: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasChemv_v2_64", dynlib: libName.}
proc cublasZhemv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                    alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex; lda: cint;
                    x: ptr cuDoubleComplex; incx: cint; beta: ptr cuDoubleComplex;
                    y: ptr cuDoubleComplex; incy: cint): cublasStatus_t {.cdecl,
    importc: "cublasZhemv_v2", dynlib: libName.}
proc cublasZhemv_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: clonglong;
                       alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex;
                       lda: clonglong; x: ptr cuDoubleComplex; incx: clonglong;
                       beta: ptr cuDoubleComplex; y: ptr cuDoubleComplex;
                       incy: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasZhemv_v2_64", dynlib: libName.}
##  SBMV/HBMV

proc cublasSsbmv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint; k: cint;
                    alpha: ptr cfloat; A: ptr cfloat; lda: cint; x: ptr cfloat; incx: cint;
                    beta: ptr cfloat; y: ptr cfloat; incy: cint): cublasStatus_t {.cdecl,
    importc: "cublasSsbmv_v2", dynlib: libName.}
proc cublasSsbmv_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: clonglong;
                       k: clonglong; alpha: ptr cfloat; A: ptr cfloat; lda: clonglong;
                       x: ptr cfloat; incx: clonglong; beta: ptr cfloat; y: ptr cfloat;
                       incy: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasSsbmv_v2_64", dynlib: libName.}
proc cublasDsbmv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint; k: cint;
                    alpha: ptr cdouble; A: ptr cdouble; lda: cint; x: ptr cdouble;
                    incx: cint; beta: ptr cdouble; y: ptr cdouble; incy: cint): cublasStatus_t {.
    cdecl, importc: "cublasDsbmv_v2", dynlib: libName.}
proc cublasDsbmv_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: clonglong;
                       k: clonglong; alpha: ptr cdouble; A: ptr cdouble; lda: clonglong;
                       x: ptr cdouble; incx: clonglong; beta: ptr cdouble;
                       y: ptr cdouble; incy: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasDsbmv_v2_64", dynlib: libName.}
proc cublasChbmv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint; k: cint;
                    alpha: ptr cuComplex; A: ptr cuComplex; lda: cint; x: ptr cuComplex;
                    incx: cint; beta: ptr cuComplex; y: ptr cuComplex; incy: cint): cublasStatus_t {.
    cdecl, importc: "cublasChbmv_v2", dynlib: libName.}
proc cublasChbmv_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: clonglong;
                       k: clonglong; alpha: ptr cuComplex; A: ptr cuComplex;
                       lda: clonglong; x: ptr cuComplex; incx: clonglong;
                       beta: ptr cuComplex; y: ptr cuComplex; incy: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasChbmv_v2_64", dynlib: libName.}
proc cublasZhbmv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint; k: cint;
                    alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex; lda: cint;
                    x: ptr cuDoubleComplex; incx: cint; beta: ptr cuDoubleComplex;
                    y: ptr cuDoubleComplex; incy: cint): cublasStatus_t {.cdecl,
    importc: "cublasZhbmv_v2", dynlib: libName.}
proc cublasZhbmv_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: clonglong;
                       k: clonglong; alpha: ptr cuDoubleComplex;
                       A: ptr cuDoubleComplex; lda: clonglong;
                       x: ptr cuDoubleComplex; incx: clonglong;
                       beta: ptr cuDoubleComplex; y: ptr cuDoubleComplex;
                       incy: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasZhbmv_v2_64", dynlib: libName.}
##  SPMV/HPMV

proc cublasSspmv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                    alpha: ptr cfloat; AP: ptr cfloat; x: ptr cfloat; incx: cint;
                    beta: ptr cfloat; y: ptr cfloat; incy: cint): cublasStatus_t {.cdecl,
    importc: "cublasSspmv_v2", dynlib: libName.}
proc cublasSspmv_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: clonglong;
                       alpha: ptr cfloat; AP: ptr cfloat; x: ptr cfloat; incx: clonglong;
                       beta: ptr cfloat; y: ptr cfloat; incy: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasSspmv_v2_64", dynlib: libName.}
proc cublasDspmv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                    alpha: ptr cdouble; AP: ptr cdouble; x: ptr cdouble; incx: cint;
                    beta: ptr cdouble; y: ptr cdouble; incy: cint): cublasStatus_t {.
    cdecl, importc: "cublasDspmv_v2", dynlib: libName.}
proc cublasDspmv_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: clonglong;
                       alpha: ptr cdouble; AP: ptr cdouble; x: ptr cdouble;
                       incx: clonglong; beta: ptr cdouble; y: ptr cdouble;
                       incy: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasDspmv_v2_64", dynlib: libName.}
proc cublasChpmv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                    alpha: ptr cuComplex; AP: ptr cuComplex; x: ptr cuComplex;
                    incx: cint; beta: ptr cuComplex; y: ptr cuComplex; incy: cint): cublasStatus_t {.
    cdecl, importc: "cublasChpmv_v2", dynlib: libName.}
proc cublasChpmv_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: clonglong;
                       alpha: ptr cuComplex; AP: ptr cuComplex; x: ptr cuComplex;
                       incx: clonglong; beta: ptr cuComplex; y: ptr cuComplex;
                       incy: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasChpmv_v2_64", dynlib: libName.}
proc cublasZhpmv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                    alpha: ptr cuDoubleComplex; AP: ptr cuDoubleComplex;
                    x: ptr cuDoubleComplex; incx: cint; beta: ptr cuDoubleComplex;
                    y: ptr cuDoubleComplex; incy: cint): cublasStatus_t {.cdecl,
    importc: "cublasZhpmv_v2", dynlib: libName.}
proc cublasZhpmv_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: clonglong;
                       alpha: ptr cuDoubleComplex; AP: ptr cuDoubleComplex;
                       x: ptr cuDoubleComplex; incx: clonglong;
                       beta: ptr cuDoubleComplex; y: ptr cuDoubleComplex;
                       incy: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasZhpmv_v2_64", dynlib: libName.}
##  GER

proc cublasSger_v2*(handle: cublasHandle_t; m: cint; n: cint; alpha: ptr cfloat;
                   x: ptr cfloat; incx: cint; y: ptr cfloat; incy: cint; A: ptr cfloat;
                   lda: cint): cublasStatus_t {.cdecl, importc: "cublasSger_v2",
    dynlib: libName.}
proc cublasSger_v2_64*(handle: cublasHandle_t; m: clonglong; n: clonglong;
                      alpha: ptr cfloat; x: ptr cfloat; incx: clonglong; y: ptr cfloat;
                      incy: clonglong; A: ptr cfloat; lda: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasSger_v2_64", dynlib: libName.}
proc cublasDger_v2*(handle: cublasHandle_t; m: cint; n: cint; alpha: ptr cdouble;
                   x: ptr cdouble; incx: cint; y: ptr cdouble; incy: cint; A: ptr cdouble;
                   lda: cint): cublasStatus_t {.cdecl, importc: "cublasDger_v2",
    dynlib: libName.}
proc cublasDger_v2_64*(handle: cublasHandle_t; m: clonglong; n: clonglong;
                      alpha: ptr cdouble; x: ptr cdouble; incx: clonglong;
                      y: ptr cdouble; incy: clonglong; A: ptr cdouble; lda: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasDger_v2_64", dynlib: libName.}
proc cublasCgeru_v2*(handle: cublasHandle_t; m: cint; n: cint; alpha: ptr cuComplex;
                    x: ptr cuComplex; incx: cint; y: ptr cuComplex; incy: cint;
                    A: ptr cuComplex; lda: cint): cublasStatus_t {.cdecl,
    importc: "cublasCgeru_v2", dynlib: libName.}
proc cublasCgeru_v2_64*(handle: cublasHandle_t; m: clonglong; n: clonglong;
                       alpha: ptr cuComplex; x: ptr cuComplex; incx: clonglong;
                       y: ptr cuComplex; incy: clonglong; A: ptr cuComplex;
                       lda: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasCgeru_v2_64", dynlib: libName.}
proc cublasCgerc_v2*(handle: cublasHandle_t; m: cint; n: cint; alpha: ptr cuComplex;
                    x: ptr cuComplex; incx: cint; y: ptr cuComplex; incy: cint;
                    A: ptr cuComplex; lda: cint): cublasStatus_t {.cdecl,
    importc: "cublasCgerc_v2", dynlib: libName.}
proc cublasCgerc_v2_64*(handle: cublasHandle_t; m: clonglong; n: clonglong;
                       alpha: ptr cuComplex; x: ptr cuComplex; incx: clonglong;
                       y: ptr cuComplex; incy: clonglong; A: ptr cuComplex;
                       lda: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasCgerc_v2_64", dynlib: libName.}
proc cublasZgeru_v2*(handle: cublasHandle_t; m: cint; n: cint;
                    alpha: ptr cuDoubleComplex; x: ptr cuDoubleComplex; incx: cint;
                    y: ptr cuDoubleComplex; incy: cint; A: ptr cuDoubleComplex;
                    lda: cint): cublasStatus_t {.cdecl, importc: "cublasZgeru_v2",
    dynlib: libName.}
proc cublasZgeru_v2_64*(handle: cublasHandle_t; m: clonglong; n: clonglong;
                       alpha: ptr cuDoubleComplex; x: ptr cuDoubleComplex;
                       incx: clonglong; y: ptr cuDoubleComplex; incy: clonglong;
                       A: ptr cuDoubleComplex; lda: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasZgeru_v2_64", dynlib: libName.}
proc cublasZgerc_v2*(handle: cublasHandle_t; m: cint; n: cint;
                    alpha: ptr cuDoubleComplex; x: ptr cuDoubleComplex; incx: cint;
                    y: ptr cuDoubleComplex; incy: cint; A: ptr cuDoubleComplex;
                    lda: cint): cublasStatus_t {.cdecl, importc: "cublasZgerc_v2",
    dynlib: libName.}
proc cublasZgerc_v2_64*(handle: cublasHandle_t; m: clonglong; n: clonglong;
                       alpha: ptr cuDoubleComplex; x: ptr cuDoubleComplex;
                       incx: clonglong; y: ptr cuDoubleComplex; incy: clonglong;
                       A: ptr cuDoubleComplex; lda: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasZgerc_v2_64", dynlib: libName.}
##  SYR/HER

proc cublasSsyr_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                   alpha: ptr cfloat; x: ptr cfloat; incx: cint; A: ptr cfloat; lda: cint): cublasStatus_t {.
    cdecl, importc: "cublasSsyr_v2", dynlib: libName.}
proc cublasSsyr_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: clonglong;
                      alpha: ptr cfloat; x: ptr cfloat; incx: clonglong; A: ptr cfloat;
                      lda: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasSsyr_v2_64", dynlib: libName.}
proc cublasDsyr_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                   alpha: ptr cdouble; x: ptr cdouble; incx: cint; A: ptr cdouble;
                   lda: cint): cublasStatus_t {.cdecl, importc: "cublasDsyr_v2",
    dynlib: libName.}
proc cublasDsyr_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: clonglong;
                      alpha: ptr cdouble; x: ptr cdouble; incx: clonglong;
                      A: ptr cdouble; lda: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasDsyr_v2_64", dynlib: libName.}
proc cublasCsyr_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                   alpha: ptr cuComplex; x: ptr cuComplex; incx: cint; A: ptr cuComplex;
                   lda: cint): cublasStatus_t {.cdecl, importc: "cublasCsyr_v2",
    dynlib: libName.}
proc cublasCsyr_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: clonglong;
                      alpha: ptr cuComplex; x: ptr cuComplex; incx: clonglong;
                      A: ptr cuComplex; lda: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasCsyr_v2_64", dynlib: libName.}
proc cublasZsyr_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                   alpha: ptr cuDoubleComplex; x: ptr cuDoubleComplex; incx: cint;
                   A: ptr cuDoubleComplex; lda: cint): cublasStatus_t {.cdecl,
    importc: "cublasZsyr_v2", dynlib: libName.}
proc cublasZsyr_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: clonglong;
                      alpha: ptr cuDoubleComplex; x: ptr cuDoubleComplex;
                      incx: clonglong; A: ptr cuDoubleComplex; lda: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasZsyr_v2_64", dynlib: libName.}
proc cublasCher_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                   alpha: ptr cfloat; x: ptr cuComplex; incx: cint; A: ptr cuComplex;
                   lda: cint): cublasStatus_t {.cdecl, importc: "cublasCher_v2",
    dynlib: libName.}
proc cublasCher_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: clonglong;
                      alpha: ptr cfloat; x: ptr cuComplex; incx: clonglong;
                      A: ptr cuComplex; lda: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasCher_v2_64", dynlib: libName.}
proc cublasZher_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                   alpha: ptr cdouble; x: ptr cuDoubleComplex; incx: cint;
                   A: ptr cuDoubleComplex; lda: cint): cublasStatus_t {.cdecl,
    importc: "cublasZher_v2", dynlib: libName.}
proc cublasZher_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: clonglong;
                      alpha: ptr cdouble; x: ptr cuDoubleComplex; incx: clonglong;
                      A: ptr cuDoubleComplex; lda: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasZher_v2_64", dynlib: libName.}
##  SPR/HPR

proc cublasSspr_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                   alpha: ptr cfloat; x: ptr cfloat; incx: cint; AP: ptr cfloat): cublasStatus_t {.
    cdecl, importc: "cublasSspr_v2", dynlib: libName.}
proc cublasSspr_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: clonglong;
                      alpha: ptr cfloat; x: ptr cfloat; incx: clonglong; AP: ptr cfloat): cublasStatus_t {.
    cdecl, importc: "cublasSspr_v2_64", dynlib: libName.}
proc cublasDspr_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                   alpha: ptr cdouble; x: ptr cdouble; incx: cint; AP: ptr cdouble): cublasStatus_t {.
    cdecl, importc: "cublasDspr_v2", dynlib: libName.}
proc cublasDspr_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: clonglong;
                      alpha: ptr cdouble; x: ptr cdouble; incx: clonglong;
                      AP: ptr cdouble): cublasStatus_t {.cdecl,
    importc: "cublasDspr_v2_64", dynlib: libName.}
proc cublasChpr_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                   alpha: ptr cfloat; x: ptr cuComplex; incx: cint; AP: ptr cuComplex): cublasStatus_t {.
    cdecl, importc: "cublasChpr_v2", dynlib: libName.}
proc cublasChpr_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: clonglong;
                      alpha: ptr cfloat; x: ptr cuComplex; incx: clonglong;
                      AP: ptr cuComplex): cublasStatus_t {.cdecl,
    importc: "cublasChpr_v2_64", dynlib: libName.}
proc cublasZhpr_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                   alpha: ptr cdouble; x: ptr cuDoubleComplex; incx: cint;
                   AP: ptr cuDoubleComplex): cublasStatus_t {.cdecl,
    importc: "cublasZhpr_v2", dynlib: libName.}
proc cublasZhpr_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: clonglong;
                      alpha: ptr cdouble; x: ptr cuDoubleComplex; incx: clonglong;
                      AP: ptr cuDoubleComplex): cublasStatus_t {.cdecl,
    importc: "cublasZhpr_v2_64", dynlib: libName.}
##  SYR2/HER2

proc cublasSsyr2_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                    alpha: ptr cfloat; x: ptr cfloat; incx: cint; y: ptr cfloat;
                    incy: cint; A: ptr cfloat; lda: cint): cublasStatus_t {.cdecl,
    importc: "cublasSsyr2_v2", dynlib: libName.}
proc cublasSsyr2_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: clonglong;
                       alpha: ptr cfloat; x: ptr cfloat; incx: clonglong; y: ptr cfloat;
                       incy: clonglong; A: ptr cfloat; lda: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasSsyr2_v2_64", dynlib: libName.}
proc cublasDsyr2_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                    alpha: ptr cdouble; x: ptr cdouble; incx: cint; y: ptr cdouble;
                    incy: cint; A: ptr cdouble; lda: cint): cublasStatus_t {.cdecl,
    importc: "cublasDsyr2_v2", dynlib: libName.}
proc cublasDsyr2_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: clonglong;
                       alpha: ptr cdouble; x: ptr cdouble; incx: clonglong;
                       y: ptr cdouble; incy: clonglong; A: ptr cdouble; lda: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasDsyr2_v2_64", dynlib: libName.}
proc cublasCsyr2_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                    alpha: ptr cuComplex; x: ptr cuComplex; incx: cint;
                    y: ptr cuComplex; incy: cint; A: ptr cuComplex; lda: cint): cublasStatus_t {.
    cdecl, importc: "cublasCsyr2_v2", dynlib: libName.}
proc cublasCsyr2_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: clonglong;
                       alpha: ptr cuComplex; x: ptr cuComplex; incx: clonglong;
                       y: ptr cuComplex; incy: clonglong; A: ptr cuComplex;
                       lda: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasCsyr2_v2_64", dynlib: libName.}
proc cublasZsyr2_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                    alpha: ptr cuDoubleComplex; x: ptr cuDoubleComplex; incx: cint;
                    y: ptr cuDoubleComplex; incy: cint; A: ptr cuDoubleComplex;
                    lda: cint): cublasStatus_t {.cdecl, importc: "cublasZsyr2_v2",
    dynlib: libName.}
proc cublasZsyr2_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: clonglong;
                       alpha: ptr cuDoubleComplex; x: ptr cuDoubleComplex;
                       incx: clonglong; y: ptr cuDoubleComplex; incy: clonglong;
                       A: ptr cuDoubleComplex; lda: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasZsyr2_v2_64", dynlib: libName.}
proc cublasCher2_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                    alpha: ptr cuComplex; x: ptr cuComplex; incx: cint;
                    y: ptr cuComplex; incy: cint; A: ptr cuComplex; lda: cint): cublasStatus_t {.
    cdecl, importc: "cublasCher2_v2", dynlib: libName.}
proc cublasCher2_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: clonglong;
                       alpha: ptr cuComplex; x: ptr cuComplex; incx: clonglong;
                       y: ptr cuComplex; incy: clonglong; A: ptr cuComplex;
                       lda: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasCher2_v2_64", dynlib: libName.}
proc cublasZher2_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                    alpha: ptr cuDoubleComplex; x: ptr cuDoubleComplex; incx: cint;
                    y: ptr cuDoubleComplex; incy: cint; A: ptr cuDoubleComplex;
                    lda: cint): cublasStatus_t {.cdecl, importc: "cublasZher2_v2",
    dynlib: libName.}
proc cublasZher2_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: clonglong;
                       alpha: ptr cuDoubleComplex; x: ptr cuDoubleComplex;
                       incx: clonglong; y: ptr cuDoubleComplex; incy: clonglong;
                       A: ptr cuDoubleComplex; lda: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasZher2_v2_64", dynlib: libName.}
##  SPR2/HPR2

proc cublasSspr2_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                    alpha: ptr cfloat; x: ptr cfloat; incx: cint; y: ptr cfloat;
                    incy: cint; AP: ptr cfloat): cublasStatus_t {.cdecl,
    importc: "cublasSspr2_v2", dynlib: libName.}
proc cublasSspr2_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: clonglong;
                       alpha: ptr cfloat; x: ptr cfloat; incx: clonglong; y: ptr cfloat;
                       incy: clonglong; AP: ptr cfloat): cublasStatus_t {.cdecl,
    importc: "cublasSspr2_v2_64", dynlib: libName.}
proc cublasDspr2_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                    alpha: ptr cdouble; x: ptr cdouble; incx: cint; y: ptr cdouble;
                    incy: cint; AP: ptr cdouble): cublasStatus_t {.cdecl,
    importc: "cublasDspr2_v2", dynlib: libName.}
proc cublasDspr2_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: clonglong;
                       alpha: ptr cdouble; x: ptr cdouble; incx: clonglong;
                       y: ptr cdouble; incy: clonglong; AP: ptr cdouble): cublasStatus_t {.
    cdecl, importc: "cublasDspr2_v2_64", dynlib: libName.}
proc cublasChpr2_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                    alpha: ptr cuComplex; x: ptr cuComplex; incx: cint;
                    y: ptr cuComplex; incy: cint; AP: ptr cuComplex): cublasStatus_t {.
    cdecl, importc: "cublasChpr2_v2", dynlib: libName.}
proc cublasChpr2_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: clonglong;
                       alpha: ptr cuComplex; x: ptr cuComplex; incx: clonglong;
                       y: ptr cuComplex; incy: clonglong; AP: ptr cuComplex): cublasStatus_t {.
    cdecl, importc: "cublasChpr2_v2_64", dynlib: libName.}
proc cublasZhpr2_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                    alpha: ptr cuDoubleComplex; x: ptr cuDoubleComplex; incx: cint;
                    y: ptr cuDoubleComplex; incy: cint; AP: ptr cuDoubleComplex): cublasStatus_t {.
    cdecl, importc: "cublasZhpr2_v2", dynlib: libName.}
proc cublasZhpr2_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: clonglong;
                       alpha: ptr cuDoubleComplex; x: ptr cuDoubleComplex;
                       incx: clonglong; y: ptr cuDoubleComplex; incy: clonglong;
                       AP: ptr cuDoubleComplex): cublasStatus_t {.cdecl,
    importc: "cublasZhpr2_v2_64", dynlib: libName.}
##  BATCH GEMV

proc cublasSgemvBatched*(handle: cublasHandle_t; trans: cublasOperation_t; m: cint;
                        n: cint; alpha: ptr cfloat; Aarray: ptr ptr cfloat; lda: cint;
                        xarray: ptr ptr cfloat; incx: cint; beta: ptr cfloat;
                        yarray: ptr ptr cfloat; incy: cint; batchCount: cint): cublasStatus_t {.
    cdecl, importc: "cublasSgemvBatched", dynlib: libName.}
proc cublasSgemvBatched_64*(handle: cublasHandle_t; trans: cublasOperation_t;
                           m: clonglong; n: clonglong; alpha: ptr cfloat;
                           Aarray: ptr ptr cfloat; lda: clonglong;
                           xarray: ptr ptr cfloat; incx: clonglong; beta: ptr cfloat;
                           yarray: ptr ptr cfloat; incy: clonglong;
                           batchCount: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasSgemvBatched_64", dynlib: libName.}
proc cublasDgemvBatched*(handle: cublasHandle_t; trans: cublasOperation_t; m: cint;
                        n: cint; alpha: ptr cdouble; Aarray: ptr ptr cdouble; lda: cint;
                        xarray: ptr ptr cdouble; incx: cint; beta: ptr cdouble;
                        yarray: ptr ptr cdouble; incy: cint; batchCount: cint): cublasStatus_t {.
    cdecl, importc: "cublasDgemvBatched", dynlib: libName.}
proc cublasDgemvBatched_64*(handle: cublasHandle_t; trans: cublasOperation_t;
                           m: clonglong; n: clonglong; alpha: ptr cdouble;
                           Aarray: ptr ptr cdouble; lda: clonglong;
                           xarray: ptr ptr cdouble; incx: clonglong;
                           beta: ptr cdouble; yarray: ptr ptr cdouble; incy: clonglong;
                           batchCount: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasDgemvBatched_64", dynlib: libName.}
proc cublasCgemvBatched*(handle: cublasHandle_t; trans: cublasOperation_t; m: cint;
                        n: cint; alpha: ptr cuComplex; Aarray: ptr ptr cuComplex;
                        lda: cint; xarray: ptr ptr cuComplex; incx: cint;
                        beta: ptr cuComplex; yarray: ptr ptr cuComplex; incy: cint;
                        batchCount: cint): cublasStatus_t {.cdecl,
    importc: "cublasCgemvBatched", dynlib: libName.}
proc cublasCgemvBatched_64*(handle: cublasHandle_t; trans: cublasOperation_t;
                           m: clonglong; n: clonglong; alpha: ptr cuComplex;
                           Aarray: ptr ptr cuComplex; lda: clonglong;
                           xarray: ptr ptr cuComplex; incx: clonglong;
                           beta: ptr cuComplex; yarray: ptr ptr cuComplex;
                           incy: clonglong; batchCount: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasCgemvBatched_64", dynlib: libName.}
proc cublasZgemvBatched*(handle: cublasHandle_t; trans: cublasOperation_t; m: cint;
                        n: cint; alpha: ptr cuDoubleComplex;
                        Aarray: ptr ptr cuDoubleComplex; lda: cint;
                        xarray: ptr ptr cuDoubleComplex; incx: cint;
                        beta: ptr cuDoubleComplex; yarray: ptr ptr cuDoubleComplex;
                        incy: cint; batchCount: cint): cublasStatus_t {.cdecl,
    importc: "cublasZgemvBatched", dynlib: libName.}
proc cublasZgemvBatched_64*(handle: cublasHandle_t; trans: cublasOperation_t;
                           m: clonglong; n: clonglong; alpha: ptr cuDoubleComplex;
                           Aarray: ptr ptr cuDoubleComplex; lda: clonglong;
                           xarray: ptr ptr cuDoubleComplex; incx: clonglong;
                           beta: ptr cuDoubleComplex;
                           yarray: ptr ptr cuDoubleComplex; incy: clonglong;
                           batchCount: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasZgemvBatched_64", dynlib: libName.}
proc cublasSgemvStridedBatched*(handle: cublasHandle_t; trans: cublasOperation_t;
                               m: cint; n: cint; alpha: ptr cfloat; A: ptr cfloat;
                               lda: cint; strideA: clonglong; x: ptr cfloat;
                               incx: cint; stridex: clonglong; beta: ptr cfloat;
                               y: ptr cfloat; incy: cint; stridey: clonglong;
                               batchCount: cint): cublasStatus_t {.cdecl,
    importc: "cublasSgemvStridedBatched", dynlib: libName.}
proc cublasSgemvStridedBatched_64*(handle: cublasHandle_t;
                                  trans: cublasOperation_t; m: clonglong;
                                  n: clonglong; alpha: ptr cfloat; A: ptr cfloat;
                                  lda: clonglong; strideA: clonglong; x: ptr cfloat;
                                  incx: clonglong; stridex: clonglong;
                                  beta: ptr cfloat; y: ptr cfloat; incy: clonglong;
                                  stridey: clonglong; batchCount: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasSgemvStridedBatched_64", dynlib: libName.}
proc cublasDgemvStridedBatched*(handle: cublasHandle_t; trans: cublasOperation_t;
                               m: cint; n: cint; alpha: ptr cdouble; A: ptr cdouble;
                               lda: cint; strideA: clonglong; x: ptr cdouble;
                               incx: cint; stridex: clonglong; beta: ptr cdouble;
                               y: ptr cdouble; incy: cint; stridey: clonglong;
                               batchCount: cint): cublasStatus_t {.cdecl,
    importc: "cublasDgemvStridedBatched", dynlib: libName.}
proc cublasDgemvStridedBatched_64*(handle: cublasHandle_t;
                                  trans: cublasOperation_t; m: clonglong;
                                  n: clonglong; alpha: ptr cdouble; A: ptr cdouble;
                                  lda: clonglong; strideA: clonglong;
                                  x: ptr cdouble; incx: clonglong;
                                  stridex: clonglong; beta: ptr cdouble;
                                  y: ptr cdouble; incy: clonglong;
                                  stridey: clonglong; batchCount: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasDgemvStridedBatched_64", dynlib: libName.}
proc cublasCgemvStridedBatched*(handle: cublasHandle_t; trans: cublasOperation_t;
                               m: cint; n: cint; alpha: ptr cuComplex;
                               A: ptr cuComplex; lda: cint; strideA: clonglong;
                               x: ptr cuComplex; incx: cint; stridex: clonglong;
                               beta: ptr cuComplex; y: ptr cuComplex; incy: cint;
                               stridey: clonglong; batchCount: cint): cublasStatus_t {.
    cdecl, importc: "cublasCgemvStridedBatched", dynlib: libName.}
proc cublasCgemvStridedBatched_64*(handle: cublasHandle_t;
                                  trans: cublasOperation_t; m: clonglong;
                                  n: clonglong; alpha: ptr cuComplex;
                                  A: ptr cuComplex; lda: clonglong;
                                  strideA: clonglong; x: ptr cuComplex;
                                  incx: clonglong; stridex: clonglong;
                                  beta: ptr cuComplex; y: ptr cuComplex;
                                  incy: clonglong; stridey: clonglong;
                                  batchCount: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasCgemvStridedBatched_64", dynlib: libName.}
proc cublasZgemvStridedBatched*(handle: cublasHandle_t; trans: cublasOperation_t;
                               m: cint; n: cint; alpha: ptr cuDoubleComplex;
                               A: ptr cuDoubleComplex; lda: cint; strideA: clonglong;
                               x: ptr cuDoubleComplex; incx: cint;
                               stridex: clonglong; beta: ptr cuDoubleComplex;
                               y: ptr cuDoubleComplex; incy: cint;
                               stridey: clonglong; batchCount: cint): cublasStatus_t {.
    cdecl, importc: "cublasZgemvStridedBatched", dynlib: libName.}
proc cublasZgemvStridedBatched_64*(handle: cublasHandle_t;
                                  trans: cublasOperation_t; m: clonglong;
                                  n: clonglong; alpha: ptr cuDoubleComplex;
                                  A: ptr cuDoubleComplex; lda: clonglong;
                                  strideA: clonglong; x: ptr cuDoubleComplex;
                                  incx: clonglong; stridex: clonglong;
                                  beta: ptr cuDoubleComplex;
                                  y: ptr cuDoubleComplex; incy: clonglong;
                                  stridey: clonglong; batchCount: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasZgemvStridedBatched_64", dynlib: libName.}
##  ---------------- CUBLAS BLAS3 Functions ----------------
##  GEMM

proc cublasSgemm_v2*(handle: cublasHandle_t; transa: cublasOperation_t;
                    transb: cublasOperation_t; m: cint; n: cint; k: cint;
                    alpha: ptr cfloat; A: ptr cfloat; lda: cint; B: ptr cfloat; ldb: cint;
                    beta: ptr cfloat; C: ptr cfloat; ldc: cint): cublasStatus_t {.cdecl,
    importc: "cublasSgemm_v2", dynlib: libName.}
proc cublasSgemm_v2_64*(handle: cublasHandle_t; transa: cublasOperation_t;
                       transb: cublasOperation_t; m: clonglong; n: clonglong;
                       k: clonglong; alpha: ptr cfloat; A: ptr cfloat; lda: clonglong;
                       B: ptr cfloat; ldb: clonglong; beta: ptr cfloat; C: ptr cfloat;
                       ldc: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasSgemm_v2_64", dynlib: libName.}
proc cublasDgemm_v2*(handle: cublasHandle_t; transa: cublasOperation_t;
                    transb: cublasOperation_t; m: cint; n: cint; k: cint;
                    alpha: ptr cdouble; A: ptr cdouble; lda: cint; B: ptr cdouble;
                    ldb: cint; beta: ptr cdouble; C: ptr cdouble; ldc: cint): cublasStatus_t {.
    cdecl, importc: "cublasDgemm_v2", dynlib: libName.}
proc cublasDgemm_v2_64*(handle: cublasHandle_t; transa: cublasOperation_t;
                       transb: cublasOperation_t; m: clonglong; n: clonglong;
                       k: clonglong; alpha: ptr cdouble; A: ptr cdouble; lda: clonglong;
                       B: ptr cdouble; ldb: clonglong; beta: ptr cdouble;
                       C: ptr cdouble; ldc: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasDgemm_v2_64", dynlib: libName.}
proc cublasCgemm_v2*(handle: cublasHandle_t; transa: cublasOperation_t;
                    transb: cublasOperation_t; m: cint; n: cint; k: cint;
                    alpha: ptr cuComplex; A: ptr cuComplex; lda: cint; B: ptr cuComplex;
                    ldb: cint; beta: ptr cuComplex; C: ptr cuComplex; ldc: cint): cublasStatus_t {.
    cdecl, importc: "cublasCgemm_v2", dynlib: libName.}
proc cublasCgemm_v2_64*(handle: cublasHandle_t; transa: cublasOperation_t;
                       transb: cublasOperation_t; m: clonglong; n: clonglong;
                       k: clonglong; alpha: ptr cuComplex; A: ptr cuComplex;
                       lda: clonglong; B: ptr cuComplex; ldb: clonglong;
                       beta: ptr cuComplex; C: ptr cuComplex; ldc: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasCgemm_v2_64", dynlib: libName.}
proc cublasCgemm3m*(handle: cublasHandle_t; transa: cublasOperation_t;
                   transb: cublasOperation_t; m: cint; n: cint; k: cint;
                   alpha: ptr cuComplex; A: ptr cuComplex; lda: cint; B: ptr cuComplex;
                   ldb: cint; beta: ptr cuComplex; C: ptr cuComplex; ldc: cint): cublasStatus_t {.
    cdecl, importc: "cublasCgemm3m", dynlib: libName.}
proc cublasCgemm3m_64*(handle: cublasHandle_t; transa: cublasOperation_t;
                      transb: cublasOperation_t; m: clonglong; n: clonglong;
                      k: clonglong; alpha: ptr cuComplex; A: ptr cuComplex;
                      lda: clonglong; B: ptr cuComplex; ldb: clonglong;
                      beta: ptr cuComplex; C: ptr cuComplex; ldc: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasCgemm3m_64", dynlib: libName.}
proc cublasCgemm3mEx*(handle: cublasHandle_t; transa: cublasOperation_t;
                     transb: cublasOperation_t; m: cint; n: cint; k: cint;
                     alpha: ptr cuComplex; A: pointer; Atype: cudaDataType; lda: cint;
                     B: pointer; Btype: cudaDataType; ldb: cint; beta: ptr cuComplex;
                     C: pointer; Ctype: cudaDataType; ldc: cint): cublasStatus_t {.
    cdecl, importc: "cublasCgemm3mEx", dynlib: libName.}
proc cublasCgemm3mEx_64*(handle: cublasHandle_t; transa: cublasOperation_t;
                        transb: cublasOperation_t; m: clonglong; n: clonglong;
                        k: clonglong; alpha: ptr cuComplex; A: pointer;
                        Atype: cudaDataType; lda: clonglong; B: pointer;
                        Btype: cudaDataType; ldb: clonglong; beta: ptr cuComplex;
                        C: pointer; Ctype: cudaDataType; ldc: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasCgemm3mEx_64", dynlib: libName.}
proc cublasZgemm_v2*(handle: cublasHandle_t; transa: cublasOperation_t;
                    transb: cublasOperation_t; m: cint; n: cint; k: cint;
                    alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex; lda: cint;
                    B: ptr cuDoubleComplex; ldb: cint; beta: ptr cuDoubleComplex;
                    C: ptr cuDoubleComplex; ldc: cint): cublasStatus_t {.cdecl,
    importc: "cublasZgemm_v2", dynlib: libName.}
proc cublasZgemm_v2_64*(handle: cublasHandle_t; transa: cublasOperation_t;
                       transb: cublasOperation_t; m: clonglong; n: clonglong;
                       k: clonglong; alpha: ptr cuDoubleComplex;
                       A: ptr cuDoubleComplex; lda: clonglong;
                       B: ptr cuDoubleComplex; ldb: clonglong;
                       beta: ptr cuDoubleComplex; C: ptr cuDoubleComplex;
                       ldc: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasZgemm_v2_64", dynlib: libName.}
proc cublasZgemm3m*(handle: cublasHandle_t; transa: cublasOperation_t;
                   transb: cublasOperation_t; m: cint; n: cint; k: cint;
                   alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex; lda: cint;
                   B: ptr cuDoubleComplex; ldb: cint; beta: ptr cuDoubleComplex;
                   C: ptr cuDoubleComplex; ldc: cint): cublasStatus_t {.cdecl,
    importc: "cublasZgemm3m", dynlib: libName.}
proc cublasZgemm3m_64*(handle: cublasHandle_t; transa: cublasOperation_t;
                      transb: cublasOperation_t; m: clonglong; n: clonglong;
                      k: clonglong; alpha: ptr cuDoubleComplex;
                      A: ptr cuDoubleComplex; lda: clonglong; B: ptr cuDoubleComplex;
                      ldb: clonglong; beta: ptr cuDoubleComplex;
                      C: ptr cuDoubleComplex; ldc: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasZgemm3m_64", dynlib: libName.}
proc cublasSgemmEx*(handle: cublasHandle_t; transa: cublasOperation_t;
                   transb: cublasOperation_t; m: cint; n: cint; k: cint;
                   alpha: ptr cfloat; A: pointer; Atype: cudaDataType; lda: cint;
                   B: pointer; Btype: cudaDataType; ldb: cint; beta: ptr cfloat;
                   C: pointer; Ctype: cudaDataType; ldc: cint): cublasStatus_t {.cdecl,
    importc: "cublasSgemmEx", dynlib: libName.}
proc cublasSgemmEx_64*(handle: cublasHandle_t; transa: cublasOperation_t;
                      transb: cublasOperation_t; m: clonglong; n: clonglong;
                      k: clonglong; alpha: ptr cfloat; A: pointer; Atype: cudaDataType;
                      lda: clonglong; B: pointer; Btype: cudaDataType; ldb: clonglong;
                      beta: ptr cfloat; C: pointer; Ctype: cudaDataType; ldc: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasSgemmEx_64", dynlib: libName.}
proc cublasGemmEx*(handle: cublasHandle_t; transa: cublasOperation_t;
                  transb: cublasOperation_t; m: cint; n: cint; k: cint; alpha: pointer;
                  A: pointer; Atype: cudaDataType; lda: cint; B: pointer;
                  Btype: cudaDataType; ldb: cint; beta: pointer; C: pointer;
                  Ctype: cudaDataType; ldc: cint; computeType: cublasComputeType_t;
                  algo: cublasGemmAlgo_t): cublasStatus_t {.cdecl,
    importc: "cublasGemmEx", dynlib: libName.}
proc cublasGemmEx_64*(handle: cublasHandle_t; transa: cublasOperation_t;
                     transb: cublasOperation_t; m: clonglong; n: clonglong;
                     k: clonglong; alpha: pointer; A: pointer; Atype: cudaDataType;
                     lda: clonglong; B: pointer; Btype: cudaDataType; ldb: clonglong;
                     beta: pointer; C: pointer; Ctype: cudaDataType; ldc: clonglong;
                     computeType: cublasComputeType_t; algo: cublasGemmAlgo_t): cublasStatus_t {.
    cdecl, importc: "cublasGemmEx_64", dynlib: libName.}
proc cublasCgemmEx*(handle: cublasHandle_t; transa: cublasOperation_t;
                   transb: cublasOperation_t; m: cint; n: cint; k: cint;
                   alpha: ptr cuComplex; A: pointer; Atype: cudaDataType; lda: cint;
                   B: pointer; Btype: cudaDataType; ldb: cint; beta: ptr cuComplex;
                   C: pointer; Ctype: cudaDataType; ldc: cint): cublasStatus_t {.cdecl,
    importc: "cublasCgemmEx", dynlib: libName.}
proc cublasCgemmEx_64*(handle: cublasHandle_t; transa: cublasOperation_t;
                      transb: cublasOperation_t; m: clonglong; n: clonglong;
                      k: clonglong; alpha: ptr cuComplex; A: pointer;
                      Atype: cudaDataType; lda: clonglong; B: pointer;
                      Btype: cudaDataType; ldb: clonglong; beta: ptr cuComplex;
                      C: pointer; Ctype: cudaDataType; ldc: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasCgemmEx_64", dynlib: libName.}
##  SYRK

proc cublasSsyrk_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                    trans: cublasOperation_t; n: cint; k: cint; alpha: ptr cfloat;
                    A: ptr cfloat; lda: cint; beta: ptr cfloat; C: ptr cfloat; ldc: cint): cublasStatus_t {.
    cdecl, importc: "cublasSsyrk_v2", dynlib: libName.}
proc cublasSsyrk_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                       trans: cublasOperation_t; n: clonglong; k: clonglong;
                       alpha: ptr cfloat; A: ptr cfloat; lda: clonglong;
                       beta: ptr cfloat; C: ptr cfloat; ldc: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasSsyrk_v2_64", dynlib: libName.}
proc cublasDsyrk_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                    trans: cublasOperation_t; n: cint; k: cint; alpha: ptr cdouble;
                    A: ptr cdouble; lda: cint; beta: ptr cdouble; C: ptr cdouble; ldc: cint): cublasStatus_t {.
    cdecl, importc: "cublasDsyrk_v2", dynlib: libName.}
proc cublasDsyrk_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                       trans: cublasOperation_t; n: clonglong; k: clonglong;
                       alpha: ptr cdouble; A: ptr cdouble; lda: clonglong;
                       beta: ptr cdouble; C: ptr cdouble; ldc: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasDsyrk_v2_64", dynlib: libName.}
proc cublasCsyrk_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                    trans: cublasOperation_t; n: cint; k: cint; alpha: ptr cuComplex;
                    A: ptr cuComplex; lda: cint; beta: ptr cuComplex; C: ptr cuComplex;
                    ldc: cint): cublasStatus_t {.cdecl, importc: "cublasCsyrk_v2",
    dynlib: libName.}
proc cublasCsyrk_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                       trans: cublasOperation_t; n: clonglong; k: clonglong;
                       alpha: ptr cuComplex; A: ptr cuComplex; lda: clonglong;
                       beta: ptr cuComplex; C: ptr cuComplex; ldc: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasCsyrk_v2_64", dynlib: libName.}
proc cublasZsyrk_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                    trans: cublasOperation_t; n: cint; k: cint;
                    alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex; lda: cint;
                    beta: ptr cuDoubleComplex; C: ptr cuDoubleComplex; ldc: cint): cublasStatus_t {.
    cdecl, importc: "cublasZsyrk_v2", dynlib: libName.}
proc cublasZsyrk_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                       trans: cublasOperation_t; n: clonglong; k: clonglong;
                       alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex;
                       lda: clonglong; beta: ptr cuDoubleComplex;
                       C: ptr cuDoubleComplex; ldc: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasZsyrk_v2_64", dynlib: libName.}
proc cublasCsyrkEx*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                   trans: cublasOperation_t; n: cint; k: cint; alpha: ptr cuComplex;
                   A: pointer; Atype: cudaDataType; lda: cint; beta: ptr cuComplex;
                   C: pointer; Ctype: cudaDataType; ldc: cint): cublasStatus_t {.cdecl,
    importc: "cublasCsyrkEx", dynlib: libName.}
proc cublasCsyrkEx_64*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                      trans: cublasOperation_t; n: clonglong; k: clonglong;
                      alpha: ptr cuComplex; A: pointer; Atype: cudaDataType;
                      lda: clonglong; beta: ptr cuComplex; C: pointer;
                      Ctype: cudaDataType; ldc: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasCsyrkEx_64", dynlib: libName.}
proc cublasCsyrk3mEx*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                     trans: cublasOperation_t; n: cint; k: cint; alpha: ptr cuComplex;
                     A: pointer; Atype: cudaDataType; lda: cint; beta: ptr cuComplex;
                     C: pointer; Ctype: cudaDataType; ldc: cint): cublasStatus_t {.
    cdecl, importc: "cublasCsyrk3mEx", dynlib: libName.}
proc cublasCsyrk3mEx_64*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                        trans: cublasOperation_t; n: clonglong; k: clonglong;
                        alpha: ptr cuComplex; A: pointer; Atype: cudaDataType;
                        lda: clonglong; beta: ptr cuComplex; C: pointer;
                        Ctype: cudaDataType; ldc: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasCsyrk3mEx_64", dynlib: libName.}
##  HERK

proc cublasCherk_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                    trans: cublasOperation_t; n: cint; k: cint; alpha: ptr cfloat;
                    A: ptr cuComplex; lda: cint; beta: ptr cfloat; C: ptr cuComplex;
                    ldc: cint): cublasStatus_t {.cdecl, importc: "cublasCherk_v2",
    dynlib: libName.}
proc cublasCherk_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                       trans: cublasOperation_t; n: clonglong; k: clonglong;
                       alpha: ptr cfloat; A: ptr cuComplex; lda: clonglong;
                       beta: ptr cfloat; C: ptr cuComplex; ldc: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasCherk_v2_64", dynlib: libName.}
proc cublasZherk_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                    trans: cublasOperation_t; n: cint; k: cint; alpha: ptr cdouble;
                    A: ptr cuDoubleComplex; lda: cint; beta: ptr cdouble;
                    C: ptr cuDoubleComplex; ldc: cint): cublasStatus_t {.cdecl,
    importc: "cublasZherk_v2", dynlib: libName.}
proc cublasZherk_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                       trans: cublasOperation_t; n: clonglong; k: clonglong;
                       alpha: ptr cdouble; A: ptr cuDoubleComplex; lda: clonglong;
                       beta: ptr cdouble; C: ptr cuDoubleComplex; ldc: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasZherk_v2_64", dynlib: libName.}
proc cublasCherkEx*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                   trans: cublasOperation_t; n: cint; k: cint; alpha: ptr cfloat;
                   A: pointer; Atype: cudaDataType; lda: cint; beta: ptr cfloat;
                   C: pointer; Ctype: cudaDataType; ldc: cint): cublasStatus_t {.cdecl,
    importc: "cublasCherkEx", dynlib: libName.}
proc cublasCherkEx_64*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                      trans: cublasOperation_t; n: clonglong; k: clonglong;
                      alpha: ptr cfloat; A: pointer; Atype: cudaDataType;
                      lda: clonglong; beta: ptr cfloat; C: pointer;
                      Ctype: cudaDataType; ldc: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasCherkEx_64", dynlib: libName.}
proc cublasCherk3mEx*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                     trans: cublasOperation_t; n: cint; k: cint; alpha: ptr cfloat;
                     A: pointer; Atype: cudaDataType; lda: cint; beta: ptr cfloat;
                     C: pointer; Ctype: cudaDataType; ldc: cint): cublasStatus_t {.
    cdecl, importc: "cublasCherk3mEx", dynlib: libName.}
proc cublasCherk3mEx_64*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                        trans: cublasOperation_t; n: clonglong; k: clonglong;
                        alpha: ptr cfloat; A: pointer; Atype: cudaDataType;
                        lda: clonglong; beta: ptr cfloat; C: pointer;
                        Ctype: cudaDataType; ldc: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasCherk3mEx_64", dynlib: libName.}
##  SYR2K / HER2K

proc cublasSsyr2k_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                     trans: cublasOperation_t; n: cint; k: cint; alpha: ptr cfloat;
                     A: ptr cfloat; lda: cint; B: ptr cfloat; ldb: cint; beta: ptr cfloat;
                     C: ptr cfloat; ldc: cint): cublasStatus_t {.cdecl,
    importc: "cublasSsyr2k_v2", dynlib: libName.}
proc cublasSsyr2k_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                        trans: cublasOperation_t; n: clonglong; k: clonglong;
                        alpha: ptr cfloat; A: ptr cfloat; lda: clonglong; B: ptr cfloat;
                        ldb: clonglong; beta: ptr cfloat; C: ptr cfloat; ldc: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasSsyr2k_v2_64", dynlib: libName.}
proc cublasDsyr2k_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                     trans: cublasOperation_t; n: cint; k: cint; alpha: ptr cdouble;
                     A: ptr cdouble; lda: cint; B: ptr cdouble; ldb: cint;
                     beta: ptr cdouble; C: ptr cdouble; ldc: cint): cublasStatus_t {.
    cdecl, importc: "cublasDsyr2k_v2", dynlib: libName.}
proc cublasDsyr2k_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                        trans: cublasOperation_t; n: clonglong; k: clonglong;
                        alpha: ptr cdouble; A: ptr cdouble; lda: clonglong;
                        B: ptr cdouble; ldb: clonglong; beta: ptr cdouble;
                        C: ptr cdouble; ldc: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasDsyr2k_v2_64", dynlib: libName.}
proc cublasCsyr2k_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                     trans: cublasOperation_t; n: cint; k: cint; alpha: ptr cuComplex;
                     A: ptr cuComplex; lda: cint; B: ptr cuComplex; ldb: cint;
                     beta: ptr cuComplex; C: ptr cuComplex; ldc: cint): cublasStatus_t {.
    cdecl, importc: "cublasCsyr2k_v2", dynlib: libName.}
proc cublasCsyr2k_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                        trans: cublasOperation_t; n: clonglong; k: clonglong;
                        alpha: ptr cuComplex; A: ptr cuComplex; lda: clonglong;
                        B: ptr cuComplex; ldb: clonglong; beta: ptr cuComplex;
                        C: ptr cuComplex; ldc: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasCsyr2k_v2_64", dynlib: libName.}
proc cublasZsyr2k_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                     trans: cublasOperation_t; n: cint; k: cint;
                     alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex; lda: cint;
                     B: ptr cuDoubleComplex; ldb: cint; beta: ptr cuDoubleComplex;
                     C: ptr cuDoubleComplex; ldc: cint): cublasStatus_t {.cdecl,
    importc: "cublasZsyr2k_v2", dynlib: libName.}
proc cublasZsyr2k_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                        trans: cublasOperation_t; n: clonglong; k: clonglong;
                        alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex;
                        lda: clonglong; B: ptr cuDoubleComplex; ldb: clonglong;
                        beta: ptr cuDoubleComplex; C: ptr cuDoubleComplex;
                        ldc: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasZsyr2k_v2_64", dynlib: libName.}
proc cublasCher2k_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                     trans: cublasOperation_t; n: cint; k: cint; alpha: ptr cuComplex;
                     A: ptr cuComplex; lda: cint; B: ptr cuComplex; ldb: cint;
                     beta: ptr cfloat; C: ptr cuComplex; ldc: cint): cublasStatus_t {.
    cdecl, importc: "cublasCher2k_v2", dynlib: libName.}
proc cublasCher2k_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                        trans: cublasOperation_t; n: clonglong; k: clonglong;
                        alpha: ptr cuComplex; A: ptr cuComplex; lda: clonglong;
                        B: ptr cuComplex; ldb: clonglong; beta: ptr cfloat;
                        C: ptr cuComplex; ldc: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasCher2k_v2_64", dynlib: libName.}
proc cublasZher2k_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                     trans: cublasOperation_t; n: cint; k: cint;
                     alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex; lda: cint;
                     B: ptr cuDoubleComplex; ldb: cint; beta: ptr cdouble;
                     C: ptr cuDoubleComplex; ldc: cint): cublasStatus_t {.cdecl,
    importc: "cublasZher2k_v2", dynlib: libName.}
proc cublasZher2k_v2_64*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                        trans: cublasOperation_t; n: clonglong; k: clonglong;
                        alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex;
                        lda: clonglong; B: ptr cuDoubleComplex; ldb: clonglong;
                        beta: ptr cdouble; C: ptr cuDoubleComplex; ldc: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasZher2k_v2_64", dynlib: libName.}
##  SYRKX / HERKX

proc cublasSsyrkx*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                  trans: cublasOperation_t; n: cint; k: cint; alpha: ptr cfloat;
                  A: ptr cfloat; lda: cint; B: ptr cfloat; ldb: cint; beta: ptr cfloat;
                  C: ptr cfloat; ldc: cint): cublasStatus_t {.cdecl,
    importc: "cublasSsyrkx", dynlib: libName.}
proc cublasSsyrkx_64*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                     trans: cublasOperation_t; n: clonglong; k: clonglong;
                     alpha: ptr cfloat; A: ptr cfloat; lda: clonglong; B: ptr cfloat;
                     ldb: clonglong; beta: ptr cfloat; C: ptr cfloat; ldc: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasSsyrkx_64", dynlib: libName.}
proc cublasDsyrkx*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                  trans: cublasOperation_t; n: cint; k: cint; alpha: ptr cdouble;
                  A: ptr cdouble; lda: cint; B: ptr cdouble; ldb: cint; beta: ptr cdouble;
                  C: ptr cdouble; ldc: cint): cublasStatus_t {.cdecl,
    importc: "cublasDsyrkx", dynlib: libName.}
proc cublasDsyrkx_64*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                     trans: cublasOperation_t; n: clonglong; k: clonglong;
                     alpha: ptr cdouble; A: ptr cdouble; lda: clonglong; B: ptr cdouble;
                     ldb: clonglong; beta: ptr cdouble; C: ptr cdouble; ldc: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasDsyrkx_64", dynlib: libName.}
proc cublasCsyrkx*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                  trans: cublasOperation_t; n: cint; k: cint; alpha: ptr cuComplex;
                  A: ptr cuComplex; lda: cint; B: ptr cuComplex; ldb: cint;
                  beta: ptr cuComplex; C: ptr cuComplex; ldc: cint): cublasStatus_t {.
    cdecl, importc: "cublasCsyrkx", dynlib: libName.}
proc cublasCsyrkx_64*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                     trans: cublasOperation_t; n: clonglong; k: clonglong;
                     alpha: ptr cuComplex; A: ptr cuComplex; lda: clonglong;
                     B: ptr cuComplex; ldb: clonglong; beta: ptr cuComplex;
                     C: ptr cuComplex; ldc: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasCsyrkx_64", dynlib: libName.}
proc cublasZsyrkx*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                  trans: cublasOperation_t; n: cint; k: cint;
                  alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex; lda: cint;
                  B: ptr cuDoubleComplex; ldb: cint; beta: ptr cuDoubleComplex;
                  C: ptr cuDoubleComplex; ldc: cint): cublasStatus_t {.cdecl,
    importc: "cublasZsyrkx", dynlib: libName.}
proc cublasZsyrkx_64*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                     trans: cublasOperation_t; n: clonglong; k: clonglong;
                     alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex;
                     lda: clonglong; B: ptr cuDoubleComplex; ldb: clonglong;
                     beta: ptr cuDoubleComplex; C: ptr cuDoubleComplex; ldc: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasZsyrkx_64", dynlib: libName.}
proc cublasCherkx*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                  trans: cublasOperation_t; n: cint; k: cint; alpha: ptr cuComplex;
                  A: ptr cuComplex; lda: cint; B: ptr cuComplex; ldb: cint;
                  beta: ptr cfloat; C: ptr cuComplex; ldc: cint): cublasStatus_t {.cdecl,
    importc: "cublasCherkx", dynlib: libName.}
proc cublasCherkx_64*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                     trans: cublasOperation_t; n: clonglong; k: clonglong;
                     alpha: ptr cuComplex; A: ptr cuComplex; lda: clonglong;
                     B: ptr cuComplex; ldb: clonglong; beta: ptr cfloat;
                     C: ptr cuComplex; ldc: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasCherkx_64", dynlib: libName.}
proc cublasZherkx*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                  trans: cublasOperation_t; n: cint; k: cint;
                  alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex; lda: cint;
                  B: ptr cuDoubleComplex; ldb: cint; beta: ptr cdouble;
                  C: ptr cuDoubleComplex; ldc: cint): cublasStatus_t {.cdecl,
    importc: "cublasZherkx", dynlib: libName.}
proc cublasZherkx_64*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                     trans: cublasOperation_t; n: clonglong; k: clonglong;
                     alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex;
                     lda: clonglong; B: ptr cuDoubleComplex; ldb: clonglong;
                     beta: ptr cdouble; C: ptr cuDoubleComplex; ldc: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasZherkx_64", dynlib: libName.}
##  SYMM

proc cublasSsymm_v2*(handle: cublasHandle_t; side: cublasSideMode_t;
                    uplo: cublasFillMode_t; m: cint; n: cint; alpha: ptr cfloat;
                    A: ptr cfloat; lda: cint; B: ptr cfloat; ldb: cint; beta: ptr cfloat;
                    C: ptr cfloat; ldc: cint): cublasStatus_t {.cdecl,
    importc: "cublasSsymm_v2", dynlib: libName.}
proc cublasSsymm_v2_64*(handle: cublasHandle_t; side: cublasSideMode_t;
                       uplo: cublasFillMode_t; m: clonglong; n: clonglong;
                       alpha: ptr cfloat; A: ptr cfloat; lda: clonglong; B: ptr cfloat;
                       ldb: clonglong; beta: ptr cfloat; C: ptr cfloat; ldc: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasSsymm_v2_64", dynlib: libName.}
proc cublasDsymm_v2*(handle: cublasHandle_t; side: cublasSideMode_t;
                    uplo: cublasFillMode_t; m: cint; n: cint; alpha: ptr cdouble;
                    A: ptr cdouble; lda: cint; B: ptr cdouble; ldb: cint;
                    beta: ptr cdouble; C: ptr cdouble; ldc: cint): cublasStatus_t {.
    cdecl, importc: "cublasDsymm_v2", dynlib: libName.}
proc cublasDsymm_v2_64*(handle: cublasHandle_t; side: cublasSideMode_t;
                       uplo: cublasFillMode_t; m: clonglong; n: clonglong;
                       alpha: ptr cdouble; A: ptr cdouble; lda: clonglong;
                       B: ptr cdouble; ldb: clonglong; beta: ptr cdouble;
                       C: ptr cdouble; ldc: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasDsymm_v2_64", dynlib: libName.}
proc cublasCsymm_v2*(handle: cublasHandle_t; side: cublasSideMode_t;
                    uplo: cublasFillMode_t; m: cint; n: cint; alpha: ptr cuComplex;
                    A: ptr cuComplex; lda: cint; B: ptr cuComplex; ldb: cint;
                    beta: ptr cuComplex; C: ptr cuComplex; ldc: cint): cublasStatus_t {.
    cdecl, importc: "cublasCsymm_v2", dynlib: libName.}
proc cublasCsymm_v2_64*(handle: cublasHandle_t; side: cublasSideMode_t;
                       uplo: cublasFillMode_t; m: clonglong; n: clonglong;
                       alpha: ptr cuComplex; A: ptr cuComplex; lda: clonglong;
                       B: ptr cuComplex; ldb: clonglong; beta: ptr cuComplex;
                       C: ptr cuComplex; ldc: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasCsymm_v2_64", dynlib: libName.}
proc cublasZsymm_v2*(handle: cublasHandle_t; side: cublasSideMode_t;
                    uplo: cublasFillMode_t; m: cint; n: cint;
                    alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex; lda: cint;
                    B: ptr cuDoubleComplex; ldb: cint; beta: ptr cuDoubleComplex;
                    C: ptr cuDoubleComplex; ldc: cint): cublasStatus_t {.cdecl,
    importc: "cublasZsymm_v2", dynlib: libName.}
proc cublasZsymm_v2_64*(handle: cublasHandle_t; side: cublasSideMode_t;
                       uplo: cublasFillMode_t; m: clonglong; n: clonglong;
                       alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex;
                       lda: clonglong; B: ptr cuDoubleComplex; ldb: clonglong;
                       beta: ptr cuDoubleComplex; C: ptr cuDoubleComplex;
                       ldc: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasZsymm_v2_64", dynlib: libName.}
##  HEMM

proc cublasChemm_v2*(handle: cublasHandle_t; side: cublasSideMode_t;
                    uplo: cublasFillMode_t; m: cint; n: cint; alpha: ptr cuComplex;
                    A: ptr cuComplex; lda: cint; B: ptr cuComplex; ldb: cint;
                    beta: ptr cuComplex; C: ptr cuComplex; ldc: cint): cublasStatus_t {.
    cdecl, importc: "cublasChemm_v2", dynlib: libName.}
proc cublasChemm_v2_64*(handle: cublasHandle_t; side: cublasSideMode_t;
                       uplo: cublasFillMode_t; m: clonglong; n: clonglong;
                       alpha: ptr cuComplex; A: ptr cuComplex; lda: clonglong;
                       B: ptr cuComplex; ldb: clonglong; beta: ptr cuComplex;
                       C: ptr cuComplex; ldc: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasChemm_v2_64", dynlib: libName.}
proc cublasZhemm_v2*(handle: cublasHandle_t; side: cublasSideMode_t;
                    uplo: cublasFillMode_t; m: cint; n: cint;
                    alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex; lda: cint;
                    B: ptr cuDoubleComplex; ldb: cint; beta: ptr cuDoubleComplex;
                    C: ptr cuDoubleComplex; ldc: cint): cublasStatus_t {.cdecl,
    importc: "cublasZhemm_v2", dynlib: libName.}
proc cublasZhemm_v2_64*(handle: cublasHandle_t; side: cublasSideMode_t;
                       uplo: cublasFillMode_t; m: clonglong; n: clonglong;
                       alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex;
                       lda: clonglong; B: ptr cuDoubleComplex; ldb: clonglong;
                       beta: ptr cuDoubleComplex; C: ptr cuDoubleComplex;
                       ldc: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasZhemm_v2_64", dynlib: libName.}
##  TRSM

proc cublasStrsm_v2*(handle: cublasHandle_t; side: cublasSideMode_t;
                    uplo: cublasFillMode_t; trans: cublasOperation_t;
                    diag: cublasDiagType_t; m: cint; n: cint; alpha: ptr cfloat;
                    A: ptr cfloat; lda: cint; B: ptr cfloat; ldb: cint): cublasStatus_t {.
    cdecl, importc: "cublasStrsm_v2", dynlib: libName.}
proc cublasStrsm_v2_64*(handle: cublasHandle_t; side: cublasSideMode_t;
                       uplo: cublasFillMode_t; trans: cublasOperation_t;
                       diag: cublasDiagType_t; m: clonglong; n: clonglong;
                       alpha: ptr cfloat; A: ptr cfloat; lda: clonglong; B: ptr cfloat;
                       ldb: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasStrsm_v2_64", dynlib: libName.}
proc cublasDtrsm_v2*(handle: cublasHandle_t; side: cublasSideMode_t;
                    uplo: cublasFillMode_t; trans: cublasOperation_t;
                    diag: cublasDiagType_t; m: cint; n: cint; alpha: ptr cdouble;
                    A: ptr cdouble; lda: cint; B: ptr cdouble; ldb: cint): cublasStatus_t {.
    cdecl, importc: "cublasDtrsm_v2", dynlib: libName.}
proc cublasDtrsm_v2_64*(handle: cublasHandle_t; side: cublasSideMode_t;
                       uplo: cublasFillMode_t; trans: cublasOperation_t;
                       diag: cublasDiagType_t; m: clonglong; n: clonglong;
                       alpha: ptr cdouble; A: ptr cdouble; lda: clonglong;
                       B: ptr cdouble; ldb: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasDtrsm_v2_64", dynlib: libName.}
proc cublasCtrsm_v2*(handle: cublasHandle_t; side: cublasSideMode_t;
                    uplo: cublasFillMode_t; trans: cublasOperation_t;
                    diag: cublasDiagType_t; m: cint; n: cint; alpha: ptr cuComplex;
                    A: ptr cuComplex; lda: cint; B: ptr cuComplex; ldb: cint): cublasStatus_t {.
    cdecl, importc: "cublasCtrsm_v2", dynlib: libName.}
proc cublasCtrsm_v2_64*(handle: cublasHandle_t; side: cublasSideMode_t;
                       uplo: cublasFillMode_t; trans: cublasOperation_t;
                       diag: cublasDiagType_t; m: clonglong; n: clonglong;
                       alpha: ptr cuComplex; A: ptr cuComplex; lda: clonglong;
                       B: ptr cuComplex; ldb: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasCtrsm_v2_64", dynlib: libName.}
proc cublasZtrsm_v2*(handle: cublasHandle_t; side: cublasSideMode_t;
                    uplo: cublasFillMode_t; trans: cublasOperation_t;
                    diag: cublasDiagType_t; m: cint; n: cint;
                    alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex; lda: cint;
                    B: ptr cuDoubleComplex; ldb: cint): cublasStatus_t {.cdecl,
    importc: "cublasZtrsm_v2", dynlib: libName.}
proc cublasZtrsm_v2_64*(handle: cublasHandle_t; side: cublasSideMode_t;
                       uplo: cublasFillMode_t; trans: cublasOperation_t;
                       diag: cublasDiagType_t; m: clonglong; n: clonglong;
                       alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex;
                       lda: clonglong; B: ptr cuDoubleComplex; ldb: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasZtrsm_v2_64", dynlib: libName.}
##  TRMM

proc cublasStrmm_v2*(handle: cublasHandle_t; side: cublasSideMode_t;
                    uplo: cublasFillMode_t; trans: cublasOperation_t;
                    diag: cublasDiagType_t; m: cint; n: cint; alpha: ptr cfloat;
                    A: ptr cfloat; lda: cint; B: ptr cfloat; ldb: cint; C: ptr cfloat;
                    ldc: cint): cublasStatus_t {.cdecl, importc: "cublasStrmm_v2",
    dynlib: libName.}
proc cublasStrmm_v2_64*(handle: cublasHandle_t; side: cublasSideMode_t;
                       uplo: cublasFillMode_t; trans: cublasOperation_t;
                       diag: cublasDiagType_t; m: clonglong; n: clonglong;
                       alpha: ptr cfloat; A: ptr cfloat; lda: clonglong; B: ptr cfloat;
                       ldb: clonglong; C: ptr cfloat; ldc: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasStrmm_v2_64", dynlib: libName.}
proc cublasDtrmm_v2*(handle: cublasHandle_t; side: cublasSideMode_t;
                    uplo: cublasFillMode_t; trans: cublasOperation_t;
                    diag: cublasDiagType_t; m: cint; n: cint; alpha: ptr cdouble;
                    A: ptr cdouble; lda: cint; B: ptr cdouble; ldb: cint; C: ptr cdouble;
                    ldc: cint): cublasStatus_t {.cdecl, importc: "cublasDtrmm_v2",
    dynlib: libName.}
proc cublasDtrmm_v2_64*(handle: cublasHandle_t; side: cublasSideMode_t;
                       uplo: cublasFillMode_t; trans: cublasOperation_t;
                       diag: cublasDiagType_t; m: clonglong; n: clonglong;
                       alpha: ptr cdouble; A: ptr cdouble; lda: clonglong;
                       B: ptr cdouble; ldb: clonglong; C: ptr cdouble; ldc: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasDtrmm_v2_64", dynlib: libName.}
proc cublasCtrmm_v2*(handle: cublasHandle_t; side: cublasSideMode_t;
                    uplo: cublasFillMode_t; trans: cublasOperation_t;
                    diag: cublasDiagType_t; m: cint; n: cint; alpha: ptr cuComplex;
                    A: ptr cuComplex; lda: cint; B: ptr cuComplex; ldb: cint;
                    C: ptr cuComplex; ldc: cint): cublasStatus_t {.cdecl,
    importc: "cublasCtrmm_v2", dynlib: libName.}
proc cublasCtrmm_v2_64*(handle: cublasHandle_t; side: cublasSideMode_t;
                       uplo: cublasFillMode_t; trans: cublasOperation_t;
                       diag: cublasDiagType_t; m: clonglong; n: clonglong;
                       alpha: ptr cuComplex; A: ptr cuComplex; lda: clonglong;
                       B: ptr cuComplex; ldb: clonglong; C: ptr cuComplex;
                       ldc: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasCtrmm_v2_64", dynlib: libName.}
proc cublasZtrmm_v2*(handle: cublasHandle_t; side: cublasSideMode_t;
                    uplo: cublasFillMode_t; trans: cublasOperation_t;
                    diag: cublasDiagType_t; m: cint; n: cint;
                    alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex; lda: cint;
                    B: ptr cuDoubleComplex; ldb: cint; C: ptr cuDoubleComplex; ldc: cint): cublasStatus_t {.
    cdecl, importc: "cublasZtrmm_v2", dynlib: libName.}
proc cublasZtrmm_v2_64*(handle: cublasHandle_t; side: cublasSideMode_t;
                       uplo: cublasFillMode_t; trans: cublasOperation_t;
                       diag: cublasDiagType_t; m: clonglong; n: clonglong;
                       alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex;
                       lda: clonglong; B: ptr cuDoubleComplex; ldb: clonglong;
                       C: ptr cuDoubleComplex; ldc: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasZtrmm_v2_64", dynlib: libName.}
##  BATCH GEMM

proc cublasSgemmBatched*(handle: cublasHandle_t; transa: cublasOperation_t;
                        transb: cublasOperation_t; m: cint; n: cint; k: cint;
                        alpha: ptr cfloat; Aarray: ptr ptr cfloat; lda: cint;
                        Barray: ptr ptr cfloat; ldb: cint; beta: ptr cfloat;
                        Carray: ptr ptr cfloat; ldc: cint; batchCount: cint): cublasStatus_t {.
    cdecl, importc: "cublasSgemmBatched", dynlib: libName.}
proc cublasSgemmBatched_64*(handle: cublasHandle_t; transa: cublasOperation_t;
                           transb: cublasOperation_t; m: clonglong; n: clonglong;
                           k: clonglong; alpha: ptr cfloat; Aarray: ptr ptr cfloat;
                           lda: clonglong; Barray: ptr ptr cfloat; ldb: clonglong;
                           beta: ptr cfloat; Carray: ptr ptr cfloat; ldc: clonglong;
                           batchCount: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasSgemmBatched_64", dynlib: libName.}
proc cublasDgemmBatched*(handle: cublasHandle_t; transa: cublasOperation_t;
                        transb: cublasOperation_t; m: cint; n: cint; k: cint;
                        alpha: ptr cdouble; Aarray: ptr ptr cdouble; lda: cint;
                        Barray: ptr ptr cdouble; ldb: cint; beta: ptr cdouble;
                        Carray: ptr ptr cdouble; ldc: cint; batchCount: cint): cublasStatus_t {.
    cdecl, importc: "cublasDgemmBatched", dynlib: libName.}
proc cublasDgemmBatched_64*(handle: cublasHandle_t; transa: cublasOperation_t;
                           transb: cublasOperation_t; m: clonglong; n: clonglong;
                           k: clonglong; alpha: ptr cdouble; Aarray: ptr ptr cdouble;
                           lda: clonglong; Barray: ptr ptr cdouble; ldb: clonglong;
                           beta: ptr cdouble; Carray: ptr ptr cdouble; ldc: clonglong;
                           batchCount: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasDgemmBatched_64", dynlib: libName.}
proc cublasCgemmBatched*(handle: cublasHandle_t; transa: cublasOperation_t;
                        transb: cublasOperation_t; m: cint; n: cint; k: cint;
                        alpha: ptr cuComplex; Aarray: ptr ptr cuComplex; lda: cint;
                        Barray: ptr ptr cuComplex; ldb: cint; beta: ptr cuComplex;
                        Carray: ptr ptr cuComplex; ldc: cint; batchCount: cint): cublasStatus_t {.
    cdecl, importc: "cublasCgemmBatched", dynlib: libName.}
proc cublasCgemmBatched_64*(handle: cublasHandle_t; transa: cublasOperation_t;
                           transb: cublasOperation_t; m: clonglong; n: clonglong;
                           k: clonglong; alpha: ptr cuComplex;
                           Aarray: ptr ptr cuComplex; lda: clonglong;
                           Barray: ptr ptr cuComplex; ldb: clonglong;
                           beta: ptr cuComplex; Carray: ptr ptr cuComplex;
                           ldc: clonglong; batchCount: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasCgemmBatched_64", dynlib: libName.}
proc cublasCgemm3mBatched*(handle: cublasHandle_t; transa: cublasOperation_t;
                          transb: cublasOperation_t; m: cint; n: cint; k: cint;
                          alpha: ptr cuComplex; Aarray: ptr ptr cuComplex; lda: cint;
                          Barray: ptr ptr cuComplex; ldb: cint; beta: ptr cuComplex;
                          Carray: ptr ptr cuComplex; ldc: cint; batchCount: cint): cublasStatus_t {.
    cdecl, importc: "cublasCgemm3mBatched", dynlib: libName.}
proc cublasCgemm3mBatched_64*(handle: cublasHandle_t; transa: cublasOperation_t;
                             transb: cublasOperation_t; m: clonglong; n: clonglong;
                             k: clonglong; alpha: ptr cuComplex;
                             Aarray: ptr ptr cuComplex; lda: clonglong;
                             Barray: ptr ptr cuComplex; ldb: clonglong;
                             beta: ptr cuComplex; Carray: ptr ptr cuComplex;
                             ldc: clonglong; batchCount: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasCgemm3mBatched_64", dynlib: libName.}
proc cublasZgemmBatched*(handle: cublasHandle_t; transa: cublasOperation_t;
                        transb: cublasOperation_t; m: cint; n: cint; k: cint;
                        alpha: ptr cuDoubleComplex;
                        Aarray: ptr ptr cuDoubleComplex; lda: cint;
                        Barray: ptr ptr cuDoubleComplex; ldb: cint;
                        beta: ptr cuDoubleComplex; Carray: ptr ptr cuDoubleComplex;
                        ldc: cint; batchCount: cint): cublasStatus_t {.cdecl,
    importc: "cublasZgemmBatched", dynlib: libName.}
proc cublasZgemmBatched_64*(handle: cublasHandle_t; transa: cublasOperation_t;
                           transb: cublasOperation_t; m: clonglong; n: clonglong;
                           k: clonglong; alpha: ptr cuDoubleComplex;
                           Aarray: ptr ptr cuDoubleComplex; lda: clonglong;
                           Barray: ptr ptr cuDoubleComplex; ldb: clonglong;
                           beta: ptr cuDoubleComplex;
                           Carray: ptr ptr cuDoubleComplex; ldc: clonglong;
                           batchCount: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasZgemmBatched_64", dynlib: libName.}
proc cublasSgemmStridedBatched*(handle: cublasHandle_t; transa: cublasOperation_t;
                               transb: cublasOperation_t; m: cint; n: cint; k: cint;
                               alpha: ptr cfloat; A: ptr cfloat; lda: cint;
                               strideA: clonglong; B: ptr cfloat; ldb: cint;
                               strideB: clonglong; beta: ptr cfloat; C: ptr cfloat;
                               ldc: cint; strideC: clonglong; batchCount: cint): cublasStatus_t {.
    cdecl, importc: "cublasSgemmStridedBatched", dynlib: libName.}
proc cublasSgemmStridedBatched_64*(handle: cublasHandle_t;
                                  transa: cublasOperation_t;
                                  transb: cublasOperation_t; m: clonglong;
                                  n: clonglong; k: clonglong; alpha: ptr cfloat;
                                  A: ptr cfloat; lda: clonglong; strideA: clonglong;
                                  B: ptr cfloat; ldb: clonglong; strideB: clonglong;
                                  beta: ptr cfloat; C: ptr cfloat; ldc: clonglong;
                                  strideC: clonglong; batchCount: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasSgemmStridedBatched_64", dynlib: libName.}
proc cublasDgemmStridedBatched*(handle: cublasHandle_t; transa: cublasOperation_t;
                               transb: cublasOperation_t; m: cint; n: cint; k: cint;
                               alpha: ptr cdouble; A: ptr cdouble; lda: cint;
                               strideA: clonglong; B: ptr cdouble; ldb: cint;
                               strideB: clonglong; beta: ptr cdouble; C: ptr cdouble;
                               ldc: cint; strideC: clonglong; batchCount: cint): cublasStatus_t {.
    cdecl, importc: "cublasDgemmStridedBatched", dynlib: libName.}
proc cublasDgemmStridedBatched_64*(handle: cublasHandle_t;
                                  transa: cublasOperation_t;
                                  transb: cublasOperation_t; m: clonglong;
                                  n: clonglong; k: clonglong; alpha: ptr cdouble;
                                  A: ptr cdouble; lda: clonglong; strideA: clonglong;
                                  B: ptr cdouble; ldb: clonglong; strideB: clonglong;
                                  beta: ptr cdouble; C: ptr cdouble; ldc: clonglong;
                                  strideC: clonglong; batchCount: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasDgemmStridedBatched_64", dynlib: libName.}
proc cublasCgemmStridedBatched*(handle: cublasHandle_t; transa: cublasOperation_t;
                               transb: cublasOperation_t; m: cint; n: cint; k: cint;
                               alpha: ptr cuComplex; A: ptr cuComplex; lda: cint;
                               strideA: clonglong; B: ptr cuComplex; ldb: cint;
                               strideB: clonglong; beta: ptr cuComplex;
                               C: ptr cuComplex; ldc: cint; strideC: clonglong;
                               batchCount: cint): cublasStatus_t {.cdecl,
    importc: "cublasCgemmStridedBatched", dynlib: libName.}
proc cublasCgemmStridedBatched_64*(handle: cublasHandle_t;
                                  transa: cublasOperation_t;
                                  transb: cublasOperation_t; m: clonglong;
                                  n: clonglong; k: clonglong; alpha: ptr cuComplex;
                                  A: ptr cuComplex; lda: clonglong;
                                  strideA: clonglong; B: ptr cuComplex;
                                  ldb: clonglong; strideB: clonglong;
                                  beta: ptr cuComplex; C: ptr cuComplex;
                                  ldc: clonglong; strideC: clonglong;
                                  batchCount: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasCgemmStridedBatched_64", dynlib: libName.}
proc cublasCgemm3mStridedBatched*(handle: cublasHandle_t;
                                 transa: cublasOperation_t;
                                 transb: cublasOperation_t; m: cint; n: cint; k: cint;
                                 alpha: ptr cuComplex; A: ptr cuComplex; lda: cint;
                                 strideA: clonglong; B: ptr cuComplex; ldb: cint;
                                 strideB: clonglong; beta: ptr cuComplex;
                                 C: ptr cuComplex; ldc: cint; strideC: clonglong;
                                 batchCount: cint): cublasStatus_t {.cdecl,
    importc: "cublasCgemm3mStridedBatched", dynlib: libName.}
proc cublasCgemm3mStridedBatched_64*(handle: cublasHandle_t;
                                    transa: cublasOperation_t;
                                    transb: cublasOperation_t; m: clonglong;
                                    n: clonglong; k: clonglong;
                                    alpha: ptr cuComplex; A: ptr cuComplex;
                                    lda: clonglong; strideA: clonglong;
                                    B: ptr cuComplex; ldb: clonglong;
                                    strideB: clonglong; beta: ptr cuComplex;
                                    C: ptr cuComplex; ldc: clonglong;
                                    strideC: clonglong; batchCount: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasCgemm3mStridedBatched_64", dynlib: libName.}
proc cublasZgemmStridedBatched*(handle: cublasHandle_t; transa: cublasOperation_t;
                               transb: cublasOperation_t; m: cint; n: cint; k: cint;
                               alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex;
                               lda: cint; strideA: clonglong;
                               B: ptr cuDoubleComplex; ldb: cint; strideB: clonglong;
                               beta: ptr cuDoubleComplex; C: ptr cuDoubleComplex;
                               ldc: cint; strideC: clonglong; batchCount: cint): cublasStatus_t {.
    cdecl, importc: "cublasZgemmStridedBatched", dynlib: libName.}
proc cublasZgemmStridedBatched_64*(handle: cublasHandle_t;
                                  transa: cublasOperation_t;
                                  transb: cublasOperation_t; m: clonglong;
                                  n: clonglong; k: clonglong;
                                  alpha: ptr cuDoubleComplex;
                                  A: ptr cuDoubleComplex; lda: clonglong;
                                  strideA: clonglong; B: ptr cuDoubleComplex;
                                  ldb: clonglong; strideB: clonglong;
                                  beta: ptr cuDoubleComplex;
                                  C: ptr cuDoubleComplex; ldc: clonglong;
                                  strideC: clonglong; batchCount: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasZgemmStridedBatched_64", dynlib: libName.}
proc cublasGemmBatchedEx*(handle: cublasHandle_t; transa: cublasOperation_t;
                         transb: cublasOperation_t; m: cint; n: cint; k: cint;
                         alpha: pointer; Aarray: ptr pointer; Atype: cudaDataType;
                         lda: cint; Barray: ptr pointer; Btype: cudaDataType;
                         ldb: cint; beta: pointer; Carray: ptr pointer;
                         Ctype: cudaDataType; ldc: cint; batchCount: cint;
                         computeType: cublasComputeType_t; algo: cublasGemmAlgo_t): cublasStatus_t {.
    cdecl, importc: "cublasGemmBatchedEx", dynlib: libName.}
proc cublasGemmBatchedEx_64*(handle: cublasHandle_t; transa: cublasOperation_t;
                            transb: cublasOperation_t; m: clonglong; n: clonglong;
                            k: clonglong; alpha: pointer; Aarray: ptr pointer;
                            Atype: cudaDataType; lda: clonglong;
                            Barray: ptr pointer; Btype: cudaDataType; ldb: clonglong;
                            beta: pointer; Carray: ptr pointer; Ctype: cudaDataType;
                            ldc: clonglong; batchCount: clonglong;
                            computeType: cublasComputeType_t;
                            algo: cublasGemmAlgo_t): cublasStatus_t {.cdecl,
    importc: "cublasGemmBatchedEx_64", dynlib: libName.}
proc cublasGemmStridedBatchedEx*(handle: cublasHandle_t; transa: cublasOperation_t;
                                transb: cublasOperation_t; m: cint; n: cint; k: cint;
                                alpha: pointer; A: pointer; Atype: cudaDataType;
                                lda: cint; strideA: clonglong; B: pointer;
                                Btype: cudaDataType; ldb: cint; strideB: clonglong;
                                beta: pointer; C: pointer; Ctype: cudaDataType;
                                ldc: cint; strideC: clonglong; batchCount: cint;
                                computeType: cublasComputeType_t;
                                algo: cublasGemmAlgo_t): cublasStatus_t {.cdecl,
    importc: "cublasGemmStridedBatchedEx", dynlib: libName.}
proc cublasGemmStridedBatchedEx_64*(handle: cublasHandle_t;
                                   transa: cublasOperation_t;
                                   transb: cublasOperation_t; m: clonglong;
                                   n: clonglong; k: clonglong; alpha: pointer;
                                   A: pointer; Atype: cudaDataType; lda: clonglong;
                                   strideA: clonglong; B: pointer;
                                   Btype: cudaDataType; ldb: clonglong;
                                   strideB: clonglong; beta: pointer; C: pointer;
                                   Ctype: cudaDataType; ldc: clonglong;
                                   strideC: clonglong; batchCount: clonglong;
                                   computeType: cublasComputeType_t;
                                   algo: cublasGemmAlgo_t): cublasStatus_t {.cdecl,
    importc: "cublasGemmStridedBatchedEx_64", dynlib: libName.}
proc cublasSgemmGroupedBatched*(handle: cublasHandle_t;
                               transa_array: ptr cublasOperation_t;
                               transb_array: ptr cublasOperation_t;
                               m_array: ptr cint; n_array: ptr cint;
                               k_array: ptr cint; alpha_array: ptr cfloat;
                               Aarray: ptr ptr cfloat; lda_array: ptr cint;
                               Barray: ptr ptr cfloat; ldb_array: ptr cint;
                               beta_array: ptr cfloat; Carray: ptr ptr cfloat;
                               ldc_array: ptr cint; group_count: cint;
                               group_size: ptr cint): cublasStatus_t {.cdecl,
    importc: "cublasSgemmGroupedBatched", dynlib: libName.}
proc cublasSgemmGroupedBatched_64*(handle: cublasHandle_t;
                                  transa_array: ptr cublasOperation_t;
                                  transb_array: ptr cublasOperation_t;
                                  m_array: ptr clonglong; n_array: ptr clonglong;
                                  k_array: ptr clonglong; alpha_array: ptr cfloat;
                                  Aarray: ptr ptr cfloat; lda_array: ptr clonglong;
                                  Barray: ptr ptr cfloat; ldb_array: ptr clonglong;
                                  beta_array: ptr cfloat; Carray: ptr ptr cfloat;
                                  ldc_array: ptr clonglong; group_count: clonglong;
                                  group_size: ptr clonglong): cublasStatus_t {.
    cdecl, importc: "cublasSgemmGroupedBatched_64", dynlib: libName.}
proc cublasDgemmGroupedBatched*(handle: cublasHandle_t;
                               transa_array: ptr cublasOperation_t;
                               transb_array: ptr cublasOperation_t;
                               m_array: ptr cint; n_array: ptr cint;
                               k_array: ptr cint; alpha_array: ptr cdouble;
                               Aarray: ptr ptr cdouble; lda_array: ptr cint;
                               Barray: ptr ptr cdouble; ldb_array: ptr cint;
                               beta_array: ptr cdouble; Carray: ptr ptr cdouble;
                               ldc_array: ptr cint; group_count: cint;
                               group_size: ptr cint): cublasStatus_t {.cdecl,
    importc: "cublasDgemmGroupedBatched", dynlib: libName.}
proc cublasDgemmGroupedBatched_64*(handle: cublasHandle_t;
                                  transa_array: ptr cublasOperation_t;
                                  transb_array: ptr cublasOperation_t;
                                  m_array: ptr clonglong; n_array: ptr clonglong;
                                  k_array: ptr clonglong; alpha_array: ptr cdouble;
                                  Aarray: ptr ptr cdouble; lda_array: ptr clonglong;
                                  Barray: ptr ptr cdouble; ldb_array: ptr clonglong;
                                  beta_array: ptr cdouble; Carray: ptr ptr cdouble;
                                  ldc_array: ptr clonglong; group_count: clonglong;
                                  group_size: ptr clonglong): cublasStatus_t {.
    cdecl, importc: "cublasDgemmGroupedBatched_64", dynlib: libName.}
proc cublasGemmGroupedBatchedEx*(handle: cublasHandle_t;
                                transa_array: ptr cublasOperation_t;
                                transb_array: ptr cublasOperation_t;
                                m_array: ptr cint; n_array: ptr cint;
                                k_array: ptr cint; alpha_array: pointer;
                                Aarray: ptr pointer; Atype: cudaDataType_t;
                                lda_array: ptr cint; Barray: ptr pointer;
                                Btype: cudaDataType_t; ldb_array: ptr cint;
                                beta_array: pointer; Carray: ptr pointer;
                                Ctype: cudaDataType_t; ldc_array: ptr cint;
                                group_count: cint; group_size: ptr cint;
                                computeType: cublasComputeType_t): cublasStatus_t {.
    cdecl, importc: "cublasGemmGroupedBatchedEx", dynlib: libName.}
proc cublasGemmGroupedBatchedEx_64*(handle: cublasHandle_t;
                                   transa_array: ptr cublasOperation_t;
                                   transb_array: ptr cublasOperation_t;
                                   m_array: ptr clonglong; n_array: ptr clonglong;
                                   k_array: ptr clonglong; alpha_array: pointer;
                                   Aarray: ptr pointer; Atype: cudaDataType_t;
                                   lda_array: ptr clonglong; Barray: ptr pointer;
                                   Btype: cudaDataType_t;
                                   ldb_array: ptr clonglong; beta_array: pointer;
                                   Carray: ptr pointer; Ctype: cudaDataType_t;
                                   ldc_array: ptr clonglong;
                                   group_count: clonglong;
                                   group_size: ptr clonglong;
                                   computeType: cublasComputeType_t): cublasStatus_t {.
    cdecl, importc: "cublasGemmGroupedBatchedEx_64", dynlib: libName.}
##  ---------------- CUBLAS BLAS-like Extension ----------------
##  GEAM

proc cublasSgeam*(handle: cublasHandle_t; transa: cublasOperation_t;
                 transb: cublasOperation_t; m: cint; n: cint; alpha: ptr cfloat;
                 A: ptr cfloat; lda: cint; beta: ptr cfloat; B: ptr cfloat; ldb: cint;
                 C: ptr cfloat; ldc: cint): cublasStatus_t {.cdecl,
    importc: "cublasSgeam", dynlib: libName.}
proc cublasSgeam_64*(handle: cublasHandle_t; transa: cublasOperation_t;
                    transb: cublasOperation_t; m: clonglong; n: clonglong;
                    alpha: ptr cfloat; A: ptr cfloat; lda: clonglong; beta: ptr cfloat;
                    B: ptr cfloat; ldb: clonglong; C: ptr cfloat; ldc: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasSgeam_64", dynlib: libName.}
proc cublasDgeam*(handle: cublasHandle_t; transa: cublasOperation_t;
                 transb: cublasOperation_t; m: cint; n: cint; alpha: ptr cdouble;
                 A: ptr cdouble; lda: cint; beta: ptr cdouble; B: ptr cdouble; ldb: cint;
                 C: ptr cdouble; ldc: cint): cublasStatus_t {.cdecl,
    importc: "cublasDgeam", dynlib: libName.}
proc cublasDgeam_64*(handle: cublasHandle_t; transa: cublasOperation_t;
                    transb: cublasOperation_t; m: clonglong; n: clonglong;
                    alpha: ptr cdouble; A: ptr cdouble; lda: clonglong;
                    beta: ptr cdouble; B: ptr cdouble; ldb: clonglong; C: ptr cdouble;
                    ldc: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasDgeam_64", dynlib: libName.}
proc cublasCgeam*(handle: cublasHandle_t; transa: cublasOperation_t;
                 transb: cublasOperation_t; m: cint; n: cint; alpha: ptr cuComplex;
                 A: ptr cuComplex; lda: cint; beta: ptr cuComplex; B: ptr cuComplex;
                 ldb: cint; C: ptr cuComplex; ldc: cint): cublasStatus_t {.cdecl,
    importc: "cublasCgeam", dynlib: libName.}
proc cublasCgeam_64*(handle: cublasHandle_t; transa: cublasOperation_t;
                    transb: cublasOperation_t; m: clonglong; n: clonglong;
                    alpha: ptr cuComplex; A: ptr cuComplex; lda: clonglong;
                    beta: ptr cuComplex; B: ptr cuComplex; ldb: clonglong;
                    C: ptr cuComplex; ldc: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasCgeam_64", dynlib: libName.}
proc cublasZgeam*(handle: cublasHandle_t; transa: cublasOperation_t;
                 transb: cublasOperation_t; m: cint; n: cint;
                 alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex; lda: cint;
                 beta: ptr cuDoubleComplex; B: ptr cuDoubleComplex; ldb: cint;
                 C: ptr cuDoubleComplex; ldc: cint): cublasStatus_t {.cdecl,
    importc: "cublasZgeam", dynlib: libName.}
proc cublasZgeam_64*(handle: cublasHandle_t; transa: cublasOperation_t;
                    transb: cublasOperation_t; m: clonglong; n: clonglong;
                    alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex;
                    lda: clonglong; beta: ptr cuDoubleComplex;
                    B: ptr cuDoubleComplex; ldb: clonglong; C: ptr cuDoubleComplex;
                    ldc: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasZgeam_64", dynlib: libName.}
##  TRSM - Batched Triangular Solver

proc cublasStrsmBatched*(handle: cublasHandle_t; side: cublasSideMode_t;
                        uplo: cublasFillMode_t; trans: cublasOperation_t;
                        diag: cublasDiagType_t; m: cint; n: cint; alpha: ptr cfloat;
                        A: ptr ptr cfloat; lda: cint; B: ptr ptr cfloat; ldb: cint;
                        batchCount: cint): cublasStatus_t {.cdecl,
    importc: "cublasStrsmBatched", dynlib: libName.}
proc cublasStrsmBatched_64*(handle: cublasHandle_t; side: cublasSideMode_t;
                           uplo: cublasFillMode_t; trans: cublasOperation_t;
                           diag: cublasDiagType_t; m: clonglong; n: clonglong;
                           alpha: ptr cfloat; A: ptr ptr cfloat; lda: clonglong;
                           B: ptr ptr cfloat; ldb: clonglong; batchCount: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasStrsmBatched_64", dynlib: libName.}
proc cublasDtrsmBatched*(handle: cublasHandle_t; side: cublasSideMode_t;
                        uplo: cublasFillMode_t; trans: cublasOperation_t;
                        diag: cublasDiagType_t; m: cint; n: cint; alpha: ptr cdouble;
                        A: ptr ptr cdouble; lda: cint; B: ptr ptr cdouble; ldb: cint;
                        batchCount: cint): cublasStatus_t {.cdecl,
    importc: "cublasDtrsmBatched", dynlib: libName.}
proc cublasDtrsmBatched_64*(handle: cublasHandle_t; side: cublasSideMode_t;
                           uplo: cublasFillMode_t; trans: cublasOperation_t;
                           diag: cublasDiagType_t; m: clonglong; n: clonglong;
                           alpha: ptr cdouble; A: ptr ptr cdouble; lda: clonglong;
                           B: ptr ptr cdouble; ldb: clonglong; batchCount: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasDtrsmBatched_64", dynlib: libName.}
proc cublasCtrsmBatched*(handle: cublasHandle_t; side: cublasSideMode_t;
                        uplo: cublasFillMode_t; trans: cublasOperation_t;
                        diag: cublasDiagType_t; m: cint; n: cint;
                        alpha: ptr cuComplex; A: ptr ptr cuComplex; lda: cint;
                        B: ptr ptr cuComplex; ldb: cint; batchCount: cint): cublasStatus_t {.
    cdecl, importc: "cublasCtrsmBatched", dynlib: libName.}
proc cublasCtrsmBatched_64*(handle: cublasHandle_t; side: cublasSideMode_t;
                           uplo: cublasFillMode_t; trans: cublasOperation_t;
                           diag: cublasDiagType_t; m: clonglong; n: clonglong;
                           alpha: ptr cuComplex; A: ptr ptr cuComplex; lda: clonglong;
                           B: ptr ptr cuComplex; ldb: clonglong; batchCount: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasCtrsmBatched_64", dynlib: libName.}
proc cublasZtrsmBatched*(handle: cublasHandle_t; side: cublasSideMode_t;
                        uplo: cublasFillMode_t; trans: cublasOperation_t;
                        diag: cublasDiagType_t; m: cint; n: cint;
                        alpha: ptr cuDoubleComplex; A: ptr ptr cuDoubleComplex;
                        lda: cint; B: ptr ptr cuDoubleComplex; ldb: cint;
                        batchCount: cint): cublasStatus_t {.cdecl,
    importc: "cublasZtrsmBatched", dynlib: libName.}
proc cublasZtrsmBatched_64*(handle: cublasHandle_t; side: cublasSideMode_t;
                           uplo: cublasFillMode_t; trans: cublasOperation_t;
                           diag: cublasDiagType_t; m: clonglong; n: clonglong;
                           alpha: ptr cuDoubleComplex; A: ptr ptr cuDoubleComplex;
                           lda: clonglong; B: ptr ptr cuDoubleComplex; ldb: clonglong;
                           batchCount: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasZtrsmBatched_64", dynlib: libName.}
##  DGMM

proc cublasSdgmm*(handle: cublasHandle_t; mode: cublasSideMode_t; m: cint; n: cint;
                 A: ptr cfloat; lda: cint; x: ptr cfloat; incx: cint; C: ptr cfloat;
                 ldc: cint): cublasStatus_t {.cdecl, importc: "cublasSdgmm",
    dynlib: libName.}
proc cublasSdgmm_64*(handle: cublasHandle_t; mode: cublasSideMode_t; m: clonglong;
                    n: clonglong; A: ptr cfloat; lda: clonglong; x: ptr cfloat;
                    incx: clonglong; C: ptr cfloat; ldc: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasSdgmm_64", dynlib: libName.}
proc cublasDdgmm*(handle: cublasHandle_t; mode: cublasSideMode_t; m: cint; n: cint;
                 A: ptr cdouble; lda: cint; x: ptr cdouble; incx: cint; C: ptr cdouble;
                 ldc: cint): cublasStatus_t {.cdecl, importc: "cublasDdgmm",
    dynlib: libName.}
proc cublasDdgmm_64*(handle: cublasHandle_t; mode: cublasSideMode_t; m: clonglong;
                    n: clonglong; A: ptr cdouble; lda: clonglong; x: ptr cdouble;
                    incx: clonglong; C: ptr cdouble; ldc: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasDdgmm_64", dynlib: libName.}
proc cublasCdgmm*(handle: cublasHandle_t; mode: cublasSideMode_t; m: cint; n: cint;
                 A: ptr cuComplex; lda: cint; x: ptr cuComplex; incx: cint;
                 C: ptr cuComplex; ldc: cint): cublasStatus_t {.cdecl,
    importc: "cublasCdgmm", dynlib: libName.}
proc cublasCdgmm_64*(handle: cublasHandle_t; mode: cublasSideMode_t; m: clonglong;
                    n: clonglong; A: ptr cuComplex; lda: clonglong; x: ptr cuComplex;
                    incx: clonglong; C: ptr cuComplex; ldc: clonglong): cublasStatus_t {.
    cdecl, importc: "cublasCdgmm_64", dynlib: libName.}
proc cublasZdgmm*(handle: cublasHandle_t; mode: cublasSideMode_t; m: cint; n: cint;
                 A: ptr cuDoubleComplex; lda: cint; x: ptr cuDoubleComplex; incx: cint;
                 C: ptr cuDoubleComplex; ldc: cint): cublasStatus_t {.cdecl,
    importc: "cublasZdgmm", dynlib: libName.}
proc cublasZdgmm_64*(handle: cublasHandle_t; mode: cublasSideMode_t; m: clonglong;
                    n: clonglong; A: ptr cuDoubleComplex; lda: clonglong;
                    x: ptr cuDoubleComplex; incx: clonglong; C: ptr cuDoubleComplex;
                    ldc: clonglong): cublasStatus_t {.cdecl,
    importc: "cublasZdgmm_64", dynlib: libName.}
##  Batched - MATINV

proc cublasSmatinvBatched*(handle: cublasHandle_t; n: cint; A: ptr ptr cfloat; lda: cint;
                          Ainv: ptr ptr cfloat; lda_inv: cint; info: ptr cint;
                          batchSize: cint): cublasStatus_t {.cdecl,
    importc: "cublasSmatinvBatched", dynlib: libName.}
proc cublasDmatinvBatched*(handle: cublasHandle_t; n: cint; A: ptr ptr cdouble;
                          lda: cint; Ainv: ptr ptr cdouble; lda_inv: cint;
                          info: ptr cint; batchSize: cint): cublasStatus_t {.cdecl,
    importc: "cublasDmatinvBatched", dynlib: libName.}
proc cublasCmatinvBatched*(handle: cublasHandle_t; n: cint; A: ptr ptr cuComplex;
                          lda: cint; Ainv: ptr ptr cuComplex; lda_inv: cint;
                          info: ptr cint; batchSize: cint): cublasStatus_t {.cdecl,
    importc: "cublasCmatinvBatched", dynlib: libName.}
proc cublasZmatinvBatched*(handle: cublasHandle_t; n: cint;
                          A: ptr ptr cuDoubleComplex; lda: cint;
                          Ainv: ptr ptr cuDoubleComplex; lda_inv: cint;
                          info: ptr cint; batchSize: cint): cublasStatus_t {.cdecl,
    importc: "cublasZmatinvBatched", dynlib: libName.}
##  Batch QR Factorization

proc cublasSgeqrfBatched*(handle: cublasHandle_t; m: cint; n: cint;
                         Aarray: ptr ptr cfloat; lda: cint; TauArray: ptr ptr cfloat;
                         info: ptr cint; batchSize: cint): cublasStatus_t {.cdecl,
    importc: "cublasSgeqrfBatched", dynlib: libName.}
proc cublasDgeqrfBatched*(handle: cublasHandle_t; m: cint; n: cint;
                         Aarray: ptr ptr cdouble; lda: cint;
                         TauArray: ptr ptr cdouble; info: ptr cint; batchSize: cint): cublasStatus_t {.
    cdecl, importc: "cublasDgeqrfBatched", dynlib: libName.}
proc cublasCgeqrfBatched*(handle: cublasHandle_t; m: cint; n: cint;
                         Aarray: ptr ptr cuComplex; lda: cint;
                         TauArray: ptr ptr cuComplex; info: ptr cint; batchSize: cint): cublasStatus_t {.
    cdecl, importc: "cublasCgeqrfBatched", dynlib: libName.}
proc cublasZgeqrfBatched*(handle: cublasHandle_t; m: cint; n: cint;
                         Aarray: ptr ptr cuDoubleComplex; lda: cint;
                         TauArray: ptr ptr cuDoubleComplex; info: ptr cint;
                         batchSize: cint): cublasStatus_t {.cdecl,
    importc: "cublasZgeqrfBatched", dynlib: libName.}
##  Least Square Min only m >= n and Non-transpose supported

proc cublasSgelsBatched*(handle: cublasHandle_t; trans: cublasOperation_t; m: cint;
                        n: cint; nrhs: cint; Aarray: ptr ptr cfloat; lda: cint;
                        Carray: ptr ptr cfloat; ldc: cint; info: ptr cint;
                        devInfoArray: ptr cint; batchSize: cint): cublasStatus_t {.
    cdecl, importc: "cublasSgelsBatched", dynlib: libName.}
proc cublasDgelsBatched*(handle: cublasHandle_t; trans: cublasOperation_t; m: cint;
                        n: cint; nrhs: cint; Aarray: ptr ptr cdouble; lda: cint;
                        Carray: ptr ptr cdouble; ldc: cint; info: ptr cint;
                        devInfoArray: ptr cint; batchSize: cint): cublasStatus_t {.
    cdecl, importc: "cublasDgelsBatched", dynlib: libName.}
proc cublasCgelsBatched*(handle: cublasHandle_t; trans: cublasOperation_t; m: cint;
                        n: cint; nrhs: cint; Aarray: ptr ptr cuComplex; lda: cint;
                        Carray: ptr ptr cuComplex; ldc: cint; info: ptr cint;
                        devInfoArray: ptr cint; batchSize: cint): cublasStatus_t {.
    cdecl, importc: "cublasCgelsBatched", dynlib: libName.}
proc cublasZgelsBatched*(handle: cublasHandle_t; trans: cublasOperation_t; m: cint;
                        n: cint; nrhs: cint; Aarray: ptr ptr cuDoubleComplex; lda: cint;
                        Carray: ptr ptr cuDoubleComplex; ldc: cint; info: ptr cint;
                        devInfoArray: ptr cint; batchSize: cint): cublasStatus_t {.
    cdecl, importc: "cublasZgelsBatched", dynlib: libName.}
##  TPTTR : Triangular Pack format to Triangular format

proc cublasStpttr*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                  AP: ptr cfloat; A: ptr cfloat; lda: cint): cublasStatus_t {.cdecl,
    importc: "cublasStpttr", dynlib: libName.}
proc cublasDtpttr*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                  AP: ptr cdouble; A: ptr cdouble; lda: cint): cublasStatus_t {.cdecl,
    importc: "cublasDtpttr", dynlib: libName.}
proc cublasCtpttr*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                  AP: ptr cuComplex; A: ptr cuComplex; lda: cint): cublasStatus_t {.
    cdecl, importc: "cublasCtpttr", dynlib: libName.}
proc cublasZtpttr*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                  AP: ptr cuDoubleComplex; A: ptr cuDoubleComplex; lda: cint): cublasStatus_t {.
    cdecl, importc: "cublasZtpttr", dynlib: libName.}
##  TRTTP : Triangular format to Triangular Pack format

proc cublasStrttp*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                  A: ptr cfloat; lda: cint; AP: ptr cfloat): cublasStatus_t {.cdecl,
    importc: "cublasStrttp", dynlib: libName.}
proc cublasDtrttp*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                  A: ptr cdouble; lda: cint; AP: ptr cdouble): cublasStatus_t {.cdecl,
    importc: "cublasDtrttp", dynlib: libName.}
proc cublasCtrttp*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                  A: ptr cuComplex; lda: cint; AP: ptr cuComplex): cublasStatus_t {.
    cdecl, importc: "cublasCtrttp", dynlib: libName.}
proc cublasZtrttp*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                  A: ptr cuDoubleComplex; lda: cint; AP: ptr cuDoubleComplex): cublasStatus_t {.
    cdecl, importc: "cublasZtrttp", dynlib: libName.}
##  Batched LU - GETRF

proc cublasSgetrfBatched*(handle: cublasHandle_t; n: cint; A: ptr ptr cfloat; lda: cint;
                         P: ptr cint; info: ptr cint; batchSize: cint): cublasStatus_t {.
    cdecl, importc: "cublasSgetrfBatched", dynlib: libName.}
proc cublasDgetrfBatched*(handle: cublasHandle_t; n: cint; A: ptr ptr cdouble; lda: cint;
                         P: ptr cint; info: ptr cint; batchSize: cint): cublasStatus_t {.
    cdecl, importc: "cublasDgetrfBatched", dynlib: libName.}
proc cublasCgetrfBatched*(handle: cublasHandle_t; n: cint; A: ptr ptr cuComplex;
                         lda: cint; P: ptr cint; info: ptr cint; batchSize: cint): cublasStatus_t {.
    cdecl, importc: "cublasCgetrfBatched", dynlib: libName.}
proc cublasZgetrfBatched*(handle: cublasHandle_t; n: cint;
                         A: ptr ptr cuDoubleComplex; lda: cint; P: ptr cint;
                         info: ptr cint; batchSize: cint): cublasStatus_t {.cdecl,
    importc: "cublasZgetrfBatched", dynlib: libName.}
##  Batched inversion based on LU factorization from getrf

proc cublasSgetriBatched*(handle: cublasHandle_t; n: cint; A: ptr ptr cfloat; lda: cint;
                         P: ptr cint; C: ptr ptr cfloat; ldc: cint; info: ptr cint;
                         batchSize: cint): cublasStatus_t {.cdecl,
    importc: "cublasSgetriBatched", dynlib: libName.}
proc cublasDgetriBatched*(handle: cublasHandle_t; n: cint; A: ptr ptr cdouble; lda: cint;
                         P: ptr cint; C: ptr ptr cdouble; ldc: cint; info: ptr cint;
                         batchSize: cint): cublasStatus_t {.cdecl,
    importc: "cublasDgetriBatched", dynlib: libName.}
proc cublasCgetriBatched*(handle: cublasHandle_t; n: cint; A: ptr ptr cuComplex;
                         lda: cint; P: ptr cint; C: ptr ptr cuComplex; ldc: cint;
                         info: ptr cint; batchSize: cint): cublasStatus_t {.cdecl,
    importc: "cublasCgetriBatched", dynlib: libName.}
proc cublasZgetriBatched*(handle: cublasHandle_t; n: cint;
                         A: ptr ptr cuDoubleComplex; lda: cint; P: ptr cint;
                         C: ptr ptr cuDoubleComplex; ldc: cint; info: ptr cint;
                         batchSize: cint): cublasStatus_t {.cdecl,
    importc: "cublasZgetriBatched", dynlib: libName.}
##  Batched solver based on LU factorization from getrf

proc cublasSgetrsBatched*(handle: cublasHandle_t; trans: cublasOperation_t; n: cint;
                         nrhs: cint; Aarray: ptr ptr cfloat; lda: cint;
                         devIpiv: ptr cint; Barray: ptr ptr cfloat; ldb: cint;
                         info: ptr cint; batchSize: cint): cublasStatus_t {.cdecl,
    importc: "cublasSgetrsBatched", dynlib: libName.}
proc cublasDgetrsBatched*(handle: cublasHandle_t; trans: cublasOperation_t; n: cint;
                         nrhs: cint; Aarray: ptr ptr cdouble; lda: cint;
                         devIpiv: ptr cint; Barray: ptr ptr cdouble; ldb: cint;
                         info: ptr cint; batchSize: cint): cublasStatus_t {.cdecl,
    importc: "cublasDgetrsBatched", dynlib: libName.}
proc cublasCgetrsBatched*(handle: cublasHandle_t; trans: cublasOperation_t; n: cint;
                         nrhs: cint; Aarray: ptr ptr cuComplex; lda: cint;
                         devIpiv: ptr cint; Barray: ptr ptr cuComplex; ldb: cint;
                         info: ptr cint; batchSize: cint): cublasStatus_t {.cdecl,
    importc: "cublasCgetrsBatched", dynlib: libName.}
proc cublasZgetrsBatched*(handle: cublasHandle_t; trans: cublasOperation_t; n: cint;
                         nrhs: cint; Aarray: ptr ptr cuDoubleComplex; lda: cint;
                         devIpiv: ptr cint; Barray: ptr ptr cuDoubleComplex; ldb: cint;
                         info: ptr cint; batchSize: cint): cublasStatus_t {.cdecl,
    importc: "cublasZgetrsBatched", dynlib: libName.}
##  Deprecated

proc cublasUint8gemmBias*(handle: cublasHandle_t; transa: cublasOperation_t;
                         transb: cublasOperation_t; transc: cublasOperation_t;
                         m: cint; n: cint; k: cint; A: ptr char; A_bias: cint; lda: cint;
                         B: ptr char; B_bias: cint; ldb: cint; C: ptr char;
                         C_bias: cint; ldc: cint; C_mult: cint; C_shift: cint): cublasStatus_t {.
    cdecl, importc: "cublasUint8gemmBias", dynlib: libName.}
##  }}} cuBLAS Exported API
