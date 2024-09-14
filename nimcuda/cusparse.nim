##  #prefix cusparse
##  #prefix cusparse_

when defined(windows):
  const
    libName = "cusparse.dll"
elif defined(macosx):
  const
    libName = "libcusparse.dylib"
else:
  const
    libName = "libcusparse.so"
import
  library_types, driver_types, cuComplex

##
##  Copyright 1993-2023 NVIDIA Corporation.  All rights reserved.
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

## ##############################################################################
## # CUSPARSE VERSION INFORMATION
## ##############################################################################

const
  CUSPARSE_VER_MAJOR* = 12
  CUSPARSE_VER_MINOR* = 5
  CUSPARSE_VER_PATCH* = 1
  CUSPARSE_VER_BUILD* = 3
  CUSPARSE_VERSION* = (
    CUSPARSE_VER_MAJOR * 1000 + CUSPARSE_VER_MINOR * 100 + CUSPARSE_VER_PATCH)

##  #############################################################################
##  # BASIC MACROS
##  #############################################################################

## ------------------------------------------------------------------------------

##  #############################################################################
##  # CUSPARSE_DEPRECATED MACRO
##  #############################################################################
##  #if !defined(DISABLE_CUSPARSE_DEPRECATED)
##
##  #   if CUSPARSE_CPP_VERSION >= 201402L
##
##  #       define CUSPARSE_DEPRECATED_REPLACE_WITH(new_func)                      \
##              [[deprecated("please use " #new_func " instead")]]
##
##  #       define CUSPARSE_DEPRECATED                                             \
##           [[deprecated("The routine will be removed in the next major release")]]
##
##  #       define CUSPARSE_DEPRECATED_TYPE                                        \
##           [[deprecated("The type will be removed in the next major release")]]
##
##  #       define CUSPARSE_DEPRECATED_TYPE_MSVC
##
##  #   elif defined(MSC_VER)
##
##  #       define CUSPARSE_DEPRECATED_REPLACE_WITH(new_func)                      \
##              __declspec(deprecated("please use " #new_func " instead"))
##
##  #       define CUSPARSE_DEPRECATED                                             \
##              __declspec(deprecated(                                             \
##                  "The routine will be removed in the next major release"))
##
##  #       define CUSPARSE_DEPRECATED_TYPE
##
##  #       define CUSPARSE_DEPRECATED_TYPE_MSVC
##              __declspec(deprecated(                                             \
##                  "The type will be removed in the next major release"))
##
##  #   elif defined(INTEL_COMPILER) || defined(clang) ||                    \
##           (defined(GNUC) &&                                                 \
##            (__GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 5)))
##
##  #       define CUSPARSE_DEPRECATED_REPLACE_WITH(new_func)                      \
##              __attribute__((deprecated("please use " #new_func " instead")))
##
##  #       define CUSPARSE_DEPRECATED                                             \
##              __attribute__((deprecated(                                         \
##                  "The routine will be removed in the next major release")))
##
##  #       define CUSPARSE_DEPRECATED_TYPE                                        \
##              __attribute__((deprecated(                                         \
##                  "The type will be removed in the next major release")))
##
##  #       define CUSPARSE_DEPRECATED_TYPE_MSVC
##
##  #   elif defined(GNUC) || defined(xlc)
##
##  #       define CUSPARSE_DEPRECATED_REPLACE_WITH(new_func)                      \
##              __attribute__((deprecated))
##
##  #       define CUSPARSE_DEPRECATED      __attribute__((deprecated))
##  #       define CUSPARSE_DEPRECATED_TYPE __attribute__((deprecated))
##  #       define CUSPARSE_DEPRECATED_TYPE_MSVC
##
##  #   else
##
##  #       define CUSPARSE_DEPRECATED_REPLACE_WITH(new_func)
##  #       define CUSPARSE_DEPRECATED
##  #       define CUSPARSE_DEPRECATED_TYPE
##  #       define CUSPARSE_DEPRECATED_TYPE_MSVC
##
##  #   endif // defined(cplusplus) && __cplusplus >= 201402L
##  //------------------------------------------------------------------------------
##
##  #   if CUSPARSE_CPP_VERSION >= 201703L
##
##  #       define CUSPARSE_DEPRECATED_ENUM_REPLACE_WITH(new_enum)                 \
##              [[deprecated("please use " #new_enum " instead")]]
##
##  #       define CUSPARSE_DEPRECATED_ENUM                                        \
##              [[deprecated("The enum will be removed in the next major release")]]
##
##  #   elif defined(clang) ||                                                 \
##           (defined(GNUC) && __GNUC__ >= 6 && !defined(PGI))
##
##  #       define CUSPARSE_DEPRECATED_ENUM_REPLACE_WITH(new_enum)                 \
##              __attribute__((deprecated("please use " #new_enum " instead")))
##
##  #       define CUSPARSE_DEPRECATED_ENUM                                        \
##              __attribute__((deprecated(                                         \
##                  "The enum will be removed in the next major release")))
##
##  #   else
##
##  #       define CUSPARSE_DEPRECATED_ENUM_REPLACE_WITH(new_enum)
##  #       define CUSPARSE_DEPRECATED_ENUM
##
##  #   endif // defined(cplusplus) && __cplusplus >= 201402L
##
##  #else // defined(DISABLE_CUSPARSE_DEPRECATED)
##  #   define CUSPARSE_DEPRECATED_REPLACE_WITH(new_func)
##  #   define CUSPARSE_DEPRECATED
##  #   define CUSPARSE_DEPRECATED_TYPE
##  #   define CUSPARSE_DEPRECATED_TYPE_MSVC
##  #   define CUSPARSE_DEPRECATED_ENUM_REPLACE_WITH(new_enum)
##  #   define CUSPARSE_DEPRECATED_ENUM
##  #endif // !defined(DISABLE_CUSPARSE_DEPRECATED)

## ------------------------------------------------------------------------------

## ##############################################################################
## # OPAQUE DATA STRUCTURES
## ##############################################################################

type cusparseContext {.nodecl.} = object
type
  cusparseHandle_t* = ptr cusparseContext

type cusparseMatDescr {.nodecl.} = object
type
  cusparseMatDescr_t* = ptr cusparseMatDescr

type bsrsv2Info {.nodecl.} = object
type
  bsrsv2Info_t* = ptr bsrsv2Info

type bsrsm2Info {.nodecl.} = object
type
  bsrsm2Info_t* = ptr bsrsm2Info

type csric02Info {.nodecl.} = object
type
  csric02Info_t* = ptr csric02Info

type bsric02Info {.nodecl.} = object
type
  bsric02Info_t* = ptr bsric02Info

type csrilu02Info {.nodecl.} = object
type
  csrilu02Info_t* = ptr csrilu02Info

type bsrilu02Info {.nodecl.} = object
type
  bsrilu02Info_t* = ptr bsrilu02Info

type csru2csrInfo {.nodecl.} = object
type
  csru2csrInfo_t* = ptr csru2csrInfo

type cusparseColorInfo {.nodecl.} = object
type
  cusparseColorInfo_t* = ptr cusparseColorInfo

type pruneInfo {.nodecl.} = object
type
  pruneInfo_t* = ptr pruneInfo

## ##############################################################################
## # ENUMERATORS
## ##############################################################################

type
  cusparseStatus_t* {.size: sizeof(cint).} = enum
    CUSPARSE_STATUS_SUCCESS = 0, CUSPARSE_STATUS_NOT_INITIALIZED = 1,
    CUSPARSE_STATUS_ALLOC_FAILED = 2, CUSPARSE_STATUS_INVALID_VALUE = 3,
    CUSPARSE_STATUS_ARCH_MISMATCH = 4, CUSPARSE_STATUS_MAPPING_ERROR = 5,
    CUSPARSE_STATUS_EXECUTION_FAILED = 6, CUSPARSE_STATUS_INTERNAL_ERROR = 7,
    CUSPARSE_STATUS_MATRIX_TYPE_NOT_SUPPORTED = 8, CUSPARSE_STATUS_ZERO_PIVOT = 9,
    CUSPARSE_STATUS_NOT_SUPPORTED = 10, CUSPARSE_STATUS_INSUFFICIENT_RESOURCES = 11
  cusparsePointerMode_t* {.size: sizeof(cint).} = enum
    CUSPARSE_POINTER_MODE_HOST = 0, CUSPARSE_POINTER_MODE_DEVICE = 1
  cusparseAction_t* {.size: sizeof(cint).} = enum
    CUSPARSE_ACTION_SYMBOLIC = 0, CUSPARSE_ACTION_NUMERIC = 1
  cusparseMatrixType_t* {.size: sizeof(cint).} = enum
    CUSPARSE_MATRIX_TYPE_GENERAL = 0, CUSPARSE_MATRIX_TYPE_SYMMETRIC = 1,
    CUSPARSE_MATRIX_TYPE_HERMITIAN = 2, CUSPARSE_MATRIX_TYPE_TRIANGULAR = 3
  cusparseFillMode_t* {.size: sizeof(cint).} = enum
    CUSPARSE_FILL_MODE_LOWER = 0, CUSPARSE_FILL_MODE_UPPER = 1
  cusparseDiagType_t* {.size: sizeof(cint).} = enum
    CUSPARSE_DIAG_TYPE_NON_UNIT = 0, CUSPARSE_DIAG_TYPE_UNIT = 1
  cusparseIndexBase_t* {.size: sizeof(cint).} = enum
    CUSPARSE_INDEX_BASE_ZERO = 0, CUSPARSE_INDEX_BASE_ONE = 1
  cusparseOperation_t* {.size: sizeof(cint).} = enum
    CUSPARSE_OPERATION_NON_TRANSPOSE = 0, CUSPARSE_OPERATION_TRANSPOSE = 1,
    CUSPARSE_OPERATION_CONJUGATE_TRANSPOSE = 2
  cusparseDirection_t* {.size: sizeof(cint).} = enum
    CUSPARSE_DIRECTION_ROW = 0, CUSPARSE_DIRECTION_COLUMN = 1
  cusparseSolvePolicy_t* {.size: sizeof(cint).} = enum
    CUSPARSE_SOLVE_POLICY_NO_LEVEL = 0, CUSPARSE_SOLVE_POLICY_USE_LEVEL = 1
  cusparseColorAlg_t* {.size: sizeof(cint).} = enum
    CUSPARSE_COLOR_ALG0 = 0,    ##  default
    CUSPARSE_COLOR_ALG1 = 1












## ##############################################################################
## # INITIALIZATION AND MANAGEMENT ROUTINES
## ##############################################################################

proc cusparseCreate*(handle: ptr cusparseHandle_t): cusparseStatus_t {.cdecl,
    importc: "cusparseCreate", dynlib: libName.}
proc cusparseDestroy*(handle: cusparseHandle_t): cusparseStatus_t {.cdecl,
    importc: "cusparseDestroy", dynlib: libName.}
