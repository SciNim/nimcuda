 {.deadCodeElim: on.}
when defined(windows):
  import os
  {.passL: "\"" & os.getEnv("CUDA_PATH") / "lib/x64" / "cublas.lib" & "\"".}
  {.pragma: dyn.}
elif defined(macosx):
  const
    libName = "libcublas.dylib"
  {.pragma: dyn, dynlib: libName.}
else:
  const
    libName = "libcublas.so"
  {.pragma: dyn, dynlib: libName.}
type
  half* = object
    x*: cushort

  half2* = object
    x*: cuint

  cudaStream_t* = pointer

import
  library_types, cuComplex

##
##  Copyright 1993-2014 NVIDIA Corporation.  All rights reserved.
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

when not defined(CUBLAS_API_H):
  const
    CUBLAS_API_H* = true
  ##  CUBLAS status type returns
  type
    cublasStatus_t* {.size: sizeof(cint).} = enum
      CUBLAS_STATUS_SUCCESS = 0, CUBLAS_STATUS_NOT_INITIALIZED = 1,
      CUBLAS_STATUS_ALLOC_FAILED = 3, CUBLAS_STATUS_INVALID_VALUE = 7,
      CUBLAS_STATUS_ARCH_MISMATCH = 8, CUBLAS_STATUS_MAPPING_ERROR = 11,
      CUBLAS_STATUS_EXECUTION_FAILED = 13, CUBLAS_STATUS_INTERNAL_ERROR = 14,
      CUBLAS_STATUS_NOT_SUPPORTED = 15, CUBLAS_STATUS_LICENSE_ERROR = 16
    cublasFillMode_t* {.size: sizeof(cint).} = enum
      CUBLAS_FILL_MODE_LOWER = 0, CUBLAS_FILL_MODE_UPPER = 1
    cublasDiagType_t* {.size: sizeof(cint).} = enum
      CUBLAS_DIAG_NON_UNIT = 0, CUBLAS_DIAG_UNIT = 1
    cublasSideMode_t* {.size: sizeof(cint).} = enum
      CUBLAS_SIDE_LEFT = 0, CUBLAS_SIDE_RIGHT = 1
    cublasOperation_t* {.size: sizeof(cint).} = enum
      CUBLAS_OP_N = 0, CUBLAS_OP_T = 1, CUBLAS_OP_C = 2
    cublasPointerMode_t* {.size: sizeof(cint).} = enum
      CUBLAS_POINTER_MODE_HOST = 0, CUBLAS_POINTER_MODE_DEVICE = 1
    cublasAtomicsMode_t* {.size: sizeof(cint).} = enum
      CUBLAS_ATOMICS_NOT_ALLOWED = 0, CUBLAS_ATOMICS_ALLOWED = 1
  ## For different GEMM algorithm
  type
    cublasGemmAlgo_t* {.size: sizeof(cint).} = enum
      CUBLAS_GEMM_DFALT = - 1, CUBLAS_GEMM_ALGO0 = 0, CUBLAS_GEMM_ALGO1 = 1,
      CUBLAS_GEMM_ALGO2 = 2, CUBLAS_GEMM_ALGO3 = 3, CUBLAS_GEMM_ALGO4 = 4,
      CUBLAS_GEMM_ALGO5 = 5, CUBLAS_GEMM_ALGO6 = 6, CUBLAS_GEMM_ALGO7 = 7
  ##  For backward compatibility purposes
  type
    cublasDataType_t* = cudaDataType
  ##  Opaque structure holding CUBLAS library context
  type
    cublasContext* = object

  type
    cublasHandle_t* = ptr cublasContext
  proc cublasCreate_v2*(handle: ptr cublasHandle_t): cublasStatus_t {.cdecl,
      importc: "cublasCreate_v2", dyn.}
  proc cublasDestroy_v2*(handle: cublasHandle_t): cublasStatus_t {.cdecl,
      importc: "cublasDestroy_v2", dyn.}
  proc cublasGetVersion_v2*(handle: cublasHandle_t; version: ptr cint): cublasStatus_t {.
      cdecl, importc: "cublasGetVersion_v2", dyn.}
  proc cublasGetProperty*(`type`: libraryPropertyType; value: ptr cint): cublasStatus_t {.
      cdecl, importc: "cublasGetProperty", dyn.}
  proc cublasSetStream_v2*(handle: cublasHandle_t; streamId: cudaStream_t): cublasStatus_t {.
      cdecl, importc: "cublasSetStream_v2", dyn.}
  proc cublasGetStream_v2*(handle: cublasHandle_t; streamId: ptr cudaStream_t): cublasStatus_t {.
      cdecl, importc: "cublasGetStream_v2", dyn.}
  proc cublasGetPointerMode_v2*(handle: cublasHandle_t;
                               mode: ptr cublasPointerMode_t): cublasStatus_t {.
      cdecl, importc: "cublasGetPointerMode_v2", dyn.}
  proc cublasSetPointerMode_v2*(handle: cublasHandle_t; mode: cublasPointerMode_t): cublasStatus_t {.
      cdecl, importc: "cublasSetPointerMode_v2", dyn.}
  proc cublasGetAtomicsMode*(handle: cublasHandle_t; mode: ptr cublasAtomicsMode_t): cublasStatus_t {.
      cdecl, importc: "cublasGetAtomicsMode", dyn.}
  proc cublasSetAtomicsMode*(handle: cublasHandle_t; mode: cublasAtomicsMode_t): cublasStatus_t {.
      cdecl, importc: "cublasSetAtomicsMode", dyn.}
  ##
  ##  `cublasStatus_t`
  ##  `cublasSetVector (int n, int elemSize, const void *x, int incx,`
  ##                    `void *y, int incy)`
  ##
  ##  copies n elements from a vector x in CPU memory space to a vector y
  ##  in GPU memory space. Elements in both vectors are assumed to have a
  ##  size of elemSize bytes. Storage spacing between consecutive elements
  ##  is incx for the source vector x and incy for the destination vector
  ##  y. In general, y points to an object, or part of an object, allocated
  ##  via cublasAlloc(). Column major format for two-dimensional matrices
  ##  is assumed throughout CUBLAS. Therefore, if the increment for a vector
  ##  is equal to 1, this access a column vector while using an increment
  ##  equal to the leading dimension of the respective matrix accesses a
  ##  row vector.
  ##
  ##  Return Values
  ##  -------------
  ##  CUBLAS_STATUS_NOT_INITIALIZED  if CUBLAS library not been initialized
  ##  CUBLAS_STATUS_INVALID_VALUE    if incx, incy, or elemSize <= 0
  ##  CUBLAS_STATUS_MAPPING_ERROR    if an error occurred accessing GPU memory
  ##  CUBLAS_STATUS_SUCCESS          if the operation completed successfully
  ##
  proc cublasSetVector*(n: cint; elemSize: cint; x: pointer; incx: cint;
                       devicePtr: pointer; incy: cint): cublasStatus_t {.cdecl,
      importc: "cublasSetVector", dyn.}
  ##
  ##  cublasStatus_t
  ##  `cublasGetVector (int n, int elemSize, const void *x, int incx,`
  ##                    `void *y, int incy)`
  ##
  ##  copies n elements from a vector x in GPU memory space to a vector y
  ##  in CPU memory space. Elements in both vectors are assumed to have a
  ##  size of elemSize bytes. Storage spacing between consecutive elements
  ##  is incx for the source vector x and incy for the destination vector
  ##  y. In general, x points to an object, or part of an object, allocated
  ##  via cublasAlloc(). Column major format for two-dimensional matrices
  ##  is assumed throughout CUBLAS. Therefore, if the increment for a vector
  ##  is equal to 1, this access a column vector while using an increment
  ##  equal to the leading dimension of the respective matrix accesses a
  ##  row vector.
  ##
  ##  Return Values
  ##  -------------
  ##  CUBLAS_STATUS_NOT_INITIALIZED  if CUBLAS library not been initialized
  ##  CUBLAS_STATUS_INVALID_VALUE    if incx, incy, or elemSize <= 0
  ##  CUBLAS_STATUS_MAPPING_ERROR    if an error occurred accessing GPU memory
  ##  CUBLAS_STATUS_SUCCESS          if the operation completed successfully
  ##
  proc cublasGetVector*(n: cint; elemSize: cint; x: pointer; incx: cint; y: pointer;
                       incy: cint): cublasStatus_t {.cdecl,
      importc: "cublasGetVector", dyn.}
  ##
  ##  cublasStatus_t
  ##  `cublasSetMatrix (int rows, int cols, int elemSize, const void *A,`
  ##                   `int lda, void *B, int ldb)`
  ##
  ##  copies a tile of rows x cols elements from a matrix A in CPU memory
  ##  space to a matrix B in GPU memory space. Each element requires storage
  ##  of elemSize bytes. Both matrices are assumed to be stored in column
  ##  major format, with the leading dimension (i.e. number of rows) of
  ##  source matrix A provided in lda, and the leading dimension of matrix B
  ##  provided in ldb. In general, B points to an object, or part of an
  ##  object, that was allocated via cublasAlloc().
  ##
  ##  Return Values
  ##  -------------
  ##  CUBLAS_STATUS_NOT_INITIALIZED  if CUBLAS library has not been initialized
  ##  CUBLAS_STATUS_INVALID_VALUE    if rows or cols < 0, or elemSize, lda, or
  ##                                 ldb <= 0
  ##  CUBLAS_STATUS_MAPPING_ERROR    if error occurred accessing GPU memory
  ##  CUBLAS_STATUS_SUCCESS          if the operation completed successfully
  ##
  proc cublasSetMatrix*(rows: cint; cols: cint; elemSize: cint; A: pointer; lda: cint;
                       B: pointer; ldb: cint): cublasStatus_t {.cdecl,
      importc: "cublasSetMatrix", dyn.}
  ##
  ##  cublasStatus_t
  ##  `cublasGetMatrix (int rows, int cols, int elemSize, const void *A,`
  ##                   `int lda, void *B, int ldb)`
  ##
  ##  copies a tile of rows x cols elements from a matrix A in GPU memory
  ##  space to a matrix B in CPU memory space. Each element requires storage
  ##  of elemSize bytes. Both matrices are assumed to be stored in column
  ##  major format, with the leading dimension (i.e. number of rows) of
  ##  source matrix A provided in lda, and the leading dimension of matrix B
  ##  provided in ldb. In general, A points to an object, or part of an
  ##  object, that was allocated via cublasAlloc().
  ##
  ##  Return Values
  ##  -------------
  ##  CUBLAS_STATUS_NOT_INITIALIZED  if CUBLAS library has not been initialized
  ##  CUBLAS_STATUS_INVALID_VALUE    if rows, cols, eleSize, lda, or ldb <= 0
  ##  CUBLAS_STATUS_MAPPING_ERROR    if error occurred accessing GPU memory
  ##  CUBLAS_STATUS_SUCCESS          if the operation completed successfully
  ##
  proc cublasGetMatrix*(rows: cint; cols: cint; elemSize: cint; A: pointer; lda: cint;
                       B: pointer; ldb: cint): cublasStatus_t {.cdecl,
      importc: "cublasGetMatrix", dyn.}
  ##
  ##  cublasStatus
  ##  `cublasSetVectorAsync ( int n, int elemSize, const void *x, int incx,`
  ##                        `void *y, int incy, cudaStream_t stream );`
  ##
  ##  cublasSetVectorAsync has the same functionnality as cublasSetVector
  ##  but the transfer is done asynchronously within the CUDA stream passed
  ##  in parameter.
  ##
  ##  Return Values
  ##  -------------
  ##  CUBLAS_STATUS_NOT_INITIALIZED  if CUBLAS library not been initialized
  ##  CUBLAS_STATUS_INVALID_VALUE    if incx, incy, or elemSize <= 0
  ##  CUBLAS_STATUS_MAPPING_ERROR    if an error occurred accessing GPU memory
  ##  CUBLAS_STATUS_SUCCESS          if the operation completed successfully
  ##
  proc cublasSetVectorAsync*(n: cint; elemSize: cint; hostPtr: pointer; incx: cint;
                            devicePtr: pointer; incy: cint; stream: cudaStream_t): cublasStatus_t {.
      cdecl, importc: "cublasSetVectorAsync", dyn.}
  ##
  ##  cublasStatus
  ##  `cublasGetVectorAsync( int n, int elemSize, const void *x, int incx,`
  ##                        `void *y, int incy, cudaStream_t stream)`
  ##
  ##  cublasGetVectorAsync has the same functionnality as cublasGetVector
  ##  but the transfer is done asynchronously within the CUDA stream passed
  ##  in parameter.
  ##
  ##  Return Values
  ##  -------------
  ##  CUBLAS_STATUS_NOT_INITIALIZED  if CUBLAS library not been initialized
  ##  CUBLAS_STATUS_INVALID_VALUE    if incx, incy, or elemSize <= 0
  ##  CUBLAS_STATUS_MAPPING_ERROR    if an error occurred accessing GPU memory
  ##  CUBLAS_STATUS_SUCCESS          if the operation completed successfully
  ##
  proc cublasGetVectorAsync*(n: cint; elemSize: cint; devicePtr: pointer; incx: cint;
                            hostPtr: pointer; incy: cint; stream: cudaStream_t): cublasStatus_t {.
      cdecl, importc: "cublasGetVectorAsync", dyn.}
  ##
  ##  cublasStatus_t
  ##  `cublasSetMatrixAsync (int rows, int cols, int elemSize, const void *A,`
  ##                        `int lda, void *B, int ldb, cudaStream_t stream)`
  ##
  ##  cublasSetMatrixAsync has the same functionnality as cublasSetMatrix
  ##  but the transfer is done asynchronously within the CUDA stream passed
  ##  in parameter.
  ##
  ##  Return Values
  ##  -------------
  ##  CUBLAS_STATUS_NOT_INITIALIZED  if CUBLAS library has not been initialized
  ##  CUBLAS_STATUS_INVALID_VALUE    if rows or cols < 0, or elemSize, lda, or
  ##                                 ldb <= 0
  ##  CUBLAS_STATUS_MAPPING_ERROR    if error occurred accessing GPU memory
  ##  CUBLAS_STATUS_SUCCESS          if the operation completed successfully
  ##
  proc cublasSetMatrixAsync*(rows: cint; cols: cint; elemSize: cint; A: pointer;
                            lda: cint; B: pointer; ldb: cint; stream: cudaStream_t): cublasStatus_t {.
      cdecl, importc: "cublasSetMatrixAsync", dyn.}
  ##
  ##  cublasStatus_t
  ##  `cublasGetMatrixAsync (int rows, int cols, int elemSize, const void *A,`
  ##                        `int lda, void *B, int ldb, cudaStream_t stream)`
  ##
  ##  cublasGetMatrixAsync has the same functionnality as cublasGetMatrix
  ##  but the transfer is done asynchronously within the CUDA stream passed
  ##  in parameter.
  ##
  ##  Return Values
  ##  -------------
  ##  CUBLAS_STATUS_NOT_INITIALIZED  if CUBLAS library has not been initialized
  ##  CUBLAS_STATUS_INVALID_VALUE    if rows, cols, eleSize, lda, or ldb <= 0
  ##  CUBLAS_STATUS_MAPPING_ERROR    if error occurred accessing GPU memory
  ##  CUBLAS_STATUS_SUCCESS          if the operation completed successfully
  ##
  proc cublasGetMatrixAsync*(rows: cint; cols: cint; elemSize: cint; A: pointer;
                            lda: cint; B: pointer; ldb: cint; stream: cudaStream_t): cublasStatus_t {.
      cdecl, importc: "cublasGetMatrixAsync", dyn.}
  proc cublasXerbla*(srName: cstring; info: cint) {.cdecl, importc: "cublasXerbla",
      dyn.}
  ##  CUBLAS BLAS1 functions
  proc cublasNrm2Ex*(handle: cublasHandle_t; n: cint; x: pointer; xType: cudaDataType;
                    incx: cint; result: pointer; resultType: cudaDataType;
                    executionType: cudaDataType): cublasStatus_t {.cdecl,
      importc: "cublasNrm2Ex", dyn.}
  ##  host or device pointer
  proc cublasSnrm2_v2*(handle: cublasHandle_t; n: cint; x: ptr cfloat; incx: cint;
                      result: ptr cfloat): cublasStatus_t {.cdecl,
      importc: "cublasSnrm2_v2", dyn.}
  ##  host or device pointer
  proc cublasDnrm2_v2*(handle: cublasHandle_t; n: cint; x: ptr cdouble; incx: cint;
                      result: ptr cdouble): cublasStatus_t {.cdecl,
      importc: "cublasDnrm2_v2", dyn.}
  ##  host or device pointer
  proc cublasScnrm2_v2*(handle: cublasHandle_t; n: cint; x: ptr cuComplex; incx: cint;
                       result: ptr cfloat): cublasStatus_t {.cdecl,
      importc: "cublasScnrm2_v2", dyn.}
  ##  host or device pointer
  proc cublasDznrm2_v2*(handle: cublasHandle_t; n: cint; x: ptr cuDoubleComplex;
                       incx: cint; result: ptr cdouble): cublasStatus_t {.cdecl,
      importc: "cublasDznrm2_v2", dyn.}
  ##  host or device pointer
  proc cublasDotEx*(handle: cublasHandle_t; n: cint; x: pointer; xType: cudaDataType;
                   incx: cint; y: pointer; yType: cudaDataType; incy: cint;
                   result: pointer; resultType: cudaDataType;
                   executionType: cudaDataType): cublasStatus_t {.cdecl,
      importc: "cublasDotEx", dyn.}
  proc cublasDotcEx*(handle: cublasHandle_t; n: cint; x: pointer; xType: cudaDataType;
                    incx: cint; y: pointer; yType: cudaDataType; incy: cint;
                    result: pointer; resultType: cudaDataType;
                    executionType: cudaDataType): cublasStatus_t {.cdecl,
      importc: "cublasDotcEx", dyn.}
  proc cublasSdot_v2*(handle: cublasHandle_t; n: cint; x: ptr cfloat; incx: cint;
                     y: ptr cfloat; incy: cint; result: ptr cfloat): cublasStatus_t {.
      cdecl, importc: "cublasSdot_v2", dyn.}
  ##  host or device pointer
  proc cublasDdot_v2*(handle: cublasHandle_t; n: cint; x: ptr cdouble; incx: cint;
                     y: ptr cdouble; incy: cint; result: ptr cdouble): cublasStatus_t {.
      cdecl, importc: "cublasDdot_v2", dyn.}
  ##  host or device pointer
  proc cublasCdotu_v2*(handle: cublasHandle_t; n: cint; x: ptr cuComplex; incx: cint;
                      y: ptr cuComplex; incy: cint; result: ptr cuComplex): cublasStatus_t {.
      cdecl, importc: "cublasCdotu_v2", dyn.}
  ##  host or device pointer
  proc cublasCdotc_v2*(handle: cublasHandle_t; n: cint; x: ptr cuComplex; incx: cint;
                      y: ptr cuComplex; incy: cint; result: ptr cuComplex): cublasStatus_t {.
      cdecl, importc: "cublasCdotc_v2", dyn.}
  ##  host or device pointer
  proc cublasZdotu_v2*(handle: cublasHandle_t; n: cint; x: ptr cuDoubleComplex;
                      incx: cint; y: ptr cuDoubleComplex; incy: cint;
                      result: ptr cuDoubleComplex): cublasStatus_t {.cdecl,
      importc: "cublasZdotu_v2", dyn.}
  ##  host or device pointer
  proc cublasZdotc_v2*(handle: cublasHandle_t; n: cint; x: ptr cuDoubleComplex;
                      incx: cint; y: ptr cuDoubleComplex; incy: cint;
                      result: ptr cuDoubleComplex): cublasStatus_t {.cdecl,
      importc: "cublasZdotc_v2", dyn.}
  ##  host or device pointer
  proc cublasScalEx*(handle: cublasHandle_t; n: cint; alpha: pointer;
                    alphaType: cudaDataType; x: pointer; xType: cudaDataType;
                    incx: cint; executionType: cudaDataType): cublasStatus_t {.cdecl,
      importc: "cublasScalEx", dyn.}
    ##  host or device pointer
  proc cublasSscal_v2*(handle: cublasHandle_t; n: cint; alpha: ptr cfloat;
                      x: ptr cfloat; incx: cint): cublasStatus_t {.cdecl,
      importc: "cublasSscal_v2", dyn.}
    ##  host or device pointer
  proc cublasDscal_v2*(handle: cublasHandle_t; n: cint; alpha: ptr cdouble;
                      x: ptr cdouble; incx: cint): cublasStatus_t {.cdecl,
      importc: "cublasDscal_v2", dyn.}
    ##  host or device pointer
  proc cublasCscal_v2*(handle: cublasHandle_t; n: cint; alpha: ptr cuComplex;
                      x: ptr cuComplex; incx: cint): cublasStatus_t {.cdecl,
      importc: "cublasCscal_v2", dyn.}
    ##  host or device pointer
  proc cublasCsscal_v2*(handle: cublasHandle_t; n: cint; alpha: ptr cfloat;
                       x: ptr cuComplex; incx: cint): cublasStatus_t {.cdecl,
      importc: "cublasCsscal_v2", dyn.}
    ##  host or device pointer
  proc cublasZscal_v2*(handle: cublasHandle_t; n: cint; alpha: ptr cuDoubleComplex;
                      x: ptr cuDoubleComplex; incx: cint): cublasStatus_t {.cdecl,
      importc: "cublasZscal_v2", dyn.}
    ##  host or device pointer
  proc cublasZdscal_v2*(handle: cublasHandle_t; n: cint; alpha: ptr cdouble;
                       x: ptr cuDoubleComplex; incx: cint): cublasStatus_t {.cdecl,
      importc: "cublasZdscal_v2", dyn.}
    ##  host or device pointer
  proc cublasAxpyEx*(handle: cublasHandle_t; n: cint; alpha: pointer;
                    alphaType: cudaDataType; x: pointer; xType: cudaDataType;
                    incx: cint; y: pointer; yType: cudaDataType; incy: cint;
                    executiontype: cudaDataType): cublasStatus_t {.cdecl,
      importc: "cublasAxpyEx", dyn.}
    ##  host or device pointer
  proc cublasSaxpy_v2*(handle: cublasHandle_t; n: cint; alpha: ptr cfloat;
                      x: ptr cfloat; incx: cint; y: ptr cfloat; incy: cint): cublasStatus_t {.
      cdecl, importc: "cublasSaxpy_v2", dyn.}
    ##  host or device pointer
  proc cublasDaxpy_v2*(handle: cublasHandle_t; n: cint; alpha: ptr cdouble;
                      x: ptr cdouble; incx: cint; y: ptr cdouble; incy: cint): cublasStatus_t {.
      cdecl, importc: "cublasDaxpy_v2", dyn.}
    ##  host or device pointer
  proc cublasCaxpy_v2*(handle: cublasHandle_t; n: cint; alpha: ptr cuComplex;
                      x: ptr cuComplex; incx: cint; y: ptr cuComplex; incy: cint): cublasStatus_t {.
      cdecl, importc: "cublasCaxpy_v2", dyn.}
    ##  host or device pointer
  proc cublasZaxpy_v2*(handle: cublasHandle_t; n: cint; alpha: ptr cuDoubleComplex;
                      x: ptr cuDoubleComplex; incx: cint; y: ptr cuDoubleComplex;
                      incy: cint): cublasStatus_t {.cdecl,
      importc: "cublasZaxpy_v2", dyn.}
    ##  host or device pointer
  proc cublasScopy_v2*(handle: cublasHandle_t; n: cint; x: ptr cfloat; incx: cint;
                      y: ptr cfloat; incy: cint): cublasStatus_t {.cdecl,
      importc: "cublasScopy_v2", dyn.}
  proc cublasDcopy_v2*(handle: cublasHandle_t; n: cint; x: ptr cdouble; incx: cint;
                      y: ptr cdouble; incy: cint): cublasStatus_t {.cdecl,
      importc: "cublasDcopy_v2", dyn.}
  proc cublasCcopy_v2*(handle: cublasHandle_t; n: cint; x: ptr cuComplex; incx: cint;
                      y: ptr cuComplex; incy: cint): cublasStatus_t {.cdecl,
      importc: "cublasCcopy_v2", dyn.}
  proc cublasZcopy_v2*(handle: cublasHandle_t; n: cint; x: ptr cuDoubleComplex;
                      incx: cint; y: ptr cuDoubleComplex; incy: cint): cublasStatus_t {.
      cdecl, importc: "cublasZcopy_v2", dyn.}
  proc cublasSswap_v2*(handle: cublasHandle_t; n: cint; x: ptr cfloat; incx: cint;
                      y: ptr cfloat; incy: cint): cublasStatus_t {.cdecl,
      importc: "cublasSswap_v2", dyn.}
  proc cublasDswap_v2*(handle: cublasHandle_t; n: cint; x: ptr cdouble; incx: cint;
                      y: ptr cdouble; incy: cint): cublasStatus_t {.cdecl,
      importc: "cublasDswap_v2", dyn.}
  proc cublasCswap_v2*(handle: cublasHandle_t; n: cint; x: ptr cuComplex; incx: cint;
                      y: ptr cuComplex; incy: cint): cublasStatus_t {.cdecl,
      importc: "cublasCswap_v2", dyn.}
  proc cublasZswap_v2*(handle: cublasHandle_t; n: cint; x: ptr cuDoubleComplex;
                      incx: cint; y: ptr cuDoubleComplex; incy: cint): cublasStatus_t {.
      cdecl, importc: "cublasZswap_v2", dyn.}
  proc cublasIsamax_v2*(handle: cublasHandle_t; n: cint; x: ptr cfloat; incx: cint;
                       result: ptr cint): cublasStatus_t {.cdecl,
      importc: "cublasIsamax_v2", dyn.}
  ##  host or device pointer
  proc cublasIdamax_v2*(handle: cublasHandle_t; n: cint; x: ptr cdouble; incx: cint;
                       result: ptr cint): cublasStatus_t {.cdecl,
      importc: "cublasIdamax_v2", dyn.}
  ##  host or device pointer
  proc cublasIcamax_v2*(handle: cublasHandle_t; n: cint; x: ptr cuComplex; incx: cint;
                       result: ptr cint): cublasStatus_t {.cdecl,
      importc: "cublasIcamax_v2", dyn.}
  ##  host or device pointer
  proc cublasIzamax_v2*(handle: cublasHandle_t; n: cint; x: ptr cuDoubleComplex;
                       incx: cint; result: ptr cint): cublasStatus_t {.cdecl,
      importc: "cublasIzamax_v2", dyn.}
  ##  host or device pointer
  proc cublasIsamin_v2*(handle: cublasHandle_t; n: cint; x: ptr cfloat; incx: cint;
                       result: ptr cint): cublasStatus_t {.cdecl,
      importc: "cublasIsamin_v2", dyn.}
  ##  host or device pointer
  proc cublasIdamin_v2*(handle: cublasHandle_t; n: cint; x: ptr cdouble; incx: cint;
                       result: ptr cint): cublasStatus_t {.cdecl,
      importc: "cublasIdamin_v2", dyn.}
  ##  host or device pointer
  proc cublasIcamin_v2*(handle: cublasHandle_t; n: cint; x: ptr cuComplex; incx: cint;
                       result: ptr cint): cublasStatus_t {.cdecl,
      importc: "cublasIcamin_v2", dyn.}
  ##  host or device pointer
  proc cublasIzamin_v2*(handle: cublasHandle_t; n: cint; x: ptr cuDoubleComplex;
                       incx: cint; result: ptr cint): cublasStatus_t {.cdecl,
      importc: "cublasIzamin_v2", dyn.}
  ##  host or device pointer
  proc cublasSasum_v2*(handle: cublasHandle_t; n: cint; x: ptr cfloat; incx: cint;
                      result: ptr cfloat): cublasStatus_t {.cdecl,
      importc: "cublasSasum_v2", dyn.}
  ##  host or device pointer
  proc cublasDasum_v2*(handle: cublasHandle_t; n: cint; x: ptr cdouble; incx: cint;
                      result: ptr cdouble): cublasStatus_t {.cdecl,
      importc: "cublasDasum_v2", dyn.}
  ##  host or device pointer
  proc cublasScasum_v2*(handle: cublasHandle_t; n: cint; x: ptr cuComplex; incx: cint;
                       result: ptr cfloat): cublasStatus_t {.cdecl,
      importc: "cublasScasum_v2", dyn.}
  ##  host or device pointer
  proc cublasDzasum_v2*(handle: cublasHandle_t; n: cint; x: ptr cuDoubleComplex;
                       incx: cint; result: ptr cdouble): cublasStatus_t {.cdecl,
      importc: "cublasDzasum_v2", dyn.}
  ##  host or device pointer
  proc cublasSrot_v2*(handle: cublasHandle_t; n: cint; x: ptr cfloat; incx: cint;
                     y: ptr cfloat; incy: cint; c: ptr cfloat; s: ptr cfloat): cublasStatus_t {.
      cdecl, importc: "cublasSrot_v2", dyn.}
    ##  host or device pointer
  ##  host or device pointer
  proc cublasDrot_v2*(handle: cublasHandle_t; n: cint; x: ptr cdouble; incx: cint;
                     y: ptr cdouble; incy: cint; c: ptr cdouble; s: ptr cdouble): cublasStatus_t {.
      cdecl, importc: "cublasDrot_v2", dyn.}
    ##  host or device pointer
  ##  host or device pointer
  proc cublasCrot_v2*(handle: cublasHandle_t; n: cint; x: ptr cuComplex; incx: cint;
                     y: ptr cuComplex; incy: cint; c: ptr cfloat; s: ptr cuComplex): cublasStatus_t {.
      cdecl, importc: "cublasCrot_v2", dyn.}
    ##  host or device pointer
  ##  host or device pointer
  proc cublasCsrot_v2*(handle: cublasHandle_t; n: cint; x: ptr cuComplex; incx: cint;
                      y: ptr cuComplex; incy: cint; c: ptr cfloat; s: ptr cfloat): cublasStatus_t {.
      cdecl, importc: "cublasCsrot_v2", dyn.}
    ##  host or device pointer
  ##  host or device pointer
  proc cublasZrot_v2*(handle: cublasHandle_t; n: cint; x: ptr cuDoubleComplex;
                     incx: cint; y: ptr cuDoubleComplex; incy: cint; c: ptr cdouble;
                     s: ptr cuDoubleComplex): cublasStatus_t {.cdecl,
      importc: "cublasZrot_v2", dyn.}
    ##  host or device pointer
  ##  host or device pointer
  proc cublasZdrot_v2*(handle: cublasHandle_t; n: cint; x: ptr cuDoubleComplex;
                      incx: cint; y: ptr cuDoubleComplex; incy: cint; c: ptr cdouble;
                      s: ptr cdouble): cublasStatus_t {.cdecl,
      importc: "cublasZdrot_v2", dyn.}
    ##  host or device pointer
  ##  host or device pointer
  proc cublasSrotg_v2*(handle: cublasHandle_t; a: ptr cfloat; b: ptr cfloat;
                      c: ptr cfloat; s: ptr cfloat): cublasStatus_t {.cdecl,
      importc: "cublasSrotg_v2", dyn.}
    ##  host or device pointer
    ##  host or device pointer
    ##  host or device pointer
  ##  host or device pointer
  proc cublasDrotg_v2*(handle: cublasHandle_t; a: ptr cdouble; b: ptr cdouble;
                      c: ptr cdouble; s: ptr cdouble): cublasStatus_t {.cdecl,
      importc: "cublasDrotg_v2", dyn.}
    ##  host or device pointer
    ##  host or device pointer
    ##  host or device pointer
  ##  host or device pointer
  proc cublasCrotg_v2*(handle: cublasHandle_t; a: ptr cuComplex; b: ptr cuComplex;
                      c: ptr cfloat; s: ptr cuComplex): cublasStatus_t {.cdecl,
      importc: "cublasCrotg_v2", dyn.}
    ##  host or device pointer
    ##  host or device pointer
    ##  host or device pointer
  ##  host or device pointer
  proc cublasZrotg_v2*(handle: cublasHandle_t; a: ptr cuDoubleComplex;
                      b: ptr cuDoubleComplex; c: ptr cdouble; s: ptr cuDoubleComplex): cublasStatus_t {.
      cdecl, importc: "cublasZrotg_v2", dyn.}
    ##  host or device pointer
    ##  host or device pointer
    ##  host or device pointer
  ##  host or device pointer
  proc cublasSrotm_v2*(handle: cublasHandle_t; n: cint; x: ptr cfloat; incx: cint;
                      y: ptr cfloat; incy: cint; param: ptr cfloat): cublasStatus_t {.
      cdecl, importc: "cublasSrotm_v2", dyn.}
  ##  host or device pointer
  proc cublasDrotm_v2*(handle: cublasHandle_t; n: cint; x: ptr cdouble; incx: cint;
                      y: ptr cdouble; incy: cint; param: ptr cdouble): cublasStatus_t {.
      cdecl, importc: "cublasDrotm_v2", dyn.}
  ##  host or device pointer
  proc cublasSrotmg_v2*(handle: cublasHandle_t; d1: ptr cfloat; d2: ptr cfloat;
                       x1: ptr cfloat; y1: ptr cfloat; param: ptr cfloat): cublasStatus_t {.
      cdecl, importc: "cublasSrotmg_v2", dyn.}
    ##  host or device pointer
    ##  host or device pointer
    ##  host or device pointer
    ##  host or device pointer
  ##  host or device pointer
  proc cublasDrotmg_v2*(handle: cublasHandle_t; d1: ptr cdouble; d2: ptr cdouble;
                       x1: ptr cdouble; y1: ptr cdouble; param: ptr cdouble): cublasStatus_t {.
      cdecl, importc: "cublasDrotmg_v2", dyn.}
    ##  host or device pointer
    ##  host or device pointer
    ##  host or device pointer
    ##  host or device pointer
  ##  host or device pointer
  ##  --------------- CUBLAS BLAS2 functions  ----------------
  ##  GEMV
  proc cublasSgemv_v2*(handle: cublasHandle_t; trans: cublasOperation_t; m: cint;
                      n: cint; alpha: ptr cfloat; A: ptr cfloat; lda: cint; x: ptr cfloat;
                      incx: cint; beta: ptr cfloat; y: ptr cfloat; incy: cint): cublasStatus_t {.
      cdecl, importc: "cublasSgemv_v2", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cublasDgemv_v2*(handle: cublasHandle_t; trans: cublasOperation_t; m: cint;
                      n: cint; alpha: ptr cdouble; A: ptr cdouble; lda: cint;
                      x: ptr cdouble; incx: cint; beta: ptr cdouble; y: ptr cdouble;
                      incy: cint): cublasStatus_t {.cdecl,
      importc: "cublasDgemv_v2", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cublasCgemv_v2*(handle: cublasHandle_t; trans: cublasOperation_t; m: cint;
                      n: cint; alpha: ptr cuComplex; A: ptr cuComplex; lda: cint;
                      x: ptr cuComplex; incx: cint; beta: ptr cuComplex;
                      y: ptr cuComplex; incy: cint): cublasStatus_t {.cdecl,
      importc: "cublasCgemv_v2", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cublasZgemv_v2*(handle: cublasHandle_t; trans: cublasOperation_t; m: cint;
                      n: cint; alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex;
                      lda: cint; x: ptr cuDoubleComplex; incx: cint;
                      beta: ptr cuDoubleComplex; y: ptr cuDoubleComplex; incy: cint): cublasStatus_t {.
      cdecl, importc: "cublasZgemv_v2", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  ##  GBMV
  proc cublasSgbmv_v2*(handle: cublasHandle_t; trans: cublasOperation_t; m: cint;
                      n: cint; kl: cint; ku: cint; alpha: ptr cfloat; A: ptr cfloat;
                      lda: cint; x: ptr cfloat; incx: cint; beta: ptr cfloat;
                      y: ptr cfloat; incy: cint): cublasStatus_t {.cdecl,
      importc: "cublasSgbmv_v2", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cublasDgbmv_v2*(handle: cublasHandle_t; trans: cublasOperation_t; m: cint;
                      n: cint; kl: cint; ku: cint; alpha: ptr cdouble; A: ptr cdouble;
                      lda: cint; x: ptr cdouble; incx: cint; beta: ptr cdouble;
                      y: ptr cdouble; incy: cint): cublasStatus_t {.cdecl,
      importc: "cublasDgbmv_v2", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cublasCgbmv_v2*(handle: cublasHandle_t; trans: cublasOperation_t; m: cint;
                      n: cint; kl: cint; ku: cint; alpha: ptr cuComplex;
                      A: ptr cuComplex; lda: cint; x: ptr cuComplex; incx: cint;
                      beta: ptr cuComplex; y: ptr cuComplex; incy: cint): cublasStatus_t {.
      cdecl, importc: "cublasCgbmv_v2", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cublasZgbmv_v2*(handle: cublasHandle_t; trans: cublasOperation_t; m: cint;
                      n: cint; kl: cint; ku: cint; alpha: ptr cuDoubleComplex;
                      A: ptr cuDoubleComplex; lda: cint; x: ptr cuDoubleComplex;
                      incx: cint; beta: ptr cuDoubleComplex; y: ptr cuDoubleComplex;
                      incy: cint): cublasStatus_t {.cdecl,
      importc: "cublasZgbmv_v2", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  ##  TRMV
  proc cublasStrmv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                      trans: cublasOperation_t; diag: cublasDiagType_t; n: cint;
                      A: ptr cfloat; lda: cint; x: ptr cfloat; incx: cint): cublasStatus_t {.
      cdecl, importc: "cublasStrmv_v2", dyn.}
  proc cublasDtrmv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                      trans: cublasOperation_t; diag: cublasDiagType_t; n: cint;
                      A: ptr cdouble; lda: cint; x: ptr cdouble; incx: cint): cublasStatus_t {.
      cdecl, importc: "cublasDtrmv_v2", dyn.}
  proc cublasCtrmv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                      trans: cublasOperation_t; diag: cublasDiagType_t; n: cint;
                      A: ptr cuComplex; lda: cint; x: ptr cuComplex; incx: cint): cublasStatus_t {.
      cdecl, importc: "cublasCtrmv_v2", dyn.}
  proc cublasZtrmv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                      trans: cublasOperation_t; diag: cublasDiagType_t; n: cint;
                      A: ptr cuDoubleComplex; lda: cint; x: ptr cuDoubleComplex;
                      incx: cint): cublasStatus_t {.cdecl,
      importc: "cublasZtrmv_v2", dyn.}
  ##  TBMV
  proc cublasStbmv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                      trans: cublasOperation_t; diag: cublasDiagType_t; n: cint;
                      k: cint; A: ptr cfloat; lda: cint; x: ptr cfloat; incx: cint): cublasStatus_t {.
      cdecl, importc: "cublasStbmv_v2", dyn.}
  proc cublasDtbmv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                      trans: cublasOperation_t; diag: cublasDiagType_t; n: cint;
                      k: cint; A: ptr cdouble; lda: cint; x: ptr cdouble; incx: cint): cublasStatus_t {.
      cdecl, importc: "cublasDtbmv_v2", dyn.}
  proc cublasCtbmv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                      trans: cublasOperation_t; diag: cublasDiagType_t; n: cint;
                      k: cint; A: ptr cuComplex; lda: cint; x: ptr cuComplex; incx: cint): cublasStatus_t {.
      cdecl, importc: "cublasCtbmv_v2", dyn.}
  proc cublasZtbmv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                      trans: cublasOperation_t; diag: cublasDiagType_t; n: cint;
                      k: cint; A: ptr cuDoubleComplex; lda: cint;
                      x: ptr cuDoubleComplex; incx: cint): cublasStatus_t {.cdecl,
      importc: "cublasZtbmv_v2", dyn.}
  ##  TPMV
  proc cublasStpmv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                      trans: cublasOperation_t; diag: cublasDiagType_t; n: cint;
                      AP: ptr cfloat; x: ptr cfloat; incx: cint): cublasStatus_t {.cdecl,
      importc: "cublasStpmv_v2", dyn.}
  proc cublasDtpmv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                      trans: cublasOperation_t; diag: cublasDiagType_t; n: cint;
                      AP: ptr cdouble; x: ptr cdouble; incx: cint): cublasStatus_t {.
      cdecl, importc: "cublasDtpmv_v2", dyn.}
  proc cublasCtpmv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                      trans: cublasOperation_t; diag: cublasDiagType_t; n: cint;
                      AP: ptr cuComplex; x: ptr cuComplex; incx: cint): cublasStatus_t {.
      cdecl, importc: "cublasCtpmv_v2", dyn.}
  proc cublasZtpmv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                      trans: cublasOperation_t; diag: cublasDiagType_t; n: cint;
                      AP: ptr cuDoubleComplex; x: ptr cuDoubleComplex; incx: cint): cublasStatus_t {.
      cdecl, importc: "cublasZtpmv_v2", dyn.}
  ##  TRSV
  proc cublasStrsv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                      trans: cublasOperation_t; diag: cublasDiagType_t; n: cint;
                      A: ptr cfloat; lda: cint; x: ptr cfloat; incx: cint): cublasStatus_t {.
      cdecl, importc: "cublasStrsv_v2", dyn.}
  proc cublasDtrsv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                      trans: cublasOperation_t; diag: cublasDiagType_t; n: cint;
                      A: ptr cdouble; lda: cint; x: ptr cdouble; incx: cint): cublasStatus_t {.
      cdecl, importc: "cublasDtrsv_v2", dyn.}
  proc cublasCtrsv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                      trans: cublasOperation_t; diag: cublasDiagType_t; n: cint;
                      A: ptr cuComplex; lda: cint; x: ptr cuComplex; incx: cint): cublasStatus_t {.
      cdecl, importc: "cublasCtrsv_v2", dyn.}
  proc cublasZtrsv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                      trans: cublasOperation_t; diag: cublasDiagType_t; n: cint;
                      A: ptr cuDoubleComplex; lda: cint; x: ptr cuDoubleComplex;
                      incx: cint): cublasStatus_t {.cdecl,
      importc: "cublasZtrsv_v2", dyn.}
  ##  TPSV
  proc cublasStpsv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                      trans: cublasOperation_t; diag: cublasDiagType_t; n: cint;
                      AP: ptr cfloat; x: ptr cfloat; incx: cint): cublasStatus_t {.cdecl,
      importc: "cublasStpsv_v2", dyn.}
  proc cublasDtpsv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                      trans: cublasOperation_t; diag: cublasDiagType_t; n: cint;
                      AP: ptr cdouble; x: ptr cdouble; incx: cint): cublasStatus_t {.
      cdecl, importc: "cublasDtpsv_v2", dyn.}
  proc cublasCtpsv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                      trans: cublasOperation_t; diag: cublasDiagType_t; n: cint;
                      AP: ptr cuComplex; x: ptr cuComplex; incx: cint): cublasStatus_t {.
      cdecl, importc: "cublasCtpsv_v2", dyn.}
  proc cublasZtpsv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                      trans: cublasOperation_t; diag: cublasDiagType_t; n: cint;
                      AP: ptr cuDoubleComplex; x: ptr cuDoubleComplex; incx: cint): cublasStatus_t {.
      cdecl, importc: "cublasZtpsv_v2", dyn.}
  ##  TBSV
  proc cublasStbsv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                      trans: cublasOperation_t; diag: cublasDiagType_t; n: cint;
                      k: cint; A: ptr cfloat; lda: cint; x: ptr cfloat; incx: cint): cublasStatus_t {.
      cdecl, importc: "cublasStbsv_v2", dyn.}
  proc cublasDtbsv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                      trans: cublasOperation_t; diag: cublasDiagType_t; n: cint;
                      k: cint; A: ptr cdouble; lda: cint; x: ptr cdouble; incx: cint): cublasStatus_t {.
      cdecl, importc: "cublasDtbsv_v2", dyn.}
  proc cublasCtbsv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                      trans: cublasOperation_t; diag: cublasDiagType_t; n: cint;
                      k: cint; A: ptr cuComplex; lda: cint; x: ptr cuComplex; incx: cint): cublasStatus_t {.
      cdecl, importc: "cublasCtbsv_v2", dyn.}
  proc cublasZtbsv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                      trans: cublasOperation_t; diag: cublasDiagType_t; n: cint;
                      k: cint; A: ptr cuDoubleComplex; lda: cint;
                      x: ptr cuDoubleComplex; incx: cint): cublasStatus_t {.cdecl,
      importc: "cublasZtbsv_v2", dyn.}
  ##  SYMV/HEMV
  proc cublasSsymv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                      alpha: ptr cfloat; A: ptr cfloat; lda: cint; x: ptr cfloat;
                      incx: cint; beta: ptr cfloat; y: ptr cfloat; incy: cint): cublasStatus_t {.
      cdecl, importc: "cublasSsymv_v2", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cublasDsymv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                      alpha: ptr cdouble; A: ptr cdouble; lda: cint; x: ptr cdouble;
                      incx: cint; beta: ptr cdouble; y: ptr cdouble; incy: cint): cublasStatus_t {.
      cdecl, importc: "cublasDsymv_v2", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cublasCsymv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                      alpha: ptr cuComplex; A: ptr cuComplex; lda: cint;
                      x: ptr cuComplex; incx: cint; beta: ptr cuComplex;
                      y: ptr cuComplex; incy: cint): cublasStatus_t {.cdecl,
      importc: "cublasCsymv_v2", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cublasZsymv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                      alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex; lda: cint;
                      x: ptr cuDoubleComplex; incx: cint; beta: ptr cuDoubleComplex;
                      y: ptr cuDoubleComplex; incy: cint): cublasStatus_t {.cdecl,
      importc: "cublasZsymv_v2", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cublasChemv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                      alpha: ptr cuComplex; A: ptr cuComplex; lda: cint;
                      x: ptr cuComplex; incx: cint; beta: ptr cuComplex;
                      y: ptr cuComplex; incy: cint): cublasStatus_t {.cdecl,
      importc: "cublasChemv_v2", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cublasZhemv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                      alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex; lda: cint;
                      x: ptr cuDoubleComplex; incx: cint; beta: ptr cuDoubleComplex;
                      y: ptr cuDoubleComplex; incy: cint): cublasStatus_t {.cdecl,
      importc: "cublasZhemv_v2", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  ##  SBMV/HBMV
  proc cublasSsbmv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                      k: cint; alpha: ptr cfloat; A: ptr cfloat; lda: cint; x: ptr cfloat;
                      incx: cint; beta: ptr cfloat; y: ptr cfloat; incy: cint): cublasStatus_t {.
      cdecl, importc: "cublasSsbmv_v2", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cublasDsbmv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                      k: cint; alpha: ptr cdouble; A: ptr cdouble; lda: cint;
                      x: ptr cdouble; incx: cint; beta: ptr cdouble; y: ptr cdouble;
                      incy: cint): cublasStatus_t {.cdecl,
      importc: "cublasDsbmv_v2", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cublasChbmv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                      k: cint; alpha: ptr cuComplex; A: ptr cuComplex; lda: cint;
                      x: ptr cuComplex; incx: cint; beta: ptr cuComplex;
                      y: ptr cuComplex; incy: cint): cublasStatus_t {.cdecl,
      importc: "cublasChbmv_v2", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cublasZhbmv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                      k: cint; alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex;
                      lda: cint; x: ptr cuDoubleComplex; incx: cint;
                      beta: ptr cuDoubleComplex; y: ptr cuDoubleComplex; incy: cint): cublasStatus_t {.
      cdecl, importc: "cublasZhbmv_v2", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  ##  SPMV/HPMV
  proc cublasSspmv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                      alpha: ptr cfloat; AP: ptr cfloat; x: ptr cfloat; incx: cint;
                      beta: ptr cfloat; y: ptr cfloat; incy: cint): cublasStatus_t {.
      cdecl, importc: "cublasSspmv_v2", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cublasDspmv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                      alpha: ptr cdouble; AP: ptr cdouble; x: ptr cdouble; incx: cint;
                      beta: ptr cdouble; y: ptr cdouble; incy: cint): cublasStatus_t {.
      cdecl, importc: "cublasDspmv_v2", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cublasChpmv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                      alpha: ptr cuComplex; AP: ptr cuComplex; x: ptr cuComplex;
                      incx: cint; beta: ptr cuComplex; y: ptr cuComplex; incy: cint): cublasStatus_t {.
      cdecl, importc: "cublasChpmv_v2", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cublasZhpmv_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                      alpha: ptr cuDoubleComplex; AP: ptr cuDoubleComplex;
                      x: ptr cuDoubleComplex; incx: cint; beta: ptr cuDoubleComplex;
                      y: ptr cuDoubleComplex; incy: cint): cublasStatus_t {.cdecl,
      importc: "cublasZhpmv_v2", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  ##  GER
  proc cublasSger_v2*(handle: cublasHandle_t; m: cint; n: cint; alpha: ptr cfloat;
                     x: ptr cfloat; incx: cint; y: ptr cfloat; incy: cint; A: ptr cfloat;
                     lda: cint): cublasStatus_t {.cdecl, importc: "cublasSger_v2",
      dyn.}
    ##  host or device pointer
  proc cublasDger_v2*(handle: cublasHandle_t; m: cint; n: cint; alpha: ptr cdouble;
                     x: ptr cdouble; incx: cint; y: ptr cdouble; incy: cint;
                     A: ptr cdouble; lda: cint): cublasStatus_t {.cdecl,
      importc: "cublasDger_v2", dyn.}
    ##  host or device pointer
  proc cublasCgeru_v2*(handle: cublasHandle_t; m: cint; n: cint; alpha: ptr cuComplex;
                      x: ptr cuComplex; incx: cint; y: ptr cuComplex; incy: cint;
                      A: ptr cuComplex; lda: cint): cublasStatus_t {.cdecl,
      importc: "cublasCgeru_v2", dyn.}
    ##  host or device pointer
  proc cublasCgerc_v2*(handle: cublasHandle_t; m: cint; n: cint; alpha: ptr cuComplex;
                      x: ptr cuComplex; incx: cint; y: ptr cuComplex; incy: cint;
                      A: ptr cuComplex; lda: cint): cublasStatus_t {.cdecl,
      importc: "cublasCgerc_v2", dyn.}
    ##  host or device pointer
  proc cublasZgeru_v2*(handle: cublasHandle_t; m: cint; n: cint;
                      alpha: ptr cuDoubleComplex; x: ptr cuDoubleComplex; incx: cint;
                      y: ptr cuDoubleComplex; incy: cint; A: ptr cuDoubleComplex;
                      lda: cint): cublasStatus_t {.cdecl, importc: "cublasZgeru_v2",
      dyn.}
    ##  host or device pointer
  proc cublasZgerc_v2*(handle: cublasHandle_t; m: cint; n: cint;
                      alpha: ptr cuDoubleComplex; x: ptr cuDoubleComplex; incx: cint;
                      y: ptr cuDoubleComplex; incy: cint; A: ptr cuDoubleComplex;
                      lda: cint): cublasStatus_t {.cdecl, importc: "cublasZgerc_v2",
      dyn.}
    ##  host or device pointer
  ##  SYR/HER
  proc cublasSsyr_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                     alpha: ptr cfloat; x: ptr cfloat; incx: cint; A: ptr cfloat; lda: cint): cublasStatus_t {.
      cdecl, importc: "cublasSsyr_v2", dyn.}
    ##  host or device pointer
  proc cublasDsyr_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                     alpha: ptr cdouble; x: ptr cdouble; incx: cint; A: ptr cdouble;
                     lda: cint): cublasStatus_t {.cdecl, importc: "cublasDsyr_v2",
      dyn.}
    ##  host or device pointer
  proc cublasCsyr_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                     alpha: ptr cuComplex; x: ptr cuComplex; incx: cint;
                     A: ptr cuComplex; lda: cint): cublasStatus_t {.cdecl,
      importc: "cublasCsyr_v2", dyn.}
    ##  host or device pointer
  proc cublasZsyr_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                     alpha: ptr cuDoubleComplex; x: ptr cuDoubleComplex; incx: cint;
                     A: ptr cuDoubleComplex; lda: cint): cublasStatus_t {.cdecl,
      importc: "cublasZsyr_v2", dyn.}
    ##  host or device pointer
  proc cublasCher_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                     alpha: ptr cfloat; x: ptr cuComplex; incx: cint; A: ptr cuComplex;
                     lda: cint): cublasStatus_t {.cdecl, importc: "cublasCher_v2",
      dyn.}
    ##  host or device pointer
  proc cublasZher_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                     alpha: ptr cdouble; x: ptr cuDoubleComplex; incx: cint;
                     A: ptr cuDoubleComplex; lda: cint): cublasStatus_t {.cdecl,
      importc: "cublasZher_v2", dyn.}
    ##  host or device pointer
  ##  SPR/HPR
  proc cublasSspr_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                     alpha: ptr cfloat; x: ptr cfloat; incx: cint; AP: ptr cfloat): cublasStatus_t {.
      cdecl, importc: "cublasSspr_v2", dyn.}
    ##  host or device pointer
  proc cublasDspr_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                     alpha: ptr cdouble; x: ptr cdouble; incx: cint; AP: ptr cdouble): cublasStatus_t {.
      cdecl, importc: "cublasDspr_v2", dyn.}
    ##  host or device pointer
  proc cublasChpr_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                     alpha: ptr cfloat; x: ptr cuComplex; incx: cint; AP: ptr cuComplex): cublasStatus_t {.
      cdecl, importc: "cublasChpr_v2", dyn.}
    ##  host or device pointer
  proc cublasZhpr_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                     alpha: ptr cdouble; x: ptr cuDoubleComplex; incx: cint;
                     AP: ptr cuDoubleComplex): cublasStatus_t {.cdecl,
      importc: "cublasZhpr_v2", dyn.}
    ##  host or device pointer
  ##  SYR2/HER2
  proc cublasSsyr2_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                      alpha: ptr cfloat; x: ptr cfloat; incx: cint; y: ptr cfloat;
                      incy: cint; A: ptr cfloat; lda: cint): cublasStatus_t {.cdecl,
      importc: "cublasSsyr2_v2", dyn.}
    ##  host or device pointer
  proc cublasDsyr2_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                      alpha: ptr cdouble; x: ptr cdouble; incx: cint; y: ptr cdouble;
                      incy: cint; A: ptr cdouble; lda: cint): cublasStatus_t {.cdecl,
      importc: "cublasDsyr2_v2", dyn.}
    ##  host or device pointer
  proc cublasCsyr2_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                      alpha: ptr cuComplex; x: ptr cuComplex; incx: cint;
                      y: ptr cuComplex; incy: cint; A: ptr cuComplex; lda: cint): cublasStatus_t {.
      cdecl, importc: "cublasCsyr2_v2", dyn.}
    ##  host or device pointer
  proc cublasZsyr2_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                      alpha: ptr cuDoubleComplex; x: ptr cuDoubleComplex; incx: cint;
                      y: ptr cuDoubleComplex; incy: cint; A: ptr cuDoubleComplex;
                      lda: cint): cublasStatus_t {.cdecl, importc: "cublasZsyr2_v2",
      dyn.}
    ##  host or device pointer
  proc cublasCher2_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                      alpha: ptr cuComplex; x: ptr cuComplex; incx: cint;
                      y: ptr cuComplex; incy: cint; A: ptr cuComplex; lda: cint): cublasStatus_t {.
      cdecl, importc: "cublasCher2_v2", dyn.}
    ##  host or device pointer
  proc cublasZher2_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                      alpha: ptr cuDoubleComplex; x: ptr cuDoubleComplex; incx: cint;
                      y: ptr cuDoubleComplex; incy: cint; A: ptr cuDoubleComplex;
                      lda: cint): cublasStatus_t {.cdecl, importc: "cublasZher2_v2",
      dyn.}
    ##  host or device pointer
  ##  SPR2/HPR2
  proc cublasSspr2_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                      alpha: ptr cfloat; x: ptr cfloat; incx: cint; y: ptr cfloat;
                      incy: cint; AP: ptr cfloat): cublasStatus_t {.cdecl,
      importc: "cublasSspr2_v2", dyn.}
    ##  host or device pointer
  proc cublasDspr2_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                      alpha: ptr cdouble; x: ptr cdouble; incx: cint; y: ptr cdouble;
                      incy: cint; AP: ptr cdouble): cublasStatus_t {.cdecl,
      importc: "cublasDspr2_v2", dyn.}
    ##  host or device pointer
  proc cublasChpr2_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                      alpha: ptr cuComplex; x: ptr cuComplex; incx: cint;
                      y: ptr cuComplex; incy: cint; AP: ptr cuComplex): cublasStatus_t {.
      cdecl, importc: "cublasChpr2_v2", dyn.}
    ##  host or device pointer
  proc cublasZhpr2_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                      alpha: ptr cuDoubleComplex; x: ptr cuDoubleComplex; incx: cint;
                      y: ptr cuDoubleComplex; incy: cint; AP: ptr cuDoubleComplex): cublasStatus_t {.
      cdecl, importc: "cublasZhpr2_v2", dyn.}
    ##  host or device pointer
  ##  ---------------- CUBLAS BLAS3 functions ----------------
  ##  GEMM
  proc cublasSgemm_v2*(handle: cublasHandle_t; transa: cublasOperation_t;
                      transb: cublasOperation_t; m: cint; n: cint; k: cint;
                      alpha: ptr cfloat; A: ptr cfloat; lda: cint; B: ptr cfloat;
                      ldb: cint; beta: ptr cfloat; C: ptr cfloat; ldc: cint): cublasStatus_t {.
      cdecl, importc: "cublasSgemm_v2", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cublasDgemm_v2*(handle: cublasHandle_t; transa: cublasOperation_t;
                      transb: cublasOperation_t; m: cint; n: cint; k: cint;
                      alpha: ptr cdouble; A: ptr cdouble; lda: cint; B: ptr cdouble;
                      ldb: cint; beta: ptr cdouble; C: ptr cdouble; ldc: cint): cublasStatus_t {.
      cdecl, importc: "cublasDgemm_v2", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cublasCgemm_v2*(handle: cublasHandle_t; transa: cublasOperation_t;
                      transb: cublasOperation_t; m: cint; n: cint; k: cint;
                      alpha: ptr cuComplex; A: ptr cuComplex; lda: cint;
                      B: ptr cuComplex; ldb: cint; beta: ptr cuComplex;
                      C: ptr cuComplex; ldc: cint): cublasStatus_t {.cdecl,
      importc: "cublasCgemm_v2", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cublasCgemm3m*(handle: cublasHandle_t; transa: cublasOperation_t;
                     transb: cublasOperation_t; m: cint; n: cint; k: cint;
                     alpha: ptr cuComplex; A: ptr cuComplex; lda: cint;
                     B: ptr cuComplex; ldb: cint; beta: ptr cuComplex; C: ptr cuComplex;
                     ldc: cint): cublasStatus_t {.cdecl, importc: "cublasCgemm3m",
      dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cublasCgemm3mEx*(handle: cublasHandle_t; transa: cublasOperation_t;
                       transb: cublasOperation_t; m: cint; n: cint; k: cint;
                       alpha: ptr cuComplex; A: pointer; Atype: cudaDataType;
                       lda: cint; B: pointer; Btype: cudaDataType; ldb: cint;
                       beta: ptr cuComplex; C: pointer; Ctype: cudaDataType; ldc: cint): cublasStatus_t {.
      cdecl, importc: "cublasCgemm3mEx", dyn.}
  proc cublasZgemm_v2*(handle: cublasHandle_t; transa: cublasOperation_t;
                      transb: cublasOperation_t; m: cint; n: cint; k: cint;
                      alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex; lda: cint;
                      B: ptr cuDoubleComplex; ldb: cint; beta: ptr cuDoubleComplex;
                      C: ptr cuDoubleComplex; ldc: cint): cublasStatus_t {.cdecl,
      importc: "cublasZgemm_v2", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cublasZgemm3m*(handle: cublasHandle_t; transa: cublasOperation_t;
                     transb: cublasOperation_t; m: cint; n: cint; k: cint;
                     alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex; lda: cint;
                     B: ptr cuDoubleComplex; ldb: cint; beta: ptr cuDoubleComplex;
                     C: ptr cuDoubleComplex; ldc: cint): cublasStatus_t {.cdecl,
      importc: "cublasZgemm3m", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cublasHgemm*(handle: cublasHandle_t; transa: cublasOperation_t;
                   transb: cublasOperation_t; m: cint; n: cint; k: cint;
                   alpha: ptr half; A: ptr half; lda: cint; B: ptr half; ldb: cint;
                   beta: ptr half; C: ptr half; ldc: cint): cublasStatus_t {.cdecl,
      importc: "cublasHgemm", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  ##  IO in FP16/FP32, computation in float
  proc cublasSgemmEx*(handle: cublasHandle_t; transa: cublasOperation_t;
                     transb: cublasOperation_t; m: cint; n: cint; k: cint;
                     alpha: ptr cfloat; A: pointer; Atype: cudaDataType; lda: cint;
                     B: pointer; Btype: cudaDataType; ldb: cint; beta: ptr cfloat;
                     C: pointer; Ctype: cudaDataType; ldc: cint): cublasStatus_t {.
      cdecl, importc: "cublasSgemmEx", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cublasGemmEx*(handle: cublasHandle_t; transa: cublasOperation_t;
                    transb: cublasOperation_t; m: cint; n: cint; k: cint;
                    alpha: pointer; A: pointer; Atype: cudaDataType; lda: cint;
                    B: pointer; Btype: cudaDataType; ldb: cint; beta: pointer;
                    C: pointer; Ctype: cudaDataType; ldc: cint;
                    computeType: cudaDataType; algo: cublasGemmAlgo_t): cublasStatus_t {.
      cdecl, importc: "cublasGemmEx", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  ##  IO in Int8 complex/cuComplex, computation in cuComplex
  proc cublasCgemmEx*(handle: cublasHandle_t; transa: cublasOperation_t;
                     transb: cublasOperation_t; m: cint; n: cint; k: cint;
                     alpha: ptr cuComplex; A: pointer; Atype: cudaDataType; lda: cint;
                     B: pointer; Btype: cudaDataType; ldb: cint; beta: ptr cuComplex;
                     C: pointer; Ctype: cudaDataType; ldc: cint): cublasStatus_t {.
      cdecl, importc: "cublasCgemmEx", dyn.}
  proc cublasUint8gemmBias*(handle: cublasHandle_t; transa: cublasOperation_t;
                           transb: cublasOperation_t; transc: cublasOperation_t;
                           m: cint; n: cint; k: cint; A: ptr cuchar; A_bias: cint;
                           lda: cint; B: ptr cuchar; B_bias: cint; ldb: cint;
                           C: ptr cuchar; C_bias: cint; ldc: cint; C_mult: cint;
                           C_shift: cint): cublasStatus_t {.cdecl,
      importc: "cublasUint8gemmBias", dyn.}
  ##  SYRK
  proc cublasSsyrk_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                      trans: cublasOperation_t; n: cint; k: cint; alpha: ptr cfloat;
                      A: ptr cfloat; lda: cint; beta: ptr cfloat; C: ptr cfloat; ldc: cint): cublasStatus_t {.
      cdecl, importc: "cublasSsyrk_v2", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cublasDsyrk_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                      trans: cublasOperation_t; n: cint; k: cint; alpha: ptr cdouble;
                      A: ptr cdouble; lda: cint; beta: ptr cdouble; C: ptr cdouble;
                      ldc: cint): cublasStatus_t {.cdecl, importc: "cublasDsyrk_v2",
      dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cublasCsyrk_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                      trans: cublasOperation_t; n: cint; k: cint;
                      alpha: ptr cuComplex; A: ptr cuComplex; lda: cint;
                      beta: ptr cuComplex; C: ptr cuComplex; ldc: cint): cublasStatus_t {.
      cdecl, importc: "cublasCsyrk_v2", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cublasZsyrk_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                      trans: cublasOperation_t; n: cint; k: cint;
                      alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex; lda: cint;
                      beta: ptr cuDoubleComplex; C: ptr cuDoubleComplex; ldc: cint): cublasStatus_t {.
      cdecl, importc: "cublasZsyrk_v2", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  ##  IO in Int8 complex/cuComplex, computation in cuComplex
  proc cublasCsyrkEx*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                     trans: cublasOperation_t; n: cint; k: cint; alpha: ptr cuComplex;
                     A: pointer; Atype: cudaDataType; lda: cint; beta: ptr cuComplex;
                     C: pointer; Ctype: cudaDataType; ldc: cint): cublasStatus_t {.
      cdecl, importc: "cublasCsyrkEx", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  ##  IO in Int8 complex/cuComplex, computation in cuComplex, Gaussian math
  proc cublasCsyrk3mEx*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                       trans: cublasOperation_t; n: cint; k: cint;
                       alpha: ptr cuComplex; A: pointer; Atype: cudaDataType;
                       lda: cint; beta: ptr cuComplex; C: pointer; Ctype: cudaDataType;
                       ldc: cint): cublasStatus_t {.cdecl,
      importc: "cublasCsyrk3mEx", dyn.}
  ##  HERK
  proc cublasCherk_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                      trans: cublasOperation_t; n: cint; k: cint; alpha: ptr cfloat;
                      A: ptr cuComplex; lda: cint; beta: ptr cfloat; C: ptr cuComplex;
                      ldc: cint): cublasStatus_t {.cdecl, importc: "cublasCherk_v2",
      dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cublasZherk_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                      trans: cublasOperation_t; n: cint; k: cint; alpha: ptr cdouble;
                      A: ptr cuDoubleComplex; lda: cint; beta: ptr cdouble;
                      C: ptr cuDoubleComplex; ldc: cint): cublasStatus_t {.cdecl,
      importc: "cublasZherk_v2", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  ##  IO in Int8 complex/cuComplex, computation in cuComplex
  proc cublasCherkEx*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                     trans: cublasOperation_t; n: cint; k: cint; alpha: ptr cfloat;
                     A: pointer; Atype: cudaDataType; lda: cint; beta: ptr cfloat;
                     C: pointer; Ctype: cudaDataType; ldc: cint): cublasStatus_t {.
      cdecl, importc: "cublasCherkEx", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  ##  IO in Int8 complex/cuComplex, computation in cuComplex, Gaussian math
  proc cublasCherk3mEx*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                       trans: cublasOperation_t; n: cint; k: cint; alpha: ptr cfloat;
                       A: pointer; Atype: cudaDataType; lda: cint; beta: ptr cfloat;
                       C: pointer; Ctype: cudaDataType; ldc: cint): cublasStatus_t {.
      cdecl, importc: "cublasCherk3mEx", dyn.}
  ##  SYR2K
  proc cublasSsyr2k_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                       trans: cublasOperation_t; n: cint; k: cint; alpha: ptr cfloat;
                       A: ptr cfloat; lda: cint; B: ptr cfloat; ldb: cint;
                       beta: ptr cfloat; C: ptr cfloat; ldc: cint): cublasStatus_t {.
      cdecl, importc: "cublasSsyr2k_v2", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cublasDsyr2k_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                       trans: cublasOperation_t; n: cint; k: cint; alpha: ptr cdouble;
                       A: ptr cdouble; lda: cint; B: ptr cdouble; ldb: cint;
                       beta: ptr cdouble; C: ptr cdouble; ldc: cint): cublasStatus_t {.
      cdecl, importc: "cublasDsyr2k_v2", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cublasCsyr2k_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                       trans: cublasOperation_t; n: cint; k: cint;
                       alpha: ptr cuComplex; A: ptr cuComplex; lda: cint;
                       B: ptr cuComplex; ldb: cint; beta: ptr cuComplex;
                       C: ptr cuComplex; ldc: cint): cublasStatus_t {.cdecl,
      importc: "cublasCsyr2k_v2", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cublasZsyr2k_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                       trans: cublasOperation_t; n: cint; k: cint;
                       alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex; lda: cint;
                       B: ptr cuDoubleComplex; ldb: cint; beta: ptr cuDoubleComplex;
                       C: ptr cuDoubleComplex; ldc: cint): cublasStatus_t {.cdecl,
      importc: "cublasZsyr2k_v2", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  ##  HER2K
  proc cublasCher2k_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                       trans: cublasOperation_t; n: cint; k: cint;
                       alpha: ptr cuComplex; A: ptr cuComplex; lda: cint;
                       B: ptr cuComplex; ldb: cint; beta: ptr cfloat; C: ptr cuComplex;
                       ldc: cint): cublasStatus_t {.cdecl,
      importc: "cublasCher2k_v2", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cublasZher2k_v2*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                       trans: cublasOperation_t; n: cint; k: cint;
                       alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex; lda: cint;
                       B: ptr cuDoubleComplex; ldb: cint; beta: ptr cdouble;
                       C: ptr cuDoubleComplex; ldc: cint): cublasStatus_t {.cdecl,
      importc: "cublasZher2k_v2", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  ##  SYRKX : eXtended SYRK
  proc cublasSsyrkx*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                    trans: cublasOperation_t; n: cint; k: cint; alpha: ptr cfloat;
                    A: ptr cfloat; lda: cint; B: ptr cfloat; ldb: cint; beta: ptr cfloat;
                    C: ptr cfloat; ldc: cint): cublasStatus_t {.cdecl,
      importc: "cublasSsyrkx", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cublasDsyrkx*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                    trans: cublasOperation_t; n: cint; k: cint; alpha: ptr cdouble;
                    A: ptr cdouble; lda: cint; B: ptr cdouble; ldb: cint;
                    beta: ptr cdouble; C: ptr cdouble; ldc: cint): cublasStatus_t {.
      cdecl, importc: "cublasDsyrkx", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cublasCsyrkx*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                    trans: cublasOperation_t; n: cint; k: cint; alpha: ptr cuComplex;
                    A: ptr cuComplex; lda: cint; B: ptr cuComplex; ldb: cint;
                    beta: ptr cuComplex; C: ptr cuComplex; ldc: cint): cublasStatus_t {.
      cdecl, importc: "cublasCsyrkx", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cublasZsyrkx*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                    trans: cublasOperation_t; n: cint; k: cint;
                    alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex; lda: cint;
                    B: ptr cuDoubleComplex; ldb: cint; beta: ptr cuDoubleComplex;
                    C: ptr cuDoubleComplex; ldc: cint): cublasStatus_t {.cdecl,
      importc: "cublasZsyrkx", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  ##  HERKX : eXtended HERK
  proc cublasCherkx*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                    trans: cublasOperation_t; n: cint; k: cint; alpha: ptr cuComplex;
                    A: ptr cuComplex; lda: cint; B: ptr cuComplex; ldb: cint;
                    beta: ptr cfloat; C: ptr cuComplex; ldc: cint): cublasStatus_t {.
      cdecl, importc: "cublasCherkx", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cublasZherkx*(handle: cublasHandle_t; uplo: cublasFillMode_t;
                    trans: cublasOperation_t; n: cint; k: cint;
                    alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex; lda: cint;
                    B: ptr cuDoubleComplex; ldb: cint; beta: ptr cdouble;
                    C: ptr cuDoubleComplex; ldc: cint): cublasStatus_t {.cdecl,
      importc: "cublasZherkx", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  ##  SYMM
  proc cublasSsymm_v2*(handle: cublasHandle_t; side: cublasSideMode_t;
                      uplo: cublasFillMode_t; m: cint; n: cint; alpha: ptr cfloat;
                      A: ptr cfloat; lda: cint; B: ptr cfloat; ldb: cint;
                      beta: ptr cfloat; C: ptr cfloat; ldc: cint): cublasStatus_t {.
      cdecl, importc: "cublasSsymm_v2", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cublasDsymm_v2*(handle: cublasHandle_t; side: cublasSideMode_t;
                      uplo: cublasFillMode_t; m: cint; n: cint; alpha: ptr cdouble;
                      A: ptr cdouble; lda: cint; B: ptr cdouble; ldb: cint;
                      beta: ptr cdouble; C: ptr cdouble; ldc: cint): cublasStatus_t {.
      cdecl, importc: "cublasDsymm_v2", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cublasCsymm_v2*(handle: cublasHandle_t; side: cublasSideMode_t;
                      uplo: cublasFillMode_t; m: cint; n: cint; alpha: ptr cuComplex;
                      A: ptr cuComplex; lda: cint; B: ptr cuComplex; ldb: cint;
                      beta: ptr cuComplex; C: ptr cuComplex; ldc: cint): cublasStatus_t {.
      cdecl, importc: "cublasCsymm_v2", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cublasZsymm_v2*(handle: cublasHandle_t; side: cublasSideMode_t;
                      uplo: cublasFillMode_t; m: cint; n: cint;
                      alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex; lda: cint;
                      B: ptr cuDoubleComplex; ldb: cint; beta: ptr cuDoubleComplex;
                      C: ptr cuDoubleComplex; ldc: cint): cublasStatus_t {.cdecl,
      importc: "cublasZsymm_v2", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  ##  HEMM
  proc cublasChemm_v2*(handle: cublasHandle_t; side: cublasSideMode_t;
                      uplo: cublasFillMode_t; m: cint; n: cint; alpha: ptr cuComplex;
                      A: ptr cuComplex; lda: cint; B: ptr cuComplex; ldb: cint;
                      beta: ptr cuComplex; C: ptr cuComplex; ldc: cint): cublasStatus_t {.
      cdecl, importc: "cublasChemm_v2", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cublasZhemm_v2*(handle: cublasHandle_t; side: cublasSideMode_t;
                      uplo: cublasFillMode_t; m: cint; n: cint;
                      alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex; lda: cint;
                      B: ptr cuDoubleComplex; ldb: cint; beta: ptr cuDoubleComplex;
                      C: ptr cuDoubleComplex; ldc: cint): cublasStatus_t {.cdecl,
      importc: "cublasZhemm_v2", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  ##  TRSM
  proc cublasStrsm_v2*(handle: cublasHandle_t; side: cublasSideMode_t;
                      uplo: cublasFillMode_t; trans: cublasOperation_t;
                      diag: cublasDiagType_t; m: cint; n: cint; alpha: ptr cfloat;
                      A: ptr cfloat; lda: cint; B: ptr cfloat; ldb: cint): cublasStatus_t {.
      cdecl, importc: "cublasStrsm_v2", dyn.}
    ##  host or device pointer
  proc cublasDtrsm_v2*(handle: cublasHandle_t; side: cublasSideMode_t;
                      uplo: cublasFillMode_t; trans: cublasOperation_t;
                      diag: cublasDiagType_t; m: cint; n: cint; alpha: ptr cdouble;
                      A: ptr cdouble; lda: cint; B: ptr cdouble; ldb: cint): cublasStatus_t {.
      cdecl, importc: "cublasDtrsm_v2", dyn.}
    ##  host or device pointer
  proc cublasCtrsm_v2*(handle: cublasHandle_t; side: cublasSideMode_t;
                      uplo: cublasFillMode_t; trans: cublasOperation_t;
                      diag: cublasDiagType_t; m: cint; n: cint; alpha: ptr cuComplex;
                      A: ptr cuComplex; lda: cint; B: ptr cuComplex; ldb: cint): cublasStatus_t {.
      cdecl, importc: "cublasCtrsm_v2", dyn.}
    ##  host or device pointer
  proc cublasZtrsm_v2*(handle: cublasHandle_t; side: cublasSideMode_t;
                      uplo: cublasFillMode_t; trans: cublasOperation_t;
                      diag: cublasDiagType_t; m: cint; n: cint;
                      alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex; lda: cint;
                      B: ptr cuDoubleComplex; ldb: cint): cublasStatus_t {.cdecl,
      importc: "cublasZtrsm_v2", dyn.}
    ##  host or device pointer
  ##  TRMM
  proc cublasStrmm_v2*(handle: cublasHandle_t; side: cublasSideMode_t;
                      uplo: cublasFillMode_t; trans: cublasOperation_t;
                      diag: cublasDiagType_t; m: cint; n: cint; alpha: ptr cfloat;
                      A: ptr cfloat; lda: cint; B: ptr cfloat; ldb: cint; C: ptr cfloat;
                      ldc: cint): cublasStatus_t {.cdecl, importc: "cublasStrmm_v2",
      dyn.}
    ##  host or device pointer
  proc cublasDtrmm_v2*(handle: cublasHandle_t; side: cublasSideMode_t;
                      uplo: cublasFillMode_t; trans: cublasOperation_t;
                      diag: cublasDiagType_t; m: cint; n: cint; alpha: ptr cdouble;
                      A: ptr cdouble; lda: cint; B: ptr cdouble; ldb: cint;
                      C: ptr cdouble; ldc: cint): cublasStatus_t {.cdecl,
      importc: "cublasDtrmm_v2", dyn.}
    ##  host or device pointer
  proc cublasCtrmm_v2*(handle: cublasHandle_t; side: cublasSideMode_t;
                      uplo: cublasFillMode_t; trans: cublasOperation_t;
                      diag: cublasDiagType_t; m: cint; n: cint; alpha: ptr cuComplex;
                      A: ptr cuComplex; lda: cint; B: ptr cuComplex; ldb: cint;
                      C: ptr cuComplex; ldc: cint): cublasStatus_t {.cdecl,
      importc: "cublasCtrmm_v2", dyn.}
    ##  host or device pointer
  proc cublasZtrmm_v2*(handle: cublasHandle_t; side: cublasSideMode_t;
                      uplo: cublasFillMode_t; trans: cublasOperation_t;
                      diag: cublasDiagType_t; m: cint; n: cint;
                      alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex; lda: cint;
                      B: ptr cuDoubleComplex; ldb: cint; C: ptr cuDoubleComplex;
                      ldc: cint): cublasStatus_t {.cdecl, importc: "cublasZtrmm_v2",
      dyn.}
    ##  host or device pointer
  ##  BATCH GEMM
  proc cublasSgemmBatched*(handle: cublasHandle_t; transa: cublasOperation_t;
                          transb: cublasOperation_t; m: cint; n: cint; k: cint;
                          alpha: ptr cfloat; Aarray: ptr ptr cfloat; lda: cint;
                          Barray: ptr ptr cfloat; ldb: cint; beta: ptr cfloat;
                          Carray: ptr ptr cfloat; ldc: cint; batchCount: cint): cublasStatus_t {.
      cdecl, importc: "cublasSgemmBatched", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cublasDgemmBatched*(handle: cublasHandle_t; transa: cublasOperation_t;
                          transb: cublasOperation_t; m: cint; n: cint; k: cint;
                          alpha: ptr cdouble; Aarray: ptr ptr cdouble; lda: cint;
                          Barray: ptr ptr cdouble; ldb: cint; beta: ptr cdouble;
                          Carray: ptr ptr cdouble; ldc: cint; batchCount: cint): cublasStatus_t {.
      cdecl, importc: "cublasDgemmBatched", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cublasCgemmBatched*(handle: cublasHandle_t; transa: cublasOperation_t;
                          transb: cublasOperation_t; m: cint; n: cint; k: cint;
                          alpha: ptr cuComplex; Aarray: ptr ptr cuComplex; lda: cint;
                          Barray: ptr ptr cuComplex; ldb: cint; beta: ptr cuComplex;
                          Carray: ptr ptr cuComplex; ldc: cint; batchCount: cint): cublasStatus_t {.
      cdecl, importc: "cublasCgemmBatched", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cublasCgemm3mBatched*(handle: cublasHandle_t; transa: cublasOperation_t;
                            transb: cublasOperation_t; m: cint; n: cint; k: cint;
                            alpha: ptr cuComplex; Aarray: ptr ptr cuComplex; lda: cint;
                            Barray: ptr ptr cuComplex; ldb: cint; beta: ptr cuComplex;
                            Carray: ptr ptr cuComplex; ldc: cint; batchCount: cint): cublasStatus_t {.
      cdecl, importc: "cublasCgemm3mBatched", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cublasZgemmBatched*(handle: cublasHandle_t; transa: cublasOperation_t;
                          transb: cublasOperation_t; m: cint; n: cint; k: cint;
                          alpha: ptr cuDoubleComplex;
                          Aarray: ptr ptr cuDoubleComplex; lda: cint;
                          Barray: ptr ptr cuDoubleComplex; ldb: cint;
                          beta: ptr cuDoubleComplex;
                          Carray: ptr ptr cuDoubleComplex; ldc: cint; batchCount: cint): cublasStatus_t {.
      cdecl, importc: "cublasZgemmBatched", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cublasSgemmStridedBatched*(handle: cublasHandle_t;
                                 transa: cublasOperation_t;
                                 transb: cublasOperation_t; m: cint; n: cint; k: cint;
                                 alpha: ptr cfloat; A: ptr cfloat; lda: cint;
                                 strideA: clonglong; B: ptr cfloat; ldb: cint;
                                 strideB: clonglong; beta: ptr cfloat; C: ptr cfloat;
                                 ldc: cint; strideC: clonglong; batchCount: cint): cublasStatus_t {.
      cdecl, importc: "cublasSgemmStridedBatched", dyn.}
    ##  host or device pointer
    ##  purposely signed
    ##  host or device pointer
  proc cublasDgemmStridedBatched*(handle: cublasHandle_t;
                                 transa: cublasOperation_t;
                                 transb: cublasOperation_t; m: cint; n: cint; k: cint;
                                 alpha: ptr cdouble; A: ptr cdouble; lda: cint;
                                 strideA: clonglong; B: ptr cdouble; ldb: cint;
                                 strideB: clonglong; beta: ptr cdouble;
                                 C: ptr cdouble; ldc: cint; strideC: clonglong;
                                 batchCount: cint): cublasStatus_t {.cdecl,
      importc: "cublasDgemmStridedBatched", dyn.}
    ##  host or device pointer
    ##  purposely signed
    ##  host or device pointer
  proc cublasCgemmStridedBatched*(handle: cublasHandle_t;
                                 transa: cublasOperation_t;
                                 transb: cublasOperation_t; m: cint; n: cint; k: cint;
                                 alpha: ptr cuComplex; A: ptr cuComplex; lda: cint;
                                 strideA: clonglong; B: ptr cuComplex; ldb: cint;
                                 strideB: clonglong; beta: ptr cuComplex;
                                 C: ptr cuComplex; ldc: cint; strideC: clonglong;
                                 batchCount: cint): cublasStatus_t {.cdecl,
      importc: "cublasCgemmStridedBatched", dyn.}
    ##  host or device pointer
    ##  purposely signed
    ##  host or device pointer
  proc cublasCgemm3mStridedBatched*(handle: cublasHandle_t;
                                   transa: cublasOperation_t;
                                   transb: cublasOperation_t; m: cint; n: cint;
                                   k: cint; alpha: ptr cuComplex; A: ptr cuComplex;
                                   lda: cint; strideA: clonglong; B: ptr cuComplex;
                                   ldb: cint; strideB: clonglong;
                                   beta: ptr cuComplex; C: ptr cuComplex; ldc: cint;
                                   strideC: clonglong; batchCount: cint): cublasStatus_t {.
      cdecl, importc: "cublasCgemm3mStridedBatched", dyn.}
    ##  host or device pointer
    ##  purposely signed
    ##  host or device pointer
  proc cublasZgemmStridedBatched*(handle: cublasHandle_t;
                                 transa: cublasOperation_t;
                                 transb: cublasOperation_t; m: cint; n: cint; k: cint;
                                 alpha: ptr cuDoubleComplex;
                                 A: ptr cuDoubleComplex; lda: cint;
                                 strideA: clonglong; B: ptr cuDoubleComplex;
                                 ldb: cint; strideB: clonglong;
                                 beta: ptr cuDoubleComplex; C: ptr cuDoubleComplex;
                                 ldc: cint; strideC: clonglong; batchCount: cint): cublasStatus_t {.
      cdecl, importc: "cublasZgemmStridedBatched", dyn.}
    ##  host or device pointer
    ##  purposely signed
    ##  host or device poi
  proc cublasHgemmStridedBatched*(handle: cublasHandle_t;
                                 transa: cublasOperation_t;
                                 transb: cublasOperation_t; m: cint; n: cint; k: cint;
                                 alpha: ptr half; A: ptr half; lda: cint;
                                 strideA: clonglong; B: ptr half; ldb: cint;
                                 strideB: clonglong; beta: ptr half; C: ptr half;
                                 ldc: cint; strideC: clonglong; batchCount: cint): cublasStatus_t {.
      cdecl, importc: "cublasHgemmStridedBatched", dyn.}
    ##  host or device pointer
    ##  purposely signed
    ##  host or device pointer
  ##  ---------------- CUBLAS BLAS-like extension ----------------
  ##  GEAM
  proc cublasSgeam*(handle: cublasHandle_t; transa: cublasOperation_t;
                   transb: cublasOperation_t; m: cint; n: cint; alpha: ptr cfloat;
                   A: ptr cfloat; lda: cint; beta: ptr cfloat; B: ptr cfloat; ldb: cint;
                   C: ptr cfloat; ldc: cint): cublasStatus_t {.cdecl,
      importc: "cublasSgeam", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cublasDgeam*(handle: cublasHandle_t; transa: cublasOperation_t;
                   transb: cublasOperation_t; m: cint; n: cint; alpha: ptr cdouble;
                   A: ptr cdouble; lda: cint; beta: ptr cdouble; B: ptr cdouble; ldb: cint;
                   C: ptr cdouble; ldc: cint): cublasStatus_t {.cdecl,
      importc: "cublasDgeam", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cublasCgeam*(handle: cublasHandle_t; transa: cublasOperation_t;
                   transb: cublasOperation_t; m: cint; n: cint; alpha: ptr cuComplex;
                   A: ptr cuComplex; lda: cint; beta: ptr cuComplex; B: ptr cuComplex;
                   ldb: cint; C: ptr cuComplex; ldc: cint): cublasStatus_t {.cdecl,
      importc: "cublasCgeam", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cublasZgeam*(handle: cublasHandle_t; transa: cublasOperation_t;
                   transb: cublasOperation_t; m: cint; n: cint;
                   alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex; lda: cint;
                   beta: ptr cuDoubleComplex; B: ptr cuDoubleComplex; ldb: cint;
                   C: ptr cuDoubleComplex; ldc: cint): cublasStatus_t {.cdecl,
      importc: "cublasZgeam", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  ##  Batched LU - GETRF
  proc cublasSgetrfBatched*(handle: cublasHandle_t; n: cint; A: ptr ptr cfloat;
                           lda: cint; P: ptr cint; info: ptr cint; batchSize: cint): cublasStatus_t {.
      cdecl, importc: "cublasSgetrfBatched", dyn.}
    ## Device pointer
    ## Device Pointer
    ## Device Pointer
  proc cublasDgetrfBatched*(handle: cublasHandle_t; n: cint; A: ptr ptr cdouble;
                           lda: cint; P: ptr cint; info: ptr cint; batchSize: cint): cublasStatus_t {.
      cdecl, importc: "cublasDgetrfBatched", dyn.}
    ## Device pointer
    ## Device Pointer
    ## Device Pointer
  proc cublasCgetrfBatched*(handle: cublasHandle_t; n: cint; A: ptr ptr cuComplex;
                           lda: cint; P: ptr cint; info: ptr cint; batchSize: cint): cublasStatus_t {.
      cdecl, importc: "cublasCgetrfBatched", dyn.}
    ## Device pointer
    ## Device Pointer
    ## Device Pointer
  proc cublasZgetrfBatched*(handle: cublasHandle_t; n: cint;
                           A: ptr ptr cuDoubleComplex; lda: cint; P: ptr cint;
                           info: ptr cint; batchSize: cint): cublasStatus_t {.cdecl,
      importc: "cublasZgetrfBatched", dyn.}
    ## Device pointer
    ## Device Pointer
    ## Device Pointer
  ##  Batched inversion based on LU factorization from getrf
  proc cublasSgetriBatched*(handle: cublasHandle_t; n: cint; A: ptr ptr cfloat;
                           lda: cint; P: ptr cint; C: ptr ptr cfloat; ldc: cint;
                           info: ptr cint; batchSize: cint): cublasStatus_t {.cdecl,
      importc: "cublasSgetriBatched", dyn.}
    ## Device pointer
    ## Device pointer
    ## Device pointer
  proc cublasDgetriBatched*(handle: cublasHandle_t; n: cint; A: ptr ptr cdouble;
                           lda: cint; P: ptr cint; C: ptr ptr cdouble; ldc: cint;
                           info: ptr cint; batchSize: cint): cublasStatus_t {.cdecl,
      importc: "cublasDgetriBatched", dyn.}
    ## Device pointer
    ## Device pointer
    ## Device pointer
  proc cublasCgetriBatched*(handle: cublasHandle_t; n: cint; A: ptr ptr cuComplex;
                           lda: cint; P: ptr cint; C: ptr ptr cuComplex; ldc: cint;
                           info: ptr cint; batchSize: cint): cublasStatus_t {.cdecl,
      importc: "cublasCgetriBatched", dyn.}
    ## Device pointer
    ## Device pointer
    ## Device pointer
  proc cublasZgetriBatched*(handle: cublasHandle_t; n: cint;
                           A: ptr ptr cuDoubleComplex; lda: cint; P: ptr cint;
                           C: ptr ptr cuDoubleComplex; ldc: cint; info: ptr cint;
                           batchSize: cint): cublasStatus_t {.cdecl,
      importc: "cublasZgetriBatched", dyn.}
    ## Device pointer
    ## Device pointer
    ## Device pointer
  ##  Batched solver based on LU factorization from getrf
  proc cublasSgetrsBatched*(handle: cublasHandle_t; trans: cublasOperation_t;
                           n: cint; nrhs: cint; Aarray: ptr ptr cfloat; lda: cint;
                           devIpiv: ptr cint; Barray: ptr ptr cfloat; ldb: cint;
                           info: ptr cint; batchSize: cint): cublasStatus_t {.cdecl,
      importc: "cublasSgetrsBatched", dyn.}
  proc cublasDgetrsBatched*(handle: cublasHandle_t; trans: cublasOperation_t;
                           n: cint; nrhs: cint; Aarray: ptr ptr cdouble; lda: cint;
                           devIpiv: ptr cint; Barray: ptr ptr cdouble; ldb: cint;
                           info: ptr cint; batchSize: cint): cublasStatus_t {.cdecl,
      importc: "cublasDgetrsBatched", dyn.}
  proc cublasCgetrsBatched*(handle: cublasHandle_t; trans: cublasOperation_t;
                           n: cint; nrhs: cint; Aarray: ptr ptr cuComplex; lda: cint;
                           devIpiv: ptr cint; Barray: ptr ptr cuComplex; ldb: cint;
                           info: ptr cint; batchSize: cint): cublasStatus_t {.cdecl,
      importc: "cublasCgetrsBatched", dyn.}
  proc cublasZgetrsBatched*(handle: cublasHandle_t; trans: cublasOperation_t;
                           n: cint; nrhs: cint; Aarray: ptr ptr cuDoubleComplex;
                           lda: cint; devIpiv: ptr cint;
                           Barray: ptr ptr cuDoubleComplex; ldb: cint; info: ptr cint;
                           batchSize: cint): cublasStatus_t {.cdecl,
      importc: "cublasZgetrsBatched", dyn.}
  ##  TRSM - Batched Triangular Solver
  proc cublasStrsmBatched*(handle: cublasHandle_t; side: cublasSideMode_t;
                          uplo: cublasFillMode_t; trans: cublasOperation_t;
                          diag: cublasDiagType_t; m: cint; n: cint; alpha: ptr cfloat;
                          A: ptr ptr cfloat; lda: cint; B: ptr ptr cfloat; ldb: cint;
                          batchCount: cint): cublasStatus_t {.cdecl,
      importc: "cublasStrsmBatched", dyn.}
    ## Host or Device Pointer
  proc cublasDtrsmBatched*(handle: cublasHandle_t; side: cublasSideMode_t;
                          uplo: cublasFillMode_t; trans: cublasOperation_t;
                          diag: cublasDiagType_t; m: cint; n: cint;
                          alpha: ptr cdouble; A: ptr ptr cdouble; lda: cint;
                          B: ptr ptr cdouble; ldb: cint; batchCount: cint): cublasStatus_t {.
      cdecl, importc: "cublasDtrsmBatched", dyn.}
    ## Host or Device Pointer
  proc cublasCtrsmBatched*(handle: cublasHandle_t; side: cublasSideMode_t;
                          uplo: cublasFillMode_t; trans: cublasOperation_t;
                          diag: cublasDiagType_t; m: cint; n: cint;
                          alpha: ptr cuComplex; A: ptr ptr cuComplex; lda: cint;
                          B: ptr ptr cuComplex; ldb: cint; batchCount: cint): cublasStatus_t {.
      cdecl, importc: "cublasCtrsmBatched", dyn.}
    ## Host or Device Pointer
  proc cublasZtrsmBatched*(handle: cublasHandle_t; side: cublasSideMode_t;
                          uplo: cublasFillMode_t; trans: cublasOperation_t;
                          diag: cublasDiagType_t; m: cint; n: cint;
                          alpha: ptr cuDoubleComplex; A: ptr ptr cuDoubleComplex;
                          lda: cint; B: ptr ptr cuDoubleComplex; ldb: cint;
                          batchCount: cint): cublasStatus_t {.cdecl,
      importc: "cublasZtrsmBatched", dyn.}
    ## Host or Device Pointer
  ##  Batched - MATINV
  proc cublasSmatinvBatched*(handle: cublasHandle_t; n: cint; A: ptr ptr cfloat;
                            lda: cint; Ainv: ptr ptr cfloat; lda_inv: cint;
                            info: ptr cint; batchSize: cint): cublasStatus_t {.cdecl,
      importc: "cublasSmatinvBatched", dyn.}
    ## Device pointer
    ## Device pointer
    ## Device Pointer
  proc cublasDmatinvBatched*(handle: cublasHandle_t; n: cint; A: ptr ptr cdouble;
                            lda: cint; Ainv: ptr ptr cdouble; lda_inv: cint;
                            info: ptr cint; batchSize: cint): cublasStatus_t {.cdecl,
      importc: "cublasDmatinvBatched", dyn.}
    ## Device pointer
    ## Device pointer
    ## Device Pointer
  proc cublasCmatinvBatched*(handle: cublasHandle_t; n: cint; A: ptr ptr cuComplex;
                            lda: cint; Ainv: ptr ptr cuComplex; lda_inv: cint;
                            info: ptr cint; batchSize: cint): cublasStatus_t {.cdecl,
      importc: "cublasCmatinvBatched", dyn.}
    ## Device pointer
    ## Device pointer
    ## Device Pointer
  proc cublasZmatinvBatched*(handle: cublasHandle_t; n: cint;
                            A: ptr ptr cuDoubleComplex; lda: cint;
                            Ainv: ptr ptr cuDoubleComplex; lda_inv: cint;
                            info: ptr cint; batchSize: cint): cublasStatus_t {.cdecl,
      importc: "cublasZmatinvBatched", dyn.}
    ## Device pointer
    ## Device pointer
    ## Device Pointer
  ##  Batch QR Factorization
  proc cublasSgeqrfBatched*(handle: cublasHandle_t; m: cint; n: cint;
                           Aarray: ptr ptr cfloat; lda: cint;
                           TauArray: ptr ptr cfloat; info: ptr cint; batchSize: cint): cublasStatus_t {.
      cdecl, importc: "cublasSgeqrfBatched", dyn.}
    ## Device pointer
    ##  Device pointer
  proc cublasDgeqrfBatched*(handle: cublasHandle_t; m: cint; n: cint;
                           Aarray: ptr ptr cdouble; lda: cint;
                           TauArray: ptr ptr cdouble; info: ptr cint; batchSize: cint): cublasStatus_t {.
      cdecl, importc: "cublasDgeqrfBatched", dyn.}
    ## Device pointer
    ##  Device pointer
  proc cublasCgeqrfBatched*(handle: cublasHandle_t; m: cint; n: cint;
                           Aarray: ptr ptr cuComplex; lda: cint;
                           TauArray: ptr ptr cuComplex; info: ptr cint; batchSize: cint): cublasStatus_t {.
      cdecl, importc: "cublasCgeqrfBatched", dyn.}
    ## Device pointer
    ##  Device pointer
  proc cublasZgeqrfBatched*(handle: cublasHandle_t; m: cint; n: cint;
                           Aarray: ptr ptr cuDoubleComplex; lda: cint;
                           TauArray: ptr ptr cuDoubleComplex; info: ptr cint;
                           batchSize: cint): cublasStatus_t {.cdecl,
      importc: "cublasZgeqrfBatched", dyn.}
    ## Device pointer
    ##  Device pointer
  ##  Least Square Min only m >= n and Non-transpose supported
  proc cublasSgelsBatched*(handle: cublasHandle_t; trans: cublasOperation_t; m: cint;
                          n: cint; nrhs: cint; Aarray: ptr ptr cfloat; lda: cint;
                          Carray: ptr ptr cfloat; ldc: cint; info: ptr cint;
                          devInfoArray: ptr cint; batchSize: cint): cublasStatus_t {.
      cdecl, importc: "cublasSgelsBatched", dyn.}
    ## Device pointer
    ##  Device pointer
    ##  Device pointer
  proc cublasDgelsBatched*(handle: cublasHandle_t; trans: cublasOperation_t; m: cint;
                          n: cint; nrhs: cint; Aarray: ptr ptr cdouble; lda: cint;
                          Carray: ptr ptr cdouble; ldc: cint; info: ptr cint;
                          devInfoArray: ptr cint; batchSize: cint): cublasStatus_t {.
      cdecl, importc: "cublasDgelsBatched", dyn.}
    ## Device pointer
    ##  Device pointer
    ##  Device pointer
  proc cublasCgelsBatched*(handle: cublasHandle_t; trans: cublasOperation_t; m: cint;
                          n: cint; nrhs: cint; Aarray: ptr ptr cuComplex; lda: cint;
                          Carray: ptr ptr cuComplex; ldc: cint; info: ptr cint;
                          devInfoArray: ptr cint; batchSize: cint): cublasStatus_t {.
      cdecl, importc: "cublasCgelsBatched", dyn.}
    ## Device pointer
    ##  Device pointer
  proc cublasZgelsBatched*(handle: cublasHandle_t; trans: cublasOperation_t; m: cint;
                          n: cint; nrhs: cint; Aarray: ptr ptr cuDoubleComplex;
                          lda: cint; Carray: ptr ptr cuDoubleComplex; ldc: cint;
                          info: ptr cint; devInfoArray: ptr cint; batchSize: cint): cublasStatus_t {.
      cdecl, importc: "cublasZgelsBatched", dyn.}
    ## Device pointer
    ##  Device pointer
  ##  DGMM
  proc cublasSdgmm*(handle: cublasHandle_t; mode: cublasSideMode_t; m: cint; n: cint;
                   A: ptr cfloat; lda: cint; x: ptr cfloat; incx: cint; C: ptr cfloat;
                   ldc: cint): cublasStatus_t {.cdecl, importc: "cublasSdgmm",
      dyn.}
  proc cublasDdgmm*(handle: cublasHandle_t; mode: cublasSideMode_t; m: cint; n: cint;
                   A: ptr cdouble; lda: cint; x: ptr cdouble; incx: cint; C: ptr cdouble;
                   ldc: cint): cublasStatus_t {.cdecl, importc: "cublasDdgmm",
      dyn.}
  proc cublasCdgmm*(handle: cublasHandle_t; mode: cublasSideMode_t; m: cint; n: cint;
                   A: ptr cuComplex; lda: cint; x: ptr cuComplex; incx: cint;
                   C: ptr cuComplex; ldc: cint): cublasStatus_t {.cdecl,
      importc: "cublasCdgmm", dyn.}
  proc cublasZdgmm*(handle: cublasHandle_t; mode: cublasSideMode_t; m: cint; n: cint;
                   A: ptr cuDoubleComplex; lda: cint; x: ptr cuDoubleComplex;
                   incx: cint; C: ptr cuDoubleComplex; ldc: cint): cublasStatus_t {.
      cdecl, importc: "cublasZdgmm", dyn.}
  ##  TPTTR : Triangular Pack format to Triangular format
  proc cublasStpttr*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                    AP: ptr cfloat; A: ptr cfloat; lda: cint): cublasStatus_t {.cdecl,
      importc: "cublasStpttr", dyn.}
  proc cublasDtpttr*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                    AP: ptr cdouble; A: ptr cdouble; lda: cint): cublasStatus_t {.cdecl,
      importc: "cublasDtpttr", dyn.}
  proc cublasCtpttr*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                    AP: ptr cuComplex; A: ptr cuComplex; lda: cint): cublasStatus_t {.
      cdecl, importc: "cublasCtpttr", dyn.}
  proc cublasZtpttr*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                    AP: ptr cuDoubleComplex; A: ptr cuDoubleComplex; lda: cint): cublasStatus_t {.
      cdecl, importc: "cublasZtpttr", dyn.}
  ##  TRTTP : Triangular format to Triangular Pack format
  proc cublasStrttp*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                    A: ptr cfloat; lda: cint; AP: ptr cfloat): cublasStatus_t {.cdecl,
      importc: "cublasStrttp", dyn.}
  proc cublasDtrttp*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                    A: ptr cdouble; lda: cint; AP: ptr cdouble): cublasStatus_t {.cdecl,
      importc: "cublasDtrttp", dyn.}
  proc cublasCtrttp*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                    A: ptr cuComplex; lda: cint; AP: ptr cuComplex): cublasStatus_t {.
      cdecl, importc: "cublasCtrttp", dyn.}
  proc cublasZtrttp*(handle: cublasHandle_t; uplo: cublasFillMode_t; n: cint;
                    A: ptr cuDoubleComplex; lda: cint; AP: ptr cuDoubleComplex): cublasStatus_t {.
      cdecl, importc: "cublasZtrttp", dyn.}