proc cusparseGetVersion*(handle: cusparseHandle_t; version: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseGetVersion", dynlib: libName.}
proc cusparseGetProperty*(`type`: libraryPropertyType; value: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseGetProperty", dynlib: libName.}
proc cusparseGetErrorName*(status: cusparseStatus_t): cstring {.cdecl,
    importc: "cusparseGetErrorName", dynlib: libName.}
proc cusparseGetErrorString*(status: cusparseStatus_t): cstring {.cdecl,
    importc: "cusparseGetErrorString", dynlib: libName.}
proc cusparseSetStream*(handle: cusparseHandle_t; streamId: cudaStream_t): cusparseStatus_t {.
    cdecl, importc: "cusparseSetStream", dynlib: libName.}
proc cusparseGetStream*(handle: cusparseHandle_t; streamId: ptr cudaStream_t): cusparseStatus_t {.
    cdecl, importc: "cusparseGetStream", dynlib: libName.}
proc cusparseGetPointerMode*(handle: cusparseHandle_t;
                            mode: ptr cusparsePointerMode_t): cusparseStatus_t {.
    cdecl, importc: "cusparseGetPointerMode", dynlib: libName.}
proc cusparseSetPointerMode*(handle: cusparseHandle_t; mode: cusparsePointerMode_t): cusparseStatus_t {.
    cdecl, importc: "cusparseSetPointerMode", dynlib: libName.}
## ##############################################################################
## # LOGGING APIs
## ##############################################################################

type
  cusparseLoggerCallback_t* = proc (logLevel: cint; functionName: cstring;
                                 message: cstring) {.cdecl.}

proc cusparseLoggerSetCallback*(callback: cusparseLoggerCallback_t): cusparseStatus_t {.
    cdecl, importc: "cusparseLoggerSetCallback", dynlib: libName.}
proc cusparseLoggerSetFile*(file: ptr FILE): cusparseStatus_t {.cdecl,
    importc: "cusparseLoggerSetFile", dynlib: libName.}
proc cusparseLoggerOpenFile*(logFile: cstring): cusparseStatus_t {.cdecl,
    importc: "cusparseLoggerOpenFile", dynlib: libName.}
proc cusparseLoggerSetLevel*(level: cint): cusparseStatus_t {.cdecl,
    importc: "cusparseLoggerSetLevel", dynlib: libName.}
proc cusparseLoggerSetMask*(mask: cint): cusparseStatus_t {.cdecl,
    importc: "cusparseLoggerSetMask", dynlib: libName.}
proc cusparseLoggerForceDisable*(): cusparseStatus_t {.cdecl,
    importc: "cusparseLoggerForceDisable", dynlib: libName.}
## ##############################################################################
## # HELPER ROUTINES
## ##############################################################################

proc cusparseCreateMatDescr*(descrA: ptr cusparseMatDescr_t): cusparseStatus_t {.
    cdecl, importc: "cusparseCreateMatDescr", dynlib: libName.}
proc cusparseDestroyMatDescr*(descrA: cusparseMatDescr_t): cusparseStatus_t {.cdecl,
    importc: "cusparseDestroyMatDescr", dynlib: libName.}
proc cusparseSetMatType*(descrA: cusparseMatDescr_t; `type`: cusparseMatrixType_t): cusparseStatus_t {.
    cdecl, importc: "cusparseSetMatType", dynlib: libName.}
proc cusparseGetMatType*(descrA: cusparseMatDescr_t): cusparseMatrixType_t {.cdecl,
    importc: "cusparseGetMatType", dynlib: libName.}
proc cusparseSetMatFillMode*(descrA: cusparseMatDescr_t;
                            fillMode: cusparseFillMode_t): cusparseStatus_t {.
    cdecl, importc: "cusparseSetMatFillMode", dynlib: libName.}
proc cusparseGetMatFillMode*(descrA: cusparseMatDescr_t): cusparseFillMode_t {.
    cdecl, importc: "cusparseGetMatFillMode", dynlib: libName.}
proc cusparseSetMatDiagType*(descrA: cusparseMatDescr_t;
                            diagType: cusparseDiagType_t): cusparseStatus_t {.
    cdecl, importc: "cusparseSetMatDiagType", dynlib: libName.}
proc cusparseGetMatDiagType*(descrA: cusparseMatDescr_t): cusparseDiagType_t {.
    cdecl, importc: "cusparseGetMatDiagType", dynlib: libName.}
proc cusparseSetMatIndexBase*(descrA: cusparseMatDescr_t; base: cusparseIndexBase_t): cusparseStatus_t {.
    cdecl, importc: "cusparseSetMatIndexBase", dynlib: libName.}
proc cusparseGetMatIndexBase*(descrA: cusparseMatDescr_t): cusparseIndexBase_t {.
    cdecl, importc: "cusparseGetMatIndexBase", dynlib: libName.}
proc cusparseCreateCsric02Info*(info: ptr csric02Info_t): cusparseStatus_t {.cdecl,
    importc: "cusparseCreateCsric02Info", dynlib: libName.}
proc cusparseDestroyCsric02Info*(info: csric02Info_t): cusparseStatus_t {.cdecl,
    importc: "cusparseDestroyCsric02Info", dynlib: libName.}
proc cusparseCreateBsric02Info*(info: ptr bsric02Info_t): cusparseStatus_t {.cdecl,
    importc: "cusparseCreateBsric02Info", dynlib: libName.}
proc cusparseDestroyBsric02Info*(info: bsric02Info_t): cusparseStatus_t {.cdecl,
    importc: "cusparseDestroyBsric02Info", dynlib: libName.}
proc cusparseCreateCsrilu02Info*(info: ptr csrilu02Info_t): cusparseStatus_t {.cdecl,
    importc: "cusparseCreateCsrilu02Info", dynlib: libName.}
proc cusparseDestroyCsrilu02Info*(info: csrilu02Info_t): cusparseStatus_t {.cdecl,
    importc: "cusparseDestroyCsrilu02Info", dynlib: libName.}
proc cusparseCreateBsrilu02Info*(info: ptr bsrilu02Info_t): cusparseStatus_t {.cdecl,
    importc: "cusparseCreateBsrilu02Info", dynlib: libName.}
proc cusparseDestroyBsrilu02Info*(info: bsrilu02Info_t): cusparseStatus_t {.cdecl,
    importc: "cusparseDestroyBsrilu02Info", dynlib: libName.}
proc cusparseCreateBsrsv2Info*(info: ptr bsrsv2Info_t): cusparseStatus_t {.cdecl,
    importc: "cusparseCreateBsrsv2Info", dynlib: libName.}
proc cusparseDestroyBsrsv2Info*(info: bsrsv2Info_t): cusparseStatus_t {.cdecl,
    importc: "cusparseDestroyBsrsv2Info", dynlib: libName.}
proc cusparseCreateBsrsm2Info*(info: ptr bsrsm2Info_t): cusparseStatus_t {.cdecl,
    importc: "cusparseCreateBsrsm2Info", dynlib: libName.}
proc cusparseDestroyBsrsm2Info*(info: bsrsm2Info_t): cusparseStatus_t {.cdecl,
    importc: "cusparseDestroyBsrsm2Info", dynlib: libName.}
proc cusparseCreateCsru2csrInfo*(info: ptr csru2csrInfo_t): cusparseStatus_t {.cdecl,
    importc: "cusparseCreateCsru2csrInfo", dynlib: libName.}
proc cusparseDestroyCsru2csrInfo*(info: csru2csrInfo_t): cusparseStatus_t {.cdecl,
    importc: "cusparseDestroyCsru2csrInfo", dynlib: libName.}
proc cusparseCreateColorInfo*(info: ptr cusparseColorInfo_t): cusparseStatus_t {.
    cdecl, importc: "cusparseCreateColorInfo", dynlib: libName.}
proc cusparseDestroyColorInfo*(info: cusparseColorInfo_t): cusparseStatus_t {.cdecl,
    importc: "cusparseDestroyColorInfo", dynlib: libName.}
proc cusparseCreatePruneInfo*(info: ptr pruneInfo_t): cusparseStatus_t {.cdecl,
    importc: "cusparseCreatePruneInfo", dynlib: libName.}
proc cusparseDestroyPruneInfo*(info: pruneInfo_t): cusparseStatus_t {.cdecl,
    importc: "cusparseDestroyPruneInfo", dynlib: libName.}
## ##############################################################################
## # SPARSE LEVEL 2 ROUTINES
## ##############################################################################

proc cusparseSgemvi*(handle: cusparseHandle_t; transA: cusparseOperation_t; m: cint;
                    n: cint; alpha: ptr cfloat; A: ptr cfloat; lda: cint; nnz: cint;
                    xVal: ptr cfloat; xInd: ptr cint; beta: ptr cfloat; y: ptr cfloat;
                    idxBase: cusparseIndexBase_t; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseSgemvi", dynlib: libName.}
proc cusparseSgemvi_bufferSize*(handle: cusparseHandle_t;
                               transA: cusparseOperation_t; m: cint; n: cint;
                               nnz: cint; pBufferSize: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseSgemvi_bufferSize", dynlib: libName.}
proc cusparseDgemvi*(handle: cusparseHandle_t; transA: cusparseOperation_t; m: cint;
                    n: cint; alpha: ptr cdouble; A: ptr cdouble; lda: cint; nnz: cint;
                    xVal: ptr cdouble; xInd: ptr cint; beta: ptr cdouble; y: ptr cdouble;
                    idxBase: cusparseIndexBase_t; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseDgemvi", dynlib: libName.}
proc cusparseDgemvi_bufferSize*(handle: cusparseHandle_t;
                               transA: cusparseOperation_t; m: cint; n: cint;
                               nnz: cint; pBufferSize: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseDgemvi_bufferSize", dynlib: libName.}
proc cusparseCgemvi*(handle: cusparseHandle_t; transA: cusparseOperation_t; m: cint;
                    n: cint; alpha: ptr cuComplex; A: ptr cuComplex; lda: cint; nnz: cint;
                    xVal: ptr cuComplex; xInd: ptr cint; beta: ptr cuComplex;
                    y: ptr cuComplex; idxBase: cusparseIndexBase_t; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseCgemvi", dynlib: libName.}
proc cusparseCgemvi_bufferSize*(handle: cusparseHandle_t;
                               transA: cusparseOperation_t; m: cint; n: cint;
                               nnz: cint; pBufferSize: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseCgemvi_bufferSize", dynlib: libName.}
proc cusparseZgemvi*(handle: cusparseHandle_t; transA: cusparseOperation_t; m: cint;
                    n: cint; alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex;
                    lda: cint; nnz: cint; xVal: ptr cuDoubleComplex; xInd: ptr cint;
                    beta: ptr cuDoubleComplex; y: ptr cuDoubleComplex;
                    idxBase: cusparseIndexBase_t; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseZgemvi", dynlib: libName.}
proc cusparseZgemvi_bufferSize*(handle: cusparseHandle_t;
                               transA: cusparseOperation_t; m: cint; n: cint;
                               nnz: cint; pBufferSize: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseZgemvi_bufferSize", dynlib: libName.}
proc cusparseSbsrmv*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                    transA: cusparseOperation_t; mb: cint; nb: cint; nnzb: cint;
                    alpha: ptr cfloat; descrA: cusparseMatDescr_t;
                    bsrSortedValA: ptr cfloat; bsrSortedRowPtrA: ptr cint;
                    bsrSortedColIndA: ptr cint; blockDim: cint; x: ptr cfloat;
                    beta: ptr cfloat; y: ptr cfloat): cusparseStatus_t {.cdecl,
    importc: "cusparseSbsrmv", dynlib: libName.}
proc cusparseDbsrmv*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                    transA: cusparseOperation_t; mb: cint; nb: cint; nnzb: cint;
                    alpha: ptr cdouble; descrA: cusparseMatDescr_t;
                    bsrSortedValA: ptr cdouble; bsrSortedRowPtrA: ptr cint;
                    bsrSortedColIndA: ptr cint; blockDim: cint; x: ptr cdouble;
                    beta: ptr cdouble; y: ptr cdouble): cusparseStatus_t {.cdecl,
    importc: "cusparseDbsrmv", dynlib: libName.}
proc cusparseCbsrmv*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                    transA: cusparseOperation_t; mb: cint; nb: cint; nnzb: cint;
                    alpha: ptr cuComplex; descrA: cusparseMatDescr_t;
                    bsrSortedValA: ptr cuComplex; bsrSortedRowPtrA: ptr cint;
                    bsrSortedColIndA: ptr cint; blockDim: cint; x: ptr cuComplex;
                    beta: ptr cuComplex; y: ptr cuComplex): cusparseStatus_t {.cdecl,
    importc: "cusparseCbsrmv", dynlib: libName.}
proc cusparseZbsrmv*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                    transA: cusparseOperation_t; mb: cint; nb: cint; nnzb: cint;
                    alpha: ptr cuDoubleComplex; descrA: cusparseMatDescr_t;
                    bsrSortedValA: ptr cuDoubleComplex; bsrSortedRowPtrA: ptr cint;
                    bsrSortedColIndA: ptr cint; blockDim: cint;
                    x: ptr cuDoubleComplex; beta: ptr cuDoubleComplex;
                    y: ptr cuDoubleComplex): cusparseStatus_t {.cdecl,
    importc: "cusparseZbsrmv", dynlib: libName.}
proc cusparseSbsrxmv*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                     transA: cusparseOperation_t; sizeOfMask: cint; mb: cint;
                     nb: cint; nnzb: cint; alpha: ptr cfloat;
                     descrA: cusparseMatDescr_t; bsrSortedValA: ptr cfloat;
                     bsrSortedMaskPtrA: ptr cint; bsrSortedRowPtrA: ptr cint;
                     bsrSortedEndPtrA: ptr cint; bsrSortedColIndA: ptr cint;
                     blockDim: cint; x: ptr cfloat; beta: ptr cfloat; y: ptr cfloat): cusparseStatus_t {.
    cdecl, importc: "cusparseSbsrxmv", dynlib: libName.}
proc cusparseDbsrxmv*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                     transA: cusparseOperation_t; sizeOfMask: cint; mb: cint;
                     nb: cint; nnzb: cint; alpha: ptr cdouble;
                     descrA: cusparseMatDescr_t; bsrSortedValA: ptr cdouble;
                     bsrSortedMaskPtrA: ptr cint; bsrSortedRowPtrA: ptr cint;
                     bsrSortedEndPtrA: ptr cint; bsrSortedColIndA: ptr cint;
                     blockDim: cint; x: ptr cdouble; beta: ptr cdouble; y: ptr cdouble): cusparseStatus_t {.
    cdecl, importc: "cusparseDbsrxmv", dynlib: libName.}
proc cusparseCbsrxmv*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                     transA: cusparseOperation_t; sizeOfMask: cint; mb: cint;
                     nb: cint; nnzb: cint; alpha: ptr cuComplex;
                     descrA: cusparseMatDescr_t; bsrSortedValA: ptr cuComplex;
                     bsrSortedMaskPtrA: ptr cint; bsrSortedRowPtrA: ptr cint;
                     bsrSortedEndPtrA: ptr cint; bsrSortedColIndA: ptr cint;
                     blockDim: cint; x: ptr cuComplex; beta: ptr cuComplex;
                     y: ptr cuComplex): cusparseStatus_t {.cdecl,
    importc: "cusparseCbsrxmv", dynlib: libName.}
proc cusparseZbsrxmv*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                     transA: cusparseOperation_t; sizeOfMask: cint; mb: cint;
                     nb: cint; nnzb: cint; alpha: ptr cuDoubleComplex;
                     descrA: cusparseMatDescr_t;
                     bsrSortedValA: ptr cuDoubleComplex;
                     bsrSortedMaskPtrA: ptr cint; bsrSortedRowPtrA: ptr cint;
                     bsrSortedEndPtrA: ptr cint; bsrSortedColIndA: ptr cint;
                     blockDim: cint; x: ptr cuDoubleComplex;
                     beta: ptr cuDoubleComplex; y: ptr cuDoubleComplex): cusparseStatus_t {.
    cdecl, importc: "cusparseZbsrxmv", dynlib: libName.}
proc cusparseXbsrsv2_zeroPivot*(handle: cusparseHandle_t; info: bsrsv2Info_t;
                               position: ptr cint): cusparseStatus_t {.cdecl,
    importc: "cusparseXbsrsv2_zeroPivot", dynlib: libName.}
proc cusparseSbsrsv2_bufferSize*(handle: cusparseHandle_t;
                                dirA: cusparseDirection_t;
                                transA: cusparseOperation_t; mb: cint; nnzb: cint;
                                descrA: cusparseMatDescr_t;
                                bsrSortedValA: ptr cfloat;
                                bsrSortedRowPtrA: ptr cint;
                                bsrSortedColIndA: ptr cint; blockDim: cint;
                                info: bsrsv2Info_t; pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseSbsrsv2_bufferSize", dynlib: libName.}
proc cusparseDbsrsv2_bufferSize*(handle: cusparseHandle_t;
                                dirA: cusparseDirection_t;
                                transA: cusparseOperation_t; mb: cint; nnzb: cint;
                                descrA: cusparseMatDescr_t;
                                bsrSortedValA: ptr cdouble;
                                bsrSortedRowPtrA: ptr cint;
                                bsrSortedColIndA: ptr cint; blockDim: cint;
                                info: bsrsv2Info_t; pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseDbsrsv2_bufferSize", dynlib: libName.}
proc cusparseCbsrsv2_bufferSize*(handle: cusparseHandle_t;
                                dirA: cusparseDirection_t;
                                transA: cusparseOperation_t; mb: cint; nnzb: cint;
                                descrA: cusparseMatDescr_t;
                                bsrSortedValA: ptr cuComplex;
                                bsrSortedRowPtrA: ptr cint;
                                bsrSortedColIndA: ptr cint; blockDim: cint;
                                info: bsrsv2Info_t; pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseCbsrsv2_bufferSize", dynlib: libName.}
proc cusparseZbsrsv2_bufferSize*(handle: cusparseHandle_t;
                                dirA: cusparseDirection_t;
                                transA: cusparseOperation_t; mb: cint; nnzb: cint;
                                descrA: cusparseMatDescr_t;
                                bsrSortedValA: ptr cuDoubleComplex;
                                bsrSortedRowPtrA: ptr cint;
                                bsrSortedColIndA: ptr cint; blockDim: cint;
                                info: bsrsv2Info_t; pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseZbsrsv2_bufferSize", dynlib: libName.}
proc cusparseSbsrsv2_bufferSizeExt*(handle: cusparseHandle_t;
                                   dirA: cusparseDirection_t;
                                   transA: cusparseOperation_t; mb: cint;
                                   nnzb: cint; descrA: cusparseMatDescr_t;
                                   bsrSortedValA: ptr cfloat;
                                   bsrSortedRowPtrA: ptr cint;
                                   bsrSortedColIndA: ptr cint; blockSize: cint;
                                   info: bsrsv2Info_t; pBufferSize: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseSbsrsv2_bufferSizeExt", dynlib: libName.}
proc cusparseDbsrsv2_bufferSizeExt*(handle: cusparseHandle_t;
                                   dirA: cusparseDirection_t;
                                   transA: cusparseOperation_t; mb: cint;
                                   nnzb: cint; descrA: cusparseMatDescr_t;
                                   bsrSortedValA: ptr cdouble;
                                   bsrSortedRowPtrA: ptr cint;
                                   bsrSortedColIndA: ptr cint; blockSize: cint;
                                   info: bsrsv2Info_t; pBufferSize: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseDbsrsv2_bufferSizeExt", dynlib: libName.}
proc cusparseCbsrsv2_bufferSizeExt*(handle: cusparseHandle_t;
                                   dirA: cusparseDirection_t;
                                   transA: cusparseOperation_t; mb: cint;
                                   nnzb: cint; descrA: cusparseMatDescr_t;
                                   bsrSortedValA: ptr cuComplex;
                                   bsrSortedRowPtrA: ptr cint;
                                   bsrSortedColIndA: ptr cint; blockSize: cint;
                                   info: bsrsv2Info_t; pBufferSize: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseCbsrsv2_bufferSizeExt", dynlib: libName.}
proc cusparseZbsrsv2_bufferSizeExt*(handle: cusparseHandle_t;
                                   dirA: cusparseDirection_t;
                                   transA: cusparseOperation_t; mb: cint;
                                   nnzb: cint; descrA: cusparseMatDescr_t;
                                   bsrSortedValA: ptr cuDoubleComplex;
                                   bsrSortedRowPtrA: ptr cint;
                                   bsrSortedColIndA: ptr cint; blockSize: cint;
                                   info: bsrsv2Info_t; pBufferSize: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseZbsrsv2_bufferSizeExt", dynlib: libName.}
proc cusparseSbsrsv2_analysis*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                              transA: cusparseOperation_t; mb: cint; nnzb: cint;
                              descrA: cusparseMatDescr_t;
                              bsrSortedValA: ptr cfloat;
                              bsrSortedRowPtrA: ptr cint;
                              bsrSortedColIndA: ptr cint; blockDim: cint;
                              info: bsrsv2Info_t; policy: cusparseSolvePolicy_t;
                              pBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseSbsrsv2_analysis", dynlib: libName.}
proc cusparseDbsrsv2_analysis*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                              transA: cusparseOperation_t; mb: cint; nnzb: cint;
                              descrA: cusparseMatDescr_t;
                              bsrSortedValA: ptr cdouble;
                              bsrSortedRowPtrA: ptr cint;
                              bsrSortedColIndA: ptr cint; blockDim: cint;
                              info: bsrsv2Info_t; policy: cusparseSolvePolicy_t;
                              pBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseDbsrsv2_analysis", dynlib: libName.}
proc cusparseCbsrsv2_analysis*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                              transA: cusparseOperation_t; mb: cint; nnzb: cint;
                              descrA: cusparseMatDescr_t;
                              bsrSortedValA: ptr cuComplex;
                              bsrSortedRowPtrA: ptr cint;
                              bsrSortedColIndA: ptr cint; blockDim: cint;
                              info: bsrsv2Info_t; policy: cusparseSolvePolicy_t;
                              pBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseCbsrsv2_analysis", dynlib: libName.}
proc cusparseZbsrsv2_analysis*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                              transA: cusparseOperation_t; mb: cint; nnzb: cint;
                              descrA: cusparseMatDescr_t;
                              bsrSortedValA: ptr cuDoubleComplex;
                              bsrSortedRowPtrA: ptr cint;
                              bsrSortedColIndA: ptr cint; blockDim: cint;
                              info: bsrsv2Info_t; policy: cusparseSolvePolicy_t;
                              pBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseZbsrsv2_analysis", dynlib: libName.}
proc cusparseSbsrsv2_solve*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                           transA: cusparseOperation_t; mb: cint; nnzb: cint;
                           alpha: ptr cfloat; descrA: cusparseMatDescr_t;
                           bsrSortedValA: ptr cfloat; bsrSortedRowPtrA: ptr cint;
                           bsrSortedColIndA: ptr cint; blockDim: cint;
                           info: bsrsv2Info_t; f: ptr cfloat; x: ptr cfloat;
                           policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseSbsrsv2_solve", dynlib: libName.}
proc cusparseDbsrsv2_solve*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                           transA: cusparseOperation_t; mb: cint; nnzb: cint;
                           alpha: ptr cdouble; descrA: cusparseMatDescr_t;
                           bsrSortedValA: ptr cdouble; bsrSortedRowPtrA: ptr cint;
                           bsrSortedColIndA: ptr cint; blockDim: cint;
                           info: bsrsv2Info_t; f: ptr cdouble; x: ptr cdouble;
                           policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseDbsrsv2_solve", dynlib: libName.}
proc cusparseCbsrsv2_solve*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                           transA: cusparseOperation_t; mb: cint; nnzb: cint;
                           alpha: ptr cuComplex; descrA: cusparseMatDescr_t;
                           bsrSortedValA: ptr cuComplex;
                           bsrSortedRowPtrA: ptr cint; bsrSortedColIndA: ptr cint;
                           blockDim: cint; info: bsrsv2Info_t; f: ptr cuComplex;
                           x: ptr cuComplex; policy: cusparseSolvePolicy_t;
                           pBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseCbsrsv2_solve", dynlib: libName.}
proc cusparseZbsrsv2_solve*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                           transA: cusparseOperation_t; mb: cint; nnzb: cint;
                           alpha: ptr cuDoubleComplex; descrA: cusparseMatDescr_t;
                           bsrSortedValA: ptr cuDoubleComplex;
                           bsrSortedRowPtrA: ptr cint; bsrSortedColIndA: ptr cint;
                           blockDim: cint; info: bsrsv2Info_t;
                           f: ptr cuDoubleComplex; x: ptr cuDoubleComplex;
                           policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseZbsrsv2_solve", dynlib: libName.}
## ##############################################################################
## # SPARSE LEVEL 3 ROUTINES
## ##############################################################################

proc cusparseSbsrmm*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                    transA: cusparseOperation_t; transB: cusparseOperation_t;
                    mb: cint; n: cint; kb: cint; nnzb: cint; alpha: ptr cfloat;
                    descrA: cusparseMatDescr_t; bsrSortedValA: ptr cfloat;
                    bsrSortedRowPtrA: ptr cint; bsrSortedColIndA: ptr cint;
                    blockSize: cint; B: ptr cfloat; ldb: cint; beta: ptr cfloat;
                    C: ptr cfloat; ldc: cint): cusparseStatus_t {.cdecl,
    importc: "cusparseSbsrmm", dynlib: libName.}
proc cusparseDbsrmm*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                    transA: cusparseOperation_t; transB: cusparseOperation_t;
                    mb: cint; n: cint; kb: cint; nnzb: cint; alpha: ptr cdouble;
                    descrA: cusparseMatDescr_t; bsrSortedValA: ptr cdouble;
                    bsrSortedRowPtrA: ptr cint; bsrSortedColIndA: ptr cint;
                    blockSize: cint; B: ptr cdouble; ldb: cint; beta: ptr cdouble;
                    C: ptr cdouble; ldc: cint): cusparseStatus_t {.cdecl,
    importc: "cusparseDbsrmm", dynlib: libName.}
proc cusparseCbsrmm*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                    transA: cusparseOperation_t; transB: cusparseOperation_t;
                    mb: cint; n: cint; kb: cint; nnzb: cint; alpha: ptr cuComplex;
                    descrA: cusparseMatDescr_t; bsrSortedValA: ptr cuComplex;
                    bsrSortedRowPtrA: ptr cint; bsrSortedColIndA: ptr cint;
                    blockSize: cint; B: ptr cuComplex; ldb: cint; beta: ptr cuComplex;
                    C: ptr cuComplex; ldc: cint): cusparseStatus_t {.cdecl,
    importc: "cusparseCbsrmm", dynlib: libName.}
proc cusparseZbsrmm*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                    transA: cusparseOperation_t; transB: cusparseOperation_t;
                    mb: cint; n: cint; kb: cint; nnzb: cint; alpha: ptr cuDoubleComplex;
                    descrA: cusparseMatDescr_t;
                    bsrSortedValA: ptr cuDoubleComplex; bsrSortedRowPtrA: ptr cint;
                    bsrSortedColIndA: ptr cint; blockSize: cint;
                    B: ptr cuDoubleComplex; ldb: cint; beta: ptr cuDoubleComplex;
                    C: ptr cuDoubleComplex; ldc: cint): cusparseStatus_t {.cdecl,
    importc: "cusparseZbsrmm", dynlib: libName.}
proc cusparseXbsrsm2_zeroPivot*(handle: cusparseHandle_t; info: bsrsm2Info_t;
                               position: ptr cint): cusparseStatus_t {.cdecl,
    importc: "cusparseXbsrsm2_zeroPivot", dynlib: libName.}
proc cusparseSbsrsm2_bufferSize*(handle: cusparseHandle_t;
                                dirA: cusparseDirection_t;
                                transA: cusparseOperation_t;
                                transXY: cusparseOperation_t; mb: cint; n: cint;
                                nnzb: cint; descrA: cusparseMatDescr_t;
                                bsrSortedVal: ptr cfloat;
                                bsrSortedRowPtr: ptr cint;
                                bsrSortedColInd: ptr cint; blockSize: cint;
                                info: bsrsm2Info_t; pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseSbsrsm2_bufferSize", dynlib: libName.}
proc cusparseDbsrsm2_bufferSize*(handle: cusparseHandle_t;
                                dirA: cusparseDirection_t;
                                transA: cusparseOperation_t;
                                transXY: cusparseOperation_t; mb: cint; n: cint;
                                nnzb: cint; descrA: cusparseMatDescr_t;
                                bsrSortedVal: ptr cdouble;
                                bsrSortedRowPtr: ptr cint;
                                bsrSortedColInd: ptr cint; blockSize: cint;
                                info: bsrsm2Info_t; pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseDbsrsm2_bufferSize", dynlib: libName.}
proc cusparseCbsrsm2_bufferSize*(handle: cusparseHandle_t;
                                dirA: cusparseDirection_t;
                                transA: cusparseOperation_t;
                                transXY: cusparseOperation_t; mb: cint; n: cint;
                                nnzb: cint; descrA: cusparseMatDescr_t;
                                bsrSortedVal: ptr cuComplex;
                                bsrSortedRowPtr: ptr cint;
                                bsrSortedColInd: ptr cint; blockSize: cint;
                                info: bsrsm2Info_t; pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseCbsrsm2_bufferSize", dynlib: libName.}
proc cusparseZbsrsm2_bufferSize*(handle: cusparseHandle_t;
                                dirA: cusparseDirection_t;
                                transA: cusparseOperation_t;
                                transXY: cusparseOperation_t; mb: cint; n: cint;
                                nnzb: cint; descrA: cusparseMatDescr_t;
                                bsrSortedVal: ptr cuDoubleComplex;
                                bsrSortedRowPtr: ptr cint;
                                bsrSortedColInd: ptr cint; blockSize: cint;
                                info: bsrsm2Info_t; pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseZbsrsm2_bufferSize", dynlib: libName.}
proc cusparseSbsrsm2_bufferSizeExt*(handle: cusparseHandle_t;
                                   dirA: cusparseDirection_t;
                                   transA: cusparseOperation_t;
                                   transB: cusparseOperation_t; mb: cint; n: cint;
                                   nnzb: cint; descrA: cusparseMatDescr_t;
                                   bsrSortedVal: ptr cfloat;
                                   bsrSortedRowPtr: ptr cint;
                                   bsrSortedColInd: ptr cint; blockSize: cint;
                                   info: bsrsm2Info_t; pBufferSize: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseSbsrsm2_bufferSizeExt", dynlib: libName.}
proc cusparseDbsrsm2_bufferSizeExt*(handle: cusparseHandle_t;
                                   dirA: cusparseDirection_t;
                                   transA: cusparseOperation_t;
                                   transB: cusparseOperation_t; mb: cint; n: cint;
                                   nnzb: cint; descrA: cusparseMatDescr_t;
                                   bsrSortedVal: ptr cdouble;
                                   bsrSortedRowPtr: ptr cint;
                                   bsrSortedColInd: ptr cint; blockSize: cint;
                                   info: bsrsm2Info_t; pBufferSize: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseDbsrsm2_bufferSizeExt", dynlib: libName.}
proc cusparseCbsrsm2_bufferSizeExt*(handle: cusparseHandle_t;
                                   dirA: cusparseDirection_t;
                                   transA: cusparseOperation_t;
                                   transB: cusparseOperation_t; mb: cint; n: cint;
                                   nnzb: cint; descrA: cusparseMatDescr_t;
                                   bsrSortedVal: ptr cuComplex;
                                   bsrSortedRowPtr: ptr cint;
                                   bsrSortedColInd: ptr cint; blockSize: cint;
                                   info: bsrsm2Info_t; pBufferSize: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseCbsrsm2_bufferSizeExt", dynlib: libName.}
proc cusparseZbsrsm2_bufferSizeExt*(handle: cusparseHandle_t;
                                   dirA: cusparseDirection_t;
                                   transA: cusparseOperation_t;
                                   transB: cusparseOperation_t; mb: cint; n: cint;
                                   nnzb: cint; descrA: cusparseMatDescr_t;
                                   bsrSortedVal: ptr cuDoubleComplex;
                                   bsrSortedRowPtr: ptr cint;
                                   bsrSortedColInd: ptr cint; blockSize: cint;
                                   info: bsrsm2Info_t; pBufferSize: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseZbsrsm2_bufferSizeExt", dynlib: libName.}
proc cusparseSbsrsm2_analysis*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                              transA: cusparseOperation_t;
                              transXY: cusparseOperation_t; mb: cint; n: cint;
                              nnzb: cint; descrA: cusparseMatDescr_t;
                              bsrSortedVal: ptr cfloat; bsrSortedRowPtr: ptr cint;
                              bsrSortedColInd: ptr cint; blockSize: cint;
                              info: bsrsm2Info_t; policy: cusparseSolvePolicy_t;
                              pBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseSbsrsm2_analysis", dynlib: libName.}
proc cusparseDbsrsm2_analysis*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                              transA: cusparseOperation_t;
                              transXY: cusparseOperation_t; mb: cint; n: cint;
                              nnzb: cint; descrA: cusparseMatDescr_t;
                              bsrSortedVal: ptr cdouble; bsrSortedRowPtr: ptr cint;
                              bsrSortedColInd: ptr cint; blockSize: cint;
                              info: bsrsm2Info_t; policy: cusparseSolvePolicy_t;
                              pBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseDbsrsm2_analysis", dynlib: libName.}
proc cusparseCbsrsm2_analysis*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                              transA: cusparseOperation_t;
                              transXY: cusparseOperation_t; mb: cint; n: cint;
                              nnzb: cint; descrA: cusparseMatDescr_t;
                              bsrSortedVal: ptr cuComplex;
                              bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint;
                              blockSize: cint; info: bsrsm2Info_t;
                              policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseCbsrsm2_analysis", dynlib: libName.}
proc cusparseZbsrsm2_analysis*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                              transA: cusparseOperation_t;
                              transXY: cusparseOperation_t; mb: cint; n: cint;
                              nnzb: cint; descrA: cusparseMatDescr_t;
                              bsrSortedVal: ptr cuDoubleComplex;
                              bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint;
                              blockSize: cint; info: bsrsm2Info_t;
                              policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseZbsrsm2_analysis", dynlib: libName.}
proc cusparseSbsrsm2_solve*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                           transA: cusparseOperation_t;
                           transXY: cusparseOperation_t; mb: cint; n: cint;
                           nnzb: cint; alpha: ptr cfloat; descrA: cusparseMatDescr_t;
                           bsrSortedVal: ptr cfloat; bsrSortedRowPtr: ptr cint;
                           bsrSortedColInd: ptr cint; blockSize: cint;
                           info: bsrsm2Info_t; B: ptr cfloat; ldb: cint; X: ptr cfloat;
                           ldx: cint; policy: cusparseSolvePolicy_t;
                           pBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseSbsrsm2_solve", dynlib: libName.}
proc cusparseDbsrsm2_solve*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                           transA: cusparseOperation_t;
                           transXY: cusparseOperation_t; mb: cint; n: cint;
                           nnzb: cint; alpha: ptr cdouble;
                           descrA: cusparseMatDescr_t; bsrSortedVal: ptr cdouble;
                           bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint;
                           blockSize: cint; info: bsrsm2Info_t; B: ptr cdouble;
                           ldb: cint; X: ptr cdouble; ldx: cint;
                           policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseDbsrsm2_solve", dynlib: libName.}
proc cusparseCbsrsm2_solve*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                           transA: cusparseOperation_t;
                           transXY: cusparseOperation_t; mb: cint; n: cint;
                           nnzb: cint; alpha: ptr cuComplex;
                           descrA: cusparseMatDescr_t;
                           bsrSortedVal: ptr cuComplex; bsrSortedRowPtr: ptr cint;
                           bsrSortedColInd: ptr cint; blockSize: cint;
                           info: bsrsm2Info_t; B: ptr cuComplex; ldb: cint;
                           X: ptr cuComplex; ldx: cint;
                           policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseCbsrsm2_solve", dynlib: libName.}
proc cusparseZbsrsm2_solve*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                           transA: cusparseOperation_t;
                           transXY: cusparseOperation_t; mb: cint; n: cint;
                           nnzb: cint; alpha: ptr cuDoubleComplex;
                           descrA: cusparseMatDescr_t;
                           bsrSortedVal: ptr cuDoubleComplex;
                           bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint;
                           blockSize: cint; info: bsrsm2Info_t;
                           B: ptr cuDoubleComplex; ldb: cint; X: ptr cuDoubleComplex;
                           ldx: cint; policy: cusparseSolvePolicy_t;
                           pBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseZbsrsm2_solve", dynlib: libName.}
## ##############################################################################
## # PRECONDITIONERS
## ##############################################################################

proc cusparseScsrilu02_numericBoost*(handle: cusparseHandle_t;
                                    info: csrilu02Info_t; enable_boost: cint;
                                    tol: ptr cdouble; boost_val: ptr cfloat): cusparseStatus_t {.
    cdecl, importc: "cusparseScsrilu02_numericBoost", dynlib: libName.}
proc cusparseDcsrilu02_numericBoost*(handle: cusparseHandle_t;
                                    info: csrilu02Info_t; enable_boost: cint;
                                    tol: ptr cdouble; boost_val: ptr cdouble): cusparseStatus_t {.
    cdecl, importc: "cusparseDcsrilu02_numericBoost", dynlib: libName.}
proc cusparseCcsrilu02_numericBoost*(handle: cusparseHandle_t;
                                    info: csrilu02Info_t; enable_boost: cint;
                                    tol: ptr cdouble; boost_val: ptr cuComplex): cusparseStatus_t {.
    cdecl, importc: "cusparseCcsrilu02_numericBoost", dynlib: libName.}
proc cusparseZcsrilu02_numericBoost*(handle: cusparseHandle_t;
                                    info: csrilu02Info_t; enable_boost: cint;
                                    tol: ptr cdouble;
                                    boost_val: ptr cuDoubleComplex): cusparseStatus_t {.
    cdecl, importc: "cusparseZcsrilu02_numericBoost", dynlib: libName.}
proc cusparseXcsrilu02_zeroPivot*(handle: cusparseHandle_t; info: csrilu02Info_t;
                                 position: ptr cint): cusparseStatus_t {.cdecl,
    importc: "cusparseXcsrilu02_zeroPivot", dynlib: libName.}
proc cusparseScsrilu02_bufferSize*(handle: cusparseHandle_t; m: cint; nnz: cint;
                                  descrA: cusparseMatDescr_t;
                                  csrSortedValA: ptr cfloat;
                                  csrSortedRowPtrA: ptr cint;
                                  csrSortedColIndA: ptr cint; info: csrilu02Info_t;
                                  pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseScsrilu02_bufferSize", dynlib: libName.}
proc cusparseDcsrilu02_bufferSize*(handle: cusparseHandle_t; m: cint; nnz: cint;
                                  descrA: cusparseMatDescr_t;
                                  csrSortedValA: ptr cdouble;
                                  csrSortedRowPtrA: ptr cint;
                                  csrSortedColIndA: ptr cint; info: csrilu02Info_t;
                                  pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseDcsrilu02_bufferSize", dynlib: libName.}
proc cusparseCcsrilu02_bufferSize*(handle: cusparseHandle_t; m: cint; nnz: cint;
                                  descrA: cusparseMatDescr_t;
                                  csrSortedValA: ptr cuComplex;
                                  csrSortedRowPtrA: ptr cint;
                                  csrSortedColIndA: ptr cint; info: csrilu02Info_t;
                                  pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseCcsrilu02_bufferSize", dynlib: libName.}
proc cusparseZcsrilu02_bufferSize*(handle: cusparseHandle_t; m: cint; nnz: cint;
                                  descrA: cusparseMatDescr_t;
                                  csrSortedValA: ptr cuDoubleComplex;
                                  csrSortedRowPtrA: ptr cint;
                                  csrSortedColIndA: ptr cint; info: csrilu02Info_t;
                                  pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseZcsrilu02_bufferSize", dynlib: libName.}
proc cusparseScsrilu02_bufferSizeExt*(handle: cusparseHandle_t; m: cint; nnz: cint;
                                     descrA: cusparseMatDescr_t;
                                     csrSortedVal: ptr cfloat;
                                     csrSortedRowPtr: ptr cint;
                                     csrSortedColInd: ptr cint;
                                     info: csrilu02Info_t;
                                     pBufferSize: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseScsrilu02_bufferSizeExt", dynlib: libName.}
proc cusparseDcsrilu02_bufferSizeExt*(handle: cusparseHandle_t; m: cint; nnz: cint;
                                     descrA: cusparseMatDescr_t;
                                     csrSortedVal: ptr cdouble;
                                     csrSortedRowPtr: ptr cint;
                                     csrSortedColInd: ptr cint;
                                     info: csrilu02Info_t;
                                     pBufferSize: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseDcsrilu02_bufferSizeExt", dynlib: libName.}
proc cusparseCcsrilu02_bufferSizeExt*(handle: cusparseHandle_t; m: cint; nnz: cint;
                                     descrA: cusparseMatDescr_t;
                                     csrSortedVal: ptr cuComplex;
                                     csrSortedRowPtr: ptr cint;
                                     csrSortedColInd: ptr cint;
                                     info: csrilu02Info_t;
                                     pBufferSize: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseCcsrilu02_bufferSizeExt", dynlib: libName.}
proc cusparseZcsrilu02_bufferSizeExt*(handle: cusparseHandle_t; m: cint; nnz: cint;
                                     descrA: cusparseMatDescr_t;
                                     csrSortedVal: ptr cuDoubleComplex;
                                     csrSortedRowPtr: ptr cint;
                                     csrSortedColInd: ptr cint;
                                     info: csrilu02Info_t;
                                     pBufferSize: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseZcsrilu02_bufferSizeExt", dynlib: libName.}
proc cusparseScsrilu02_analysis*(handle: cusparseHandle_t; m: cint; nnz: cint;
                                descrA: cusparseMatDescr_t;
                                csrSortedValA: ptr cfloat;
                                csrSortedRowPtrA: ptr cint;
                                csrSortedColIndA: ptr cint; info: csrilu02Info_t;
                                policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseScsrilu02_analysis", dynlib: libName.}
proc cusparseDcsrilu02_analysis*(handle: cusparseHandle_t; m: cint; nnz: cint;
                                descrA: cusparseMatDescr_t;
                                csrSortedValA: ptr cdouble;
                                csrSortedRowPtrA: ptr cint;
                                csrSortedColIndA: ptr cint; info: csrilu02Info_t;
                                policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseDcsrilu02_analysis", dynlib: libName.}
proc cusparseCcsrilu02_analysis*(handle: cusparseHandle_t; m: cint; nnz: cint;
                                descrA: cusparseMatDescr_t;
                                csrSortedValA: ptr cuComplex;
                                csrSortedRowPtrA: ptr cint;
                                csrSortedColIndA: ptr cint; info: csrilu02Info_t;
                                policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseCcsrilu02_analysis", dynlib: libName.}
proc cusparseZcsrilu02_analysis*(handle: cusparseHandle_t; m: cint; nnz: cint;
                                descrA: cusparseMatDescr_t;
                                csrSortedValA: ptr cuDoubleComplex;
                                csrSortedRowPtrA: ptr cint;
                                csrSortedColIndA: ptr cint; info: csrilu02Info_t;
                                policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseZcsrilu02_analysis", dynlib: libName.}
proc cusparseScsrilu02*(handle: cusparseHandle_t; m: cint; nnz: cint;
                       descrA: cusparseMatDescr_t; csrSortedValA_valM: ptr cfloat;
                       csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                       info: csrilu02Info_t; policy: cusparseSolvePolicy_t;
                       pBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseScsrilu02", dynlib: libName.}
proc cusparseDcsrilu02*(handle: cusparseHandle_t; m: cint; nnz: cint;
                       descrA: cusparseMatDescr_t;
                       csrSortedValA_valM: ptr cdouble; csrSortedRowPtrA: ptr cint;
                       csrSortedColIndA: ptr cint; info: csrilu02Info_t;
                       policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseDcsrilu02", dynlib: libName.}
proc cusparseCcsrilu02*(handle: cusparseHandle_t; m: cint; nnz: cint;
                       descrA: cusparseMatDescr_t;
                       csrSortedValA_valM: ptr cuComplex;
                       csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                       info: csrilu02Info_t; policy: cusparseSolvePolicy_t;
                       pBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseCcsrilu02", dynlib: libName.}
proc cusparseZcsrilu02*(handle: cusparseHandle_t; m: cint; nnz: cint;
                       descrA: cusparseMatDescr_t;
                       csrSortedValA_valM: ptr cuDoubleComplex;
                       csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                       info: csrilu02Info_t; policy: cusparseSolvePolicy_t;
                       pBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseZcsrilu02", dynlib: libName.}
proc cusparseSbsrilu02_numericBoost*(handle: cusparseHandle_t;
                                    info: bsrilu02Info_t; enable_boost: cint;
                                    tol: ptr cdouble; boost_val: ptr cfloat): cusparseStatus_t {.
    cdecl, importc: "cusparseSbsrilu02_numericBoost", dynlib: libName.}
proc cusparseDbsrilu02_numericBoost*(handle: cusparseHandle_t;
                                    info: bsrilu02Info_t; enable_boost: cint;
                                    tol: ptr cdouble; boost_val: ptr cdouble): cusparseStatus_t {.
    cdecl, importc: "cusparseDbsrilu02_numericBoost", dynlib: libName.}
proc cusparseCbsrilu02_numericBoost*(handle: cusparseHandle_t;
                                    info: bsrilu02Info_t; enable_boost: cint;
                                    tol: ptr cdouble; boost_val: ptr cuComplex): cusparseStatus_t {.
    cdecl, importc: "cusparseCbsrilu02_numericBoost", dynlib: libName.}
proc cusparseZbsrilu02_numericBoost*(handle: cusparseHandle_t;
                                    info: bsrilu02Info_t; enable_boost: cint;
                                    tol: ptr cdouble;
                                    boost_val: ptr cuDoubleComplex): cusparseStatus_t {.
    cdecl, importc: "cusparseZbsrilu02_numericBoost", dynlib: libName.}
proc cusparseXbsrilu02_zeroPivot*(handle: cusparseHandle_t; info: bsrilu02Info_t;
                                 position: ptr cint): cusparseStatus_t {.cdecl,
    importc: "cusparseXbsrilu02_zeroPivot", dynlib: libName.}
proc cusparseSbsrilu02_bufferSize*(handle: cusparseHandle_t;
                                  dirA: cusparseDirection_t; mb: cint; nnzb: cint;
                                  descrA: cusparseMatDescr_t;
                                  bsrSortedVal: ptr cfloat;
                                  bsrSortedRowPtr: ptr cint;
                                  bsrSortedColInd: ptr cint; blockDim: cint;
                                  info: bsrilu02Info_t;
                                  pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseSbsrilu02_bufferSize", dynlib: libName.}
proc cusparseDbsrilu02_bufferSize*(handle: cusparseHandle_t;
                                  dirA: cusparseDirection_t; mb: cint; nnzb: cint;
                                  descrA: cusparseMatDescr_t;
                                  bsrSortedVal: ptr cdouble;
                                  bsrSortedRowPtr: ptr cint;
                                  bsrSortedColInd: ptr cint; blockDim: cint;
                                  info: bsrilu02Info_t;
                                  pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseDbsrilu02_bufferSize", dynlib: libName.}
proc cusparseCbsrilu02_bufferSize*(handle: cusparseHandle_t;
                                  dirA: cusparseDirection_t; mb: cint; nnzb: cint;
                                  descrA: cusparseMatDescr_t;
                                  bsrSortedVal: ptr cuComplex;
                                  bsrSortedRowPtr: ptr cint;
                                  bsrSortedColInd: ptr cint; blockDim: cint;
                                  info: bsrilu02Info_t;
                                  pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseCbsrilu02_bufferSize", dynlib: libName.}
proc cusparseZbsrilu02_bufferSize*(handle: cusparseHandle_t;
                                  dirA: cusparseDirection_t; mb: cint; nnzb: cint;
                                  descrA: cusparseMatDescr_t;
                                  bsrSortedVal: ptr cuDoubleComplex;
                                  bsrSortedRowPtr: ptr cint;
                                  bsrSortedColInd: ptr cint; blockDim: cint;
                                  info: bsrilu02Info_t;
                                  pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseZbsrilu02_bufferSize", dynlib: libName.}
proc cusparseSbsrilu02_bufferSizeExt*(handle: cusparseHandle_t;
                                     dirA: cusparseDirection_t; mb: cint;
                                     nnzb: cint; descrA: cusparseMatDescr_t;
                                     bsrSortedVal: ptr cfloat;
                                     bsrSortedRowPtr: ptr cint;
                                     bsrSortedColInd: ptr cint; blockSize: cint;
                                     info: bsrilu02Info_t;
                                     pBufferSize: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseSbsrilu02_bufferSizeExt", dynlib: libName.}
proc cusparseDbsrilu02_bufferSizeExt*(handle: cusparseHandle_t;
                                     dirA: cusparseDirection_t; mb: cint;
                                     nnzb: cint; descrA: cusparseMatDescr_t;
                                     bsrSortedVal: ptr cdouble;
                                     bsrSortedRowPtr: ptr cint;
                                     bsrSortedColInd: ptr cint; blockSize: cint;
                                     info: bsrilu02Info_t;
                                     pBufferSize: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseDbsrilu02_bufferSizeExt", dynlib: libName.}
proc cusparseCbsrilu02_bufferSizeExt*(handle: cusparseHandle_t;
                                     dirA: cusparseDirection_t; mb: cint;
                                     nnzb: cint; descrA: cusparseMatDescr_t;
                                     bsrSortedVal: ptr cuComplex;
                                     bsrSortedRowPtr: ptr cint;
                                     bsrSortedColInd: ptr cint; blockSize: cint;
                                     info: bsrilu02Info_t;
                                     pBufferSize: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseCbsrilu02_bufferSizeExt", dynlib: libName.}
proc cusparseZbsrilu02_bufferSizeExt*(handle: cusparseHandle_t;
                                     dirA: cusparseDirection_t; mb: cint;
                                     nnzb: cint; descrA: cusparseMatDescr_t;
                                     bsrSortedVal: ptr cuDoubleComplex;
                                     bsrSortedRowPtr: ptr cint;
                                     bsrSortedColInd: ptr cint; blockSize: cint;
                                     info: bsrilu02Info_t;
                                     pBufferSize: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseZbsrilu02_bufferSizeExt", dynlib: libName.}
proc cusparseSbsrilu02_analysis*(handle: cusparseHandle_t;
                                dirA: cusparseDirection_t; mb: cint; nnzb: cint;
                                descrA: cusparseMatDescr_t;
                                bsrSortedVal: ptr cfloat;
                                bsrSortedRowPtr: ptr cint;
                                bsrSortedColInd: ptr cint; blockDim: cint;
                                info: bsrilu02Info_t;
                                policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseSbsrilu02_analysis", dynlib: libName.}
proc cusparseDbsrilu02_analysis*(handle: cusparseHandle_t;
                                dirA: cusparseDirection_t; mb: cint; nnzb: cint;
                                descrA: cusparseMatDescr_t;
                                bsrSortedVal: ptr cdouble;
                                bsrSortedRowPtr: ptr cint;
                                bsrSortedColInd: ptr cint; blockDim: cint;
                                info: bsrilu02Info_t;
                                policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseDbsrilu02_analysis", dynlib: libName.}
proc cusparseCbsrilu02_analysis*(handle: cusparseHandle_t;
                                dirA: cusparseDirection_t; mb: cint; nnzb: cint;
                                descrA: cusparseMatDescr_t;
                                bsrSortedVal: ptr cuComplex;
                                bsrSortedRowPtr: ptr cint;
                                bsrSortedColInd: ptr cint; blockDim: cint;
                                info: bsrilu02Info_t;
                                policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseCbsrilu02_analysis", dynlib: libName.}
proc cusparseZbsrilu02_analysis*(handle: cusparseHandle_t;
                                dirA: cusparseDirection_t; mb: cint; nnzb: cint;
                                descrA: cusparseMatDescr_t;
                                bsrSortedVal: ptr cuDoubleComplex;
                                bsrSortedRowPtr: ptr cint;
                                bsrSortedColInd: ptr cint; blockDim: cint;
                                info: bsrilu02Info_t;
                                policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseZbsrilu02_analysis", dynlib: libName.}
proc cusparseSbsrilu02*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                       mb: cint; nnzb: cint; descrA: cusparseMatDescr_t;
                       bsrSortedVal: ptr cfloat; bsrSortedRowPtr: ptr cint;
                       bsrSortedColInd: ptr cint; blockDim: cint;
                       info: bsrilu02Info_t; policy: cusparseSolvePolicy_t;
                       pBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseSbsrilu02", dynlib: libName.}
proc cusparseDbsrilu02*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                       mb: cint; nnzb: cint; descrA: cusparseMatDescr_t;
                       bsrSortedVal: ptr cdouble; bsrSortedRowPtr: ptr cint;
                       bsrSortedColInd: ptr cint; blockDim: cint;
                       info: bsrilu02Info_t; policy: cusparseSolvePolicy_t;
                       pBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseDbsrilu02", dynlib: libName.}
proc cusparseCbsrilu02*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                       mb: cint; nnzb: cint; descrA: cusparseMatDescr_t;
                       bsrSortedVal: ptr cuComplex; bsrSortedRowPtr: ptr cint;
                       bsrSortedColInd: ptr cint; blockDim: cint;
                       info: bsrilu02Info_t; policy: cusparseSolvePolicy_t;
                       pBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseCbsrilu02", dynlib: libName.}
proc cusparseZbsrilu02*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                       mb: cint; nnzb: cint; descrA: cusparseMatDescr_t;
                       bsrSortedVal: ptr cuDoubleComplex;
                       bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint;
                       blockDim: cint; info: bsrilu02Info_t;
                       policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseZbsrilu02", dynlib: libName.}
proc cusparseXcsric02_zeroPivot*(handle: cusparseHandle_t; info: csric02Info_t;
                                position: ptr cint): cusparseStatus_t {.cdecl,
    importc: "cusparseXcsric02_zeroPivot", dynlib: libName.}
proc cusparseScsric02_bufferSize*(handle: cusparseHandle_t; m: cint; nnz: cint;
                                 descrA: cusparseMatDescr_t;
                                 csrSortedValA: ptr cfloat;
                                 csrSortedRowPtrA: ptr cint;
                                 csrSortedColIndA: ptr cint; info: csric02Info_t;
                                 pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseScsric02_bufferSize", dynlib: libName.}
proc cusparseDcsric02_bufferSize*(handle: cusparseHandle_t; m: cint; nnz: cint;
                                 descrA: cusparseMatDescr_t;
                                 csrSortedValA: ptr cdouble;
                                 csrSortedRowPtrA: ptr cint;
                                 csrSortedColIndA: ptr cint; info: csric02Info_t;
                                 pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseDcsric02_bufferSize", dynlib: libName.}
proc cusparseCcsric02_bufferSize*(handle: cusparseHandle_t; m: cint; nnz: cint;
                                 descrA: cusparseMatDescr_t;
                                 csrSortedValA: ptr cuComplex;
                                 csrSortedRowPtrA: ptr cint;
                                 csrSortedColIndA: ptr cint; info: csric02Info_t;
                                 pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseCcsric02_bufferSize", dynlib: libName.}
proc cusparseZcsric02_bufferSize*(handle: cusparseHandle_t; m: cint; nnz: cint;
                                 descrA: cusparseMatDescr_t;
                                 csrSortedValA: ptr cuDoubleComplex;
                                 csrSortedRowPtrA: ptr cint;
                                 csrSortedColIndA: ptr cint; info: csric02Info_t;
                                 pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseZcsric02_bufferSize", dynlib: libName.}
proc cusparseScsric02_bufferSizeExt*(handle: cusparseHandle_t; m: cint; nnz: cint;
                                    descrA: cusparseMatDescr_t;
                                    csrSortedVal: ptr cfloat;
                                    csrSortedRowPtr: ptr cint;
                                    csrSortedColInd: ptr cint; info: csric02Info_t;
                                    pBufferSize: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseScsric02_bufferSizeExt", dynlib: libName.}
proc cusparseDcsric02_bufferSizeExt*(handle: cusparseHandle_t; m: cint; nnz: cint;
                                    descrA: cusparseMatDescr_t;
                                    csrSortedVal: ptr cdouble;
                                    csrSortedRowPtr: ptr cint;
                                    csrSortedColInd: ptr cint; info: csric02Info_t;
                                    pBufferSize: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseDcsric02_bufferSizeExt", dynlib: libName.}
proc cusparseCcsric02_bufferSizeExt*(handle: cusparseHandle_t; m: cint; nnz: cint;
                                    descrA: cusparseMatDescr_t;
                                    csrSortedVal: ptr cuComplex;
                                    csrSortedRowPtr: ptr cint;
                                    csrSortedColInd: ptr cint; info: csric02Info_t;
                                    pBufferSize: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseCcsric02_bufferSizeExt", dynlib: libName.}
proc cusparseZcsric02_bufferSizeExt*(handle: cusparseHandle_t; m: cint; nnz: cint;
                                    descrA: cusparseMatDescr_t;
                                    csrSortedVal: ptr cuDoubleComplex;
                                    csrSortedRowPtr: ptr cint;
                                    csrSortedColInd: ptr cint; info: csric02Info_t;
                                    pBufferSize: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseZcsric02_bufferSizeExt", dynlib: libName.}
proc cusparseScsric02_analysis*(handle: cusparseHandle_t; m: cint; nnz: cint;
                               descrA: cusparseMatDescr_t;
                               csrSortedValA: ptr cfloat;
                               csrSortedRowPtrA: ptr cint;
                               csrSortedColIndA: ptr cint; info: csric02Info_t;
                               policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseScsric02_analysis", dynlib: libName.}
proc cusparseDcsric02_analysis*(handle: cusparseHandle_t; m: cint; nnz: cint;
                               descrA: cusparseMatDescr_t;
                               csrSortedValA: ptr cdouble;
                               csrSortedRowPtrA: ptr cint;
                               csrSortedColIndA: ptr cint; info: csric02Info_t;
                               policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseDcsric02_analysis", dynlib: libName.}
proc cusparseCcsric02_analysis*(handle: cusparseHandle_t; m: cint; nnz: cint;
                               descrA: cusparseMatDescr_t;
                               csrSortedValA: ptr cuComplex;
                               csrSortedRowPtrA: ptr cint;
                               csrSortedColIndA: ptr cint; info: csric02Info_t;
                               policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseCcsric02_analysis", dynlib: libName.}
proc cusparseZcsric02_analysis*(handle: cusparseHandle_t; m: cint; nnz: cint;
                               descrA: cusparseMatDescr_t;
                               csrSortedValA: ptr cuDoubleComplex;
                               csrSortedRowPtrA: ptr cint;
                               csrSortedColIndA: ptr cint; info: csric02Info_t;
                               policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseZcsric02_analysis", dynlib: libName.}
proc cusparseScsric02*(handle: cusparseHandle_t; m: cint; nnz: cint;
                      descrA: cusparseMatDescr_t; csrSortedValA_valM: ptr cfloat;
                      csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                      info: csric02Info_t; policy: cusparseSolvePolicy_t;
                      pBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseScsric02", dynlib: libName.}
proc cusparseDcsric02*(handle: cusparseHandle_t; m: cint; nnz: cint;
                      descrA: cusparseMatDescr_t; csrSortedValA_valM: ptr cdouble;
                      csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                      info: csric02Info_t; policy: cusparseSolvePolicy_t;
                      pBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseDcsric02", dynlib: libName.}
proc cusparseCcsric02*(handle: cusparseHandle_t; m: cint; nnz: cint;
                      descrA: cusparseMatDescr_t;
                      csrSortedValA_valM: ptr cuComplex;
                      csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                      info: csric02Info_t; policy: cusparseSolvePolicy_t;
                      pBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseCcsric02", dynlib: libName.}
proc cusparseZcsric02*(handle: cusparseHandle_t; m: cint; nnz: cint;
                      descrA: cusparseMatDescr_t;
                      csrSortedValA_valM: ptr cuDoubleComplex;
                      csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                      info: csric02Info_t; policy: cusparseSolvePolicy_t;
                      pBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseZcsric02", dynlib: libName.}
proc cusparseXbsric02_zeroPivot*(handle: cusparseHandle_t; info: bsric02Info_t;
                                position: ptr cint): cusparseStatus_t {.cdecl,
    importc: "cusparseXbsric02_zeroPivot", dynlib: libName.}
proc cusparseSbsric02_bufferSize*(handle: cusparseHandle_t;
                                 dirA: cusparseDirection_t; mb: cint; nnzb: cint;
                                 descrA: cusparseMatDescr_t;
                                 bsrSortedVal: ptr cfloat;
                                 bsrSortedRowPtr: ptr cint;
                                 bsrSortedColInd: ptr cint; blockDim: cint;
                                 info: bsric02Info_t; pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseSbsric02_bufferSize", dynlib: libName.}
proc cusparseDbsric02_bufferSize*(handle: cusparseHandle_t;
                                 dirA: cusparseDirection_t; mb: cint; nnzb: cint;
                                 descrA: cusparseMatDescr_t;
                                 bsrSortedVal: ptr cdouble;
                                 bsrSortedRowPtr: ptr cint;
                                 bsrSortedColInd: ptr cint; blockDim: cint;
                                 info: bsric02Info_t; pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseDbsric02_bufferSize", dynlib: libName.}
proc cusparseCbsric02_bufferSize*(handle: cusparseHandle_t;
                                 dirA: cusparseDirection_t; mb: cint; nnzb: cint;
                                 descrA: cusparseMatDescr_t;
                                 bsrSortedVal: ptr cuComplex;
                                 bsrSortedRowPtr: ptr cint;
                                 bsrSortedColInd: ptr cint; blockDim: cint;
                                 info: bsric02Info_t; pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseCbsric02_bufferSize", dynlib: libName.}
proc cusparseZbsric02_bufferSize*(handle: cusparseHandle_t;
                                 dirA: cusparseDirection_t; mb: cint; nnzb: cint;
                                 descrA: cusparseMatDescr_t;
                                 bsrSortedVal: ptr cuDoubleComplex;
                                 bsrSortedRowPtr: ptr cint;
                                 bsrSortedColInd: ptr cint; blockDim: cint;
                                 info: bsric02Info_t; pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseZbsric02_bufferSize", dynlib: libName.}
proc cusparseSbsric02_bufferSizeExt*(handle: cusparseHandle_t;
                                    dirA: cusparseDirection_t; mb: cint; nnzb: cint;
                                    descrA: cusparseMatDescr_t;
                                    bsrSortedVal: ptr cfloat;
                                    bsrSortedRowPtr: ptr cint;
                                    bsrSortedColInd: ptr cint; blockSize: cint;
                                    info: bsric02Info_t; pBufferSize: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseSbsric02_bufferSizeExt", dynlib: libName.}
proc cusparseDbsric02_bufferSizeExt*(handle: cusparseHandle_t;
                                    dirA: cusparseDirection_t; mb: cint; nnzb: cint;
                                    descrA: cusparseMatDescr_t;
                                    bsrSortedVal: ptr cdouble;
                                    bsrSortedRowPtr: ptr cint;
                                    bsrSortedColInd: ptr cint; blockSize: cint;
                                    info: bsric02Info_t; pBufferSize: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseDbsric02_bufferSizeExt", dynlib: libName.}
proc cusparseCbsric02_bufferSizeExt*(handle: cusparseHandle_t;
                                    dirA: cusparseDirection_t; mb: cint; nnzb: cint;
                                    descrA: cusparseMatDescr_t;
                                    bsrSortedVal: ptr cuComplex;
                                    bsrSortedRowPtr: ptr cint;
                                    bsrSortedColInd: ptr cint; blockSize: cint;
                                    info: bsric02Info_t; pBufferSize: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseCbsric02_bufferSizeExt", dynlib: libName.}
proc cusparseZbsric02_bufferSizeExt*(handle: cusparseHandle_t;
                                    dirA: cusparseDirection_t; mb: cint; nnzb: cint;
                                    descrA: cusparseMatDescr_t;
                                    bsrSortedVal: ptr cuDoubleComplex;
                                    bsrSortedRowPtr: ptr cint;
                                    bsrSortedColInd: ptr cint; blockSize: cint;
                                    info: bsric02Info_t; pBufferSize: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseZbsric02_bufferSizeExt", dynlib: libName.}
proc cusparseSbsric02_analysis*(handle: cusparseHandle_t;
                               dirA: cusparseDirection_t; mb: cint; nnzb: cint;
                               descrA: cusparseMatDescr_t;
                               bsrSortedVal: ptr cfloat; bsrSortedRowPtr: ptr cint;
                               bsrSortedColInd: ptr cint; blockDim: cint;
                               info: bsric02Info_t; policy: cusparseSolvePolicy_t;
                               pInputBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseSbsric02_analysis", dynlib: libName.}
proc cusparseDbsric02_analysis*(handle: cusparseHandle_t;
                               dirA: cusparseDirection_t; mb: cint; nnzb: cint;
                               descrA: cusparseMatDescr_t;
                               bsrSortedVal: ptr cdouble;
                               bsrSortedRowPtr: ptr cint;
                               bsrSortedColInd: ptr cint; blockDim: cint;
                               info: bsric02Info_t; policy: cusparseSolvePolicy_t;
                               pInputBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseDbsric02_analysis", dynlib: libName.}
proc cusparseCbsric02_analysis*(handle: cusparseHandle_t;
                               dirA: cusparseDirection_t; mb: cint; nnzb: cint;
                               descrA: cusparseMatDescr_t;
                               bsrSortedVal: ptr cuComplex;
                               bsrSortedRowPtr: ptr cint;
                               bsrSortedColInd: ptr cint; blockDim: cint;
                               info: bsric02Info_t; policy: cusparseSolvePolicy_t;
                               pInputBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseCbsric02_analysis", dynlib: libName.}
proc cusparseZbsric02_analysis*(handle: cusparseHandle_t;
                               dirA: cusparseDirection_t; mb: cint; nnzb: cint;
                               descrA: cusparseMatDescr_t;
                               bsrSortedVal: ptr cuDoubleComplex;
                               bsrSortedRowPtr: ptr cint;
                               bsrSortedColInd: ptr cint; blockDim: cint;
                               info: bsric02Info_t; policy: cusparseSolvePolicy_t;
                               pInputBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseZbsric02_analysis", dynlib: libName.}
proc cusparseSbsric02*(handle: cusparseHandle_t; dirA: cusparseDirection_t; mb: cint;
                      nnzb: cint; descrA: cusparseMatDescr_t;
                      bsrSortedVal: ptr cfloat; bsrSortedRowPtr: ptr cint;
                      bsrSortedColInd: ptr cint; blockDim: cint; info: bsric02Info_t;
                      policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseSbsric02", dynlib: libName.}
proc cusparseDbsric02*(handle: cusparseHandle_t; dirA: cusparseDirection_t; mb: cint;
                      nnzb: cint; descrA: cusparseMatDescr_t;
                      bsrSortedVal: ptr cdouble; bsrSortedRowPtr: ptr cint;
                      bsrSortedColInd: ptr cint; blockDim: cint; info: bsric02Info_t;
                      policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseDbsric02", dynlib: libName.}
proc cusparseCbsric02*(handle: cusparseHandle_t; dirA: cusparseDirection_t; mb: cint;
                      nnzb: cint; descrA: cusparseMatDescr_t;
                      bsrSortedVal: ptr cuComplex; bsrSortedRowPtr: ptr cint;
                      bsrSortedColInd: ptr cint; blockDim: cint; info: bsric02Info_t;
                      policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseCbsric02", dynlib: libName.}
proc cusparseZbsric02*(handle: cusparseHandle_t; dirA: cusparseDirection_t; mb: cint;
                      nnzb: cint; descrA: cusparseMatDescr_t;
                      bsrSortedVal: ptr cuDoubleComplex; bsrSortedRowPtr: ptr cint;
                      bsrSortedColInd: ptr cint; blockDim: cint; info: bsric02Info_t;
                      policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseZbsric02", dynlib: libName.}
proc cusparseSgtsv2_bufferSizeExt*(handle: cusparseHandle_t; m: cint; n: cint;
                                  dl: ptr cfloat; d: ptr cfloat; du: ptr cfloat;
                                  B: ptr cfloat; ldb: cint;
                                  bufferSizeInBytes: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseSgtsv2_bufferSizeExt", dynlib: libName.}
proc cusparseDgtsv2_bufferSizeExt*(handle: cusparseHandle_t; m: cint; n: cint;
                                  dl: ptr cdouble; d: ptr cdouble; du: ptr cdouble;
                                  B: ptr cdouble; ldb: cint;
                                  bufferSizeInBytes: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseDgtsv2_bufferSizeExt", dynlib: libName.}
proc cusparseCgtsv2_bufferSizeExt*(handle: cusparseHandle_t; m: cint; n: cint;
                                  dl: ptr cuComplex; d: ptr cuComplex;
                                  du: ptr cuComplex; B: ptr cuComplex; ldb: cint;
                                  bufferSizeInBytes: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseCgtsv2_bufferSizeExt", dynlib: libName.}
proc cusparseZgtsv2_bufferSizeExt*(handle: cusparseHandle_t; m: cint; n: cint;
                                  dl: ptr cuDoubleComplex; d: ptr cuDoubleComplex;
                                  du: ptr cuDoubleComplex; B: ptr cuDoubleComplex;
                                  ldb: cint; bufferSizeInBytes: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseZgtsv2_bufferSizeExt", dynlib: libName.}
proc cusparseSgtsv2*(handle: cusparseHandle_t; m: cint; n: cint; dl: ptr cfloat;
                    d: ptr cfloat; du: ptr cfloat; B: ptr cfloat; ldb: cint;
                    pBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseSgtsv2", dynlib: libName.}
proc cusparseDgtsv2*(handle: cusparseHandle_t; m: cint; n: cint; dl: ptr cdouble;
                    d: ptr cdouble; du: ptr cdouble; B: ptr cdouble; ldb: cint;
                    pBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseDgtsv2", dynlib: libName.}
proc cusparseCgtsv2*(handle: cusparseHandle_t; m: cint; n: cint; dl: ptr cuComplex;
                    d: ptr cuComplex; du: ptr cuComplex; B: ptr cuComplex; ldb: cint;
                    pBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseCgtsv2", dynlib: libName.}
proc cusparseZgtsv2*(handle: cusparseHandle_t; m: cint; n: cint;
                    dl: ptr cuDoubleComplex; d: ptr cuDoubleComplex;
                    du: ptr cuDoubleComplex; B: ptr cuDoubleComplex; ldb: cint;
                    pBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseZgtsv2", dynlib: libName.}
proc cusparseSgtsv2_nopivot_bufferSizeExt*(handle: cusparseHandle_t; m: cint;
    n: cint; dl: ptr cfloat; d: ptr cfloat; du: ptr cfloat; B: ptr cfloat; ldb: cint;
    bufferSizeInBytes: ptr csize_t): cusparseStatus_t {.cdecl,
    importc: "cusparseSgtsv2_nopivot_bufferSizeExt", dynlib: libName.}
proc cusparseDgtsv2_nopivot_bufferSizeExt*(handle: cusparseHandle_t; m: cint;
    n: cint; dl: ptr cdouble; d: ptr cdouble; du: ptr cdouble; B: ptr cdouble; ldb: cint;
    bufferSizeInBytes: ptr csize_t): cusparseStatus_t {.cdecl,
    importc: "cusparseDgtsv2_nopivot_bufferSizeExt", dynlib: libName.}
proc cusparseCgtsv2_nopivot_bufferSizeExt*(handle: cusparseHandle_t; m: cint;
    n: cint; dl: ptr cuComplex; d: ptr cuComplex; du: ptr cuComplex; B: ptr cuComplex;
    ldb: cint; bufferSizeInBytes: ptr csize_t): cusparseStatus_t {.cdecl,
    importc: "cusparseCgtsv2_nopivot_bufferSizeExt", dynlib: libName.}
proc cusparseZgtsv2_nopivot_bufferSizeExt*(handle: cusparseHandle_t; m: cint;
    n: cint; dl: ptr cuDoubleComplex; d: ptr cuDoubleComplex; du: ptr cuDoubleComplex;
    B: ptr cuDoubleComplex; ldb: cint; bufferSizeInBytes: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseZgtsv2_nopivot_bufferSizeExt", dynlib: libName.}
proc cusparseSgtsv2_nopivot*(handle: cusparseHandle_t; m: cint; n: cint;
                            dl: ptr cfloat; d: ptr cfloat; du: ptr cfloat; B: ptr cfloat;
                            ldb: cint; pBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseSgtsv2_nopivot", dynlib: libName.}
proc cusparseDgtsv2_nopivot*(handle: cusparseHandle_t; m: cint; n: cint;
                            dl: ptr cdouble; d: ptr cdouble; du: ptr cdouble;
                            B: ptr cdouble; ldb: cint; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseDgtsv2_nopivot", dynlib: libName.}
proc cusparseCgtsv2_nopivot*(handle: cusparseHandle_t; m: cint; n: cint;
                            dl: ptr cuComplex; d: ptr cuComplex; du: ptr cuComplex;
                            B: ptr cuComplex; ldb: cint; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseCgtsv2_nopivot", dynlib: libName.}
proc cusparseZgtsv2_nopivot*(handle: cusparseHandle_t; m: cint; n: cint;
                            dl: ptr cuDoubleComplex; d: ptr cuDoubleComplex;
                            du: ptr cuDoubleComplex; B: ptr cuDoubleComplex;
                            ldb: cint; pBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseZgtsv2_nopivot", dynlib: libName.}
proc cusparseSgtsv2StridedBatch_bufferSizeExt*(handle: cusparseHandle_t; m: cint;
    dl: ptr cfloat; d: ptr cfloat; du: ptr cfloat; x: ptr cfloat; batchCount: cint;
    batchStride: cint; bufferSizeInBytes: ptr csize_t): cusparseStatus_t {.cdecl,
    importc: "cusparseSgtsv2StridedBatch_bufferSizeExt", dynlib: libName.}
proc cusparseDgtsv2StridedBatch_bufferSizeExt*(handle: cusparseHandle_t; m: cint;
    dl: ptr cdouble; d: ptr cdouble; du: ptr cdouble; x: ptr cdouble; batchCount: cint;
    batchStride: cint; bufferSizeInBytes: ptr csize_t): cusparseStatus_t {.cdecl,
    importc: "cusparseDgtsv2StridedBatch_bufferSizeExt", dynlib: libName.}
proc cusparseCgtsv2StridedBatch_bufferSizeExt*(handle: cusparseHandle_t; m: cint;
    dl: ptr cuComplex; d: ptr cuComplex; du: ptr cuComplex; x: ptr cuComplex;
    batchCount: cint; batchStride: cint; bufferSizeInBytes: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseCgtsv2StridedBatch_bufferSizeExt", dynlib: libName.}
proc cusparseZgtsv2StridedBatch_bufferSizeExt*(handle: cusparseHandle_t; m: cint;
    dl: ptr cuDoubleComplex; d: ptr cuDoubleComplex; du: ptr cuDoubleComplex;
    x: ptr cuDoubleComplex; batchCount: cint; batchStride: cint;
    bufferSizeInBytes: ptr csize_t): cusparseStatus_t {.cdecl,
    importc: "cusparseZgtsv2StridedBatch_bufferSizeExt", dynlib: libName.}
proc cusparseSgtsv2StridedBatch*(handle: cusparseHandle_t; m: cint; dl: ptr cfloat;
                                d: ptr cfloat; du: ptr cfloat; x: ptr cfloat;
                                batchCount: cint; batchStride: cint;
                                pBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseSgtsv2StridedBatch", dynlib: libName.}
proc cusparseDgtsv2StridedBatch*(handle: cusparseHandle_t; m: cint; dl: ptr cdouble;
                                d: ptr cdouble; du: ptr cdouble; x: ptr cdouble;
                                batchCount: cint; batchStride: cint;
                                pBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseDgtsv2StridedBatch", dynlib: libName.}
proc cusparseCgtsv2StridedBatch*(handle: cusparseHandle_t; m: cint;
                                dl: ptr cuComplex; d: ptr cuComplex;
                                du: ptr cuComplex; x: ptr cuComplex; batchCount: cint;
                                batchStride: cint; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseCgtsv2StridedBatch", dynlib: libName.}
proc cusparseZgtsv2StridedBatch*(handle: cusparseHandle_t; m: cint;
                                dl: ptr cuDoubleComplex; d: ptr cuDoubleComplex;
                                du: ptr cuDoubleComplex; x: ptr cuDoubleComplex;
                                batchCount: cint; batchStride: cint;
                                pBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseZgtsv2StridedBatch", dynlib: libName.}
proc cusparseSgtsvInterleavedBatch_bufferSizeExt*(handle: cusparseHandle_t;
    algo: cint; m: cint; dl: ptr cfloat; d: ptr cfloat; du: ptr cfloat; x: ptr cfloat;
    batchCount: cint; pBufferSizeInBytes: ptr csize_t): cusparseStatus_t {.cdecl,
    importc: "cusparseSgtsvInterleavedBatch_bufferSizeExt", dynlib: libName.}
proc cusparseDgtsvInterleavedBatch_bufferSizeExt*(handle: cusparseHandle_t;
    algo: cint; m: cint; dl: ptr cdouble; d: ptr cdouble; du: ptr cdouble; x: ptr cdouble;
    batchCount: cint; pBufferSizeInBytes: ptr csize_t): cusparseStatus_t {.cdecl,
    importc: "cusparseDgtsvInterleavedBatch_bufferSizeExt", dynlib: libName.}
proc cusparseCgtsvInterleavedBatch_bufferSizeExt*(handle: cusparseHandle_t;
    algo: cint; m: cint; dl: ptr cuComplex; d: ptr cuComplex; du: ptr cuComplex;
    x: ptr cuComplex; batchCount: cint; pBufferSizeInBytes: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseCgtsvInterleavedBatch_bufferSizeExt", dynlib: libName.}
proc cusparseZgtsvInterleavedBatch_bufferSizeExt*(handle: cusparseHandle_t;
    algo: cint; m: cint; dl: ptr cuDoubleComplex; d: ptr cuDoubleComplex;
    du: ptr cuDoubleComplex; x: ptr cuDoubleComplex; batchCount: cint;
    pBufferSizeInBytes: ptr csize_t): cusparseStatus_t {.cdecl,
    importc: "cusparseZgtsvInterleavedBatch_bufferSizeExt", dynlib: libName.}
proc cusparseSgtsvInterleavedBatch*(handle: cusparseHandle_t; algo: cint; m: cint;
                                   dl: ptr cfloat; d: ptr cfloat; du: ptr cfloat;
                                   x: ptr cfloat; batchCount: cint; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseSgtsvInterleavedBatch", dynlib: libName.}
proc cusparseDgtsvInterleavedBatch*(handle: cusparseHandle_t; algo: cint; m: cint;
                                   dl: ptr cdouble; d: ptr cdouble; du: ptr cdouble;
                                   x: ptr cdouble; batchCount: cint; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseDgtsvInterleavedBatch", dynlib: libName.}
proc cusparseCgtsvInterleavedBatch*(handle: cusparseHandle_t; algo: cint; m: cint;
                                   dl: ptr cuComplex; d: ptr cuComplex;
                                   du: ptr cuComplex; x: ptr cuComplex;
                                   batchCount: cint; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseCgtsvInterleavedBatch", dynlib: libName.}
proc cusparseZgtsvInterleavedBatch*(handle: cusparseHandle_t; algo: cint; m: cint;
                                   dl: ptr cuDoubleComplex; d: ptr cuDoubleComplex;
                                   du: ptr cuDoubleComplex; x: ptr cuDoubleComplex;
                                   batchCount: cint; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseZgtsvInterleavedBatch", dynlib: libName.}
proc cusparseSgpsvInterleavedBatch_bufferSizeExt*(handle: cusparseHandle_t;
    algo: cint; m: cint; ds: ptr cfloat; dl: ptr cfloat; d: ptr cfloat; du: ptr cfloat;
    dw: ptr cfloat; x: ptr cfloat; batchCount: cint; pBufferSizeInBytes: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseSgpsvInterleavedBatch_bufferSizeExt", dynlib: libName.}
proc cusparseDgpsvInterleavedBatch_bufferSizeExt*(handle: cusparseHandle_t;
    algo: cint; m: cint; ds: ptr cdouble; dl: ptr cdouble; d: ptr cdouble; du: ptr cdouble;
    dw: ptr cdouble; x: ptr cdouble; batchCount: cint; pBufferSizeInBytes: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseDgpsvInterleavedBatch_bufferSizeExt", dynlib: libName.}
proc cusparseCgpsvInterleavedBatch_bufferSizeExt*(handle: cusparseHandle_t;
    algo: cint; m: cint; ds: ptr cuComplex; dl: ptr cuComplex; d: ptr cuComplex;
    du: ptr cuComplex; dw: ptr cuComplex; x: ptr cuComplex; batchCount: cint;
    pBufferSizeInBytes: ptr csize_t): cusparseStatus_t {.cdecl,
    importc: "cusparseCgpsvInterleavedBatch_bufferSizeExt", dynlib: libName.}
proc cusparseZgpsvInterleavedBatch_bufferSizeExt*(handle: cusparseHandle_t;
    algo: cint; m: cint; ds: ptr cuDoubleComplex; dl: ptr cuDoubleComplex;
    d: ptr cuDoubleComplex; du: ptr cuDoubleComplex; dw: ptr cuDoubleComplex;
    x: ptr cuDoubleComplex; batchCount: cint; pBufferSizeInBytes: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseZgpsvInterleavedBatch_bufferSizeExt", dynlib: libName.}
proc cusparseSgpsvInterleavedBatch*(handle: cusparseHandle_t; algo: cint; m: cint;
                                   ds: ptr cfloat; dl: ptr cfloat; d: ptr cfloat;
                                   du: ptr cfloat; dw: ptr cfloat; x: ptr cfloat;
                                   batchCount: cint; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseSgpsvInterleavedBatch", dynlib: libName.}
proc cusparseDgpsvInterleavedBatch*(handle: cusparseHandle_t; algo: cint; m: cint;
                                   ds: ptr cdouble; dl: ptr cdouble; d: ptr cdouble;
                                   du: ptr cdouble; dw: ptr cdouble; x: ptr cdouble;
                                   batchCount: cint; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseDgpsvInterleavedBatch", dynlib: libName.}
proc cusparseCgpsvInterleavedBatch*(handle: cusparseHandle_t; algo: cint; m: cint;
                                   ds: ptr cuComplex; dl: ptr cuComplex;
                                   d: ptr cuComplex; du: ptr cuComplex;
                                   dw: ptr cuComplex; x: ptr cuComplex;
                                   batchCount: cint; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseCgpsvInterleavedBatch", dynlib: libName.}
proc cusparseZgpsvInterleavedBatch*(handle: cusparseHandle_t; algo: cint; m: cint;
                                   ds: ptr cuDoubleComplex;
                                   dl: ptr cuDoubleComplex; d: ptr cuDoubleComplex;
                                   du: ptr cuDoubleComplex;
                                   dw: ptr cuDoubleComplex; x: ptr cuDoubleComplex;
                                   batchCount: cint; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseZgpsvInterleavedBatch", dynlib: libName.}
## ##############################################################################
## # EXTRA ROUTINES
## ##############################################################################

proc cusparseScsrgeam2_bufferSizeExt*(handle: cusparseHandle_t; m: cint; n: cint;
                                     alpha: ptr cfloat; descrA: cusparseMatDescr_t;
                                     nnzA: cint; csrSortedValA: ptr cfloat;
                                     csrSortedRowPtrA: ptr cint;
                                     csrSortedColIndA: ptr cint; beta: ptr cfloat;
                                     descrB: cusparseMatDescr_t; nnzB: cint;
                                     csrSortedValB: ptr cfloat;
                                     csrSortedRowPtrB: ptr cint;
                                     csrSortedColIndB: ptr cint;
                                     descrC: cusparseMatDescr_t;
                                     csrSortedValC: ptr cfloat;
                                     csrSortedRowPtrC: ptr cint;
                                     csrSortedColIndC: ptr cint;
                                     pBufferSizeInBytes: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseScsrgeam2_bufferSizeExt", dynlib: libName.}
proc cusparseDcsrgeam2_bufferSizeExt*(handle: cusparseHandle_t; m: cint; n: cint;
                                     alpha: ptr cdouble;
                                     descrA: cusparseMatDescr_t; nnzA: cint;
                                     csrSortedValA: ptr cdouble;
                                     csrSortedRowPtrA: ptr cint;
                                     csrSortedColIndA: ptr cint; beta: ptr cdouble;
                                     descrB: cusparseMatDescr_t; nnzB: cint;
                                     csrSortedValB: ptr cdouble;
                                     csrSortedRowPtrB: ptr cint;
                                     csrSortedColIndB: ptr cint;
                                     descrC: cusparseMatDescr_t;
                                     csrSortedValC: ptr cdouble;
                                     csrSortedRowPtrC: ptr cint;
                                     csrSortedColIndC: ptr cint;
                                     pBufferSizeInBytes: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseDcsrgeam2_bufferSizeExt", dynlib: libName.}
proc cusparseCcsrgeam2_bufferSizeExt*(handle: cusparseHandle_t; m: cint; n: cint;
                                     alpha: ptr cuComplex;
                                     descrA: cusparseMatDescr_t; nnzA: cint;
                                     csrSortedValA: ptr cuComplex;
                                     csrSortedRowPtrA: ptr cint;
                                     csrSortedColIndA: ptr cint;
                                     beta: ptr cuComplex;
                                     descrB: cusparseMatDescr_t; nnzB: cint;
                                     csrSortedValB: ptr cuComplex;
                                     csrSortedRowPtrB: ptr cint;
                                     csrSortedColIndB: ptr cint;
                                     descrC: cusparseMatDescr_t;
                                     csrSortedValC: ptr cuComplex;
                                     csrSortedRowPtrC: ptr cint;
                                     csrSortedColIndC: ptr cint;
                                     pBufferSizeInBytes: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseCcsrgeam2_bufferSizeExt", dynlib: libName.}
proc cusparseZcsrgeam2_bufferSizeExt*(handle: cusparseHandle_t; m: cint; n: cint;
                                     alpha: ptr cuDoubleComplex;
                                     descrA: cusparseMatDescr_t; nnzA: cint;
                                     csrSortedValA: ptr cuDoubleComplex;
                                     csrSortedRowPtrA: ptr cint;
                                     csrSortedColIndA: ptr cint;
                                     beta: ptr cuDoubleComplex;
                                     descrB: cusparseMatDescr_t; nnzB: cint;
                                     csrSortedValB: ptr cuDoubleComplex;
                                     csrSortedRowPtrB: ptr cint;
                                     csrSortedColIndB: ptr cint;
                                     descrC: cusparseMatDescr_t;
                                     csrSortedValC: ptr cuDoubleComplex;
                                     csrSortedRowPtrC: ptr cint;
                                     csrSortedColIndC: ptr cint;
                                     pBufferSizeInBytes: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseZcsrgeam2_bufferSizeExt", dynlib: libName.}
proc cusparseXcsrgeam2Nnz*(handle: cusparseHandle_t; m: cint; n: cint;
                          descrA: cusparseMatDescr_t; nnzA: cint;
                          csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                          descrB: cusparseMatDescr_t; nnzB: cint;
                          csrSortedRowPtrB: ptr cint; csrSortedColIndB: ptr cint;
                          descrC: cusparseMatDescr_t; csrSortedRowPtrC: ptr cint;
                          nnzTotalDevHostPtr: ptr cint; workspace: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseXcsrgeam2Nnz", dynlib: libName.}
proc cusparseScsrgeam2*(handle: cusparseHandle_t; m: cint; n: cint; alpha: ptr cfloat;
                       descrA: cusparseMatDescr_t; nnzA: cint;
                       csrSortedValA: ptr cfloat; csrSortedRowPtrA: ptr cint;
                       csrSortedColIndA: ptr cint; beta: ptr cfloat;
                       descrB: cusparseMatDescr_t; nnzB: cint;
                       csrSortedValB: ptr cfloat; csrSortedRowPtrB: ptr cint;
                       csrSortedColIndB: ptr cint; descrC: cusparseMatDescr_t;
                       csrSortedValC: ptr cfloat; csrSortedRowPtrC: ptr cint;
                       csrSortedColIndC: ptr cint; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseScsrgeam2", dynlib: libName.}
proc cusparseDcsrgeam2*(handle: cusparseHandle_t; m: cint; n: cint; alpha: ptr cdouble;
                       descrA: cusparseMatDescr_t; nnzA: cint;
                       csrSortedValA: ptr cdouble; csrSortedRowPtrA: ptr cint;
                       csrSortedColIndA: ptr cint; beta: ptr cdouble;
                       descrB: cusparseMatDescr_t; nnzB: cint;
                       csrSortedValB: ptr cdouble; csrSortedRowPtrB: ptr cint;
                       csrSortedColIndB: ptr cint; descrC: cusparseMatDescr_t;
                       csrSortedValC: ptr cdouble; csrSortedRowPtrC: ptr cint;
                       csrSortedColIndC: ptr cint; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseDcsrgeam2", dynlib: libName.}
proc cusparseCcsrgeam2*(handle: cusparseHandle_t; m: cint; n: cint;
                       alpha: ptr cuComplex; descrA: cusparseMatDescr_t; nnzA: cint;
                       csrSortedValA: ptr cuComplex; csrSortedRowPtrA: ptr cint;
                       csrSortedColIndA: ptr cint; beta: ptr cuComplex;
                       descrB: cusparseMatDescr_t; nnzB: cint;
                       csrSortedValB: ptr cuComplex; csrSortedRowPtrB: ptr cint;
                       csrSortedColIndB: ptr cint; descrC: cusparseMatDescr_t;
                       csrSortedValC: ptr cuComplex; csrSortedRowPtrC: ptr cint;
                       csrSortedColIndC: ptr cint; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseCcsrgeam2", dynlib: libName.}
proc cusparseZcsrgeam2*(handle: cusparseHandle_t; m: cint; n: cint;
                       alpha: ptr cuDoubleComplex; descrA: cusparseMatDescr_t;
                       nnzA: cint; csrSortedValA: ptr cuDoubleComplex;
                       csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                       beta: ptr cuDoubleComplex; descrB: cusparseMatDescr_t;
                       nnzB: cint; csrSortedValB: ptr cuDoubleComplex;
                       csrSortedRowPtrB: ptr cint; csrSortedColIndB: ptr cint;
                       descrC: cusparseMatDescr_t;
                       csrSortedValC: ptr cuDoubleComplex;
                       csrSortedRowPtrC: ptr cint; csrSortedColIndC: ptr cint;
                       pBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseZcsrgeam2", dynlib: libName.}
## ##############################################################################
## # SPARSE MATRIX REORDERING
## ##############################################################################

proc cusparseScsrcolor*(handle: cusparseHandle_t; m: cint; nnz: cint;
                       descrA: cusparseMatDescr_t; csrSortedValA: ptr cfloat;
                       csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                       fractionToColor: ptr cfloat; ncolors: ptr cint;
                       coloring: ptr cint; reordering: ptr cint;
                       info: cusparseColorInfo_t): cusparseStatus_t {.cdecl,
    importc: "cusparseScsrcolor", dynlib: libName.}
proc cusparseDcsrcolor*(handle: cusparseHandle_t; m: cint; nnz: cint;
                       descrA: cusparseMatDescr_t; csrSortedValA: ptr cdouble;
                       csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                       fractionToColor: ptr cdouble; ncolors: ptr cint;
                       coloring: ptr cint; reordering: ptr cint;
                       info: cusparseColorInfo_t): cusparseStatus_t {.cdecl,
    importc: "cusparseDcsrcolor", dynlib: libName.}
proc cusparseCcsrcolor*(handle: cusparseHandle_t; m: cint; nnz: cint;
                       descrA: cusparseMatDescr_t; csrSortedValA: ptr cuComplex;
                       csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                       fractionToColor: ptr cfloat; ncolors: ptr cint;
                       coloring: ptr cint; reordering: ptr cint;
                       info: cusparseColorInfo_t): cusparseStatus_t {.cdecl,
    importc: "cusparseCcsrcolor", dynlib: libName.}
proc cusparseZcsrcolor*(handle: cusparseHandle_t; m: cint; nnz: cint;
                       descrA: cusparseMatDescr_t;
                       csrSortedValA: ptr cuDoubleComplex;
                       csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                       fractionToColor: ptr cdouble; ncolors: ptr cint;
                       coloring: ptr cint; reordering: ptr cint;
                       info: cusparseColorInfo_t): cusparseStatus_t {.cdecl,
    importc: "cusparseZcsrcolor", dynlib: libName.}
## ##############################################################################
## # SPARSE FORMAT CONVERSION
## ##############################################################################

proc cusparseSnnz*(handle: cusparseHandle_t; dirA: cusparseDirection_t; m: cint;
                  n: cint; descrA: cusparseMatDescr_t; A: ptr cfloat; lda: cint;
                  nnzPerRowCol: ptr cint; nnzTotalDevHostPtr: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseSnnz", dynlib: libName.}
proc cusparseDnnz*(handle: cusparseHandle_t; dirA: cusparseDirection_t; m: cint;
                  n: cint; descrA: cusparseMatDescr_t; A: ptr cdouble; lda: cint;
                  nnzPerRowCol: ptr cint; nnzTotalDevHostPtr: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseDnnz", dynlib: libName.}
proc cusparseCnnz*(handle: cusparseHandle_t; dirA: cusparseDirection_t; m: cint;
                  n: cint; descrA: cusparseMatDescr_t; A: ptr cuComplex; lda: cint;
                  nnzPerRowCol: ptr cint; nnzTotalDevHostPtr: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseCnnz", dynlib: libName.}
proc cusparseZnnz*(handle: cusparseHandle_t; dirA: cusparseDirection_t; m: cint;
                  n: cint; descrA: cusparseMatDescr_t; A: ptr cuDoubleComplex;
                  lda: cint; nnzPerRowCol: ptr cint; nnzTotalDevHostPtr: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseZnnz", dynlib: libName.}
## ##############################################################################
## # SPARSE FORMAT CONVERSION
## ##############################################################################

proc cusparseSnnz_compress*(handle: cusparseHandle_t; m: cint;
                           descr: cusparseMatDescr_t; csrSortedValA: ptr cfloat;
                           csrSortedRowPtrA: ptr cint; nnzPerRow: ptr cint;
                           nnzC: ptr cint; tol: cfloat): cusparseStatus_t {.cdecl,
    importc: "cusparseSnnz_compress", dynlib: libName.}
proc cusparseDnnz_compress*(handle: cusparseHandle_t; m: cint;
                           descr: cusparseMatDescr_t; csrSortedValA: ptr cdouble;
                           csrSortedRowPtrA: ptr cint; nnzPerRow: ptr cint;
                           nnzC: ptr cint; tol: cdouble): cusparseStatus_t {.cdecl,
    importc: "cusparseDnnz_compress", dynlib: libName.}
proc cusparseCnnz_compress*(handle: cusparseHandle_t; m: cint;
                           descr: cusparseMatDescr_t;
                           csrSortedValA: ptr cuComplex;
                           csrSortedRowPtrA: ptr cint; nnzPerRow: ptr cint;
                           nnzC: ptr cint; tol: cuComplex): cusparseStatus_t {.cdecl,
    importc: "cusparseCnnz_compress", dynlib: libName.}
proc cusparseZnnz_compress*(handle: cusparseHandle_t; m: cint;
                           descr: cusparseMatDescr_t;
                           csrSortedValA: ptr cuDoubleComplex;
                           csrSortedRowPtrA: ptr cint; nnzPerRow: ptr cint;
                           nnzC: ptr cint; tol: cuDoubleComplex): cusparseStatus_t {.
    cdecl, importc: "cusparseZnnz_compress", dynlib: libName.}
proc cusparseScsr2csr_compress*(handle: cusparseHandle_t; m: cint; n: cint;
                               descrA: cusparseMatDescr_t;
                               csrSortedValA: ptr cfloat;
                               csrSortedColIndA: ptr cint;
                               csrSortedRowPtrA: ptr cint; nnzA: cint;
                               nnzPerRow: ptr cint; csrSortedValC: ptr cfloat;
                               csrSortedColIndC: ptr cint;
                               csrSortedRowPtrC: ptr cint; tol: cfloat): cusparseStatus_t {.
    cdecl, importc: "cusparseScsr2csr_compress", dynlib: libName.}
proc cusparseDcsr2csr_compress*(handle: cusparseHandle_t; m: cint; n: cint;
                               descrA: cusparseMatDescr_t;
                               csrSortedValA: ptr cdouble;
                               csrSortedColIndA: ptr cint;
                               csrSortedRowPtrA: ptr cint; nnzA: cint;
                               nnzPerRow: ptr cint; csrSortedValC: ptr cdouble;
                               csrSortedColIndC: ptr cint;
                               csrSortedRowPtrC: ptr cint; tol: cdouble): cusparseStatus_t {.
    cdecl, importc: "cusparseDcsr2csr_compress", dynlib: libName.}
proc cusparseCcsr2csr_compress*(handle: cusparseHandle_t; m: cint; n: cint;
                               descrA: cusparseMatDescr_t;
                               csrSortedValA: ptr cuComplex;
                               csrSortedColIndA: ptr cint;
                               csrSortedRowPtrA: ptr cint; nnzA: cint;
                               nnzPerRow: ptr cint; csrSortedValC: ptr cuComplex;
                               csrSortedColIndC: ptr cint;
                               csrSortedRowPtrC: ptr cint; tol: cuComplex): cusparseStatus_t {.
    cdecl, importc: "cusparseCcsr2csr_compress", dynlib: libName.}
proc cusparseZcsr2csr_compress*(handle: cusparseHandle_t; m: cint; n: cint;
                               descrA: cusparseMatDescr_t;
                               csrSortedValA: ptr cuDoubleComplex;
                               csrSortedColIndA: ptr cint;
                               csrSortedRowPtrA: ptr cint; nnzA: cint;
                               nnzPerRow: ptr cint;
                               csrSortedValC: ptr cuDoubleComplex;
                               csrSortedColIndC: ptr cint;
                               csrSortedRowPtrC: ptr cint; tol: cuDoubleComplex): cusparseStatus_t {.
    cdecl, importc: "cusparseZcsr2csr_compress", dynlib: libName.}
proc cusparseXcoo2csr*(handle: cusparseHandle_t; cooRowInd: ptr cint; nnz: cint;
                      m: cint; csrSortedRowPtr: ptr cint;
                      idxBase: cusparseIndexBase_t): cusparseStatus_t {.cdecl,
    importc: "cusparseXcoo2csr", dynlib: libName.}
proc cusparseXcsr2coo*(handle: cusparseHandle_t; csrSortedRowPtr: ptr cint; nnz: cint;
                      m: cint; cooRowInd: ptr cint; idxBase: cusparseIndexBase_t): cusparseStatus_t {.
    cdecl, importc: "cusparseXcsr2coo", dynlib: libName.}
proc cusparseXcsr2bsrNnz*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                         m: cint; n: cint; descrA: cusparseMatDescr_t;
                         csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                         blockDim: cint; descrC: cusparseMatDescr_t;
                         bsrSortedRowPtrC: ptr cint; nnzTotalDevHostPtr: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseXcsr2bsrNnz", dynlib: libName.}
proc cusparseScsr2bsr*(handle: cusparseHandle_t; dirA: cusparseDirection_t; m: cint;
                      n: cint; descrA: cusparseMatDescr_t;
                      csrSortedValA: ptr cfloat; csrSortedRowPtrA: ptr cint;
                      csrSortedColIndA: ptr cint; blockDim: cint;
                      descrC: cusparseMatDescr_t; bsrSortedValC: ptr cfloat;
                      bsrSortedRowPtrC: ptr cint; bsrSortedColIndC: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseScsr2bsr", dynlib: libName.}
proc cusparseDcsr2bsr*(handle: cusparseHandle_t; dirA: cusparseDirection_t; m: cint;
                      n: cint; descrA: cusparseMatDescr_t;
                      csrSortedValA: ptr cdouble; csrSortedRowPtrA: ptr cint;
                      csrSortedColIndA: ptr cint; blockDim: cint;
                      descrC: cusparseMatDescr_t; bsrSortedValC: ptr cdouble;
                      bsrSortedRowPtrC: ptr cint; bsrSortedColIndC: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseDcsr2bsr", dynlib: libName.}
proc cusparseCcsr2bsr*(handle: cusparseHandle_t; dirA: cusparseDirection_t; m: cint;
                      n: cint; descrA: cusparseMatDescr_t;
                      csrSortedValA: ptr cuComplex; csrSortedRowPtrA: ptr cint;
                      csrSortedColIndA: ptr cint; blockDim: cint;
                      descrC: cusparseMatDescr_t; bsrSortedValC: ptr cuComplex;
                      bsrSortedRowPtrC: ptr cint; bsrSortedColIndC: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseCcsr2bsr", dynlib: libName.}
proc cusparseZcsr2bsr*(handle: cusparseHandle_t; dirA: cusparseDirection_t; m: cint;
                      n: cint; descrA: cusparseMatDescr_t;
                      csrSortedValA: ptr cuDoubleComplex;
                      csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                      blockDim: cint; descrC: cusparseMatDescr_t;
                      bsrSortedValC: ptr cuDoubleComplex;
                      bsrSortedRowPtrC: ptr cint; bsrSortedColIndC: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseZcsr2bsr", dynlib: libName.}
proc cusparseSbsr2csr*(handle: cusparseHandle_t; dirA: cusparseDirection_t; mb: cint;
                      nb: cint; descrA: cusparseMatDescr_t;
                      bsrSortedValA: ptr cfloat; bsrSortedRowPtrA: ptr cint;
                      bsrSortedColIndA: ptr cint; blockDim: cint;
                      descrC: cusparseMatDescr_t; csrSortedValC: ptr cfloat;
                      csrSortedRowPtrC: ptr cint; csrSortedColIndC: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseSbsr2csr", dynlib: libName.}
proc cusparseDbsr2csr*(handle: cusparseHandle_t; dirA: cusparseDirection_t; mb: cint;
                      nb: cint; descrA: cusparseMatDescr_t;
                      bsrSortedValA: ptr cdouble; bsrSortedRowPtrA: ptr cint;
                      bsrSortedColIndA: ptr cint; blockDim: cint;
                      descrC: cusparseMatDescr_t; csrSortedValC: ptr cdouble;
                      csrSortedRowPtrC: ptr cint; csrSortedColIndC: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseDbsr2csr", dynlib: libName.}
proc cusparseCbsr2csr*(handle: cusparseHandle_t; dirA: cusparseDirection_t; mb: cint;
                      nb: cint; descrA: cusparseMatDescr_t;
                      bsrSortedValA: ptr cuComplex; bsrSortedRowPtrA: ptr cint;
                      bsrSortedColIndA: ptr cint; blockDim: cint;
                      descrC: cusparseMatDescr_t; csrSortedValC: ptr cuComplex;
                      csrSortedRowPtrC: ptr cint; csrSortedColIndC: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseCbsr2csr", dynlib: libName.}
proc cusparseZbsr2csr*(handle: cusparseHandle_t; dirA: cusparseDirection_t; mb: cint;
                      nb: cint; descrA: cusparseMatDescr_t;
                      bsrSortedValA: ptr cuDoubleComplex;
                      bsrSortedRowPtrA: ptr cint; bsrSortedColIndA: ptr cint;
                      blockDim: cint; descrC: cusparseMatDescr_t;
                      csrSortedValC: ptr cuDoubleComplex;
                      csrSortedRowPtrC: ptr cint; csrSortedColIndC: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseZbsr2csr", dynlib: libName.}
proc cusparseSgebsr2gebsc_bufferSize*(handle: cusparseHandle_t; mb: cint; nb: cint;
                                     nnzb: cint; bsrSortedVal: ptr cfloat;
                                     bsrSortedRowPtr: ptr cint;
                                     bsrSortedColInd: ptr cint; rowBlockDim: cint;
                                     colBlockDim: cint;
                                     pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseSgebsr2gebsc_bufferSize", dynlib: libName.}
proc cusparseDgebsr2gebsc_bufferSize*(handle: cusparseHandle_t; mb: cint; nb: cint;
                                     nnzb: cint; bsrSortedVal: ptr cdouble;
                                     bsrSortedRowPtr: ptr cint;
                                     bsrSortedColInd: ptr cint; rowBlockDim: cint;
                                     colBlockDim: cint;
                                     pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseDgebsr2gebsc_bufferSize", dynlib: libName.}
proc cusparseCgebsr2gebsc_bufferSize*(handle: cusparseHandle_t; mb: cint; nb: cint;
                                     nnzb: cint; bsrSortedVal: ptr cuComplex;
                                     bsrSortedRowPtr: ptr cint;
                                     bsrSortedColInd: ptr cint; rowBlockDim: cint;
                                     colBlockDim: cint;
                                     pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseCgebsr2gebsc_bufferSize", dynlib: libName.}
proc cusparseZgebsr2gebsc_bufferSize*(handle: cusparseHandle_t; mb: cint; nb: cint;
                                     nnzb: cint;
                                     bsrSortedVal: ptr cuDoubleComplex;
                                     bsrSortedRowPtr: ptr cint;
                                     bsrSortedColInd: ptr cint; rowBlockDim: cint;
                                     colBlockDim: cint;
                                     pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseZgebsr2gebsc_bufferSize", dynlib: libName.}
proc cusparseSgebsr2gebsc_bufferSizeExt*(handle: cusparseHandle_t; mb: cint;
                                        nb: cint; nnzb: cint;
                                        bsrSortedVal: ptr cfloat;
                                        bsrSortedRowPtr: ptr cint;
                                        bsrSortedColInd: ptr cint;
                                        rowBlockDim: cint; colBlockDim: cint;
                                        pBufferSize: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseSgebsr2gebsc_bufferSizeExt", dynlib: libName.}
proc cusparseDgebsr2gebsc_bufferSizeExt*(handle: cusparseHandle_t; mb: cint;
                                        nb: cint; nnzb: cint;
                                        bsrSortedVal: ptr cdouble;
                                        bsrSortedRowPtr: ptr cint;
                                        bsrSortedColInd: ptr cint;
                                        rowBlockDim: cint; colBlockDim: cint;
                                        pBufferSize: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseDgebsr2gebsc_bufferSizeExt", dynlib: libName.}
proc cusparseCgebsr2gebsc_bufferSizeExt*(handle: cusparseHandle_t; mb: cint;
                                        nb: cint; nnzb: cint;
                                        bsrSortedVal: ptr cuComplex;
                                        bsrSortedRowPtr: ptr cint;
                                        bsrSortedColInd: ptr cint;
                                        rowBlockDim: cint; colBlockDim: cint;
                                        pBufferSize: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseCgebsr2gebsc_bufferSizeExt", dynlib: libName.}
proc cusparseZgebsr2gebsc_bufferSizeExt*(handle: cusparseHandle_t; mb: cint;
                                        nb: cint; nnzb: cint;
                                        bsrSortedVal: ptr cuDoubleComplex;
                                        bsrSortedRowPtr: ptr cint;
                                        bsrSortedColInd: ptr cint;
                                        rowBlockDim: cint; colBlockDim: cint;
                                        pBufferSize: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseZgebsr2gebsc_bufferSizeExt", dynlib: libName.}
proc cusparseSgebsr2gebsc*(handle: cusparseHandle_t; mb: cint; nb: cint; nnzb: cint;
                          bsrSortedVal: ptr cfloat; bsrSortedRowPtr: ptr cint;
                          bsrSortedColInd: ptr cint; rowBlockDim: cint;
                          colBlockDim: cint; bscVal: ptr cfloat; bscRowInd: ptr cint;
                          bscColPtr: ptr cint; copyValues: cusparseAction_t;
                          idxBase: cusparseIndexBase_t; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseSgebsr2gebsc", dynlib: libName.}
proc cusparseDgebsr2gebsc*(handle: cusparseHandle_t; mb: cint; nb: cint; nnzb: cint;
                          bsrSortedVal: ptr cdouble; bsrSortedRowPtr: ptr cint;
                          bsrSortedColInd: ptr cint; rowBlockDim: cint;
                          colBlockDim: cint; bscVal: ptr cdouble;
                          bscRowInd: ptr cint; bscColPtr: ptr cint;
                          copyValues: cusparseAction_t;
                          idxBase: cusparseIndexBase_t; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseDgebsr2gebsc", dynlib: libName.}
proc cusparseCgebsr2gebsc*(handle: cusparseHandle_t; mb: cint; nb: cint; nnzb: cint;
                          bsrSortedVal: ptr cuComplex; bsrSortedRowPtr: ptr cint;
                          bsrSortedColInd: ptr cint; rowBlockDim: cint;
                          colBlockDim: cint; bscVal: ptr cuComplex;
                          bscRowInd: ptr cint; bscColPtr: ptr cint;
                          copyValues: cusparseAction_t;
                          idxBase: cusparseIndexBase_t; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseCgebsr2gebsc", dynlib: libName.}
proc cusparseZgebsr2gebsc*(handle: cusparseHandle_t; mb: cint; nb: cint; nnzb: cint;
                          bsrSortedVal: ptr cuDoubleComplex;
                          bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint;
                          rowBlockDim: cint; colBlockDim: cint;
                          bscVal: ptr cuDoubleComplex; bscRowInd: ptr cint;
                          bscColPtr: ptr cint; copyValues: cusparseAction_t;
                          idxBase: cusparseIndexBase_t; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseZgebsr2gebsc", dynlib: libName.}
proc cusparseXgebsr2csr*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                        mb: cint; nb: cint; descrA: cusparseMatDescr_t;
                        bsrSortedRowPtrA: ptr cint; bsrSortedColIndA: ptr cint;
                        rowBlockDim: cint; colBlockDim: cint;
                        descrC: cusparseMatDescr_t; csrSortedRowPtrC: ptr cint;
                        csrSortedColIndC: ptr cint): cusparseStatus_t {.cdecl,
    importc: "cusparseXgebsr2csr", dynlib: libName.}
proc cusparseSgebsr2csr*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                        mb: cint; nb: cint; descrA: cusparseMatDescr_t;
                        bsrSortedValA: ptr cfloat; bsrSortedRowPtrA: ptr cint;
                        bsrSortedColIndA: ptr cint; rowBlockDim: cint;
                        colBlockDim: cint; descrC: cusparseMatDescr_t;
                        csrSortedValC: ptr cfloat; csrSortedRowPtrC: ptr cint;
                        csrSortedColIndC: ptr cint): cusparseStatus_t {.cdecl,
    importc: "cusparseSgebsr2csr", dynlib: libName.}
proc cusparseDgebsr2csr*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                        mb: cint; nb: cint; descrA: cusparseMatDescr_t;
                        bsrSortedValA: ptr cdouble; bsrSortedRowPtrA: ptr cint;
                        bsrSortedColIndA: ptr cint; rowBlockDim: cint;
                        colBlockDim: cint; descrC: cusparseMatDescr_t;
                        csrSortedValC: ptr cdouble; csrSortedRowPtrC: ptr cint;
                        csrSortedColIndC: ptr cint): cusparseStatus_t {.cdecl,
    importc: "cusparseDgebsr2csr", dynlib: libName.}
proc cusparseCgebsr2csr*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                        mb: cint; nb: cint; descrA: cusparseMatDescr_t;
                        bsrSortedValA: ptr cuComplex; bsrSortedRowPtrA: ptr cint;
                        bsrSortedColIndA: ptr cint; rowBlockDim: cint;
                        colBlockDim: cint; descrC: cusparseMatDescr_t;
                        csrSortedValC: ptr cuComplex; csrSortedRowPtrC: ptr cint;
                        csrSortedColIndC: ptr cint): cusparseStatus_t {.cdecl,
    importc: "cusparseCgebsr2csr", dynlib: libName.}
proc cusparseZgebsr2csr*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                        mb: cint; nb: cint; descrA: cusparseMatDescr_t;
                        bsrSortedValA: ptr cuDoubleComplex;
                        bsrSortedRowPtrA: ptr cint; bsrSortedColIndA: ptr cint;
                        rowBlockDim: cint; colBlockDim: cint;
                        descrC: cusparseMatDescr_t;
                        csrSortedValC: ptr cuDoubleComplex;
                        csrSortedRowPtrC: ptr cint; csrSortedColIndC: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseZgebsr2csr", dynlib: libName.}
proc cusparseScsr2gebsr_bufferSize*(handle: cusparseHandle_t;
                                   dirA: cusparseDirection_t; m: cint; n: cint;
                                   descrA: cusparseMatDescr_t;
                                   csrSortedValA: ptr cfloat;
                                   csrSortedRowPtrA: ptr cint;
                                   csrSortedColIndA: ptr cint; rowBlockDim: cint;
                                   colBlockDim: cint; pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseScsr2gebsr_bufferSize", dynlib: libName.}
proc cusparseDcsr2gebsr_bufferSize*(handle: cusparseHandle_t;
                                   dirA: cusparseDirection_t; m: cint; n: cint;
                                   descrA: cusparseMatDescr_t;
                                   csrSortedValA: ptr cdouble;
                                   csrSortedRowPtrA: ptr cint;
                                   csrSortedColIndA: ptr cint; rowBlockDim: cint;
                                   colBlockDim: cint; pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseDcsr2gebsr_bufferSize", dynlib: libName.}
proc cusparseCcsr2gebsr_bufferSize*(handle: cusparseHandle_t;
                                   dirA: cusparseDirection_t; m: cint; n: cint;
                                   descrA: cusparseMatDescr_t;
                                   csrSortedValA: ptr cuComplex;
                                   csrSortedRowPtrA: ptr cint;
                                   csrSortedColIndA: ptr cint; rowBlockDim: cint;
                                   colBlockDim: cint; pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseCcsr2gebsr_bufferSize", dynlib: libName.}
proc cusparseZcsr2gebsr_bufferSize*(handle: cusparseHandle_t;
                                   dirA: cusparseDirection_t; m: cint; n: cint;
                                   descrA: cusparseMatDescr_t;
                                   csrSortedValA: ptr cuDoubleComplex;
                                   csrSortedRowPtrA: ptr cint;
                                   csrSortedColIndA: ptr cint; rowBlockDim: cint;
                                   colBlockDim: cint; pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseZcsr2gebsr_bufferSize", dynlib: libName.}
proc cusparseScsr2gebsr_bufferSizeExt*(handle: cusparseHandle_t;
                                      dirA: cusparseDirection_t; m: cint; n: cint;
                                      descrA: cusparseMatDescr_t;
                                      csrSortedValA: ptr cfloat;
                                      csrSortedRowPtrA: ptr cint;
                                      csrSortedColIndA: ptr cint;
                                      rowBlockDim: cint; colBlockDim: cint;
                                      pBufferSize: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseScsr2gebsr_bufferSizeExt", dynlib: libName.}
proc cusparseDcsr2gebsr_bufferSizeExt*(handle: cusparseHandle_t;
                                      dirA: cusparseDirection_t; m: cint; n: cint;
                                      descrA: cusparseMatDescr_t;
                                      csrSortedValA: ptr cdouble;
                                      csrSortedRowPtrA: ptr cint;
                                      csrSortedColIndA: ptr cint;
                                      rowBlockDim: cint; colBlockDim: cint;
                                      pBufferSize: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseDcsr2gebsr_bufferSizeExt", dynlib: libName.}
proc cusparseCcsr2gebsr_bufferSizeExt*(handle: cusparseHandle_t;
                                      dirA: cusparseDirection_t; m: cint; n: cint;
                                      descrA: cusparseMatDescr_t;
                                      csrSortedValA: ptr cuComplex;
                                      csrSortedRowPtrA: ptr cint;
                                      csrSortedColIndA: ptr cint;
                                      rowBlockDim: cint; colBlockDim: cint;
                                      pBufferSize: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseCcsr2gebsr_bufferSizeExt", dynlib: libName.}
proc cusparseZcsr2gebsr_bufferSizeExt*(handle: cusparseHandle_t;
                                      dirA: cusparseDirection_t; m: cint; n: cint;
                                      descrA: cusparseMatDescr_t;
                                      csrSortedValA: ptr cuDoubleComplex;
                                      csrSortedRowPtrA: ptr cint;
                                      csrSortedColIndA: ptr cint;
                                      rowBlockDim: cint; colBlockDim: cint;
                                      pBufferSize: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseZcsr2gebsr_bufferSizeExt", dynlib: libName.}
proc cusparseXcsr2gebsrNnz*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                           m: cint; n: cint; descrA: cusparseMatDescr_t;
                           csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                           descrC: cusparseMatDescr_t; bsrSortedRowPtrC: ptr cint;
                           rowBlockDim: cint; colBlockDim: cint;
                           nnzTotalDevHostPtr: ptr cint; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseXcsr2gebsrNnz", dynlib: libName.}
proc cusparseScsr2gebsr*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                        m: cint; n: cint; descrA: cusparseMatDescr_t;
                        csrSortedValA: ptr cfloat; csrSortedRowPtrA: ptr cint;
                        csrSortedColIndA: ptr cint; descrC: cusparseMatDescr_t;
                        bsrSortedValC: ptr cfloat; bsrSortedRowPtrC: ptr cint;
                        bsrSortedColIndC: ptr cint; rowBlockDim: cint;
                        colBlockDim: cint; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseScsr2gebsr", dynlib: libName.}
proc cusparseDcsr2gebsr*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                        m: cint; n: cint; descrA: cusparseMatDescr_t;
                        csrSortedValA: ptr cdouble; csrSortedRowPtrA: ptr cint;
                        csrSortedColIndA: ptr cint; descrC: cusparseMatDescr_t;
                        bsrSortedValC: ptr cdouble; bsrSortedRowPtrC: ptr cint;
                        bsrSortedColIndC: ptr cint; rowBlockDim: cint;
                        colBlockDim: cint; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseDcsr2gebsr", dynlib: libName.}
proc cusparseCcsr2gebsr*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                        m: cint; n: cint; descrA: cusparseMatDescr_t;
                        csrSortedValA: ptr cuComplex; csrSortedRowPtrA: ptr cint;
                        csrSortedColIndA: ptr cint; descrC: cusparseMatDescr_t;
                        bsrSortedValC: ptr cuComplex; bsrSortedRowPtrC: ptr cint;
                        bsrSortedColIndC: ptr cint; rowBlockDim: cint;
                        colBlockDim: cint; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseCcsr2gebsr", dynlib: libName.}
proc cusparseZcsr2gebsr*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                        m: cint; n: cint; descrA: cusparseMatDescr_t;
                        csrSortedValA: ptr cuDoubleComplex;
                        csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                        descrC: cusparseMatDescr_t;
                        bsrSortedValC: ptr cuDoubleComplex;
                        bsrSortedRowPtrC: ptr cint; bsrSortedColIndC: ptr cint;
                        rowBlockDim: cint; colBlockDim: cint; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseZcsr2gebsr", dynlib: libName.}
proc cusparseSgebsr2gebsr_bufferSize*(handle: cusparseHandle_t;
                                     dirA: cusparseDirection_t; mb: cint; nb: cint;
                                     nnzb: cint; descrA: cusparseMatDescr_t;
                                     bsrSortedValA: ptr cfloat;
                                     bsrSortedRowPtrA: ptr cint;
                                     bsrSortedColIndA: ptr cint;
                                     rowBlockDimA: cint; colBlockDimA: cint;
                                     rowBlockDimC: cint; colBlockDimC: cint;
                                     pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseSgebsr2gebsr_bufferSize", dynlib: libName.}
proc cusparseDgebsr2gebsr_bufferSize*(handle: cusparseHandle_t;
                                     dirA: cusparseDirection_t; mb: cint; nb: cint;
                                     nnzb: cint; descrA: cusparseMatDescr_t;
                                     bsrSortedValA: ptr cdouble;
                                     bsrSortedRowPtrA: ptr cint;
                                     bsrSortedColIndA: ptr cint;
                                     rowBlockDimA: cint; colBlockDimA: cint;
                                     rowBlockDimC: cint; colBlockDimC: cint;
                                     pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseDgebsr2gebsr_bufferSize", dynlib: libName.}
proc cusparseCgebsr2gebsr_bufferSize*(handle: cusparseHandle_t;
                                     dirA: cusparseDirection_t; mb: cint; nb: cint;
                                     nnzb: cint; descrA: cusparseMatDescr_t;
                                     bsrSortedValA: ptr cuComplex;
                                     bsrSortedRowPtrA: ptr cint;
                                     bsrSortedColIndA: ptr cint;
                                     rowBlockDimA: cint; colBlockDimA: cint;
                                     rowBlockDimC: cint; colBlockDimC: cint;
                                     pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseCgebsr2gebsr_bufferSize", dynlib: libName.}
proc cusparseZgebsr2gebsr_bufferSize*(handle: cusparseHandle_t;
                                     dirA: cusparseDirection_t; mb: cint; nb: cint;
                                     nnzb: cint; descrA: cusparseMatDescr_t;
                                     bsrSortedValA: ptr cuDoubleComplex;
                                     bsrSortedRowPtrA: ptr cint;
                                     bsrSortedColIndA: ptr cint;
                                     rowBlockDimA: cint; colBlockDimA: cint;
                                     rowBlockDimC: cint; colBlockDimC: cint;
                                     pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
    cdecl, importc: "cusparseZgebsr2gebsr_bufferSize", dynlib: libName.}
proc cusparseSgebsr2gebsr_bufferSizeExt*(handle: cusparseHandle_t;
                                        dirA: cusparseDirection_t; mb: cint;
                                        nb: cint; nnzb: cint;
                                        descrA: cusparseMatDescr_t;
                                        bsrSortedValA: ptr cfloat;
                                        bsrSortedRowPtrA: ptr cint;
                                        bsrSortedColIndA: ptr cint;
                                        rowBlockDimA: cint; colBlockDimA: cint;
                                        rowBlockDimC: cint; colBlockDimC: cint;
                                        pBufferSize: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseSgebsr2gebsr_bufferSizeExt", dynlib: libName.}
proc cusparseDgebsr2gebsr_bufferSizeExt*(handle: cusparseHandle_t;
                                        dirA: cusparseDirection_t; mb: cint;
                                        nb: cint; nnzb: cint;
                                        descrA: cusparseMatDescr_t;
                                        bsrSortedValA: ptr cdouble;
                                        bsrSortedRowPtrA: ptr cint;
                                        bsrSortedColIndA: ptr cint;
                                        rowBlockDimA: cint; colBlockDimA: cint;
                                        rowBlockDimC: cint; colBlockDimC: cint;
                                        pBufferSize: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseDgebsr2gebsr_bufferSizeExt", dynlib: libName.}
proc cusparseCgebsr2gebsr_bufferSizeExt*(handle: cusparseHandle_t;
                                        dirA: cusparseDirection_t; mb: cint;
                                        nb: cint; nnzb: cint;
                                        descrA: cusparseMatDescr_t;
                                        bsrSortedValA: ptr cuComplex;
                                        bsrSortedRowPtrA: ptr cint;
                                        bsrSortedColIndA: ptr cint;
                                        rowBlockDimA: cint; colBlockDimA: cint;
                                        rowBlockDimC: cint; colBlockDimC: cint;
                                        pBufferSize: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseCgebsr2gebsr_bufferSizeExt", dynlib: libName.}
proc cusparseZgebsr2gebsr_bufferSizeExt*(handle: cusparseHandle_t;
                                        dirA: cusparseDirection_t; mb: cint;
                                        nb: cint; nnzb: cint;
                                        descrA: cusparseMatDescr_t;
                                        bsrSortedValA: ptr cuDoubleComplex;
                                        bsrSortedRowPtrA: ptr cint;
                                        bsrSortedColIndA: ptr cint;
                                        rowBlockDimA: cint; colBlockDimA: cint;
                                        rowBlockDimC: cint; colBlockDimC: cint;
                                        pBufferSize: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseZgebsr2gebsr_bufferSizeExt", dynlib: libName.}
proc cusparseXgebsr2gebsrNnz*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                             mb: cint; nb: cint; nnzb: cint;
                             descrA: cusparseMatDescr_t;
                             bsrSortedRowPtrA: ptr cint;
                             bsrSortedColIndA: ptr cint; rowBlockDimA: cint;
                             colBlockDimA: cint; descrC: cusparseMatDescr_t;
                             bsrSortedRowPtrC: ptr cint; rowBlockDimC: cint;
                             colBlockDimC: cint; nnzTotalDevHostPtr: ptr cint;
                             pBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseXgebsr2gebsrNnz", dynlib: libName.}
proc cusparseSgebsr2gebsr*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                          mb: cint; nb: cint; nnzb: cint; descrA: cusparseMatDescr_t;
                          bsrSortedValA: ptr cfloat; bsrSortedRowPtrA: ptr cint;
                          bsrSortedColIndA: ptr cint; rowBlockDimA: cint;
                          colBlockDimA: cint; descrC: cusparseMatDescr_t;
                          bsrSortedValC: ptr cfloat; bsrSortedRowPtrC: ptr cint;
                          bsrSortedColIndC: ptr cint; rowBlockDimC: cint;
                          colBlockDimC: cint; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseSgebsr2gebsr", dynlib: libName.}
proc cusparseDgebsr2gebsr*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                          mb: cint; nb: cint; nnzb: cint; descrA: cusparseMatDescr_t;
                          bsrSortedValA: ptr cdouble; bsrSortedRowPtrA: ptr cint;
                          bsrSortedColIndA: ptr cint; rowBlockDimA: cint;
                          colBlockDimA: cint; descrC: cusparseMatDescr_t;
                          bsrSortedValC: ptr cdouble; bsrSortedRowPtrC: ptr cint;
                          bsrSortedColIndC: ptr cint; rowBlockDimC: cint;
                          colBlockDimC: cint; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseDgebsr2gebsr", dynlib: libName.}
proc cusparseCgebsr2gebsr*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                          mb: cint; nb: cint; nnzb: cint; descrA: cusparseMatDescr_t;
                          bsrSortedValA: ptr cuComplex; bsrSortedRowPtrA: ptr cint;
                          bsrSortedColIndA: ptr cint; rowBlockDimA: cint;
                          colBlockDimA: cint; descrC: cusparseMatDescr_t;
                          bsrSortedValC: ptr cuComplex; bsrSortedRowPtrC: ptr cint;
                          bsrSortedColIndC: ptr cint; rowBlockDimC: cint;
                          colBlockDimC: cint; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseCgebsr2gebsr", dynlib: libName.}
proc cusparseZgebsr2gebsr*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                          mb: cint; nb: cint; nnzb: cint; descrA: cusparseMatDescr_t;
                          bsrSortedValA: ptr cuDoubleComplex;
                          bsrSortedRowPtrA: ptr cint; bsrSortedColIndA: ptr cint;
                          rowBlockDimA: cint; colBlockDimA: cint;
                          descrC: cusparseMatDescr_t;
                          bsrSortedValC: ptr cuDoubleComplex;
                          bsrSortedRowPtrC: ptr cint; bsrSortedColIndC: ptr cint;
                          rowBlockDimC: cint; colBlockDimC: cint; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseZgebsr2gebsr", dynlib: libName.}
## ##############################################################################
## # SPARSE MATRIX SORTING
## ##############################################################################

proc cusparseCreateIdentityPermutation*(handle: cusparseHandle_t; n: cint;
                                       p: ptr cint): cusparseStatus_t {.cdecl,
    importc: "cusparseCreateIdentityPermutation", dynlib: libName.}
proc cusparseXcoosort_bufferSizeExt*(handle: cusparseHandle_t; m: cint; n: cint;
                                    nnz: cint; cooRowsA: ptr cint;
                                    cooColsA: ptr cint;
                                    pBufferSizeInBytes: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseXcoosort_bufferSizeExt", dynlib: libName.}
proc cusparseXcoosortByRow*(handle: cusparseHandle_t; m: cint; n: cint; nnz: cint;
                           cooRowsA: ptr cint; cooColsA: ptr cint; P: ptr cint;
                           pBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseXcoosortByRow", dynlib: libName.}
proc cusparseXcoosortByColumn*(handle: cusparseHandle_t; m: cint; n: cint; nnz: cint;
                              cooRowsA: ptr cint; cooColsA: ptr cint; P: ptr cint;
                              pBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseXcoosortByColumn", dynlib: libName.}
proc cusparseXcsrsort_bufferSizeExt*(handle: cusparseHandle_t; m: cint; n: cint;
                                    nnz: cint; csrRowPtrA: ptr cint;
                                    csrColIndA: ptr cint;
                                    pBufferSizeInBytes: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseXcsrsort_bufferSizeExt", dynlib: libName.}
proc cusparseXcsrsort*(handle: cusparseHandle_t; m: cint; n: cint; nnz: cint;
                      descrA: cusparseMatDescr_t; csrRowPtrA: ptr cint;
                      csrColIndA: ptr cint; P: ptr cint; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseXcsrsort", dynlib: libName.}
proc cusparseXcscsort_bufferSizeExt*(handle: cusparseHandle_t; m: cint; n: cint;
                                    nnz: cint; cscColPtrA: ptr cint;
                                    cscRowIndA: ptr cint;
                                    pBufferSizeInBytes: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseXcscsort_bufferSizeExt", dynlib: libName.}
proc cusparseXcscsort*(handle: cusparseHandle_t; m: cint; n: cint; nnz: cint;
                      descrA: cusparseMatDescr_t; cscColPtrA: ptr cint;
                      cscRowIndA: ptr cint; P: ptr cint; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseXcscsort", dynlib: libName.}
proc cusparseScsru2csr_bufferSizeExt*(handle: cusparseHandle_t; m: cint; n: cint;
                                     nnz: cint; csrVal: ptr cfloat;
                                     csrRowPtr: ptr cint; csrColInd: ptr cint;
                                     info: csru2csrInfo_t;
                                     pBufferSizeInBytes: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseScsru2csr_bufferSizeExt", dynlib: libName.}
proc cusparseDcsru2csr_bufferSizeExt*(handle: cusparseHandle_t; m: cint; n: cint;
                                     nnz: cint; csrVal: ptr cdouble;
                                     csrRowPtr: ptr cint; csrColInd: ptr cint;
                                     info: csru2csrInfo_t;
                                     pBufferSizeInBytes: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseDcsru2csr_bufferSizeExt", dynlib: libName.}
proc cusparseCcsru2csr_bufferSizeExt*(handle: cusparseHandle_t; m: cint; n: cint;
                                     nnz: cint; csrVal: ptr cuComplex;
                                     csrRowPtr: ptr cint; csrColInd: ptr cint;
                                     info: csru2csrInfo_t;
                                     pBufferSizeInBytes: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseCcsru2csr_bufferSizeExt", dynlib: libName.}
proc cusparseZcsru2csr_bufferSizeExt*(handle: cusparseHandle_t; m: cint; n: cint;
                                     nnz: cint; csrVal: ptr cuDoubleComplex;
                                     csrRowPtr: ptr cint; csrColInd: ptr cint;
                                     info: csru2csrInfo_t;
                                     pBufferSizeInBytes: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseZcsru2csr_bufferSizeExt", dynlib: libName.}
proc cusparseScsru2csr*(handle: cusparseHandle_t; m: cint; n: cint; nnz: cint;
                       descrA: cusparseMatDescr_t; csrVal: ptr cfloat;
                       csrRowPtr: ptr cint; csrColInd: ptr cint; info: csru2csrInfo_t;
                       pBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseScsru2csr", dynlib: libName.}
proc cusparseDcsru2csr*(handle: cusparseHandle_t; m: cint; n: cint; nnz: cint;
                       descrA: cusparseMatDescr_t; csrVal: ptr cdouble;
                       csrRowPtr: ptr cint; csrColInd: ptr cint; info: csru2csrInfo_t;
                       pBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseDcsru2csr", dynlib: libName.}
proc cusparseCcsru2csr*(handle: cusparseHandle_t; m: cint; n: cint; nnz: cint;
                       descrA: cusparseMatDescr_t; csrVal: ptr cuComplex;
                       csrRowPtr: ptr cint; csrColInd: ptr cint; info: csru2csrInfo_t;
                       pBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseCcsru2csr", dynlib: libName.}
proc cusparseZcsru2csr*(handle: cusparseHandle_t; m: cint; n: cint; nnz: cint;
                       descrA: cusparseMatDescr_t; csrVal: ptr cuDoubleComplex;
                       csrRowPtr: ptr cint; csrColInd: ptr cint; info: csru2csrInfo_t;
                       pBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseZcsru2csr", dynlib: libName.}
proc cusparseScsr2csru*(handle: cusparseHandle_t; m: cint; n: cint; nnz: cint;
                       descrA: cusparseMatDescr_t; csrVal: ptr cfloat;
                       csrRowPtr: ptr cint; csrColInd: ptr cint; info: csru2csrInfo_t;
                       pBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseScsr2csru", dynlib: libName.}
proc cusparseDcsr2csru*(handle: cusparseHandle_t; m: cint; n: cint; nnz: cint;
                       descrA: cusparseMatDescr_t; csrVal: ptr cdouble;
                       csrRowPtr: ptr cint; csrColInd: ptr cint; info: csru2csrInfo_t;
                       pBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseDcsr2csru", dynlib: libName.}
proc cusparseCcsr2csru*(handle: cusparseHandle_t; m: cint; n: cint; nnz: cint;
                       descrA: cusparseMatDescr_t; csrVal: ptr cuComplex;
                       csrRowPtr: ptr cint; csrColInd: ptr cint; info: csru2csrInfo_t;
                       pBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseCcsr2csru", dynlib: libName.}
proc cusparseZcsr2csru*(handle: cusparseHandle_t; m: cint; n: cint; nnz: cint;
                       descrA: cusparseMatDescr_t; csrVal: ptr cuDoubleComplex;
                       csrRowPtr: ptr cint; csrColInd: ptr cint; info: csru2csrInfo_t;
                       pBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseZcsr2csru", dynlib: libName.}
proc cusparseSpruneDense2csr_bufferSizeExt*(handle: cusparseHandle_t; m: cint;
    n: cint; A: ptr cfloat; lda: cint; threshold: ptr cfloat; descrC: cusparseMatDescr_t;
    csrSortedValC: ptr cfloat; csrSortedRowPtrC: ptr cint; csrSortedColIndC: ptr cint;
    pBufferSizeInBytes: ptr csize_t): cusparseStatus_t {.cdecl,
    importc: "cusparseSpruneDense2csr_bufferSizeExt", dynlib: libName.}
proc cusparseDpruneDense2csr_bufferSizeExt*(handle: cusparseHandle_t; m: cint;
    n: cint; A: ptr cdouble; lda: cint; threshold: ptr cdouble;
    descrC: cusparseMatDescr_t; csrSortedValC: ptr cdouble;
    csrSortedRowPtrC: ptr cint; csrSortedColIndC: ptr cint;
    pBufferSizeInBytes: ptr csize_t): cusparseStatus_t {.cdecl,
    importc: "cusparseDpruneDense2csr_bufferSizeExt", dynlib: libName.}
proc cusparseSpruneDense2csrNnz*(handle: cusparseHandle_t; m: cint; n: cint;
                                A: ptr cfloat; lda: cint; threshold: ptr cfloat;
                                descrC: cusparseMatDescr_t; csrRowPtrC: ptr cint;
                                nnzTotalDevHostPtr: ptr cint; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseSpruneDense2csrNnz", dynlib: libName.}
proc cusparseDpruneDense2csrNnz*(handle: cusparseHandle_t; m: cint; n: cint;
                                A: ptr cdouble; lda: cint; threshold: ptr cdouble;
                                descrC: cusparseMatDescr_t;
                                csrSortedRowPtrC: ptr cint;
                                nnzTotalDevHostPtr: ptr cint; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseDpruneDense2csrNnz", dynlib: libName.}
proc cusparseSpruneDense2csr*(handle: cusparseHandle_t; m: cint; n: cint;
                             A: ptr cfloat; lda: cint; threshold: ptr cfloat;
                             descrC: cusparseMatDescr_t;
                             csrSortedValC: ptr cfloat; csrSortedRowPtrC: ptr cint;
                             csrSortedColIndC: ptr cint; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseSpruneDense2csr", dynlib: libName.}
proc cusparseDpruneDense2csr*(handle: cusparseHandle_t; m: cint; n: cint;
                             A: ptr cdouble; lda: cint; threshold: ptr cdouble;
                             descrC: cusparseMatDescr_t;
                             csrSortedValC: ptr cdouble;
                             csrSortedRowPtrC: ptr cint;
                             csrSortedColIndC: ptr cint; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseDpruneDense2csr", dynlib: libName.}
proc cusparseSpruneCsr2csr_bufferSizeExt*(handle: cusparseHandle_t; m: cint; n: cint;
    nnzA: cint; descrA: cusparseMatDescr_t; csrSortedValA: ptr cfloat;
    csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint; threshold: ptr cfloat;
    descrC: cusparseMatDescr_t; csrSortedValC: ptr cfloat;
    csrSortedRowPtrC: ptr cint; csrSortedColIndC: ptr cint;
    pBufferSizeInBytes: ptr csize_t): cusparseStatus_t {.cdecl,
    importc: "cusparseSpruneCsr2csr_bufferSizeExt", dynlib: libName.}
proc cusparseDpruneCsr2csr_bufferSizeExt*(handle: cusparseHandle_t; m: cint; n: cint;
    nnzA: cint; descrA: cusparseMatDescr_t; csrSortedValA: ptr cdouble;
    csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint; threshold: ptr cdouble;
    descrC: cusparseMatDescr_t; csrSortedValC: ptr cdouble;
    csrSortedRowPtrC: ptr cint; csrSortedColIndC: ptr cint;
    pBufferSizeInBytes: ptr csize_t): cusparseStatus_t {.cdecl,
    importc: "cusparseDpruneCsr2csr_bufferSizeExt", dynlib: libName.}
proc cusparseSpruneCsr2csrNnz*(handle: cusparseHandle_t; m: cint; n: cint; nnzA: cint;
                              descrA: cusparseMatDescr_t;
                              csrSortedValA: ptr cfloat;
                              csrSortedRowPtrA: ptr cint;
                              csrSortedColIndA: ptr cint; threshold: ptr cfloat;
                              descrC: cusparseMatDescr_t;
                              csrSortedRowPtrC: ptr cint;
                              nnzTotalDevHostPtr: ptr cint; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseSpruneCsr2csrNnz", dynlib: libName.}
proc cusparseDpruneCsr2csrNnz*(handle: cusparseHandle_t; m: cint; n: cint; nnzA: cint;
                              descrA: cusparseMatDescr_t;
                              csrSortedValA: ptr cdouble;
                              csrSortedRowPtrA: ptr cint;
                              csrSortedColIndA: ptr cint; threshold: ptr cdouble;
                              descrC: cusparseMatDescr_t;
                              csrSortedRowPtrC: ptr cint;
                              nnzTotalDevHostPtr: ptr cint; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseDpruneCsr2csrNnz", dynlib: libName.}
proc cusparseSpruneCsr2csr*(handle: cusparseHandle_t; m: cint; n: cint; nnzA: cint;
                           descrA: cusparseMatDescr_t; csrSortedValA: ptr cfloat;
                           csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                           threshold: ptr cfloat; descrC: cusparseMatDescr_t;
                           csrSortedValC: ptr cfloat; csrSortedRowPtrC: ptr cint;
                           csrSortedColIndC: ptr cint; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseSpruneCsr2csr", dynlib: libName.}
proc cusparseDpruneCsr2csr*(handle: cusparseHandle_t; m: cint; n: cint; nnzA: cint;
                           descrA: cusparseMatDescr_t; csrSortedValA: ptr cdouble;
                           csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                           threshold: ptr cdouble; descrC: cusparseMatDescr_t;
                           csrSortedValC: ptr cdouble; csrSortedRowPtrC: ptr cint;
                           csrSortedColIndC: ptr cint; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseDpruneCsr2csr", dynlib: libName.}
proc cusparseSpruneDense2csrByPercentage_bufferSizeExt*(handle: cusparseHandle_t;
    m: cint; n: cint; A: ptr cfloat; lda: cint; percentage: cfloat;
    descrC: cusparseMatDescr_t; csrSortedValC: ptr cfloat;
    csrSortedRowPtrC: ptr cint; csrSortedColIndC: ptr cint; info: pruneInfo_t;
    pBufferSizeInBytes: ptr csize_t): cusparseStatus_t {.cdecl,
    importc: "cusparseSpruneDense2csrByPercentage_bufferSizeExt", dynlib: libName.}
proc cusparseDpruneDense2csrByPercentage_bufferSizeExt*(handle: cusparseHandle_t;
    m: cint; n: cint; A: ptr cdouble; lda: cint; percentage: cfloat;
    descrC: cusparseMatDescr_t; csrSortedValC: ptr cdouble;
    csrSortedRowPtrC: ptr cint; csrSortedColIndC: ptr cint; info: pruneInfo_t;
    pBufferSizeInBytes: ptr csize_t): cusparseStatus_t {.cdecl,
    importc: "cusparseDpruneDense2csrByPercentage_bufferSizeExt", dynlib: libName.}
proc cusparseSpruneDense2csrNnzByPercentage*(handle: cusparseHandle_t; m: cint;
    n: cint; A: ptr cfloat; lda: cint; percentage: cfloat; descrC: cusparseMatDescr_t;
    csrRowPtrC: ptr cint; nnzTotalDevHostPtr: ptr cint; info: pruneInfo_t;
    pBuffer: pointer): cusparseStatus_t {.cdecl, importc: "cusparseSpruneDense2csrNnzByPercentage",
                                       dynlib: libName.}
proc cusparseDpruneDense2csrNnzByPercentage*(handle: cusparseHandle_t; m: cint;
    n: cint; A: ptr cdouble; lda: cint; percentage: cfloat; descrC: cusparseMatDescr_t;
    csrRowPtrC: ptr cint; nnzTotalDevHostPtr: ptr cint; info: pruneInfo_t;
    pBuffer: pointer): cusparseStatus_t {.cdecl, importc: "cusparseDpruneDense2csrNnzByPercentage",
                                       dynlib: libName.}
proc cusparseSpruneDense2csrByPercentage*(handle: cusparseHandle_t; m: cint; n: cint;
    A: ptr cfloat; lda: cint; percentage: cfloat; descrC: cusparseMatDescr_t;
    csrSortedValC: ptr cfloat; csrSortedRowPtrC: ptr cint; csrSortedColIndC: ptr cint;
    info: pruneInfo_t; pBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseSpruneDense2csrByPercentage", dynlib: libName.}
proc cusparseDpruneDense2csrByPercentage*(handle: cusparseHandle_t; m: cint; n: cint;
    A: ptr cdouble; lda: cint; percentage: cfloat; descrC: cusparseMatDescr_t;
    csrSortedValC: ptr cdouble; csrSortedRowPtrC: ptr cint;
    csrSortedColIndC: ptr cint; info: pruneInfo_t; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseDpruneDense2csrByPercentage", dynlib: libName.}
proc cusparseSpruneCsr2csrByPercentage_bufferSizeExt*(handle: cusparseHandle_t;
    m: cint; n: cint; nnzA: cint; descrA: cusparseMatDescr_t; csrSortedValA: ptr cfloat;
    csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint; percentage: cfloat;
    descrC: cusparseMatDescr_t; csrSortedValC: ptr cfloat;
    csrSortedRowPtrC: ptr cint; csrSortedColIndC: ptr cint; info: pruneInfo_t;
    pBufferSizeInBytes: ptr csize_t): cusparseStatus_t {.cdecl,
    importc: "cusparseSpruneCsr2csrByPercentage_bufferSizeExt", dynlib: libName.}
proc cusparseDpruneCsr2csrByPercentage_bufferSizeExt*(handle: cusparseHandle_t;
    m: cint; n: cint; nnzA: cint; descrA: cusparseMatDescr_t;
    csrSortedValA: ptr cdouble; csrSortedRowPtrA: ptr cint;
    csrSortedColIndA: ptr cint; percentage: cfloat; descrC: cusparseMatDescr_t;
    csrSortedValC: ptr cdouble; csrSortedRowPtrC: ptr cint;
    csrSortedColIndC: ptr cint; info: pruneInfo_t; pBufferSizeInBytes: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseDpruneCsr2csrByPercentage_bufferSizeExt",
    dynlib: libName.}
proc cusparseSpruneCsr2csrNnzByPercentage*(handle: cusparseHandle_t; m: cint;
    n: cint; nnzA: cint; descrA: cusparseMatDescr_t; csrSortedValA: ptr cfloat;
    csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint; percentage: cfloat;
    descrC: cusparseMatDescr_t; csrSortedRowPtrC: ptr cint;
    nnzTotalDevHostPtr: ptr cint; info: pruneInfo_t; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseSpruneCsr2csrNnzByPercentage", dynlib: libName.}
proc cusparseDpruneCsr2csrNnzByPercentage*(handle: cusparseHandle_t; m: cint;
    n: cint; nnzA: cint; descrA: cusparseMatDescr_t; csrSortedValA: ptr cdouble;
    csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint; percentage: cfloat;
    descrC: cusparseMatDescr_t; csrSortedRowPtrC: ptr cint;
    nnzTotalDevHostPtr: ptr cint; info: pruneInfo_t; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseDpruneCsr2csrNnzByPercentage", dynlib: libName.}
proc cusparseSpruneCsr2csrByPercentage*(handle: cusparseHandle_t; m: cint; n: cint;
                                       nnzA: cint; descrA: cusparseMatDescr_t;
                                       csrSortedValA: ptr cfloat;
                                       csrSortedRowPtrA: ptr cint;
                                       csrSortedColIndA: ptr cint;
                                       percentage: cfloat;
                                       descrC: cusparseMatDescr_t;
                                       csrSortedValC: ptr cfloat;
                                       csrSortedRowPtrC: ptr cint;
                                       csrSortedColIndC: ptr cint;
                                       info: pruneInfo_t; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseSpruneCsr2csrByPercentage", dynlib: libName.}
proc cusparseDpruneCsr2csrByPercentage*(handle: cusparseHandle_t; m: cint; n: cint;
                                       nnzA: cint; descrA: cusparseMatDescr_t;
                                       csrSortedValA: ptr cdouble;
                                       csrSortedRowPtrA: ptr cint;
                                       csrSortedColIndA: ptr cint;
                                       percentage: cfloat;
                                       descrC: cusparseMatDescr_t;
                                       csrSortedValC: ptr cdouble;
                                       csrSortedRowPtrC: ptr cint;
                                       csrSortedColIndC: ptr cint;
                                       info: pruneInfo_t; pBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseDpruneCsr2csrByPercentage", dynlib: libName.}
## ##############################################################################
## # CSR2CSC
## ##############################################################################

type
  cusparseCsr2CscAlg_t* {.size: sizeof(cint).} = enum
    CUSPARSE_CSR2CSC_ALG_DEFAULT = 1

const
  CUSPARSE_CSR2CSC_ALG1 = CUSPARSE_CSR2CSC_ALG_DEFAULT

proc cusparseCsr2cscEx2*(handle: cusparseHandle_t; m: cint; n: cint; nnz: cint;
                        csrVal: pointer; csrRowPtr: ptr cint; csrColInd: ptr cint;
                        cscVal: pointer; cscColPtr: ptr cint; cscRowInd: ptr cint;
                        valType: cudaDataType; copyValues: cusparseAction_t;
                        idxBase: cusparseIndexBase_t; alg: cusparseCsr2CscAlg_t;
                        buffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseCsr2cscEx2", dynlib: libName.}
proc cusparseCsr2cscEx2_bufferSize*(handle: cusparseHandle_t; m: cint; n: cint;
                                   nnz: cint; csrVal: pointer; csrRowPtr: ptr cint;
                                   csrColInd: ptr cint; cscVal: pointer;
                                   cscColPtr: ptr cint; cscRowInd: ptr cint;
                                   valType: cudaDataType;
                                   copyValues: cusparseAction_t;
                                   idxBase: cusparseIndexBase_t;
                                   alg: cusparseCsr2CscAlg_t;
                                   bufferSize: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseCsr2cscEx2_bufferSize", dynlib: libName.}
##  #############################################################################
##  # GENERIC APIs - Enumerators and Opaque Data Structures
##  #############################################################################

type
  cusparseFormat_t* {.size: sizeof(cint).} = enum
    CUSPARSE_FORMAT_CSR = 1,    ## < Compressed Sparse Row (CSR)
    CUSPARSE_FORMAT_CSC = 2,    ## < Compressed Sparse Column (CSC)
    CUSPARSE_FORMAT_COO = 3,    ## < Coordinate (COO) - Structure of Arrays
    CUSPARSE_FORMAT_BLOCKED_ELL = 5, ## < Blocked ELL
    CUSPARSE_FORMAT_BSR = 6,    ## < Blocked Compressed Sparse Row (BSR)
    CUSPARSE_FORMAT_SLICED_ELLPACK = 7 ## < Sliced ELL
  cusparseOrder_t* {.size: sizeof(cint).} = enum
    CUSPARSE_ORDER_COL = 1,     ## < Column-Major Order - Matrix memory layout
    CUSPARSE_ORDER_ROW = 2      ## < Row-Major Order - Matrix memory layout
  cusparseIndexType_t* {.size: sizeof(cint).} = enum
    CUSPARSE_INDEX_16U = 1,     ## < 16-bit unsigned integer for matrix/vector
                         ## < indices
    CUSPARSE_INDEX_32I = 2,     ## < 32-bit signed integer for matrix/vector indices
    CUSPARSE_INDEX_64I = 3      ## < 64-bit signed integer for matrix/vector indices




## ------------------------------------------------------------------------------

type cusparseSpVecDescr {.nodecl.} = object
type cusparseDnVecDescr {.nodecl.} = object
type cusparseSpMatDescr {.nodecl.} = object
type cusparseDnMatDescr {.nodecl.} = object
type
  cusparseSpVecDescr_t* = ptr cusparseSpVecDescr
  cusparseDnVecDescr_t* = ptr cusparseDnVecDescr
  cusparseSpMatDescr_t* = ptr cusparseSpMatDescr
  cusparseDnMatDescr_t* = ptr cusparseDnMatDescr
  cusparseConstSpVecDescr_t* = ptr cusparseSpVecDescr
  cusparseConstDnVecDescr_t* = ptr cusparseDnVecDescr
  cusparseConstSpMatDescr_t* = ptr cusparseSpMatDescr
  cusparseConstDnMatDescr_t* = ptr cusparseDnMatDescr

##  #############################################################################
##  # SPARSE VECTOR DESCRIPTOR
##  #############################################################################

proc cusparseCreateSpVec*(spVecDescr: ptr cusparseSpVecDescr_t; size: clonglong;
                         nnz: clonglong; indices: pointer; values: pointer;
                         idxType: cusparseIndexType_t;
                         idxBase: cusparseIndexBase_t; valueType: cudaDataType): cusparseStatus_t {.
    cdecl, importc: "cusparseCreateSpVec", dynlib: libName.}
proc cusparseCreateConstSpVec*(spVecDescr: ptr cusparseConstSpVecDescr_t;
                              size: clonglong; nnz: clonglong; indices: pointer;
                              values: pointer; idxType: cusparseIndexType_t;
                              idxBase: cusparseIndexBase_t;
                              valueType: cudaDataType): cusparseStatus_t {.cdecl,
    importc: "cusparseCreateConstSpVec", dynlib: libName.}
proc cusparseDestroySpVec*(spVecDescr: cusparseConstSpVecDescr_t): cusparseStatus_t {.
    cdecl, importc: "cusparseDestroySpVec", dynlib: libName.}
proc cusparseSpVecGet*(spVecDescr: cusparseSpVecDescr_t; size: ptr clonglong;
                      nnz: ptr clonglong; indices: ptr pointer; values: ptr pointer;
                      idxType: ptr cusparseIndexType_t;
                      idxBase: ptr cusparseIndexBase_t; valueType: ptr cudaDataType): cusparseStatus_t {.
    cdecl, importc: "cusparseSpVecGet", dynlib: libName.}
proc cusparseConstSpVecGet*(spVecDescr: cusparseConstSpVecDescr_t;
                           size: ptr clonglong; nnz: ptr clonglong;
                           indices: ptr pointer; values: ptr pointer;
                           idxType: ptr cusparseIndexType_t;
                           idxBase: ptr cusparseIndexBase_t;
                           valueType: ptr cudaDataType): cusparseStatus_t {.cdecl,
    importc: "cusparseConstSpVecGet", dynlib: libName.}
proc cusparseSpVecGetIndexBase*(spVecDescr: cusparseConstSpVecDescr_t;
                               idxBase: ptr cusparseIndexBase_t): cusparseStatus_t {.
    cdecl, importc: "cusparseSpVecGetIndexBase", dynlib: libName.}
proc cusparseSpVecGetValues*(spVecDescr: cusparseSpVecDescr_t; values: ptr pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseSpVecGetValues", dynlib: libName.}
proc cusparseConstSpVecGetValues*(spVecDescr: cusparseConstSpVecDescr_t;
                                 values: ptr pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseConstSpVecGetValues", dynlib: libName.}
proc cusparseSpVecSetValues*(spVecDescr: cusparseSpVecDescr_t; values: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseSpVecSetValues", dynlib: libName.}
##  #############################################################################
##  # DENSE VECTOR DESCRIPTOR
##  #############################################################################

proc cusparseCreateDnVec*(dnVecDescr: ptr cusparseDnVecDescr_t; size: clonglong;
                         values: pointer; valueType: cudaDataType): cusparseStatus_t {.
    cdecl, importc: "cusparseCreateDnVec", dynlib: libName.}
proc cusparseCreateConstDnVec*(dnVecDescr: ptr cusparseConstDnVecDescr_t;
                              size: clonglong; values: pointer;
                              valueType: cudaDataType): cusparseStatus_t {.cdecl,
    importc: "cusparseCreateConstDnVec", dynlib: libName.}
proc cusparseDestroyDnVec*(dnVecDescr: cusparseConstDnVecDescr_t): cusparseStatus_t {.
    cdecl, importc: "cusparseDestroyDnVec", dynlib: libName.}
proc cusparseDnVecGet*(dnVecDescr: cusparseDnVecDescr_t; size: ptr clonglong;
                      values: ptr pointer; valueType: ptr cudaDataType): cusparseStatus_t {.
    cdecl, importc: "cusparseDnVecGet", dynlib: libName.}
proc cusparseConstDnVecGet*(dnVecDescr: cusparseConstDnVecDescr_t;
                           size: ptr clonglong; values: ptr pointer;
                           valueType: ptr cudaDataType): cusparseStatus_t {.cdecl,
    importc: "cusparseConstDnVecGet", dynlib: libName.}
proc cusparseDnVecGetValues*(dnVecDescr: cusparseDnVecDescr_t; values: ptr pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseDnVecGetValues", dynlib: libName.}
proc cusparseConstDnVecGetValues*(dnVecDescr: cusparseConstDnVecDescr_t;
                                 values: ptr pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseConstDnVecGetValues", dynlib: libName.}
proc cusparseDnVecSetValues*(dnVecDescr: cusparseDnVecDescr_t; values: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseDnVecSetValues", dynlib: libName.}
##  #############################################################################
##  # SPARSE MATRIX DESCRIPTOR
##  #############################################################################

proc cusparseDestroySpMat*(spMatDescr: cusparseConstSpMatDescr_t): cusparseStatus_t {.
    cdecl, importc: "cusparseDestroySpMat", dynlib: libName.}
proc cusparseSpMatGetFormat*(spMatDescr: cusparseConstSpMatDescr_t;
                            format: ptr cusparseFormat_t): cusparseStatus_t {.cdecl,
    importc: "cusparseSpMatGetFormat", dynlib: libName.}
proc cusparseSpMatGetIndexBase*(spMatDescr: cusparseConstSpMatDescr_t;
                               idxBase: ptr cusparseIndexBase_t): cusparseStatus_t {.
    cdecl, importc: "cusparseSpMatGetIndexBase", dynlib: libName.}
proc cusparseSpMatGetValues*(spMatDescr: cusparseSpMatDescr_t; values: ptr pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseSpMatGetValues", dynlib: libName.}
proc cusparseConstSpMatGetValues*(spMatDescr: cusparseConstSpMatDescr_t;
                                 values: ptr pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseConstSpMatGetValues", dynlib: libName.}
proc cusparseSpMatSetValues*(spMatDescr: cusparseSpMatDescr_t; values: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseSpMatSetValues", dynlib: libName.}
proc cusparseSpMatGetSize*(spMatDescr: cusparseConstSpMatDescr_t;
                          rows: ptr clonglong; cols: ptr clonglong; nnz: ptr clonglong): cusparseStatus_t {.
    cdecl, importc: "cusparseSpMatGetSize", dynlib: libName.}
proc cusparseSpMatGetStridedBatch*(spMatDescr: cusparseConstSpMatDescr_t;
                                  batchCount: ptr cint): cusparseStatus_t {.cdecl,
    importc: "cusparseSpMatGetStridedBatch", dynlib: libName.}
proc cusparseCooSetStridedBatch*(spMatDescr: cusparseSpMatDescr_t;
                                batchCount: cint; batchStride: clonglong): cusparseStatus_t {.
    cdecl, importc: "cusparseCooSetStridedBatch", dynlib: libName.}
proc cusparseCsrSetStridedBatch*(spMatDescr: cusparseSpMatDescr_t;
                                batchCount: cint; offsetsBatchStride: clonglong;
                                columnsValuesBatchStride: clonglong): cusparseStatus_t {.
    cdecl, importc: "cusparseCsrSetStridedBatch", dynlib: libName.}
proc cusparseBsrSetStridedBatch*(spMatDescr: cusparseSpMatDescr_t;
                                batchCount: cint; offsetsBatchStride: clonglong;
                                columnsBatchStride: clonglong;
                                ValuesBatchStride: clonglong): cusparseStatus_t {.
    cdecl, importc: "cusparseBsrSetStridedBatch", dynlib: libName.}
type
  cusparseSpMatAttribute_t* {.size: sizeof(cint).} = enum
    CUSPARSE_SPMAT_FILL_MODE, CUSPARSE_SPMAT_DIAG_TYPE


proc cusparseSpMatGetAttribute*(spMatDescr: cusparseConstSpMatDescr_t;
                               attribute: cusparseSpMatAttribute_t; data: pointer;
                               dataSize: csize_t): cusparseStatus_t {.cdecl,
    importc: "cusparseSpMatGetAttribute", dynlib: libName.}
proc cusparseSpMatSetAttribute*(spMatDescr: cusparseSpMatDescr_t;
                               attribute: cusparseSpMatAttribute_t; data: pointer;
                               dataSize: csize_t): cusparseStatus_t {.cdecl,
    importc: "cusparseSpMatSetAttribute", dynlib: libName.}
## ------------------------------------------------------------------------------
##  ### CSR ###

proc cusparseCreateCsr*(spMatDescr: ptr cusparseSpMatDescr_t; rows: clonglong;
                       cols: clonglong; nnz: clonglong; csrRowOffsets: pointer;
                       csrColInd: pointer; csrValues: pointer;
                       csrRowOffsetsType: cusparseIndexType_t;
                       csrColIndType: cusparseIndexType_t;
                       idxBase: cusparseIndexBase_t; valueType: cudaDataType): cusparseStatus_t {.
    cdecl, importc: "cusparseCreateCsr", dynlib: libName.}
proc cusparseCreateConstCsr*(spMatDescr: ptr cusparseConstSpMatDescr_t;
                            rows: clonglong; cols: clonglong; nnz: clonglong;
                            csrRowOffsets: pointer; csrColInd: pointer;
                            csrValues: pointer;
                            csrRowOffsetsType: cusparseIndexType_t;
                            csrColIndType: cusparseIndexType_t;
                            idxBase: cusparseIndexBase_t; valueType: cudaDataType): cusparseStatus_t {.
    cdecl, importc: "cusparseCreateConstCsr", dynlib: libName.}
proc cusparseCreateCsc*(spMatDescr: ptr cusparseSpMatDescr_t; rows: clonglong;
                       cols: clonglong; nnz: clonglong; cscColOffsets: pointer;
                       cscRowInd: pointer; cscValues: pointer;
                       cscColOffsetsType: cusparseIndexType_t;
                       cscRowIndType: cusparseIndexType_t;
                       idxBase: cusparseIndexBase_t; valueType: cudaDataType): cusparseStatus_t {.
    cdecl, importc: "cusparseCreateCsc", dynlib: libName.}
proc cusparseCreateConstCsc*(spMatDescr: ptr cusparseConstSpMatDescr_t;
                            rows: clonglong; cols: clonglong; nnz: clonglong;
                            cscColOffsets: pointer; cscRowInd: pointer;
                            cscValues: pointer;
                            cscColOffsetsType: cusparseIndexType_t;
                            cscRowIndType: cusparseIndexType_t;
                            idxBase: cusparseIndexBase_t; valueType: cudaDataType): cusparseStatus_t {.
    cdecl, importc: "cusparseCreateConstCsc", dynlib: libName.}
proc cusparseCsrGet*(spMatDescr: cusparseSpMatDescr_t; rows: ptr clonglong;
                    cols: ptr clonglong; nnz: ptr clonglong;
                    csrRowOffsets: ptr pointer; csrColInd: ptr pointer;
                    csrValues: ptr pointer;
                    csrRowOffsetsType: ptr cusparseIndexType_t;
                    csrColIndType: ptr cusparseIndexType_t;
                    idxBase: ptr cusparseIndexBase_t; valueType: ptr cudaDataType): cusparseStatus_t {.
    cdecl, importc: "cusparseCsrGet", dynlib: libName.}
proc cusparseConstCsrGet*(spMatDescr: cusparseConstSpMatDescr_t;
                         rows: ptr clonglong; cols: ptr clonglong; nnz: ptr clonglong;
                         csrRowOffsets: ptr pointer; csrColInd: ptr pointer;
                         csrValues: ptr pointer;
                         csrRowOffsetsType: ptr cusparseIndexType_t;
                         csrColIndType: ptr cusparseIndexType_t;
                         idxBase: ptr cusparseIndexBase_t;
                         valueType: ptr cudaDataType): cusparseStatus_t {.cdecl,
    importc: "cusparseConstCsrGet", dynlib: libName.}
proc cusparseCscGet*(spMatDescr: cusparseSpMatDescr_t; rows: ptr clonglong;
                    cols: ptr clonglong; nnz: ptr clonglong;
                    cscColOffsets: ptr pointer; cscRowInd: ptr pointer;
                    cscValues: ptr pointer;
                    cscColOffsetsType: ptr cusparseIndexType_t;
                    cscRowIndType: ptr cusparseIndexType_t;
                    idxBase: ptr cusparseIndexBase_t; valueType: ptr cudaDataType): cusparseStatus_t {.
    cdecl, importc: "cusparseCscGet", dynlib: libName.}
proc cusparseConstCscGet*(spMatDescr: cusparseConstSpMatDescr_t;
                         rows: ptr clonglong; cols: ptr clonglong; nnz: ptr clonglong;
                         cscColOffsets: ptr pointer; cscRowInd: ptr pointer;
                         cscValues: ptr pointer;
                         cscColOffsetsType: ptr cusparseIndexType_t;
                         cscRowIndType: ptr cusparseIndexType_t;
                         idxBase: ptr cusparseIndexBase_t;
                         valueType: ptr cudaDataType): cusparseStatus_t {.cdecl,
    importc: "cusparseConstCscGet", dynlib: libName.}
proc cusparseCsrSetPointers*(spMatDescr: cusparseSpMatDescr_t;
                            csrRowOffsets: pointer; csrColInd: pointer;
                            csrValues: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseCsrSetPointers", dynlib: libName.}
proc cusparseCscSetPointers*(spMatDescr: cusparseSpMatDescr_t;
                            cscColOffsets: pointer; cscRowInd: pointer;
                            cscValues: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseCscSetPointers", dynlib: libName.}
## ------------------------------------------------------------------------------
##  ### BSR ###

proc cusparseCreateBsr*(spMatDescr: ptr cusparseSpMatDescr_t; brows: clonglong;
                       bcols: clonglong; bnnz: clonglong; rowBlockSize: clonglong;
                       colBlockSize: clonglong; bsrRowOffsets: pointer;
                       bsrColInd: pointer; bsrValues: pointer;
                       bsrRowOffsetsType: cusparseIndexType_t;
                       bsrColIndType: cusparseIndexType_t;
                       idxBase: cusparseIndexBase_t; valueType: cudaDataType;
                       order: cusparseOrder_t): cusparseStatus_t {.cdecl,
    importc: "cusparseCreateBsr", dynlib: libName.}
proc cusparseCreateConstBsr*(spMatDescr: ptr cusparseConstSpMatDescr_t;
                            brows: clonglong; bcols: clonglong; bnnz: clonglong;
                            rowBlockDim: clonglong; colBlockDim: clonglong;
                            bsrRowOffsets: pointer; bsrColInd: pointer;
                            bsrValues: pointer;
                            bsrRowOffsetsType: cusparseIndexType_t;
                            bsrColIndType: cusparseIndexType_t;
                            idxBase: cusparseIndexBase_t; valueType: cudaDataType;
                            order: cusparseOrder_t): cusparseStatus_t {.cdecl,
    importc: "cusparseCreateConstBsr", dynlib: libName.}
## ------------------------------------------------------------------------------
##  ### COO ###

proc cusparseCreateCoo*(spMatDescr: ptr cusparseSpMatDescr_t; rows: clonglong;
                       cols: clonglong; nnz: clonglong; cooRowInd: pointer;
                       cooColInd: pointer; cooValues: pointer;
                       cooIdxType: cusparseIndexType_t;
                       idxBase: cusparseIndexBase_t; valueType: cudaDataType): cusparseStatus_t {.
    cdecl, importc: "cusparseCreateCoo", dynlib: libName.}
proc cusparseCreateConstCoo*(spMatDescr: ptr cusparseConstSpMatDescr_t;
                            rows: clonglong; cols: clonglong; nnz: clonglong;
                            cooRowInd: pointer; cooColInd: pointer;
                            cooValues: pointer; cooIdxType: cusparseIndexType_t;
                            idxBase: cusparseIndexBase_t; valueType: cudaDataType): cusparseStatus_t {.
    cdecl, importc: "cusparseCreateConstCoo", dynlib: libName.}
proc cusparseCooGet*(spMatDescr: cusparseSpMatDescr_t; rows: ptr clonglong;
                    cols: ptr clonglong; nnz: ptr clonglong; cooRowInd: ptr pointer;
                    cooColInd: ptr pointer; cooValues: ptr pointer;
                    idxType: ptr cusparseIndexType_t;
                    idxBase: ptr cusparseIndexBase_t; valueType: ptr cudaDataType): cusparseStatus_t {.
    cdecl, importc: "cusparseCooGet", dynlib: libName.}
  ##  COO row indices
  ##  COO column indices
  ##  COO values
proc cusparseConstCooGet*(spMatDescr: cusparseConstSpMatDescr_t;
                         rows: ptr clonglong; cols: ptr clonglong; nnz: ptr clonglong;
                         cooRowInd: ptr pointer; cooColInd: ptr pointer;
                         cooValues: ptr pointer; idxType: ptr cusparseIndexType_t;
                         idxBase: ptr cusparseIndexBase_t;
                         valueType: ptr cudaDataType): cusparseStatus_t {.cdecl,
    importc: "cusparseConstCooGet", dynlib: libName.}
  ##  COO row indices
  ##  COO column indices
  ##  COO values
proc cusparseCooSetPointers*(spMatDescr: cusparseSpMatDescr_t; cooRows: pointer;
                            cooColumns: pointer; cooValues: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseCooSetPointers", dynlib: libName.}
## ------------------------------------------------------------------------------
##  ### BLOCKED ELL ###

proc cusparseCreateBlockedEll*(spMatDescr: ptr cusparseSpMatDescr_t;
                              rows: clonglong; cols: clonglong;
                              ellBlockSize: clonglong; ellCols: clonglong;
                              ellColInd: pointer; ellValue: pointer;
                              ellIdxType: cusparseIndexType_t;
                              idxBase: cusparseIndexBase_t;
                              valueType: cudaDataType): cusparseStatus_t {.cdecl,
    importc: "cusparseCreateBlockedEll", dynlib: libName.}
proc cusparseCreateConstBlockedEll*(spMatDescr: ptr cusparseConstSpMatDescr_t;
                                   rows: clonglong; cols: clonglong;
                                   ellBlockSize: clonglong; ellCols: clonglong;
                                   ellColInd: pointer; ellValue: pointer;
                                   ellIdxType: cusparseIndexType_t;
                                   idxBase: cusparseIndexBase_t;
                                   valueType: cudaDataType): cusparseStatus_t {.
    cdecl, importc: "cusparseCreateConstBlockedEll", dynlib: libName.}
proc cusparseBlockedEllGet*(spMatDescr: cusparseSpMatDescr_t; rows: ptr clonglong;
                           cols: ptr clonglong; ellBlockSize: ptr clonglong;
                           ellCols: ptr clonglong; ellColInd: ptr pointer;
                           ellValue: ptr pointer;
                           ellIdxType: ptr cusparseIndexType_t;
                           idxBase: ptr cusparseIndexBase_t;
                           valueType: ptr cudaDataType): cusparseStatus_t {.cdecl,
    importc: "cusparseBlockedEllGet", dynlib: libName.}
proc cusparseConstBlockedEllGet*(spMatDescr: cusparseConstSpMatDescr_t;
                                rows: ptr clonglong; cols: ptr clonglong;
                                ellBlockSize: ptr clonglong;
                                ellCols: ptr clonglong; ellColInd: ptr pointer;
                                ellValue: ptr pointer;
                                ellIdxType: ptr cusparseIndexType_t;
                                idxBase: ptr cusparseIndexBase_t;
                                valueType: ptr cudaDataType): cusparseStatus_t {.
    cdecl, importc: "cusparseConstBlockedEllGet", dynlib: libName.}
## ------------------------------------------------------------------------------
##  ### Sliced ELLPACK ###

proc cusparseCreateSlicedEll*(spMatDescr: ptr cusparseSpMatDescr_t; rows: clonglong;
                             cols: clonglong; nnz: clonglong;
                             sellValuesSize: clonglong; sliceSize: clonglong;
                             sellSliceOffsets: pointer; sellColInd: pointer;
                             sellValues: pointer;
                             sellSliceOffsetsType: cusparseIndexType_t;
                             sellColIndType: cusparseIndexType_t;
                             idxBase: cusparseIndexBase_t; valueType: cudaDataType): cusparseStatus_t {.
    cdecl, importc: "cusparseCreateSlicedEll", dynlib: libName.}
proc cusparseCreateConstSlicedEll*(spMatDescr: ptr cusparseConstSpMatDescr_t;
                                  rows: clonglong; cols: clonglong; nnz: clonglong;
                                  sellValuesSize: clonglong; sliceSize: clonglong;
                                  sellSliceOffsets: pointer; sellColInd: pointer;
                                  sellValues: pointer;
                                  sellSliceOffsetsType: cusparseIndexType_t;
                                  sellColIndType: cusparseIndexType_t;
                                  idxBase: cusparseIndexBase_t;
                                  valueType: cudaDataType): cusparseStatus_t {.
    cdecl, importc: "cusparseCreateConstSlicedEll", dynlib: libName.}
##  #############################################################################
##  # DENSE MATRIX DESCRIPTOR
##  #############################################################################

proc cusparseCreateDnMat*(dnMatDescr: ptr cusparseDnMatDescr_t; rows: clonglong;
                         cols: clonglong; ld: clonglong; values: pointer;
                         valueType: cudaDataType; order: cusparseOrder_t): cusparseStatus_t {.
    cdecl, importc: "cusparseCreateDnMat", dynlib: libName.}
proc cusparseCreateConstDnMat*(dnMatDescr: ptr cusparseConstDnMatDescr_t;
                              rows: clonglong; cols: clonglong; ld: clonglong;
                              values: pointer; valueType: cudaDataType;
                              order: cusparseOrder_t): cusparseStatus_t {.cdecl,
    importc: "cusparseCreateConstDnMat", dynlib: libName.}
proc cusparseDestroyDnMat*(dnMatDescr: cusparseConstDnMatDescr_t): cusparseStatus_t {.
    cdecl, importc: "cusparseDestroyDnMat", dynlib: libName.}
proc cusparseDnMatGet*(dnMatDescr: cusparseDnMatDescr_t; rows: ptr clonglong;
                      cols: ptr clonglong; ld: ptr clonglong; values: ptr pointer;
                      `type`: ptr cudaDataType; order: ptr cusparseOrder_t): cusparseStatus_t {.
    cdecl, importc: "cusparseDnMatGet", dynlib: libName.}
proc cusparseConstDnMatGet*(dnMatDescr: cusparseConstDnMatDescr_t;
                           rows: ptr clonglong; cols: ptr clonglong;
                           ld: ptr clonglong; values: ptr pointer;
                           `type`: ptr cudaDataType; order: ptr cusparseOrder_t): cusparseStatus_t {.
    cdecl, importc: "cusparseConstDnMatGet", dynlib: libName.}
proc cusparseDnMatGetValues*(dnMatDescr: cusparseDnMatDescr_t; values: ptr pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseDnMatGetValues", dynlib: libName.}
proc cusparseConstDnMatGetValues*(dnMatDescr: cusparseConstDnMatDescr_t;
                                 values: ptr pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseConstDnMatGetValues", dynlib: libName.}
proc cusparseDnMatSetValues*(dnMatDescr: cusparseDnMatDescr_t; values: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseDnMatSetValues", dynlib: libName.}
proc cusparseDnMatSetStridedBatch*(dnMatDescr: cusparseDnMatDescr_t;
                                  batchCount: cint; batchStride: clonglong): cusparseStatus_t {.
    cdecl, importc: "cusparseDnMatSetStridedBatch", dynlib: libName.}
proc cusparseDnMatGetStridedBatch*(dnMatDescr: cusparseConstDnMatDescr_t;
                                  batchCount: ptr cint; batchStride: ptr clonglong): cusparseStatus_t {.
    cdecl, importc: "cusparseDnMatGetStridedBatch", dynlib: libName.}
##  #############################################################################
##  # VECTOR-VECTOR OPERATIONS
##  #############################################################################

proc cusparseAxpby*(handle: cusparseHandle_t; alpha: pointer;
                   vecX: cusparseConstSpVecDescr_t; beta: pointer;
                   vecY: cusparseDnVecDescr_t): cusparseStatus_t {.cdecl,
    importc: "cusparseAxpby", dynlib: libName.}
proc cusparseGather*(handle: cusparseHandle_t; vecY: cusparseConstDnVecDescr_t;
                    vecX: cusparseSpVecDescr_t): cusparseStatus_t {.cdecl,
    importc: "cusparseGather", dynlib: libName.}
proc cusparseScatter*(handle: cusparseHandle_t; vecX: cusparseConstSpVecDescr_t;
                     vecY: cusparseDnVecDescr_t): cusparseStatus_t {.cdecl,
    importc: "cusparseScatter", dynlib: libName.}
proc cusparseRot*(handle: cusparseHandle_t; c_coeff: pointer; s_coeff: pointer;
                 vecX: cusparseSpVecDescr_t; vecY: cusparseDnVecDescr_t): cusparseStatus_t {.
    cdecl, importc: "cusparseRot", dynlib: libName.}
proc cusparseSpVV_bufferSize*(handle: cusparseHandle_t; opX: cusparseOperation_t;
                             vecX: cusparseConstSpVecDescr_t;
                             vecY: cusparseConstDnVecDescr_t; resultNotKeyWord: pointer;
                             computeType: cudaDataType; bufferSize: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseSpVV_bufferSize", dynlib: libName.}
proc cusparseSpVV*(handle: cusparseHandle_t; opX: cusparseOperation_t;
                  vecX: cusparseConstSpVecDescr_t;
                  vecY: cusparseConstDnVecDescr_t; resultNotKeyWord: pointer;
                  computeType: cudaDataType; externalBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseSpVV", dynlib: libName.}
##  #############################################################################
##  # SPARSE TO DENSE
##  #############################################################################

type
  cusparseSparseToDenseAlg_t* {.size: sizeof(cint).} = enum
    CUSPARSE_SPARSETODENSE_ALG_DEFAULT = 0


proc cusparseSparseToDense_bufferSize*(handle: cusparseHandle_t;
                                      matA: cusparseConstSpMatDescr_t;
                                      matB: cusparseDnMatDescr_t;
                                      alg: cusparseSparseToDenseAlg_t;
                                      bufferSize: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseSparseToDense_bufferSize", dynlib: libName.}
proc cusparseSparseToDense*(handle: cusparseHandle_t;
                           matA: cusparseConstSpMatDescr_t;
                           matB: cusparseDnMatDescr_t;
                           alg: cusparseSparseToDenseAlg_t;
                           externalBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseSparseToDense", dynlib: libName.}
##  #############################################################################
##  # DENSE TO SPARSE
##  #############################################################################

type
  cusparseDenseToSparseAlg_t* {.size: sizeof(cint).} = enum
    CUSPARSE_DENSETOSPARSE_ALG_DEFAULT = 0


proc cusparseDenseToSparse_bufferSize*(handle: cusparseHandle_t;
                                      matA: cusparseConstDnMatDescr_t;
                                      matB: cusparseSpMatDescr_t;
                                      alg: cusparseDenseToSparseAlg_t;
                                      bufferSize: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseDenseToSparse_bufferSize", dynlib: libName.}
proc cusparseDenseToSparse_analysis*(handle: cusparseHandle_t;
                                    matA: cusparseConstDnMatDescr_t;
                                    matB: cusparseSpMatDescr_t;
                                    alg: cusparseDenseToSparseAlg_t;
                                    externalBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseDenseToSparse_analysis", dynlib: libName.}
proc cusparseDenseToSparse_convert*(handle: cusparseHandle_t;
                                   matA: cusparseConstDnMatDescr_t;
                                   matB: cusparseSpMatDescr_t;
                                   alg: cusparseDenseToSparseAlg_t;
                                   externalBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseDenseToSparse_convert", dynlib: libName.}
##  #############################################################################
##  # SPARSE MATRIX-VECTOR MULTIPLICATION
##  #############################################################################

type
  cusparseSpMVAlg_t* {.size: sizeof(cint).} = enum
    CUSPARSE_SPMV_ALG_DEFAULT = 0, CUSPARSE_SPMV_COO_ALG1 = 1,
    CUSPARSE_SPMV_CSR_ALG1 = 2, CUSPARSE_SPMV_CSR_ALG2 = 3,
    CUSPARSE_SPMV_COO_ALG2 = 4, CUSPARSE_SPMV_SELL_ALG1 = 5


proc cusparseSpMV*(handle: cusparseHandle_t; opA: cusparseOperation_t;
                  alpha: pointer; matA: cusparseConstSpMatDescr_t;
                  vecX: cusparseConstDnVecDescr_t; beta: pointer;
                  vecY: cusparseDnVecDescr_t; computeType: cudaDataType;
                  alg: cusparseSpMVAlg_t; externalBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseSpMV", dynlib: libName.}
proc cusparseSpMV_bufferSize*(handle: cusparseHandle_t; opA: cusparseOperation_t;
                             alpha: pointer; matA: cusparseConstSpMatDescr_t;
                             vecX: cusparseConstDnVecDescr_t; beta: pointer;
                             vecY: cusparseDnVecDescr_t;
                             computeType: cudaDataType; alg: cusparseSpMVAlg_t;
                             bufferSize: ptr csize_t): cusparseStatus_t {.cdecl,
    importc: "cusparseSpMV_bufferSize", dynlib: libName.}
proc cusparseSpMV_preprocess*(handle: cusparseHandle_t; opA: cusparseOperation_t;
                             alpha: pointer; matA: cusparseConstSpMatDescr_t;
                             vecX: cusparseConstDnVecDescr_t; beta: pointer;
                             vecY: cusparseDnVecDescr_t;
                             computeType: cudaDataType; alg: cusparseSpMVAlg_t;
                             externalBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseSpMV_preprocess", dynlib: libName.}
##  #############################################################################
##  # SPARSE TRIANGULAR VECTOR SOLVE
##  #############################################################################

type
  cusparseSpSVAlg_t* {.size: sizeof(cint).} = enum
    CUSPARSE_SPSV_ALG_DEFAULT = 0
  cusparseSpSVUpdate_t* {.size: sizeof(cint).} = enum
    CUSPARSE_SPSV_UPDATE_GENERAL = 0, CUSPARSE_SPSV_UPDATE_DIAGONAL = 1



type cusparseSpSVDescr {.nodecl.} = object
type
  cusparseSpSVDescr_t* = ptr cusparseSpSVDescr

proc cusparseSpSV_createDescr*(descr: ptr cusparseSpSVDescr_t): cusparseStatus_t {.
    cdecl, importc: "cusparseSpSV_createDescr", dynlib: libName.}
proc cusparseSpSV_destroyDescr*(descr: cusparseSpSVDescr_t): cusparseStatus_t {.
    cdecl, importc: "cusparseSpSV_destroyDescr", dynlib: libName.}
proc cusparseSpSV_bufferSize*(handle: cusparseHandle_t; opA: cusparseOperation_t;
                             alpha: pointer; matA: cusparseConstSpMatDescr_t;
                             vecX: cusparseConstDnVecDescr_t;
                             vecY: cusparseDnVecDescr_t;
                             computeType: cudaDataType; alg: cusparseSpSVAlg_t;
                             spsvDescr: cusparseSpSVDescr_t;
                             bufferSize: ptr csize_t): cusparseStatus_t {.cdecl,
    importc: "cusparseSpSV_bufferSize", dynlib: libName.}
proc cusparseSpSV_analysis*(handle: cusparseHandle_t; opA: cusparseOperation_t;
                           alpha: pointer; matA: cusparseConstSpMatDescr_t;
                           vecX: cusparseConstDnVecDescr_t;
                           vecY: cusparseDnVecDescr_t; computeType: cudaDataType;
                           alg: cusparseSpSVAlg_t; spsvDescr: cusparseSpSVDescr_t;
                           externalBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseSpSV_analysis", dynlib: libName.}
proc cusparseSpSV_solve*(handle: cusparseHandle_t; opA: cusparseOperation_t;
                        alpha: pointer; matA: cusparseConstSpMatDescr_t;
                        vecX: cusparseConstDnVecDescr_t;
                        vecY: cusparseDnVecDescr_t; computeType: cudaDataType;
                        alg: cusparseSpSVAlg_t; spsvDescr: cusparseSpSVDescr_t): cusparseStatus_t {.
    cdecl, importc: "cusparseSpSV_solve", dynlib: libName.}
proc cusparseSpSV_updateMatrix*(handle: cusparseHandle_t;
                               spsvDescr: cusparseSpSVDescr_t; newValues: pointer;
                               updatePart: cusparseSpSVUpdate_t): cusparseStatus_t {.
    cdecl, importc: "cusparseSpSV_updateMatrix", dynlib: libName.}
##  #############################################################################
##  # SPARSE TRIANGULAR MATRIX SOLVE
##  #############################################################################

type
  cusparseSpSMAlg_t* {.size: sizeof(cint).} = enum
    CUSPARSE_SPSM_ALG_DEFAULT = 0
  cusparseSpSMUpdate_t* {.size: sizeof(cint).} = enum
    CUSPARSE_SPSM_UPDATE_GENERAL = 0, CUSPARSE_SPSM_UPDATE_DIAGONAL = 1



type cusparseSpSMDescr {.nodecl.} = object
type
  cusparseSpSMDescr_t* = ptr cusparseSpSMDescr

proc cusparseSpSM_createDescr*(descr: ptr cusparseSpSMDescr_t): cusparseStatus_t {.
    cdecl, importc: "cusparseSpSM_createDescr", dynlib: libName.}
proc cusparseSpSM_destroyDescr*(descr: cusparseSpSMDescr_t): cusparseStatus_t {.
    cdecl, importc: "cusparseSpSM_destroyDescr", dynlib: libName.}
proc cusparseSpSM_bufferSize*(handle: cusparseHandle_t; opA: cusparseOperation_t;
                             opB: cusparseOperation_t; alpha: pointer;
                             matA: cusparseConstSpMatDescr_t;
                             matB: cusparseConstDnMatDescr_t;
                             matC: cusparseDnMatDescr_t;
                             computeType: cudaDataType; alg: cusparseSpSMAlg_t;
                             spsmDescr: cusparseSpSMDescr_t;
                             bufferSize: ptr csize_t): cusparseStatus_t {.cdecl,
    importc: "cusparseSpSM_bufferSize", dynlib: libName.}
proc cusparseSpSM_analysis*(handle: cusparseHandle_t; opA: cusparseOperation_t;
                           opB: cusparseOperation_t; alpha: pointer;
                           matA: cusparseConstSpMatDescr_t;
                           matB: cusparseConstDnMatDescr_t;
                           matC: cusparseDnMatDescr_t; computeType: cudaDataType;
                           alg: cusparseSpSMAlg_t; spsmDescr: cusparseSpSMDescr_t;
                           externalBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseSpSM_analysis", dynlib: libName.}
proc cusparseSpSM_solve*(handle: cusparseHandle_t; opA: cusparseOperation_t;
                        opB: cusparseOperation_t; alpha: pointer;
                        matA: cusparseConstSpMatDescr_t;
                        matB: cusparseConstDnMatDescr_t;
                        matC: cusparseDnMatDescr_t; computeType: cudaDataType;
                        alg: cusparseSpSMAlg_t; spsmDescr: cusparseSpSMDescr_t): cusparseStatus_t {.
    cdecl, importc: "cusparseSpSM_solve", dynlib: libName.}
proc cusparseSpSM_updateMatrix*(handle: cusparseHandle_t;
                               spsmDescr: cusparseSpSMDescr_t; newValues: pointer;
                               updatePart: cusparseSpSMUpdate_t): cusparseStatus_t {.
    cdecl, importc: "cusparseSpSM_updateMatrix", dynlib: libName.}
##  #############################################################################
##  # SPARSE MATRIX-MATRIX MULTIPLICATION
##  #############################################################################

type
  cusparseSpMMAlg_t* {.size: sizeof(cint).} = enum
    CUSPARSE_SPMM_ALG_DEFAULT = 0, CUSPARSE_SPMM_COO_ALG1 = 1,
    CUSPARSE_SPMM_COO_ALG2 = 2, CUSPARSE_SPMM_COO_ALG3 = 3,
    CUSPARSE_SPMM_CSR_ALG1 = 4, CUSPARSE_SPMM_COO_ALG4 = 5,
    CUSPARSE_SPMM_CSR_ALG2 = 6, CUSPARSE_SPMM_CSR_ALG3 = 12,
    CUSPARSE_SPMM_BLOCKED_ELL_ALG1 = 13, CUSPARSE_SPMM_BSR_ALG1 = 14


proc cusparseSpMM_bufferSize*(handle: cusparseHandle_t; opA: cusparseOperation_t;
                             opB: cusparseOperation_t; alpha: pointer;
                             matA: cusparseConstSpMatDescr_t;
                             matB: cusparseConstDnMatDescr_t; beta: pointer;
                             matC: cusparseDnMatDescr_t;
                             computeType: cudaDataType; alg: cusparseSpMMAlg_t;
                             bufferSize: ptr csize_t): cusparseStatus_t {.cdecl,
    importc: "cusparseSpMM_bufferSize", dynlib: libName.}
proc cusparseSpMM_preprocess*(handle: cusparseHandle_t; opA: cusparseOperation_t;
                             opB: cusparseOperation_t; alpha: pointer;
                             matA: cusparseConstSpMatDescr_t;
                             matB: cusparseConstDnMatDescr_t; beta: pointer;
                             matC: cusparseDnMatDescr_t;
                             computeType: cudaDataType; alg: cusparseSpMMAlg_t;
                             externalBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseSpMM_preprocess", dynlib: libName.}
proc cusparseSpMM*(handle: cusparseHandle_t; opA: cusparseOperation_t;
                  opB: cusparseOperation_t; alpha: pointer;
                  matA: cusparseConstSpMatDescr_t;
                  matB: cusparseConstDnMatDescr_t; beta: pointer;
                  matC: cusparseDnMatDescr_t; computeType: cudaDataType;
                  alg: cusparseSpMMAlg_t; externalBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseSpMM", dynlib: libName.}
##  #############################################################################
##  # SPARSE MATRIX - SPARSE MATRIX MULTIPLICATION (SpGEMM)
##  #############################################################################

type
  cusparseSpGEMMAlg_t* {.size: sizeof(cint).} = enum
    CUSPARSE_SPGEMM_DEFAULT = 0, CUSPARSE_SPGEMM_CSR_ALG_DETERMINITIC = 1,
    CUSPARSE_SPGEMM_CSR_ALG_NONDETERMINITIC = 2, CUSPARSE_SPGEMM_ALG1 = 3,
    CUSPARSE_SPGEMM_ALG2 = 4, CUSPARSE_SPGEMM_ALG3 = 5


type cusparseSpGEMMDescr {.nodecl.} = object
type
  cusparseSpGEMMDescr_t* = ptr cusparseSpGEMMDescr

proc cusparseSpGEMM_createDescr*(descr: ptr cusparseSpGEMMDescr_t): cusparseStatus_t {.
    cdecl, importc: "cusparseSpGEMM_createDescr", dynlib: libName.}
proc cusparseSpGEMM_destroyDescr*(descr: cusparseSpGEMMDescr_t): cusparseStatus_t {.
    cdecl, importc: "cusparseSpGEMM_destroyDescr", dynlib: libName.}
proc cusparseSpGEMM_workEstimation*(handle: cusparseHandle_t;
                                   opA: cusparseOperation_t;
                                   opB: cusparseOperation_t; alpha: pointer;
                                   matA: cusparseConstSpMatDescr_t;
                                   matB: cusparseConstSpMatDescr_t; beta: pointer;
                                   matC: cusparseSpMatDescr_t;
                                   computeType: cudaDataType;
                                   alg: cusparseSpGEMMAlg_t;
                                   spgemmDescr: cusparseSpGEMMDescr_t;
                                   bufferSize1: ptr csize_t;
                                   externalBuffer1: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseSpGEMM_workEstimation", dynlib: libName.}
proc cusparseSpGEMM_getNumProducts*(spgemmDescr: cusparseSpGEMMDescr_t;
                                   num_prods: ptr clonglong): cusparseStatus_t {.
    cdecl, importc: "cusparseSpGEMM_getNumProducts", dynlib: libName.}
proc cusparseSpGEMM_estimateMemory*(handle: cusparseHandle_t;
                                   opA: cusparseOperation_t;
                                   opB: cusparseOperation_t; alpha: pointer;
                                   matA: cusparseConstSpMatDescr_t;
                                   matB: cusparseConstSpMatDescr_t; beta: pointer;
                                   matC: cusparseSpMatDescr_t;
                                   computeType: cudaDataType;
                                   alg: cusparseSpGEMMAlg_t;
                                   spgemmDescr: cusparseSpGEMMDescr_t;
                                   chunk_fraction: cfloat;
                                   bufferSize3: ptr csize_t;
                                   externalBuffer3: pointer;
                                   bufferSize2: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseSpGEMM_estimateMemory", dynlib: libName.}
proc cusparseSpGEMM_compute*(handle: cusparseHandle_t; opA: cusparseOperation_t;
                            opB: cusparseOperation_t; alpha: pointer;
                            matA: cusparseConstSpMatDescr_t;
                            matB: cusparseConstSpMatDescr_t; beta: pointer;
                            matC: cusparseSpMatDescr_t; computeType: cudaDataType;
                            alg: cusparseSpGEMMAlg_t;
                            spgemmDescr: cusparseSpGEMMDescr_t;
                            bufferSize2: ptr csize_t; externalBuffer2: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseSpGEMM_compute", dynlib: libName.}
proc cusparseSpGEMM_copy*(handle: cusparseHandle_t; opA: cusparseOperation_t;
                         opB: cusparseOperation_t; alpha: pointer;
                         matA: cusparseConstSpMatDescr_t;
                         matB: cusparseConstSpMatDescr_t; beta: pointer;
                         matC: cusparseSpMatDescr_t; computeType: cudaDataType;
                         alg: cusparseSpGEMMAlg_t;
                         spgemmDescr: cusparseSpGEMMDescr_t): cusparseStatus_t {.
    cdecl, importc: "cusparseSpGEMM_copy", dynlib: libName.}
##  #############################################################################
##  # SPARSE MATRIX - SPARSE MATRIX MULTIPLICATION (SpGEMM) STRUCTURE REUSE
##  #############################################################################

proc cusparseSpGEMMreuse_workEstimation*(handle: cusparseHandle_t;
                                        opA: cusparseOperation_t;
                                        opB: cusparseOperation_t;
                                        matA: cusparseConstSpMatDescr_t;
                                        matB: cusparseConstSpMatDescr_t;
                                        matC: cusparseSpMatDescr_t;
                                        alg: cusparseSpGEMMAlg_t;
                                        spgemmDescr: cusparseSpGEMMDescr_t;
                                        bufferSize1: ptr csize_t;
                                        externalBuffer1: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseSpGEMMreuse_workEstimation", dynlib: libName.}
proc cusparseSpGEMMreuse_nnz*(handle: cusparseHandle_t; opA: cusparseOperation_t;
                             opB: cusparseOperation_t;
                             matA: cusparseConstSpMatDescr_t;
                             matB: cusparseConstSpMatDescr_t;
                             matC: cusparseSpMatDescr_t; alg: cusparseSpGEMMAlg_t;
                             spgemmDescr: cusparseSpGEMMDescr_t;
                             bufferSize2: ptr csize_t; externalBuffer2: pointer;
                             bufferSize3: ptr csize_t; externalBuffer3: pointer;
                             bufferSize4: ptr csize_t; externalBuffer4: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseSpGEMMreuse_nnz", dynlib: libName.}
proc cusparseSpGEMMreuse_copy*(handle: cusparseHandle_t; opA: cusparseOperation_t;
                              opB: cusparseOperation_t;
                              matA: cusparseConstSpMatDescr_t;
                              matB: cusparseConstSpMatDescr_t;
                              matC: cusparseSpMatDescr_t;
                              alg: cusparseSpGEMMAlg_t;
                              spgemmDescr: cusparseSpGEMMDescr_t;
                              bufferSize5: ptr csize_t; externalBuffer5: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseSpGEMMreuse_copy", dynlib: libName.}
proc cusparseSpGEMMreuse_compute*(handle: cusparseHandle_t;
                                 opA: cusparseOperation_t;
                                 opB: cusparseOperation_t; alpha: pointer;
                                 matA: cusparseConstSpMatDescr_t;
                                 matB: cusparseConstSpMatDescr_t; beta: pointer;
                                 matC: cusparseSpMatDescr_t;
                                 computeType: cudaDataType;
                                 alg: cusparseSpGEMMAlg_t;
                                 spgemmDescr: cusparseSpGEMMDescr_t): cusparseStatus_t {.
    cdecl, importc: "cusparseSpGEMMreuse_compute", dynlib: libName.}
##  #############################################################################
##  # SAMPLED DENSE-DENSE MATRIX MULTIPLICATION
##  #############################################################################

type
  cusparseSDDMMAlg_t* {.size: sizeof(cint).} = enum
    CUSPARSE_SDDMM_ALG_DEFAULT = 0


proc cusparseSDDMM_bufferSize*(handle: cusparseHandle_t; opA: cusparseOperation_t;
                              opB: cusparseOperation_t; alpha: pointer;
                              matA: cusparseConstDnMatDescr_t;
                              matB: cusparseConstDnMatDescr_t; beta: pointer;
                              matC: cusparseSpMatDescr_t;
                              computeType: cudaDataType; alg: cusparseSDDMMAlg_t;
                              bufferSize: ptr csize_t): cusparseStatus_t {.cdecl,
    importc: "cusparseSDDMM_bufferSize", dynlib: libName.}
proc cusparseSDDMM_preprocess*(handle: cusparseHandle_t; opA: cusparseOperation_t;
                              opB: cusparseOperation_t; alpha: pointer;
                              matA: cusparseConstDnMatDescr_t;
                              matB: cusparseConstDnMatDescr_t; beta: pointer;
                              matC: cusparseSpMatDescr_t;
                              computeType: cudaDataType; alg: cusparseSDDMMAlg_t;
                              externalBuffer: pointer): cusparseStatus_t {.cdecl,
    importc: "cusparseSDDMM_preprocess", dynlib: libName.}
proc cusparseSDDMM*(handle: cusparseHandle_t; opA: cusparseOperation_t;
                   opB: cusparseOperation_t; alpha: pointer;
                   matA: cusparseConstDnMatDescr_t;
                   matB: cusparseConstDnMatDescr_t; beta: pointer;
                   matC: cusparseSpMatDescr_t; computeType: cudaDataType;
                   alg: cusparseSDDMMAlg_t; externalBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseSDDMM", dynlib: libName.}
##  #############################################################################
##  # GENERIC APIs WITH CUSTOM OPERATORS (PREVIEW)
##  #############################################################################

type cusparseSpMMOpPlan {.nodecl.} = object
type
  cusparseSpMMOpPlan_t* = ptr cusparseSpMMOpPlan
  cusparseSpMMOpAlg_t* {.size: sizeof(cint).} = enum
    CUSPARSE_SPMM_OP_ALG_DEFAULT


proc cusparseSpMMOp_createPlan*(handle: cusparseHandle_t;
                               plan: ptr cusparseSpMMOpPlan_t;
                               opA: cusparseOperation_t; opB: cusparseOperation_t;
                               matA: cusparseConstSpMatDescr_t;
                               matB: cusparseConstDnMatDescr_t;
                               matC: cusparseDnMatDescr_t;
                               computeType: cudaDataType;
                               alg: cusparseSpMMOpAlg_t;
                               addOperationNvvmBuffer: pointer;
                               addOperationBufferSize: csize_t;
                               mulOperationNvvmBuffer: pointer;
                               mulOperationBufferSize: csize_t;
                               epilogueNvvmBuffer: pointer;
                               epilogueBufferSize: csize_t;
                               SpMMWorkspaceSize: ptr csize_t): cusparseStatus_t {.
    cdecl, importc: "cusparseSpMMOp_createPlan", dynlib: libName.}
proc cusparseSpMMOp*(plan: cusparseSpMMOpPlan_t; externalBuffer: pointer): cusparseStatus_t {.
    cdecl, importc: "cusparseSpMMOp", dynlib: libName.}
proc cusparseSpMMOp_destroyPlan*(plan: cusparseSpMMOpPlan_t): cusparseStatus_t {.
    cdecl, importc: "cusparseSpMMOp_destroyPlan", dynlib: libName.}
## ------------------------------------------------------------------------------

##  #undef CUSPARSE_DEPRECATED_REPLACE_WITH
##  #undef CUSPARSE_DEPRECATED
##  #undef CUSPARSE_DEPRECATED_TYPE
##  #undef CUSPARSE_DEPRECATED_TYPE_MSVC
##  #undef CUSPARSE_DEPRECATED_ENUM_REPLACE_WITH
##  #undef CUSPARSE_DEPRECATED_ENUM
