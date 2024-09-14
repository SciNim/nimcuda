##  #prefix cusparse
##  #prefix cusparse_

{.deadCodeElim: on.}
when defined(windows):
  import os
  {.passL: "\"" & os.getEnv("CUDA_PATH") / "lib/x64" / "cusparse.lib" & "\"".}
  {.pragma: dyn.}
elif defined(macosx):
  const
    libName = "libcusparse.dylib"
  {.pragma: dyn, dynlib: libName.}
else:
  const
    libName = "libcusparse.so"
  {.pragma: dyn, dynlib: libName.}
type
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

when not defined(CUSPARSE_H):
  const
    CUSPARSE_H* = true
  ##  CUSPARSE status type returns
  type
    cusparseStatus_t* {.size: sizeof(cint).} = enum
      CUSPARSE_STATUS_SUCCESS = 0, CUSPARSE_STATUS_NOT_INITIALIZED = 1,
      CUSPARSE_STATUS_ALLOC_FAILED = 2, CUSPARSE_STATUS_INVALID_VALUE = 3,
      CUSPARSE_STATUS_ARCH_MISMATCH = 4, CUSPARSE_STATUS_MAPPING_ERROR = 5,
      CUSPARSE_STATUS_EXECUTION_FAILED = 6, CUSPARSE_STATUS_INTERNAL_ERROR = 7,
      CUSPARSE_STATUS_MATRIX_TYPE_NOT_SUPPORTED = 8, CUSPARSE_STATUS_ZERO_PIVOT = 9
  ##  Opaque structure holding CUSPARSE library context
  type
    cusparseContext* = object
    
  type
    cusparseHandle_t* = ptr cusparseContext
  ##  Opaque structure holding the matrix descriptor
  type
    cusparseMatDescr* = object
    
  type
    cusparseMatDescr_t* = ptr cusparseMatDescr
  ##  Opaque structure holding the sparse triangular solve information
  type
    cusparseSolveAnalysisInfo* = object
    
  type
    cusparseSolveAnalysisInfo_t* = ptr cusparseSolveAnalysisInfo
  ##  Opaque structures holding the sparse triangular solve information
  type
    csrsv2Info* = object
    
  type
    csrsv2Info_t* = ptr csrsv2Info
  type
    bsrsv2Info* = object
    
  type
    bsrsv2Info_t* = ptr bsrsv2Info
  type
    bsrsm2Info* = object
    
  type
    bsrsm2Info_t* = ptr bsrsm2Info
  ##  Opaque structures holding incomplete Cholesky information
  type
    csric02Info* = object
    
  type
    csric02Info_t* = ptr csric02Info
  type
    bsric02Info* = object
    
  type
    bsric02Info_t* = ptr bsric02Info
  ##  Opaque structures holding incomplete LU information
  type
    csrilu02Info* = object
    
  type
    csrilu02Info_t* = ptr csrilu02Info
  type
    bsrilu02Info* = object
    
  type
    bsrilu02Info_t* = ptr bsrilu02Info
  ##  Opaque structures holding the hybrid (HYB) storage information
  type
    cusparseHybMat* = object
    
  type
    cusparseHybMat_t* = ptr cusparseHybMat
  ##  Opaque structures holding sparse gemm information
  type
    csrgemm2Info* = object
    
  type
    csrgemm2Info_t* = ptr csrgemm2Info
  ##  Opaque structure holding the sorting information
  type
    csru2csrInfo* = object
    
  type
    csru2csrInfo_t* = ptr csru2csrInfo
  ##  Opaque structure holding the coloring information
  type
    cusparseColorInfo* = object
    
  type
    cusparseColorInfo_t* = ptr cusparseColorInfo
  ##  Types definitions
  type
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
    cusparseHybPartition_t* {.size: sizeof(cint).} = enum
      CUSPARSE_HYB_PARTITION_AUTO = 0, ##  automatically decide how to split the data into regular/irregular part
      CUSPARSE_HYB_PARTITION_USER = 1, ##  store data into regular part up to a user specified treshhold
      CUSPARSE_HYB_PARTITION_MAX = 2
  ##  used in csrsv2, csric02, and csrilu02
  type
    cusparseSolvePolicy_t* {.size: sizeof(cint).} = enum
      CUSPARSE_SOLVE_POLICY_NO_LEVEL = 0, ##  no level information is generated, only reports structural zero.
      CUSPARSE_SOLVE_POLICY_USE_LEVEL = 1
    cusparseSideMode_t* {.size: sizeof(cint).} = enum
      CUSPARSE_SIDE_LEFT = 0, CUSPARSE_SIDE_RIGHT = 1
    cusparseColorAlg_t* {.size: sizeof(cint).} = enum
      CUSPARSE_COLOR_ALG0 = 0,  ##  default
      CUSPARSE_COLOR_ALG1 = 1
    cusparseAlgMode_t* {.size: sizeof(cint).} = enum
      CUSPARSE_ALG0 = 0,        ## default, naive
      CUSPARSE_ALG1 = 1
  ##  CUSPARSE initialization and managment routines
  proc cusparseCreate*(handle: ptr cusparseHandle_t): cusparseStatus_t {.cdecl,
      importc: "cusparseCreate", dyn.}
  proc cusparseDestroy*(handle: cusparseHandle_t): cusparseStatus_t {.cdecl,
      importc: "cusparseDestroy", dyn.}
  proc cusparseGetVersion*(handle: cusparseHandle_t; version: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseGetVersion", dyn.}
  proc cusparseGetProperty*(`type`: libraryPropertyType; value: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseGetProperty", dyn.}
  proc cusparseSetStream*(handle: cusparseHandle_t; streamId: cudaStream_t): cusparseStatus_t {.
      cdecl, importc: "cusparseSetStream", dyn.}
  proc cusparseGetStream*(handle: cusparseHandle_t; streamId: ptr cudaStream_t): cusparseStatus_t {.
      cdecl, importc: "cusparseGetStream", dyn.}
  ##  CUSPARSE type creation, destruction, set and get routines
  proc cusparseGetPointerMode*(handle: cusparseHandle_t;
                              mode: ptr cusparsePointerMode_t): cusparseStatus_t {.
      cdecl, importc: "cusparseGetPointerMode", dyn.}
  proc cusparseSetPointerMode*(handle: cusparseHandle_t;
                              mode: cusparsePointerMode_t): cusparseStatus_t {.
      cdecl, importc: "cusparseSetPointerMode", dyn.}
  ##  sparse matrix descriptor
  ##  When the matrix descriptor is created, its fields are initialized to: 
  ##    CUSPARSE_MATRIX_TYPE_GENERAL
  ##    CUSPARSE_INDEX_BASE_ZERO
  ##    All other fields are uninitialized
  ## 
  proc cusparseCreateMatDescr*(descrA: ptr cusparseMatDescr_t): cusparseStatus_t {.
      cdecl, importc: "cusparseCreateMatDescr", dyn.}
  proc cusparseDestroyMatDescr*(descrA: cusparseMatDescr_t): cusparseStatus_t {.
      cdecl, importc: "cusparseDestroyMatDescr", dyn.}
  proc cusparseCopyMatDescr*(dest: cusparseMatDescr_t; src: cusparseMatDescr_t): cusparseStatus_t {.
      cdecl, importc: "cusparseCopyMatDescr", dyn.}
  proc cusparseSetMatType*(descrA: cusparseMatDescr_t; `type`: cusparseMatrixType_t): cusparseStatus_t {.
      cdecl, importc: "cusparseSetMatType", dyn.}
  proc cusparseGetMatType*(descrA: cusparseMatDescr_t): cusparseMatrixType_t {.
      cdecl, importc: "cusparseGetMatType", dyn.}
  proc cusparseSetMatFillMode*(descrA: cusparseMatDescr_t;
                              fillMode: cusparseFillMode_t): cusparseStatus_t {.
      cdecl, importc: "cusparseSetMatFillMode", dyn.}
  proc cusparseGetMatFillMode*(descrA: cusparseMatDescr_t): cusparseFillMode_t {.
      cdecl, importc: "cusparseGetMatFillMode", dyn.}
  proc cusparseSetMatDiagType*(descrA: cusparseMatDescr_t;
                              diagType: cusparseDiagType_t): cusparseStatus_t {.
      cdecl, importc: "cusparseSetMatDiagType", dyn.}
  proc cusparseGetMatDiagType*(descrA: cusparseMatDescr_t): cusparseDiagType_t {.
      cdecl, importc: "cusparseGetMatDiagType", dyn.}
  proc cusparseSetMatIndexBase*(descrA: cusparseMatDescr_t;
                               base: cusparseIndexBase_t): cusparseStatus_t {.
      cdecl, importc: "cusparseSetMatIndexBase", dyn.}
  proc cusparseGetMatIndexBase*(descrA: cusparseMatDescr_t): cusparseIndexBase_t {.
      cdecl, importc: "cusparseGetMatIndexBase", dyn.}
  ##  sparse triangular solve and incomplete-LU and Cholesky (algorithm 1)
  proc cusparseCreateSolveAnalysisInfo*(info: ptr cusparseSolveAnalysisInfo_t): cusparseStatus_t {.
      cdecl, importc: "cusparseCreateSolveAnalysisInfo", dyn.}
  proc cusparseDestroySolveAnalysisInfo*(info: cusparseSolveAnalysisInfo_t): cusparseStatus_t {.
      cdecl, importc: "cusparseDestroySolveAnalysisInfo", dyn.}
  proc cusparseGetLevelInfo*(handle: cusparseHandle_t;
                            info: cusparseSolveAnalysisInfo_t; nlevels: ptr cint;
                            levelPtr: ptr ptr cint; levelInd: ptr ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseGetLevelInfo", dyn.}
  ##  sparse triangular solve (algorithm 2)
  proc cusparseCreateCsrsv2Info*(info: ptr csrsv2Info_t): cusparseStatus_t {.cdecl,
      importc: "cusparseCreateCsrsv2Info", dyn.}
  proc cusparseDestroyCsrsv2Info*(info: csrsv2Info_t): cusparseStatus_t {.cdecl,
      importc: "cusparseDestroyCsrsv2Info", dyn.}
  ##  incomplete Cholesky (algorithm 2)
  proc cusparseCreateCsric02Info*(info: ptr csric02Info_t): cusparseStatus_t {.cdecl,
      importc: "cusparseCreateCsric02Info", dyn.}
  proc cusparseDestroyCsric02Info*(info: csric02Info_t): cusparseStatus_t {.cdecl,
      importc: "cusparseDestroyCsric02Info", dyn.}
  proc cusparseCreateBsric02Info*(info: ptr bsric02Info_t): cusparseStatus_t {.cdecl,
      importc: "cusparseCreateBsric02Info", dyn.}
  proc cusparseDestroyBsric02Info*(info: bsric02Info_t): cusparseStatus_t {.cdecl,
      importc: "cusparseDestroyBsric02Info", dyn.}
  ##  incomplete LU (algorithm 2)
  proc cusparseCreateCsrilu02Info*(info: ptr csrilu02Info_t): cusparseStatus_t {.
      cdecl, importc: "cusparseCreateCsrilu02Info", dyn.}
  proc cusparseDestroyCsrilu02Info*(info: csrilu02Info_t): cusparseStatus_t {.cdecl,
      importc: "cusparseDestroyCsrilu02Info", dyn.}
  proc cusparseCreateBsrilu02Info*(info: ptr bsrilu02Info_t): cusparseStatus_t {.
      cdecl, importc: "cusparseCreateBsrilu02Info", dyn.}
  proc cusparseDestroyBsrilu02Info*(info: bsrilu02Info_t): cusparseStatus_t {.cdecl,
      importc: "cusparseDestroyBsrilu02Info", dyn.}
  ##  block-CSR triangular solve (algorithm 2)
  proc cusparseCreateBsrsv2Info*(info: ptr bsrsv2Info_t): cusparseStatus_t {.cdecl,
      importc: "cusparseCreateBsrsv2Info", dyn.}
  proc cusparseDestroyBsrsv2Info*(info: bsrsv2Info_t): cusparseStatus_t {.cdecl,
      importc: "cusparseDestroyBsrsv2Info", dyn.}
  proc cusparseCreateBsrsm2Info*(info: ptr bsrsm2Info_t): cusparseStatus_t {.cdecl,
      importc: "cusparseCreateBsrsm2Info", dyn.}
  proc cusparseDestroyBsrsm2Info*(info: bsrsm2Info_t): cusparseStatus_t {.cdecl,
      importc: "cusparseDestroyBsrsm2Info", dyn.}
  ##  hybrid (HYB) format
  proc cusparseCreateHybMat*(hybA: ptr cusparseHybMat_t): cusparseStatus_t {.cdecl,
      importc: "cusparseCreateHybMat", dyn.}
  proc cusparseDestroyHybMat*(hybA: cusparseHybMat_t): cusparseStatus_t {.cdecl,
      importc: "cusparseDestroyHybMat", dyn.}
  ##  sorting information
  proc cusparseCreateCsru2csrInfo*(info: ptr csru2csrInfo_t): cusparseStatus_t {.
      cdecl, importc: "cusparseCreateCsru2csrInfo", dyn.}
  proc cusparseDestroyCsru2csrInfo*(info: csru2csrInfo_t): cusparseStatus_t {.cdecl,
      importc: "cusparseDestroyCsru2csrInfo", dyn.}
  ##  coloring info
  proc cusparseCreateColorInfo*(info: ptr cusparseColorInfo_t): cusparseStatus_t {.
      cdecl, importc: "cusparseCreateColorInfo", dyn.}
  proc cusparseDestroyColorInfo*(info: cusparseColorInfo_t): cusparseStatus_t {.
      cdecl, importc: "cusparseDestroyColorInfo", dyn.}
  proc cusparseSetColorAlgs*(info: cusparseColorInfo_t; alg: cusparseColorAlg_t): cusparseStatus_t {.
      cdecl, importc: "cusparseSetColorAlgs", dyn.}
  proc cusparseGetColorAlgs*(info: cusparseColorInfo_t; alg: ptr cusparseColorAlg_t): cusparseStatus_t {.
      cdecl, importc: "cusparseGetColorAlgs", dyn.}
  ##  --- Sparse Level 1 routines ---
  ##  Description: Addition of a scalar multiple of a sparse vector x  
  ##    and a dense vector y.
  proc cusparseSaxpyi*(handle: cusparseHandle_t; nnz: cint; alpha: ptr cfloat;
                      xVal: ptr cfloat; xInd: ptr cint; y: ptr cfloat;
                      idxBase: cusparseIndexBase_t): cusparseStatus_t {.cdecl,
      importc: "cusparseSaxpyi", dyn.}
  proc cusparseDaxpyi*(handle: cusparseHandle_t; nnz: cint; alpha: ptr cdouble;
                      xVal: ptr cdouble; xInd: ptr cint; y: ptr cdouble;
                      idxBase: cusparseIndexBase_t): cusparseStatus_t {.cdecl,
      importc: "cusparseDaxpyi", dyn.}
  proc cusparseCaxpyi*(handle: cusparseHandle_t; nnz: cint; alpha: ptr cuComplex;
                      xVal: ptr cuComplex; xInd: ptr cint; y: ptr cuComplex;
                      idxBase: cusparseIndexBase_t): cusparseStatus_t {.cdecl,
      importc: "cusparseCaxpyi", dyn.}
  proc cusparseZaxpyi*(handle: cusparseHandle_t; nnz: cint;
                      alpha: ptr cuDoubleComplex; xVal: ptr cuDoubleComplex;
                      xInd: ptr cint; y: ptr cuDoubleComplex;
                      idxBase: cusparseIndexBase_t): cusparseStatus_t {.cdecl,
      importc: "cusparseZaxpyi", dyn.}
  ##  Description: dot product of a sparse vector x and a dense vector y.
  proc cusparseSdoti*(handle: cusparseHandle_t; nnz: cint; xVal: ptr cfloat;
                     xInd: ptr cint; y: ptr cfloat; resultDevHostPtr: ptr cfloat;
                     idxBase: cusparseIndexBase_t): cusparseStatus_t {.cdecl,
      importc: "cusparseSdoti", dyn.}
  proc cusparseDdoti*(handle: cusparseHandle_t; nnz: cint; xVal: ptr cdouble;
                     xInd: ptr cint; y: ptr cdouble; resultDevHostPtr: ptr cdouble;
                     idxBase: cusparseIndexBase_t): cusparseStatus_t {.cdecl,
      importc: "cusparseDdoti", dyn.}
  proc cusparseCdoti*(handle: cusparseHandle_t; nnz: cint; xVal: ptr cuComplex;
                     xInd: ptr cint; y: ptr cuComplex;
                     resultDevHostPtr: ptr cuComplex; idxBase: cusparseIndexBase_t): cusparseStatus_t {.
      cdecl, importc: "cusparseCdoti", dyn.}
  proc cusparseZdoti*(handle: cusparseHandle_t; nnz: cint; xVal: ptr cuDoubleComplex;
                     xInd: ptr cint; y: ptr cuDoubleComplex;
                     resultDevHostPtr: ptr cuDoubleComplex;
                     idxBase: cusparseIndexBase_t): cusparseStatus_t {.cdecl,
      importc: "cusparseZdoti", dyn.}
  ##  Description: dot product of complex conjugate of a sparse vector x
  ##    and a dense vector y.
  proc cusparseCdotci*(handle: cusparseHandle_t; nnz: cint; xVal: ptr cuComplex;
                      xInd: ptr cint; y: ptr cuComplex;
                      resultDevHostPtr: ptr cuComplex; idxBase: cusparseIndexBase_t): cusparseStatus_t {.
      cdecl, importc: "cusparseCdotci", dyn.}
  proc cusparseZdotci*(handle: cusparseHandle_t; nnz: cint;
                      xVal: ptr cuDoubleComplex; xInd: ptr cint;
                      y: ptr cuDoubleComplex;
                      resultDevHostPtr: ptr cuDoubleComplex;
                      idxBase: cusparseIndexBase_t): cusparseStatus_t {.cdecl,
      importc: "cusparseZdotci", dyn.}
  ##  Description: Gather of non-zero elements from dense vector y into 
  ##    sparse vector x.
  proc cusparseSgthr*(handle: cusparseHandle_t; nnz: cint; y: ptr cfloat;
                     xVal: ptr cfloat; xInd: ptr cint; idxBase: cusparseIndexBase_t): cusparseStatus_t {.
      cdecl, importc: "cusparseSgthr", dyn.}
  proc cusparseDgthr*(handle: cusparseHandle_t; nnz: cint; y: ptr cdouble;
                     xVal: ptr cdouble; xInd: ptr cint; idxBase: cusparseIndexBase_t): cusparseStatus_t {.
      cdecl, importc: "cusparseDgthr", dyn.}
  proc cusparseCgthr*(handle: cusparseHandle_t; nnz: cint; y: ptr cuComplex;
                     xVal: ptr cuComplex; xInd: ptr cint; idxBase: cusparseIndexBase_t): cusparseStatus_t {.
      cdecl, importc: "cusparseCgthr", dyn.}
  proc cusparseZgthr*(handle: cusparseHandle_t; nnz: cint; y: ptr cuDoubleComplex;
                     xVal: ptr cuDoubleComplex; xInd: ptr cint;
                     idxBase: cusparseIndexBase_t): cusparseStatus_t {.cdecl,
      importc: "cusparseZgthr", dyn.}
  ##  Description: Gather of non-zero elements from desne vector y into 
  ##    sparse vector x (also replacing these elements in y by zeros).
  proc cusparseSgthrz*(handle: cusparseHandle_t; nnz: cint; y: ptr cfloat;
                      xVal: ptr cfloat; xInd: ptr cint; idxBase: cusparseIndexBase_t): cusparseStatus_t {.
      cdecl, importc: "cusparseSgthrz", dyn.}
  proc cusparseDgthrz*(handle: cusparseHandle_t; nnz: cint; y: ptr cdouble;
                      xVal: ptr cdouble; xInd: ptr cint; idxBase: cusparseIndexBase_t): cusparseStatus_t {.
      cdecl, importc: "cusparseDgthrz", dyn.}
  proc cusparseCgthrz*(handle: cusparseHandle_t; nnz: cint; y: ptr cuComplex;
                      xVal: ptr cuComplex; xInd: ptr cint;
                      idxBase: cusparseIndexBase_t): cusparseStatus_t {.cdecl,
      importc: "cusparseCgthrz", dyn.}
  proc cusparseZgthrz*(handle: cusparseHandle_t; nnz: cint; y: ptr cuDoubleComplex;
                      xVal: ptr cuDoubleComplex; xInd: ptr cint;
                      idxBase: cusparseIndexBase_t): cusparseStatus_t {.cdecl,
      importc: "cusparseZgthrz", dyn.}
  ##  Description: Scatter of elements of the sparse vector x into 
  ##    dense vector y.
  proc cusparseSsctr*(handle: cusparseHandle_t; nnz: cint; xVal: ptr cfloat;
                     xInd: ptr cint; y: ptr cfloat; idxBase: cusparseIndexBase_t): cusparseStatus_t {.
      cdecl, importc: "cusparseSsctr", dyn.}
  proc cusparseDsctr*(handle: cusparseHandle_t; nnz: cint; xVal: ptr cdouble;
                     xInd: ptr cint; y: ptr cdouble; idxBase: cusparseIndexBase_t): cusparseStatus_t {.
      cdecl, importc: "cusparseDsctr", dyn.}
  proc cusparseCsctr*(handle: cusparseHandle_t; nnz: cint; xVal: ptr cuComplex;
                     xInd: ptr cint; y: ptr cuComplex; idxBase: cusparseIndexBase_t): cusparseStatus_t {.
      cdecl, importc: "cusparseCsctr", dyn.}
  proc cusparseZsctr*(handle: cusparseHandle_t; nnz: cint; xVal: ptr cuDoubleComplex;
                     xInd: ptr cint; y: ptr cuDoubleComplex;
                     idxBase: cusparseIndexBase_t): cusparseStatus_t {.cdecl,
      importc: "cusparseZsctr", dyn.}
  ##  Description: Givens rotation, where c and s are cosine and sine, 
  ##    x and y are sparse and dense vectors, respectively.
  proc cusparseSroti*(handle: cusparseHandle_t; nnz: cint; xVal: ptr cfloat;
                     xInd: ptr cint; y: ptr cfloat; c: ptr cfloat; s: ptr cfloat;
                     idxBase: cusparseIndexBase_t): cusparseStatus_t {.cdecl,
      importc: "cusparseSroti", dyn.}
  proc cusparseDroti*(handle: cusparseHandle_t; nnz: cint; xVal: ptr cdouble;
                     xInd: ptr cint; y: ptr cdouble; c: ptr cdouble; s: ptr cdouble;
                     idxBase: cusparseIndexBase_t): cusparseStatus_t {.cdecl,
      importc: "cusparseDroti", dyn.}
  ##  --- Sparse Level 2 routines ---
  proc cusparseSgemvi*(handle: cusparseHandle_t; transA: cusparseOperation_t;
                      m: cint; n: cint; alpha: ptr cfloat; A: ptr cfloat; lda: cint;
                      nnz: cint; xVal: ptr cfloat; xInd: ptr cint; beta: ptr cfloat;
                      y: ptr cfloat; idxBase: cusparseIndexBase_t; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseSgemvi", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cusparseSgemvi_bufferSize*(handle: cusparseHandle_t;
                                 transA: cusparseOperation_t; m: cint; n: cint;
                                 nnz: cint; pBufferSize: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseSgemvi_bufferSize", dyn.}
  proc cusparseDgemvi*(handle: cusparseHandle_t; transA: cusparseOperation_t;
                      m: cint; n: cint; alpha: ptr cdouble; A: ptr cdouble; lda: cint;
                      nnz: cint; xVal: ptr cdouble; xInd: ptr cint; beta: ptr cdouble;
                      y: ptr cdouble; idxBase: cusparseIndexBase_t; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseDgemvi", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cusparseDgemvi_bufferSize*(handle: cusparseHandle_t;
                                 transA: cusparseOperation_t; m: cint; n: cint;
                                 nnz: cint; pBufferSize: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseDgemvi_bufferSize", dyn.}
  proc cusparseCgemvi*(handle: cusparseHandle_t; transA: cusparseOperation_t;
                      m: cint; n: cint; alpha: ptr cuComplex; A: ptr cuComplex; lda: cint;
                      nnz: cint; xVal: ptr cuComplex; xInd: ptr cint;
                      beta: ptr cuComplex; y: ptr cuComplex;
                      idxBase: cusparseIndexBase_t; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseCgemvi", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cusparseCgemvi_bufferSize*(handle: cusparseHandle_t;
                                 transA: cusparseOperation_t; m: cint; n: cint;
                                 nnz: cint; pBufferSize: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseCgemvi_bufferSize", dyn.}
  proc cusparseZgemvi*(handle: cusparseHandle_t; transA: cusparseOperation_t;
                      m: cint; n: cint; alpha: ptr cuDoubleComplex;
                      A: ptr cuDoubleComplex; lda: cint; nnz: cint;
                      xVal: ptr cuDoubleComplex; xInd: ptr cint;
                      beta: ptr cuDoubleComplex; y: ptr cuDoubleComplex;
                      idxBase: cusparseIndexBase_t; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseZgemvi", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cusparseZgemvi_bufferSize*(handle: cusparseHandle_t;
                                 transA: cusparseOperation_t; m: cint; n: cint;
                                 nnz: cint; pBufferSize: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseZgemvi_bufferSize", dyn.}
  ##  Description: Matrix-vector multiplication  y = alpha * op(A) * x  + beta * y, 
  ##    where A is a sparse matrix in CSR storage format, x and y are dense vectors.
  proc cusparseScsrmv*(handle: cusparseHandle_t; transA: cusparseOperation_t;
                      m: cint; n: cint; nnz: cint; alpha: ptr cfloat;
                      descrA: cusparseMatDescr_t; csrSortedValA: ptr cfloat;
                      csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                      x: ptr cfloat; beta: ptr cfloat; y: ptr cfloat): cusparseStatus_t {.
      cdecl, importc: "cusparseScsrmv", dyn.}
  proc cusparseDcsrmv*(handle: cusparseHandle_t; transA: cusparseOperation_t;
                      m: cint; n: cint; nnz: cint; alpha: ptr cdouble;
                      descrA: cusparseMatDescr_t; csrSortedValA: ptr cdouble;
                      csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                      x: ptr cdouble; beta: ptr cdouble; y: ptr cdouble): cusparseStatus_t {.
      cdecl, importc: "cusparseDcsrmv", dyn.}
  proc cusparseCcsrmv*(handle: cusparseHandle_t; transA: cusparseOperation_t;
                      m: cint; n: cint; nnz: cint; alpha: ptr cuComplex;
                      descrA: cusparseMatDescr_t; csrSortedValA: ptr cuComplex;
                      csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                      x: ptr cuComplex; beta: ptr cuComplex; y: ptr cuComplex): cusparseStatus_t {.
      cdecl, importc: "cusparseCcsrmv", dyn.}
  proc cusparseZcsrmv*(handle: cusparseHandle_t; transA: cusparseOperation_t;
                      m: cint; n: cint; nnz: cint; alpha: ptr cuDoubleComplex;
                      descrA: cusparseMatDescr_t;
                      csrSortedValA: ptr cuDoubleComplex;
                      csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                      x: ptr cuDoubleComplex; beta: ptr cuDoubleComplex;
                      y: ptr cuDoubleComplex): cusparseStatus_t {.cdecl,
      importc: "cusparseZcsrmv", dyn.}
  ## Returns number of bytes
  proc cusparseCsrmvEx_bufferSize*(handle: cusparseHandle_t;
                                  alg: cusparseAlgMode_t;
                                  transA: cusparseOperation_t; m: cint; n: cint;
                                  nnz: cint; alpha: pointer;
                                  alphatype: cudaDataType;
                                  descrA: cusparseMatDescr_t; csrValA: pointer;
                                  csrValAtype: cudaDataType; csrRowPtrA: ptr cint;
                                  csrColIndA: ptr cint; x: pointer;
                                  xtype: cudaDataType; beta: pointer;
                                  betatype: cudaDataType; y: pointer;
                                  ytype: cudaDataType;
                                  executiontype: cudaDataType;
                                  bufferSizeInBytes: ptr csize): cusparseStatus_t {.
      cdecl, importc: "cusparseCsrmvEx_bufferSize", dyn.}
  proc cusparseCsrmvEx*(handle: cusparseHandle_t; alg: cusparseAlgMode_t;
                       transA: cusparseOperation_t; m: cint; n: cint; nnz: cint;
                       alpha: pointer; alphatype: cudaDataType;
                       descrA: cusparseMatDescr_t; csrValA: pointer;
                       csrValAtype: cudaDataType; csrRowPtrA: ptr cint;
                       csrColIndA: ptr cint; x: pointer; xtype: cudaDataType;
                       beta: pointer; betatype: cudaDataType; y: pointer;
                       ytype: cudaDataType; executiontype: cudaDataType;
                       buffer: pointer): cusparseStatus_t {.cdecl,
      importc: "cusparseCsrmvEx", dyn.}
  ##  Description: Matrix-vector multiplication  y = alpha * op(A) * x  + beta * y, 
  ##    where A is a sparse matrix in CSR storage format, x and y are dense vectors
  ##    using a Merge Path load-balancing implementation.
  proc cusparseScsrmv_mp*(handle: cusparseHandle_t; transA: cusparseOperation_t;
                         m: cint; n: cint; nnz: cint; alpha: ptr cfloat;
                         descrA: cusparseMatDescr_t; csrSortedValA: ptr cfloat;
                         csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                         x: ptr cfloat; beta: ptr cfloat; y: ptr cfloat): cusparseStatus_t {.
      cdecl, importc: "cusparseScsrmv_mp", dyn.}
  proc cusparseDcsrmv_mp*(handle: cusparseHandle_t; transA: cusparseOperation_t;
                         m: cint; n: cint; nnz: cint; alpha: ptr cdouble;
                         descrA: cusparseMatDescr_t; csrSortedValA: ptr cdouble;
                         csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                         x: ptr cdouble; beta: ptr cdouble; y: ptr cdouble): cusparseStatus_t {.
      cdecl, importc: "cusparseDcsrmv_mp", dyn.}
  proc cusparseCcsrmv_mp*(handle: cusparseHandle_t; transA: cusparseOperation_t;
                         m: cint; n: cint; nnz: cint; alpha: ptr cuComplex;
                         descrA: cusparseMatDescr_t; csrSortedValA: ptr cuComplex;
                         csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                         x: ptr cuComplex; beta: ptr cuComplex; y: ptr cuComplex): cusparseStatus_t {.
      cdecl, importc: "cusparseCcsrmv_mp", dyn.}
  proc cusparseZcsrmv_mp*(handle: cusparseHandle_t; transA: cusparseOperation_t;
                         m: cint; n: cint; nnz: cint; alpha: ptr cuDoubleComplex;
                         descrA: cusparseMatDescr_t;
                         csrSortedValA: ptr cuDoubleComplex;
                         csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                         x: ptr cuDoubleComplex; beta: ptr cuDoubleComplex;
                         y: ptr cuDoubleComplex): cusparseStatus_t {.cdecl,
      importc: "cusparseZcsrmv_mp", dyn.}
  ##  Description: Matrix-vector multiplication  y = alpha * op(A) * x  + beta * y, 
  ##    where A is a sparse matrix in HYB storage format, x and y are dense vectors.
  proc cusparseShybmv*(handle: cusparseHandle_t; transA: cusparseOperation_t;
                      alpha: ptr cfloat; descrA: cusparseMatDescr_t;
                      hybA: cusparseHybMat_t; x: ptr cfloat; beta: ptr cfloat;
                      y: ptr cfloat): cusparseStatus_t {.cdecl,
      importc: "cusparseShybmv", dyn.}
  proc cusparseDhybmv*(handle: cusparseHandle_t; transA: cusparseOperation_t;
                      alpha: ptr cdouble; descrA: cusparseMatDescr_t;
                      hybA: cusparseHybMat_t; x: ptr cdouble; beta: ptr cdouble;
                      y: ptr cdouble): cusparseStatus_t {.cdecl,
      importc: "cusparseDhybmv", dyn.}
  proc cusparseChybmv*(handle: cusparseHandle_t; transA: cusparseOperation_t;
                      alpha: ptr cuComplex; descrA: cusparseMatDescr_t;
                      hybA: cusparseHybMat_t; x: ptr cuComplex; beta: ptr cuComplex;
                      y: ptr cuComplex): cusparseStatus_t {.cdecl,
      importc: "cusparseChybmv", dyn.}
  proc cusparseZhybmv*(handle: cusparseHandle_t; transA: cusparseOperation_t;
                      alpha: ptr cuDoubleComplex; descrA: cusparseMatDescr_t;
                      hybA: cusparseHybMat_t; x: ptr cuDoubleComplex;
                      beta: ptr cuDoubleComplex; y: ptr cuDoubleComplex): cusparseStatus_t {.
      cdecl, importc: "cusparseZhybmv", dyn.}
  ##  Description: Matrix-vector multiplication  y = alpha * op(A) * x  + beta * y, 
  ##    where A is a sparse matrix in BSR storage format, x and y are dense vectors.
  proc cusparseSbsrmv*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                      transA: cusparseOperation_t; mb: cint; nb: cint; nnzb: cint;
                      alpha: ptr cfloat; descrA: cusparseMatDescr_t;
                      bsrSortedValA: ptr cfloat; bsrSortedRowPtrA: ptr cint;
                      bsrSortedColIndA: ptr cint; blockDim: cint; x: ptr cfloat;
                      beta: ptr cfloat; y: ptr cfloat): cusparseStatus_t {.cdecl,
      importc: "cusparseSbsrmv", dyn.}
  proc cusparseDbsrmv*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                      transA: cusparseOperation_t; mb: cint; nb: cint; nnzb: cint;
                      alpha: ptr cdouble; descrA: cusparseMatDescr_t;
                      bsrSortedValA: ptr cdouble; bsrSortedRowPtrA: ptr cint;
                      bsrSortedColIndA: ptr cint; blockDim: cint; x: ptr cdouble;
                      beta: ptr cdouble; y: ptr cdouble): cusparseStatus_t {.cdecl,
      importc: "cusparseDbsrmv", dyn.}
  proc cusparseCbsrmv*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                      transA: cusparseOperation_t; mb: cint; nb: cint; nnzb: cint;
                      alpha: ptr cuComplex; descrA: cusparseMatDescr_t;
                      bsrSortedValA: ptr cuComplex; bsrSortedRowPtrA: ptr cint;
                      bsrSortedColIndA: ptr cint; blockDim: cint; x: ptr cuComplex;
                      beta: ptr cuComplex; y: ptr cuComplex): cusparseStatus_t {.cdecl,
      importc: "cusparseCbsrmv", dyn.}
  proc cusparseZbsrmv*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                      transA: cusparseOperation_t; mb: cint; nb: cint; nnzb: cint;
                      alpha: ptr cuDoubleComplex; descrA: cusparseMatDescr_t;
                      bsrSortedValA: ptr cuDoubleComplex;
                      bsrSortedRowPtrA: ptr cint; bsrSortedColIndA: ptr cint;
                      blockDim: cint; x: ptr cuDoubleComplex;
                      beta: ptr cuDoubleComplex; y: ptr cuDoubleComplex): cusparseStatus_t {.
      cdecl, importc: "cusparseZbsrmv", dyn.}
  ##  Description: Matrix-vector multiplication  y = alpha * op(A) * x  + beta * y, 
  ##    where A is a sparse matrix in extended BSR storage format, x and y are dense 
  ##    vectors.
  proc cusparseSbsrxmv*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                       transA: cusparseOperation_t; sizeOfMask: cint; mb: cint;
                       nb: cint; nnzb: cint; alpha: ptr cfloat;
                       descrA: cusparseMatDescr_t; bsrSortedValA: ptr cfloat;
                       bsrSortedMaskPtrA: ptr cint; bsrSortedRowPtrA: ptr cint;
                       bsrSortedEndPtrA: ptr cint; bsrSortedColIndA: ptr cint;
                       blockDim: cint; x: ptr cfloat; beta: ptr cfloat; y: ptr cfloat): cusparseStatus_t {.
      cdecl, importc: "cusparseSbsrxmv", dyn.}
  proc cusparseDbsrxmv*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                       transA: cusparseOperation_t; sizeOfMask: cint; mb: cint;
                       nb: cint; nnzb: cint; alpha: ptr cdouble;
                       descrA: cusparseMatDescr_t; bsrSortedValA: ptr cdouble;
                       bsrSortedMaskPtrA: ptr cint; bsrSortedRowPtrA: ptr cint;
                       bsrSortedEndPtrA: ptr cint; bsrSortedColIndA: ptr cint;
                       blockDim: cint; x: ptr cdouble; beta: ptr cdouble; y: ptr cdouble): cusparseStatus_t {.
      cdecl, importc: "cusparseDbsrxmv", dyn.}
  proc cusparseCbsrxmv*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                       transA: cusparseOperation_t; sizeOfMask: cint; mb: cint;
                       nb: cint; nnzb: cint; alpha: ptr cuComplex;
                       descrA: cusparseMatDescr_t; bsrSortedValA: ptr cuComplex;
                       bsrSortedMaskPtrA: ptr cint; bsrSortedRowPtrA: ptr cint;
                       bsrSortedEndPtrA: ptr cint; bsrSortedColIndA: ptr cint;
                       blockDim: cint; x: ptr cuComplex; beta: ptr cuComplex;
                       y: ptr cuComplex): cusparseStatus_t {.cdecl,
      importc: "cusparseCbsrxmv", dyn.}
  proc cusparseZbsrxmv*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                       transA: cusparseOperation_t; sizeOfMask: cint; mb: cint;
                       nb: cint; nnzb: cint; alpha: ptr cuDoubleComplex;
                       descrA: cusparseMatDescr_t;
                       bsrSortedValA: ptr cuDoubleComplex;
                       bsrSortedMaskPtrA: ptr cint; bsrSortedRowPtrA: ptr cint;
                       bsrSortedEndPtrA: ptr cint; bsrSortedColIndA: ptr cint;
                       blockDim: cint; x: ptr cuDoubleComplex;
                       beta: ptr cuDoubleComplex; y: ptr cuDoubleComplex): cusparseStatus_t {.
      cdecl, importc: "cusparseZbsrxmv", dyn.}
  ##  Description: Solution of triangular linear system op(A) * x = alpha * f, 
  ##    where A is a sparse matrix in CSR storage format, rhs f and solution x 
  ##    are dense vectors. This routine implements algorithm 1 for the solve.
  proc cusparseCsrsv_analysisEx*(handle: cusparseHandle_t;
                                transA: cusparseOperation_t; m: cint; nnz: cint;
                                descrA: cusparseMatDescr_t;
                                csrSortedValA: pointer;
                                csrSortedValAtype: cudaDataType;
                                csrSortedRowPtrA: ptr cint;
                                csrSortedColIndA: ptr cint;
                                info: cusparseSolveAnalysisInfo_t;
                                executiontype: cudaDataType): cusparseStatus_t {.
      cdecl, importc: "cusparseCsrsv_analysisEx", dyn.}
  proc cusparseScsrsv_analysis*(handle: cusparseHandle_t;
                               transA: cusparseOperation_t; m: cint; nnz: cint;
                               descrA: cusparseMatDescr_t;
                               csrSortedValA: ptr cfloat;
                               csrSortedRowPtrA: ptr cint;
                               csrSortedColIndA: ptr cint;
                               info: cusparseSolveAnalysisInfo_t): cusparseStatus_t {.
      cdecl, importc: "cusparseScsrsv_analysis", dyn.}
  proc cusparseDcsrsv_analysis*(handle: cusparseHandle_t;
                               transA: cusparseOperation_t; m: cint; nnz: cint;
                               descrA: cusparseMatDescr_t;
                               csrSortedValA: ptr cdouble;
                               csrSortedRowPtrA: ptr cint;
                               csrSortedColIndA: ptr cint;
                               info: cusparseSolveAnalysisInfo_t): cusparseStatus_t {.
      cdecl, importc: "cusparseDcsrsv_analysis", dyn.}
  proc cusparseCcsrsv_analysis*(handle: cusparseHandle_t;
                               transA: cusparseOperation_t; m: cint; nnz: cint;
                               descrA: cusparseMatDescr_t;
                               csrSortedValA: ptr cuComplex;
                               csrSortedRowPtrA: ptr cint;
                               csrSortedColIndA: ptr cint;
                               info: cusparseSolveAnalysisInfo_t): cusparseStatus_t {.
      cdecl, importc: "cusparseCcsrsv_analysis", dyn.}
  proc cusparseZcsrsv_analysis*(handle: cusparseHandle_t;
                               transA: cusparseOperation_t; m: cint; nnz: cint;
                               descrA: cusparseMatDescr_t;
                               csrSortedValA: ptr cuDoubleComplex;
                               csrSortedRowPtrA: ptr cint;
                               csrSortedColIndA: ptr cint;
                               info: cusparseSolveAnalysisInfo_t): cusparseStatus_t {.
      cdecl, importc: "cusparseZcsrsv_analysis", dyn.}
  proc cusparseCsrsv_solveEx*(handle: cusparseHandle_t;
                             transA: cusparseOperation_t; m: cint; alpha: pointer;
                             alphatype: cudaDataType; descrA: cusparseMatDescr_t;
                             csrSortedValA: pointer;
                             csrSortedValAtype: cudaDataType;
                             csrSortedRowPtrA: ptr cint;
                             csrSortedColIndA: ptr cint;
                             info: cusparseSolveAnalysisInfo_t; f: pointer;
                             ftype: cudaDataType; x: pointer; xtype: cudaDataType;
                             executiontype: cudaDataType): cusparseStatus_t {.
      cdecl, importc: "cusparseCsrsv_solveEx", dyn.}
  proc cusparseScsrsv_solve*(handle: cusparseHandle_t; transA: cusparseOperation_t;
                            m: cint; alpha: ptr cfloat; descrA: cusparseMatDescr_t;
                            csrSortedValA: ptr cfloat; csrSortedRowPtrA: ptr cint;
                            csrSortedColIndA: ptr cint;
                            info: cusparseSolveAnalysisInfo_t; f: ptr cfloat;
                            x: ptr cfloat): cusparseStatus_t {.cdecl,
      importc: "cusparseScsrsv_solve", dyn.}
  proc cusparseDcsrsv_solve*(handle: cusparseHandle_t; transA: cusparseOperation_t;
                            m: cint; alpha: ptr cdouble; descrA: cusparseMatDescr_t;
                            csrSortedValA: ptr cdouble; csrSortedRowPtrA: ptr cint;
                            csrSortedColIndA: ptr cint;
                            info: cusparseSolveAnalysisInfo_t; f: ptr cdouble;
                            x: ptr cdouble): cusparseStatus_t {.cdecl,
      importc: "cusparseDcsrsv_solve", dyn.}
  proc cusparseCcsrsv_solve*(handle: cusparseHandle_t; transA: cusparseOperation_t;
                            m: cint; alpha: ptr cuComplex;
                            descrA: cusparseMatDescr_t;
                            csrSortedValA: ptr cuComplex;
                            csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                            info: cusparseSolveAnalysisInfo_t; f: ptr cuComplex;
                            x: ptr cuComplex): cusparseStatus_t {.cdecl,
      importc: "cusparseCcsrsv_solve", dyn.}
  proc cusparseZcsrsv_solve*(handle: cusparseHandle_t; transA: cusparseOperation_t;
                            m: cint; alpha: ptr cuDoubleComplex;
                            descrA: cusparseMatDescr_t;
                            csrSortedValA: ptr cuDoubleComplex;
                            csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                            info: cusparseSolveAnalysisInfo_t;
                            f: ptr cuDoubleComplex; x: ptr cuDoubleComplex): cusparseStatus_t {.
      cdecl, importc: "cusparseZcsrsv_solve", dyn.}
  ##  Description: Solution of triangular linear system op(A) * x = alpha * f, 
  ##    where A is a sparse matrix in CSR storage format, rhs f and solution y 
  ##    are dense vectors. This routine implements algorithm 1 for this problem. 
  ##    Also, it provides a utility function to query size of buffer used.
  proc cusparseXcsrsv2_zeroPivot*(handle: cusparseHandle_t; info: csrsv2Info_t;
                                 position: ptr cint): cusparseStatus_t {.cdecl,
      importc: "cusparseXcsrsv2_zeroPivot", dyn.}
  proc cusparseScsrsv2_bufferSize*(handle: cusparseHandle_t;
                                  transA: cusparseOperation_t; m: cint; nnz: cint;
                                  descrA: cusparseMatDescr_t;
                                  csrSortedValA: ptr cfloat;
                                  csrSortedRowPtrA: ptr cint;
                                  csrSortedColIndA: ptr cint; info: csrsv2Info_t;
                                  pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseScsrsv2_bufferSize", dyn.}
  proc cusparseDcsrsv2_bufferSize*(handle: cusparseHandle_t;
                                  transA: cusparseOperation_t; m: cint; nnz: cint;
                                  descrA: cusparseMatDescr_t;
                                  csrSortedValA: ptr cdouble;
                                  csrSortedRowPtrA: ptr cint;
                                  csrSortedColIndA: ptr cint; info: csrsv2Info_t;
                                  pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseDcsrsv2_bufferSize", dyn.}
  proc cusparseCcsrsv2_bufferSize*(handle: cusparseHandle_t;
                                  transA: cusparseOperation_t; m: cint; nnz: cint;
                                  descrA: cusparseMatDescr_t;
                                  csrSortedValA: ptr cuComplex;
                                  csrSortedRowPtrA: ptr cint;
                                  csrSortedColIndA: ptr cint; info: csrsv2Info_t;
                                  pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseCcsrsv2_bufferSize", dyn.}
  proc cusparseZcsrsv2_bufferSize*(handle: cusparseHandle_t;
                                  transA: cusparseOperation_t; m: cint; nnz: cint;
                                  descrA: cusparseMatDescr_t;
                                  csrSortedValA: ptr cuDoubleComplex;
                                  csrSortedRowPtrA: ptr cint;
                                  csrSortedColIndA: ptr cint; info: csrsv2Info_t;
                                  pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseZcsrsv2_bufferSize", dyn.}
  proc cusparseScsrsv2_bufferSizeExt*(handle: cusparseHandle_t;
                                     transA: cusparseOperation_t; m: cint;
                                     nnz: cint; descrA: cusparseMatDescr_t;
                                     csrSortedValA: ptr cfloat;
                                     csrSortedRowPtrA: ptr cint;
                                     csrSortedColIndA: ptr cint;
                                     info: csrsv2Info_t; pBufferSize: ptr csize): cusparseStatus_t {.
      cdecl, importc: "cusparseScsrsv2_bufferSizeExt", dyn.}
  proc cusparseDcsrsv2_bufferSizeExt*(handle: cusparseHandle_t;
                                     transA: cusparseOperation_t; m: cint;
                                     nnz: cint; descrA: cusparseMatDescr_t;
                                     csrSortedValA: ptr cdouble;
                                     csrSortedRowPtrA: ptr cint;
                                     csrSortedColIndA: ptr cint;
                                     info: csrsv2Info_t; pBufferSize: ptr csize): cusparseStatus_t {.
      cdecl, importc: "cusparseDcsrsv2_bufferSizeExt", dyn.}
  proc cusparseCcsrsv2_bufferSizeExt*(handle: cusparseHandle_t;
                                     transA: cusparseOperation_t; m: cint;
                                     nnz: cint; descrA: cusparseMatDescr_t;
                                     csrSortedValA: ptr cuComplex;
                                     csrSortedRowPtrA: ptr cint;
                                     csrSortedColIndA: ptr cint;
                                     info: csrsv2Info_t; pBufferSize: ptr csize): cusparseStatus_t {.
      cdecl, importc: "cusparseCcsrsv2_bufferSizeExt", dyn.}
  proc cusparseZcsrsv2_bufferSizeExt*(handle: cusparseHandle_t;
                                     transA: cusparseOperation_t; m: cint;
                                     nnz: cint; descrA: cusparseMatDescr_t;
                                     csrSortedValA: ptr cuDoubleComplex;
                                     csrSortedRowPtrA: ptr cint;
                                     csrSortedColIndA: ptr cint;
                                     info: csrsv2Info_t; pBufferSize: ptr csize): cusparseStatus_t {.
      cdecl, importc: "cusparseZcsrsv2_bufferSizeExt", dyn.}
  proc cusparseScsrsv2_analysis*(handle: cusparseHandle_t;
                                transA: cusparseOperation_t; m: cint; nnz: cint;
                                descrA: cusparseMatDescr_t;
                                csrSortedValA: ptr cfloat;
                                csrSortedRowPtrA: ptr cint;
                                csrSortedColIndA: ptr cint; info: csrsv2Info_t;
                                policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseScsrsv2_analysis", dyn.}
  proc cusparseDcsrsv2_analysis*(handle: cusparseHandle_t;
                                transA: cusparseOperation_t; m: cint; nnz: cint;
                                descrA: cusparseMatDescr_t;
                                csrSortedValA: ptr cdouble;
                                csrSortedRowPtrA: ptr cint;
                                csrSortedColIndA: ptr cint; info: csrsv2Info_t;
                                policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseDcsrsv2_analysis", dyn.}
  proc cusparseCcsrsv2_analysis*(handle: cusparseHandle_t;
                                transA: cusparseOperation_t; m: cint; nnz: cint;
                                descrA: cusparseMatDescr_t;
                                csrSortedValA: ptr cuComplex;
                                csrSortedRowPtrA: ptr cint;
                                csrSortedColIndA: ptr cint; info: csrsv2Info_t;
                                policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseCcsrsv2_analysis", dyn.}
  proc cusparseZcsrsv2_analysis*(handle: cusparseHandle_t;
                                transA: cusparseOperation_t; m: cint; nnz: cint;
                                descrA: cusparseMatDescr_t;
                                csrSortedValA: ptr cuDoubleComplex;
                                csrSortedRowPtrA: ptr cint;
                                csrSortedColIndA: ptr cint; info: csrsv2Info_t;
                                policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseZcsrsv2_analysis", dyn.}
  proc cusparseScsrsv2_solve*(handle: cusparseHandle_t;
                             transA: cusparseOperation_t; m: cint; nnz: cint;
                             alpha: ptr cfloat; descrA: cusparseMatDescr_t;
                             csrSortedValA: ptr cfloat; csrSortedRowPtrA: ptr cint;
                             csrSortedColIndA: ptr cint; info: csrsv2Info_t;
                             f: ptr cfloat; x: ptr cfloat;
                             policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseScsrsv2_solve", dyn.}
  proc cusparseDcsrsv2_solve*(handle: cusparseHandle_t;
                             transA: cusparseOperation_t; m: cint; nnz: cint;
                             alpha: ptr cdouble; descrA: cusparseMatDescr_t;
                             csrSortedValA: ptr cdouble;
                             csrSortedRowPtrA: ptr cint;
                             csrSortedColIndA: ptr cint; info: csrsv2Info_t;
                             f: ptr cdouble; x: ptr cdouble;
                             policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseDcsrsv2_solve", dyn.}
  proc cusparseCcsrsv2_solve*(handle: cusparseHandle_t;
                             transA: cusparseOperation_t; m: cint; nnz: cint;
                             alpha: ptr cuComplex; descrA: cusparseMatDescr_t;
                             csrSortedValA: ptr cuComplex;
                             csrSortedRowPtrA: ptr cint;
                             csrSortedColIndA: ptr cint; info: csrsv2Info_t;
                             f: ptr cuComplex; x: ptr cuComplex;
                             policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseCcsrsv2_solve", dyn.}
  proc cusparseZcsrsv2_solve*(handle: cusparseHandle_t;
                             transA: cusparseOperation_t; m: cint; nnz: cint;
                             alpha: ptr cuDoubleComplex;
                             descrA: cusparseMatDescr_t;
                             csrSortedValA: ptr cuDoubleComplex;
                             csrSortedRowPtrA: ptr cint;
                             csrSortedColIndA: ptr cint; info: csrsv2Info_t;
                             f: ptr cuDoubleComplex; x: ptr cuDoubleComplex;
                             policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseZcsrsv2_solve", dyn.}
  ##  Description: Solution of triangular linear system op(A) * x = alpha * f, 
  ##    where A is a sparse matrix in block-CSR storage format, rhs f and solution y 
  ##    are dense vectors. This routine implements algorithm 2 for this problem. 
  ##    Also, it provides a utility function to query size of buffer used.
  proc cusparseXbsrsv2_zeroPivot*(handle: cusparseHandle_t; info: bsrsv2Info_t;
                                 position: ptr cint): cusparseStatus_t {.cdecl,
      importc: "cusparseXbsrsv2_zeroPivot", dyn.}
  proc cusparseSbsrsv2_bufferSize*(handle: cusparseHandle_t;
                                  dirA: cusparseDirection_t;
                                  transA: cusparseOperation_t; mb: cint; nnzb: cint;
                                  descrA: cusparseMatDescr_t;
                                  bsrSortedValA: ptr cfloat;
                                  bsrSortedRowPtrA: ptr cint;
                                  bsrSortedColIndA: ptr cint; blockDim: cint;
                                  info: bsrsv2Info_t; pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseSbsrsv2_bufferSize", dyn.}
  proc cusparseDbsrsv2_bufferSize*(handle: cusparseHandle_t;
                                  dirA: cusparseDirection_t;
                                  transA: cusparseOperation_t; mb: cint; nnzb: cint;
                                  descrA: cusparseMatDescr_t;
                                  bsrSortedValA: ptr cdouble;
                                  bsrSortedRowPtrA: ptr cint;
                                  bsrSortedColIndA: ptr cint; blockDim: cint;
                                  info: bsrsv2Info_t; pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseDbsrsv2_bufferSize", dyn.}
  proc cusparseCbsrsv2_bufferSize*(handle: cusparseHandle_t;
                                  dirA: cusparseDirection_t;
                                  transA: cusparseOperation_t; mb: cint; nnzb: cint;
                                  descrA: cusparseMatDescr_t;
                                  bsrSortedValA: ptr cuComplex;
                                  bsrSortedRowPtrA: ptr cint;
                                  bsrSortedColIndA: ptr cint; blockDim: cint;
                                  info: bsrsv2Info_t; pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseCbsrsv2_bufferSize", dyn.}
  proc cusparseZbsrsv2_bufferSize*(handle: cusparseHandle_t;
                                  dirA: cusparseDirection_t;
                                  transA: cusparseOperation_t; mb: cint; nnzb: cint;
                                  descrA: cusparseMatDescr_t;
                                  bsrSortedValA: ptr cuDoubleComplex;
                                  bsrSortedRowPtrA: ptr cint;
                                  bsrSortedColIndA: ptr cint; blockDim: cint;
                                  info: bsrsv2Info_t; pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseZbsrsv2_bufferSize", dyn.}
  proc cusparseSbsrsv2_bufferSizeExt*(handle: cusparseHandle_t;
                                     dirA: cusparseDirection_t;
                                     transA: cusparseOperation_t; mb: cint;
                                     nnzb: cint; descrA: cusparseMatDescr_t;
                                     bsrSortedValA: ptr cfloat;
                                     bsrSortedRowPtrA: ptr cint;
                                     bsrSortedColIndA: ptr cint; blockSize: cint;
                                     info: bsrsv2Info_t; pBufferSize: ptr csize): cusparseStatus_t {.
      cdecl, importc: "cusparseSbsrsv2_bufferSizeExt", dyn.}
  proc cusparseDbsrsv2_bufferSizeExt*(handle: cusparseHandle_t;
                                     dirA: cusparseDirection_t;
                                     transA: cusparseOperation_t; mb: cint;
                                     nnzb: cint; descrA: cusparseMatDescr_t;
                                     bsrSortedValA: ptr cdouble;
                                     bsrSortedRowPtrA: ptr cint;
                                     bsrSortedColIndA: ptr cint; blockSize: cint;
                                     info: bsrsv2Info_t; pBufferSize: ptr csize): cusparseStatus_t {.
      cdecl, importc: "cusparseDbsrsv2_bufferSizeExt", dyn.}
  proc cusparseCbsrsv2_bufferSizeExt*(handle: cusparseHandle_t;
                                     dirA: cusparseDirection_t;
                                     transA: cusparseOperation_t; mb: cint;
                                     nnzb: cint; descrA: cusparseMatDescr_t;
                                     bsrSortedValA: ptr cuComplex;
                                     bsrSortedRowPtrA: ptr cint;
                                     bsrSortedColIndA: ptr cint; blockSize: cint;
                                     info: bsrsv2Info_t; pBufferSize: ptr csize): cusparseStatus_t {.
      cdecl, importc: "cusparseCbsrsv2_bufferSizeExt", dyn.}
  proc cusparseZbsrsv2_bufferSizeExt*(handle: cusparseHandle_t;
                                     dirA: cusparseDirection_t;
                                     transA: cusparseOperation_t; mb: cint;
                                     nnzb: cint; descrA: cusparseMatDescr_t;
                                     bsrSortedValA: ptr cuDoubleComplex;
                                     bsrSortedRowPtrA: ptr cint;
                                     bsrSortedColIndA: ptr cint; blockSize: cint;
                                     info: bsrsv2Info_t; pBufferSize: ptr csize): cusparseStatus_t {.
      cdecl, importc: "cusparseZbsrsv2_bufferSizeExt", dyn.}
  proc cusparseSbsrsv2_analysis*(handle: cusparseHandle_t;
                                dirA: cusparseDirection_t;
                                transA: cusparseOperation_t; mb: cint; nnzb: cint;
                                descrA: cusparseMatDescr_t;
                                bsrSortedValA: ptr cfloat;
                                bsrSortedRowPtrA: ptr cint;
                                bsrSortedColIndA: ptr cint; blockDim: cint;
                                info: bsrsv2Info_t; policy: cusparseSolvePolicy_t;
                                pBuffer: pointer): cusparseStatus_t {.cdecl,
      importc: "cusparseSbsrsv2_analysis", dyn.}
  proc cusparseDbsrsv2_analysis*(handle: cusparseHandle_t;
                                dirA: cusparseDirection_t;
                                transA: cusparseOperation_t; mb: cint; nnzb: cint;
                                descrA: cusparseMatDescr_t;
                                bsrSortedValA: ptr cdouble;
                                bsrSortedRowPtrA: ptr cint;
                                bsrSortedColIndA: ptr cint; blockDim: cint;
                                info: bsrsv2Info_t; policy: cusparseSolvePolicy_t;
                                pBuffer: pointer): cusparseStatus_t {.cdecl,
      importc: "cusparseDbsrsv2_analysis", dyn.}
  proc cusparseCbsrsv2_analysis*(handle: cusparseHandle_t;
                                dirA: cusparseDirection_t;
                                transA: cusparseOperation_t; mb: cint; nnzb: cint;
                                descrA: cusparseMatDescr_t;
                                bsrSortedValA: ptr cuComplex;
                                bsrSortedRowPtrA: ptr cint;
                                bsrSortedColIndA: ptr cint; blockDim: cint;
                                info: bsrsv2Info_t; policy: cusparseSolvePolicy_t;
                                pBuffer: pointer): cusparseStatus_t {.cdecl,
      importc: "cusparseCbsrsv2_analysis", dyn.}
  proc cusparseZbsrsv2_analysis*(handle: cusparseHandle_t;
                                dirA: cusparseDirection_t;
                                transA: cusparseOperation_t; mb: cint; nnzb: cint;
                                descrA: cusparseMatDescr_t;
                                bsrSortedValA: ptr cuDoubleComplex;
                                bsrSortedRowPtrA: ptr cint;
                                bsrSortedColIndA: ptr cint; blockDim: cint;
                                info: bsrsv2Info_t; policy: cusparseSolvePolicy_t;
                                pBuffer: pointer): cusparseStatus_t {.cdecl,
      importc: "cusparseZbsrsv2_analysis", dyn.}
  proc cusparseSbsrsv2_solve*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                             transA: cusparseOperation_t; mb: cint; nnzb: cint;
                             alpha: ptr cfloat; descrA: cusparseMatDescr_t;
                             bsrSortedValA: ptr cfloat; bsrSortedRowPtrA: ptr cint;
                             bsrSortedColIndA: ptr cint; blockDim: cint;
                             info: bsrsv2Info_t; f: ptr cfloat; x: ptr cfloat;
                             policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseSbsrsv2_solve", dyn.}
  proc cusparseDbsrsv2_solve*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                             transA: cusparseOperation_t; mb: cint; nnzb: cint;
                             alpha: ptr cdouble; descrA: cusparseMatDescr_t;
                             bsrSortedValA: ptr cdouble;
                             bsrSortedRowPtrA: ptr cint;
                             bsrSortedColIndA: ptr cint; blockDim: cint;
                             info: bsrsv2Info_t; f: ptr cdouble; x: ptr cdouble;
                             policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseDbsrsv2_solve", dyn.}
  proc cusparseCbsrsv2_solve*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                             transA: cusparseOperation_t; mb: cint; nnzb: cint;
                             alpha: ptr cuComplex; descrA: cusparseMatDescr_t;
                             bsrSortedValA: ptr cuComplex;
                             bsrSortedRowPtrA: ptr cint;
                             bsrSortedColIndA: ptr cint; blockDim: cint;
                             info: bsrsv2Info_t; f: ptr cuComplex; x: ptr cuComplex;
                             policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseCbsrsv2_solve", dyn.}
  proc cusparseZbsrsv2_solve*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                             transA: cusparseOperation_t; mb: cint; nnzb: cint;
                             alpha: ptr cuDoubleComplex;
                             descrA: cusparseMatDescr_t;
                             bsrSortedValA: ptr cuDoubleComplex;
                             bsrSortedRowPtrA: ptr cint;
                             bsrSortedColIndA: ptr cint; blockDim: cint;
                             info: bsrsv2Info_t; f: ptr cuDoubleComplex;
                             x: ptr cuDoubleComplex; policy: cusparseSolvePolicy_t;
                             pBuffer: pointer): cusparseStatus_t {.cdecl,
      importc: "cusparseZbsrsv2_solve", dyn.}
  ##  Description: Solution of triangular linear system op(A) * x = alpha * f, 
  ##    where A is a sparse matrix in HYB storage format, rhs f and solution x 
  ##    are dense vectors.
  proc cusparseShybsv_analysis*(handle: cusparseHandle_t;
                               transA: cusparseOperation_t;
                               descrA: cusparseMatDescr_t; hybA: cusparseHybMat_t;
                               info: cusparseSolveAnalysisInfo_t): cusparseStatus_t {.
      cdecl, importc: "cusparseShybsv_analysis", dyn.}
  proc cusparseDhybsv_analysis*(handle: cusparseHandle_t;
                               transA: cusparseOperation_t;
                               descrA: cusparseMatDescr_t; hybA: cusparseHybMat_t;
                               info: cusparseSolveAnalysisInfo_t): cusparseStatus_t {.
      cdecl, importc: "cusparseDhybsv_analysis", dyn.}
  proc cusparseChybsv_analysis*(handle: cusparseHandle_t;
                               transA: cusparseOperation_t;
                               descrA: cusparseMatDescr_t; hybA: cusparseHybMat_t;
                               info: cusparseSolveAnalysisInfo_t): cusparseStatus_t {.
      cdecl, importc: "cusparseChybsv_analysis", dyn.}
  proc cusparseZhybsv_analysis*(handle: cusparseHandle_t;
                               transA: cusparseOperation_t;
                               descrA: cusparseMatDescr_t; hybA: cusparseHybMat_t;
                               info: cusparseSolveAnalysisInfo_t): cusparseStatus_t {.
      cdecl, importc: "cusparseZhybsv_analysis", dyn.}
  proc cusparseShybsv_solve*(handle: cusparseHandle_t; trans: cusparseOperation_t;
                            alpha: ptr cfloat; descra: cusparseMatDescr_t;
                            hybA: cusparseHybMat_t;
                            info: cusparseSolveAnalysisInfo_t; f: ptr cfloat;
                            x: ptr cfloat): cusparseStatus_t {.cdecl,
      importc: "cusparseShybsv_solve", dyn.}
  proc cusparseChybsv_solve*(handle: cusparseHandle_t; trans: cusparseOperation_t;
                            alpha: ptr cuComplex; descra: cusparseMatDescr_t;
                            hybA: cusparseHybMat_t;
                            info: cusparseSolveAnalysisInfo_t; f: ptr cuComplex;
                            x: ptr cuComplex): cusparseStatus_t {.cdecl,
      importc: "cusparseChybsv_solve", dyn.}
  proc cusparseDhybsv_solve*(handle: cusparseHandle_t; trans: cusparseOperation_t;
                            alpha: ptr cdouble; descra: cusparseMatDescr_t;
                            hybA: cusparseHybMat_t;
                            info: cusparseSolveAnalysisInfo_t; f: ptr cdouble;
                            x: ptr cdouble): cusparseStatus_t {.cdecl,
      importc: "cusparseDhybsv_solve", dyn.}
  proc cusparseZhybsv_solve*(handle: cusparseHandle_t; trans: cusparseOperation_t;
                            alpha: ptr cuDoubleComplex; descra: cusparseMatDescr_t;
                            hybA: cusparseHybMat_t;
                            info: cusparseSolveAnalysisInfo_t;
                            f: ptr cuDoubleComplex; x: ptr cuDoubleComplex): cusparseStatus_t {.
      cdecl, importc: "cusparseZhybsv_solve", dyn.}
  ##  --- Sparse Level 3 routines ---
  ##  Description: sparse - dense matrix multiplication C = alpha * op(A) * B  + beta * C, 
  ##    where A is a sparse matrix in CSR format, B and C are dense tall matrices.
  proc cusparseScsrmm*(handle: cusparseHandle_t; transA: cusparseOperation_t;
                      m: cint; n: cint; k: cint; nnz: cint; alpha: ptr cfloat;
                      descrA: cusparseMatDescr_t; csrSortedValA: ptr cfloat;
                      csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                      B: ptr cfloat; ldb: cint; beta: ptr cfloat; C: ptr cfloat; ldc: cint): cusparseStatus_t {.
      cdecl, importc: "cusparseScsrmm", dyn.}
  proc cusparseDcsrmm*(handle: cusparseHandle_t; transA: cusparseOperation_t;
                      m: cint; n: cint; k: cint; nnz: cint; alpha: ptr cdouble;
                      descrA: cusparseMatDescr_t; csrSortedValA: ptr cdouble;
                      csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                      B: ptr cdouble; ldb: cint; beta: ptr cdouble; C: ptr cdouble;
                      ldc: cint): cusparseStatus_t {.cdecl,
      importc: "cusparseDcsrmm", dyn.}
  proc cusparseCcsrmm*(handle: cusparseHandle_t; transA: cusparseOperation_t;
                      m: cint; n: cint; k: cint; nnz: cint; alpha: ptr cuComplex;
                      descrA: cusparseMatDescr_t; csrSortedValA: ptr cuComplex;
                      csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                      B: ptr cuComplex; ldb: cint; beta: ptr cuComplex;
                      C: ptr cuComplex; ldc: cint): cusparseStatus_t {.cdecl,
      importc: "cusparseCcsrmm", dyn.}
  proc cusparseZcsrmm*(handle: cusparseHandle_t; transA: cusparseOperation_t;
                      m: cint; n: cint; k: cint; nnz: cint; alpha: ptr cuDoubleComplex;
                      descrA: cusparseMatDescr_t;
                      csrSortedValA: ptr cuDoubleComplex;
                      csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                      B: ptr cuDoubleComplex; ldb: cint; beta: ptr cuDoubleComplex;
                      C: ptr cuDoubleComplex; ldc: cint): cusparseStatus_t {.cdecl,
      importc: "cusparseZcsrmm", dyn.}
  ##  Description: sparse - dense matrix multiplication C = alpha * op(A) * B  + beta * C, 
  ##    where A is a sparse matrix in CSR format, B and C are dense tall matrices.
  ##    This routine allows transposition of matrix B, which may improve performance.
  proc cusparseScsrmm2*(handle: cusparseHandle_t; transA: cusparseOperation_t;
                       transB: cusparseOperation_t; m: cint; n: cint; k: cint;
                       nnz: cint; alpha: ptr cfloat; descrA: cusparseMatDescr_t;
                       csrSortedValA: ptr cfloat; csrSortedRowPtrA: ptr cint;
                       csrSortedColIndA: ptr cint; B: ptr cfloat; ldb: cint;
                       beta: ptr cfloat; C: ptr cfloat; ldc: cint): cusparseStatus_t {.
      cdecl, importc: "cusparseScsrmm2", dyn.}
  proc cusparseDcsrmm2*(handle: cusparseHandle_t; transA: cusparseOperation_t;
                       transB: cusparseOperation_t; m: cint; n: cint; k: cint;
                       nnz: cint; alpha: ptr cdouble; descrA: cusparseMatDescr_t;
                       csrSortedValA: ptr cdouble; csrSortedRowPtrA: ptr cint;
                       csrSortedColIndA: ptr cint; B: ptr cdouble; ldb: cint;
                       beta: ptr cdouble; C: ptr cdouble; ldc: cint): cusparseStatus_t {.
      cdecl, importc: "cusparseDcsrmm2", dyn.}
  proc cusparseCcsrmm2*(handle: cusparseHandle_t; transA: cusparseOperation_t;
                       transB: cusparseOperation_t; m: cint; n: cint; k: cint;
                       nnz: cint; alpha: ptr cuComplex; descrA: cusparseMatDescr_t;
                       csrSortedValA: ptr cuComplex; csrSortedRowPtrA: ptr cint;
                       csrSortedColIndA: ptr cint; B: ptr cuComplex; ldb: cint;
                       beta: ptr cuComplex; C: ptr cuComplex; ldc: cint): cusparseStatus_t {.
      cdecl, importc: "cusparseCcsrmm2", dyn.}
  proc cusparseZcsrmm2*(handle: cusparseHandle_t; transA: cusparseOperation_t;
                       transB: cusparseOperation_t; m: cint; n: cint; k: cint;
                       nnz: cint; alpha: ptr cuDoubleComplex;
                       descrA: cusparseMatDescr_t;
                       csrSortedValA: ptr cuDoubleComplex;
                       csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                       B: ptr cuDoubleComplex; ldb: cint; beta: ptr cuDoubleComplex;
                       C: ptr cuDoubleComplex; ldc: cint): cusparseStatus_t {.cdecl,
      importc: "cusparseZcsrmm2", dyn.}
  ##  Description: sparse - dense matrix multiplication C = alpha * op(A) * B  + beta * C, 
  ##    where A is a sparse matrix in block-CSR format, B and C are dense tall matrices.
  ##    This routine allows transposition of matrix B, which may improve performance.
  proc cusparseSbsrmm*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                      transA: cusparseOperation_t; transB: cusparseOperation_t;
                      mb: cint; n: cint; kb: cint; nnzb: cint; alpha: ptr cfloat;
                      descrA: cusparseMatDescr_t; bsrSortedValA: ptr cfloat;
                      bsrSortedRowPtrA: ptr cint; bsrSortedColIndA: ptr cint;
                      blockSize: cint; B: ptr cfloat; ldb: cint; beta: ptr cfloat;
                      C: ptr cfloat; ldc: cint): cusparseStatus_t {.cdecl,
      importc: "cusparseSbsrmm", dyn.}
  proc cusparseDbsrmm*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                      transA: cusparseOperation_t; transB: cusparseOperation_t;
                      mb: cint; n: cint; kb: cint; nnzb: cint; alpha: ptr cdouble;
                      descrA: cusparseMatDescr_t; bsrSortedValA: ptr cdouble;
                      bsrSortedRowPtrA: ptr cint; bsrSortedColIndA: ptr cint;
                      blockSize: cint; B: ptr cdouble; ldb: cint; beta: ptr cdouble;
                      C: ptr cdouble; ldc: cint): cusparseStatus_t {.cdecl,
      importc: "cusparseDbsrmm", dyn.}
  proc cusparseCbsrmm*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                      transA: cusparseOperation_t; transB: cusparseOperation_t;
                      mb: cint; n: cint; kb: cint; nnzb: cint; alpha: ptr cuComplex;
                      descrA: cusparseMatDescr_t; bsrSortedValA: ptr cuComplex;
                      bsrSortedRowPtrA: ptr cint; bsrSortedColIndA: ptr cint;
                      blockSize: cint; B: ptr cuComplex; ldb: cint;
                      beta: ptr cuComplex; C: ptr cuComplex; ldc: cint): cusparseStatus_t {.
      cdecl, importc: "cusparseCbsrmm", dyn.}
  proc cusparseZbsrmm*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                      transA: cusparseOperation_t; transB: cusparseOperation_t;
                      mb: cint; n: cint; kb: cint; nnzb: cint;
                      alpha: ptr cuDoubleComplex; descrA: cusparseMatDescr_t;
                      bsrSortedValA: ptr cuDoubleComplex;
                      bsrSortedRowPtrA: ptr cint; bsrSortedColIndA: ptr cint;
                      blockSize: cint; B: ptr cuDoubleComplex; ldb: cint;
                      beta: ptr cuDoubleComplex; C: ptr cuDoubleComplex; ldc: cint): cusparseStatus_t {.
      cdecl, importc: "cusparseZbsrmm", dyn.}
  ##  Description: dense - sparse matrix multiplication C = alpha * A * B  + beta * C, 
  ##    where A is column-major dense matrix, B is a sparse matrix in CSC format, 
  ##    and C is column-major dense matrix.
  proc cusparseSgemmi*(handle: cusparseHandle_t; m: cint; n: cint; k: cint; nnz: cint;
                      alpha: ptr cfloat; A: ptr cfloat; lda: cint; cscValB: ptr cfloat;
                      cscColPtrB: ptr cint; cscRowIndB: ptr cint; beta: ptr cfloat;
                      C: ptr cfloat; ldc: cint): cusparseStatus_t {.cdecl,
      importc: "cusparseSgemmi", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cusparseDgemmi*(handle: cusparseHandle_t; m: cint; n: cint; k: cint; nnz: cint;
                      alpha: ptr cdouble; A: ptr cdouble; lda: cint;
                      cscValB: ptr cdouble; cscColPtrB: ptr cint;
                      cscRowIndB: ptr cint; beta: ptr cdouble; C: ptr cdouble; ldc: cint): cusparseStatus_t {.
      cdecl, importc: "cusparseDgemmi", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cusparseCgemmi*(handle: cusparseHandle_t; m: cint; n: cint; k: cint; nnz: cint;
                      alpha: ptr cuComplex; A: ptr cuComplex; lda: cint;
                      cscValB: ptr cuComplex; cscColPtrB: ptr cint;
                      cscRowIndB: ptr cint; beta: ptr cuComplex; C: ptr cuComplex;
                      ldc: cint): cusparseStatus_t {.cdecl,
      importc: "cusparseCgemmi", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  proc cusparseZgemmi*(handle: cusparseHandle_t; m: cint; n: cint; k: cint; nnz: cint;
                      alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex; lda: cint;
                      cscValB: ptr cuDoubleComplex; cscColPtrB: ptr cint;
                      cscRowIndB: ptr cint; beta: ptr cuDoubleComplex;
                      C: ptr cuDoubleComplex; ldc: cint): cusparseStatus_t {.cdecl,
      importc: "cusparseZgemmi", dyn.}
    ##  host or device pointer
    ##  host or device pointer
  ##  Description: Solution of triangular linear system op(A) * X = alpha * F, 
  ##    with multiple right-hand-sides, where A is a sparse matrix in CSR storage 
  ##    format, rhs F and solution X are dense tall matrices. 
  ##    This routine implements algorithm 1 for this problem.
  proc cusparseScsrsm_analysis*(handle: cusparseHandle_t;
                               transA: cusparseOperation_t; m: cint; nnz: cint;
                               descrA: cusparseMatDescr_t;
                               csrSortedValA: ptr cfloat;
                               csrSortedRowPtrA: ptr cint;
                               csrSortedColIndA: ptr cint;
                               info: cusparseSolveAnalysisInfo_t): cusparseStatus_t {.
      cdecl, importc: "cusparseScsrsm_analysis", dyn.}
  proc cusparseDcsrsm_analysis*(handle: cusparseHandle_t;
                               transA: cusparseOperation_t; m: cint; nnz: cint;
                               descrA: cusparseMatDescr_t;
                               csrSortedValA: ptr cdouble;
                               csrSortedRowPtrA: ptr cint;
                               csrSortedColIndA: ptr cint;
                               info: cusparseSolveAnalysisInfo_t): cusparseStatus_t {.
      cdecl, importc: "cusparseDcsrsm_analysis", dyn.}
  proc cusparseCcsrsm_analysis*(handle: cusparseHandle_t;
                               transA: cusparseOperation_t; m: cint; nnz: cint;
                               descrA: cusparseMatDescr_t;
                               csrSortedValA: ptr cuComplex;
                               csrSortedRowPtrA: ptr cint;
                               csrSortedColIndA: ptr cint;
                               info: cusparseSolveAnalysisInfo_t): cusparseStatus_t {.
      cdecl, importc: "cusparseCcsrsm_analysis", dyn.}
  proc cusparseZcsrsm_analysis*(handle: cusparseHandle_t;
                               transA: cusparseOperation_t; m: cint; nnz: cint;
                               descrA: cusparseMatDescr_t;
                               csrSortedValA: ptr cuDoubleComplex;
                               csrSortedRowPtrA: ptr cint;
                               csrSortedColIndA: ptr cint;
                               info: cusparseSolveAnalysisInfo_t): cusparseStatus_t {.
      cdecl, importc: "cusparseZcsrsm_analysis", dyn.}
  proc cusparseScsrsm_solve*(handle: cusparseHandle_t; transA: cusparseOperation_t;
                            m: cint; n: cint; alpha: ptr cfloat;
                            descrA: cusparseMatDescr_t; csrSortedValA: ptr cfloat;
                            csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                            info: cusparseSolveAnalysisInfo_t; F: ptr cfloat;
                            ldf: cint; X: ptr cfloat; ldx: cint): cusparseStatus_t {.
      cdecl, importc: "cusparseScsrsm_solve", dyn.}
  proc cusparseDcsrsm_solve*(handle: cusparseHandle_t; transA: cusparseOperation_t;
                            m: cint; n: cint; alpha: ptr cdouble;
                            descrA: cusparseMatDescr_t;
                            csrSortedValA: ptr cdouble; csrSortedRowPtrA: ptr cint;
                            csrSortedColIndA: ptr cint;
                            info: cusparseSolveAnalysisInfo_t; F: ptr cdouble;
                            ldf: cint; X: ptr cdouble; ldx: cint): cusparseStatus_t {.
      cdecl, importc: "cusparseDcsrsm_solve", dyn.}
  proc cusparseCcsrsm_solve*(handle: cusparseHandle_t; transA: cusparseOperation_t;
                            m: cint; n: cint; alpha: ptr cuComplex;
                            descrA: cusparseMatDescr_t;
                            csrSortedValA: ptr cuComplex;
                            csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                            info: cusparseSolveAnalysisInfo_t; F: ptr cuComplex;
                            ldf: cint; X: ptr cuComplex; ldx: cint): cusparseStatus_t {.
      cdecl, importc: "cusparseCcsrsm_solve", dyn.}
  proc cusparseZcsrsm_solve*(handle: cusparseHandle_t; transA: cusparseOperation_t;
                            m: cint; n: cint; alpha: ptr cuDoubleComplex;
                            descrA: cusparseMatDescr_t;
                            csrSortedValA: ptr cuDoubleComplex;
                            csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                            info: cusparseSolveAnalysisInfo_t;
                            F: ptr cuDoubleComplex; ldf: cint;
                            X: ptr cuDoubleComplex; ldx: cint): cusparseStatus_t {.
      cdecl, importc: "cusparseZcsrsm_solve", dyn.}
  ##  Description: Solution of triangular linear system op(A) * X = alpha * F, 
  ##    with multiple right-hand-sides, where A is a sparse matrix in CSR storage 
  ##    format, rhs F and solution X are dense tall matrices.
  ##    This routine implements algorithm 2 for this problem.
  proc cusparseXbsrsm2_zeroPivot*(handle: cusparseHandle_t; info: bsrsm2Info_t;
                                 position: ptr cint): cusparseStatus_t {.cdecl,
      importc: "cusparseXbsrsm2_zeroPivot", dyn.}
  proc cusparseSbsrsm2_bufferSize*(handle: cusparseHandle_t;
                                  dirA: cusparseDirection_t;
                                  transA: cusparseOperation_t;
                                  transXY: cusparseOperation_t; mb: cint; n: cint;
                                  nnzb: cint; descrA: cusparseMatDescr_t;
                                  bsrSortedVal: ptr cfloat;
                                  bsrSortedRowPtr: ptr cint;
                                  bsrSortedColInd: ptr cint; blockSize: cint;
                                  info: bsrsm2Info_t; pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseSbsrsm2_bufferSize", dyn.}
  proc cusparseDbsrsm2_bufferSize*(handle: cusparseHandle_t;
                                  dirA: cusparseDirection_t;
                                  transA: cusparseOperation_t;
                                  transXY: cusparseOperation_t; mb: cint; n: cint;
                                  nnzb: cint; descrA: cusparseMatDescr_t;
                                  bsrSortedVal: ptr cdouble;
                                  bsrSortedRowPtr: ptr cint;
                                  bsrSortedColInd: ptr cint; blockSize: cint;
                                  info: bsrsm2Info_t; pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseDbsrsm2_bufferSize", dyn.}
  proc cusparseCbsrsm2_bufferSize*(handle: cusparseHandle_t;
                                  dirA: cusparseDirection_t;
                                  transA: cusparseOperation_t;
                                  transXY: cusparseOperation_t; mb: cint; n: cint;
                                  nnzb: cint; descrA: cusparseMatDescr_t;
                                  bsrSortedVal: ptr cuComplex;
                                  bsrSortedRowPtr: ptr cint;
                                  bsrSortedColInd: ptr cint; blockSize: cint;
                                  info: bsrsm2Info_t; pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseCbsrsm2_bufferSize", dyn.}
  proc cusparseZbsrsm2_bufferSize*(handle: cusparseHandle_t;
                                  dirA: cusparseDirection_t;
                                  transA: cusparseOperation_t;
                                  transXY: cusparseOperation_t; mb: cint; n: cint;
                                  nnzb: cint; descrA: cusparseMatDescr_t;
                                  bsrSortedVal: ptr cuDoubleComplex;
                                  bsrSortedRowPtr: ptr cint;
                                  bsrSortedColInd: ptr cint; blockSize: cint;
                                  info: bsrsm2Info_t; pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseZbsrsm2_bufferSize", dyn.}
  proc cusparseSbsrsm2_bufferSizeExt*(handle: cusparseHandle_t;
                                     dirA: cusparseDirection_t;
                                     transA: cusparseOperation_t;
                                     transB: cusparseOperation_t; mb: cint; n: cint;
                                     nnzb: cint; descrA: cusparseMatDescr_t;
                                     bsrSortedVal: ptr cfloat;
                                     bsrSortedRowPtr: ptr cint;
                                     bsrSortedColInd: ptr cint; blockSize: cint;
                                     info: bsrsm2Info_t; pBufferSize: ptr csize): cusparseStatus_t {.
      cdecl, importc: "cusparseSbsrsm2_bufferSizeExt", dyn.}
  proc cusparseDbsrsm2_bufferSizeExt*(handle: cusparseHandle_t;
                                     dirA: cusparseDirection_t;
                                     transA: cusparseOperation_t;
                                     transB: cusparseOperation_t; mb: cint; n: cint;
                                     nnzb: cint; descrA: cusparseMatDescr_t;
                                     bsrSortedVal: ptr cdouble;
                                     bsrSortedRowPtr: ptr cint;
                                     bsrSortedColInd: ptr cint; blockSize: cint;
                                     info: bsrsm2Info_t; pBufferSize: ptr csize): cusparseStatus_t {.
      cdecl, importc: "cusparseDbsrsm2_bufferSizeExt", dyn.}
  proc cusparseCbsrsm2_bufferSizeExt*(handle: cusparseHandle_t;
                                     dirA: cusparseDirection_t;
                                     transA: cusparseOperation_t;
                                     transB: cusparseOperation_t; mb: cint; n: cint;
                                     nnzb: cint; descrA: cusparseMatDescr_t;
                                     bsrSortedVal: ptr cuComplex;
                                     bsrSortedRowPtr: ptr cint;
                                     bsrSortedColInd: ptr cint; blockSize: cint;
                                     info: bsrsm2Info_t; pBufferSize: ptr csize): cusparseStatus_t {.
      cdecl, importc: "cusparseCbsrsm2_bufferSizeExt", dyn.}
  proc cusparseZbsrsm2_bufferSizeExt*(handle: cusparseHandle_t;
                                     dirA: cusparseDirection_t;
                                     transA: cusparseOperation_t;
                                     transB: cusparseOperation_t; mb: cint; n: cint;
                                     nnzb: cint; descrA: cusparseMatDescr_t;
                                     bsrSortedVal: ptr cuDoubleComplex;
                                     bsrSortedRowPtr: ptr cint;
                                     bsrSortedColInd: ptr cint; blockSize: cint;
                                     info: bsrsm2Info_t; pBufferSize: ptr csize): cusparseStatus_t {.
      cdecl, importc: "cusparseZbsrsm2_bufferSizeExt", dyn.}
  proc cusparseSbsrsm2_analysis*(handle: cusparseHandle_t;
                                dirA: cusparseDirection_t;
                                transA: cusparseOperation_t;
                                transXY: cusparseOperation_t; mb: cint; n: cint;
                                nnzb: cint; descrA: cusparseMatDescr_t;
                                bsrSortedVal: ptr cfloat;
                                bsrSortedRowPtr: ptr cint;
                                bsrSortedColInd: ptr cint; blockSize: cint;
                                info: bsrsm2Info_t; policy: cusparseSolvePolicy_t;
                                pBuffer: pointer): cusparseStatus_t {.cdecl,
      importc: "cusparseSbsrsm2_analysis", dyn.}
  proc cusparseDbsrsm2_analysis*(handle: cusparseHandle_t;
                                dirA: cusparseDirection_t;
                                transA: cusparseOperation_t;
                                transXY: cusparseOperation_t; mb: cint; n: cint;
                                nnzb: cint; descrA: cusparseMatDescr_t;
                                bsrSortedVal: ptr cdouble;
                                bsrSortedRowPtr: ptr cint;
                                bsrSortedColInd: ptr cint; blockSize: cint;
                                info: bsrsm2Info_t; policy: cusparseSolvePolicy_t;
                                pBuffer: pointer): cusparseStatus_t {.cdecl,
      importc: "cusparseDbsrsm2_analysis", dyn.}
  proc cusparseCbsrsm2_analysis*(handle: cusparseHandle_t;
                                dirA: cusparseDirection_t;
                                transA: cusparseOperation_t;
                                transXY: cusparseOperation_t; mb: cint; n: cint;
                                nnzb: cint; descrA: cusparseMatDescr_t;
                                bsrSortedVal: ptr cuComplex;
                                bsrSortedRowPtr: ptr cint;
                                bsrSortedColInd: ptr cint; blockSize: cint;
                                info: bsrsm2Info_t; policy: cusparseSolvePolicy_t;
                                pBuffer: pointer): cusparseStatus_t {.cdecl,
      importc: "cusparseCbsrsm2_analysis", dyn.}
  proc cusparseZbsrsm2_analysis*(handle: cusparseHandle_t;
                                dirA: cusparseDirection_t;
                                transA: cusparseOperation_t;
                                transXY: cusparseOperation_t; mb: cint; n: cint;
                                nnzb: cint; descrA: cusparseMatDescr_t;
                                bsrSortedVal: ptr cuDoubleComplex;
                                bsrSortedRowPtr: ptr cint;
                                bsrSortedColInd: ptr cint; blockSize: cint;
                                info: bsrsm2Info_t; policy: cusparseSolvePolicy_t;
                                pBuffer: pointer): cusparseStatus_t {.cdecl,
      importc: "cusparseZbsrsm2_analysis", dyn.}
  proc cusparseSbsrsm2_solve*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                             transA: cusparseOperation_t;
                             transXY: cusparseOperation_t; mb: cint; n: cint;
                             nnzb: cint; alpha: ptr cfloat;
                             descrA: cusparseMatDescr_t; bsrSortedVal: ptr cfloat;
                             bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint;
                             blockSize: cint; info: bsrsm2Info_t; F: ptr cfloat;
                             ldf: cint; X: ptr cfloat; ldx: cint;
                             policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseSbsrsm2_solve", dyn.}
  proc cusparseDbsrsm2_solve*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                             transA: cusparseOperation_t;
                             transXY: cusparseOperation_t; mb: cint; n: cint;
                             nnzb: cint; alpha: ptr cdouble;
                             descrA: cusparseMatDescr_t;
                             bsrSortedVal: ptr cdouble; bsrSortedRowPtr: ptr cint;
                             bsrSortedColInd: ptr cint; blockSize: cint;
                             info: bsrsm2Info_t; F: ptr cdouble; ldf: cint;
                             X: ptr cdouble; ldx: cint;
                             policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseDbsrsm2_solve", dyn.}
  proc cusparseCbsrsm2_solve*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                             transA: cusparseOperation_t;
                             transXY: cusparseOperation_t; mb: cint; n: cint;
                             nnzb: cint; alpha: ptr cuComplex;
                             descrA: cusparseMatDescr_t;
                             bsrSortedVal: ptr cuComplex;
                             bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint;
                             blockSize: cint; info: bsrsm2Info_t; F: ptr cuComplex;
                             ldf: cint; X: ptr cuComplex; ldx: cint;
                             policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseCbsrsm2_solve", dyn.}
  proc cusparseZbsrsm2_solve*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                             transA: cusparseOperation_t;
                             transXY: cusparseOperation_t; mb: cint; n: cint;
                             nnzb: cint; alpha: ptr cuDoubleComplex;
                             descrA: cusparseMatDescr_t;
                             bsrSortedVal: ptr cuDoubleComplex;
                             bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint;
                             blockSize: cint; info: bsrsm2Info_t;
                             F: ptr cuDoubleComplex; ldf: cint;
                             X: ptr cuDoubleComplex; ldx: cint;
                             policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseZbsrsm2_solve", dyn.}
  ##  --- Preconditioners ---
  ##  Description: Compute the incomplete-LU factorization with 0 fill-in (ILU0)
  ##    of the matrix A stored in CSR format based on the information in the opaque 
  ##    structure info that was obtained from the analysis phase (csrsv_analysis). 
  ##    This routine implements algorithm 1 for this problem.
  proc cusparseCsrilu0Ex*(handle: cusparseHandle_t; trans: cusparseOperation_t;
                         m: cint; descrA: cusparseMatDescr_t;
                         csrSortedValA_ValM: pointer;
                         csrSortedValA_ValMtype: cudaDataType;
                         csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                         info: cusparseSolveAnalysisInfo_t;
                         executiontype: cudaDataType): cusparseStatus_t {.cdecl,
      importc: "cusparseCsrilu0Ex", dyn.}
    ##  matrix A values are updated inplace 
    ##                                                  to be the preconditioner M values
  proc cusparseScsrilu0*(handle: cusparseHandle_t; trans: cusparseOperation_t;
                        m: cint; descrA: cusparseMatDescr_t;
                        csrSortedValA_ValM: ptr cfloat; csrSortedRowPtrA: ptr cint;
                        csrSortedColIndA: ptr cint;
                        info: cusparseSolveAnalysisInfo_t): cusparseStatus_t {.
      cdecl, importc: "cusparseScsrilu0", dyn.}
    ##  matrix A values are updated inplace 
    ##                                                  to be the preconditioner M values
  proc cusparseDcsrilu0*(handle: cusparseHandle_t; trans: cusparseOperation_t;
                        m: cint; descrA: cusparseMatDescr_t;
                        csrSortedValA_ValM: ptr cdouble;
                        csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                        info: cusparseSolveAnalysisInfo_t): cusparseStatus_t {.
      cdecl, importc: "cusparseDcsrilu0", dyn.}
    ##  matrix A values are updated inplace 
    ##                                                  to be the preconditioner M values
  proc cusparseCcsrilu0*(handle: cusparseHandle_t; trans: cusparseOperation_t;
                        m: cint; descrA: cusparseMatDescr_t;
                        csrSortedValA_ValM: ptr cuComplex;
                        csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                        info: cusparseSolveAnalysisInfo_t): cusparseStatus_t {.
      cdecl, importc: "cusparseCcsrilu0", dyn.}
    ##  matrix A values are updated inplace 
    ##                                                  to be the preconditioner M values
  proc cusparseZcsrilu0*(handle: cusparseHandle_t; trans: cusparseOperation_t;
                        m: cint; descrA: cusparseMatDescr_t;
                        csrSortedValA_ValM: ptr cuDoubleComplex;
                        csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                        info: cusparseSolveAnalysisInfo_t): cusparseStatus_t {.
      cdecl, importc: "cusparseZcsrilu0", dyn.}
    ##  matrix A values are updated inplace 
    ##                                                  to be the preconditioner M values
  ##  Description: Compute the incomplete-LU factorization with 0 fill-in (ILU0)
  ##    of the matrix A stored in CSR format based on the information in the opaque 
  ##    structure info that was obtained from the analysis phase (csrsv2_analysis).
  ##    This routine implements algorithm 2 for this problem.
  proc cusparseScsrilu02_numericBoost*(handle: cusparseHandle_t;
                                      info: csrilu02Info_t; enable_boost: cint;
                                      tol: ptr cdouble; boost_val: ptr cfloat): cusparseStatus_t {.
      cdecl, importc: "cusparseScsrilu02_numericBoost", dyn.}
  proc cusparseDcsrilu02_numericBoost*(handle: cusparseHandle_t;
                                      info: csrilu02Info_t; enable_boost: cint;
                                      tol: ptr cdouble; boost_val: ptr cdouble): cusparseStatus_t {.
      cdecl, importc: "cusparseDcsrilu02_numericBoost", dyn.}
  proc cusparseCcsrilu02_numericBoost*(handle: cusparseHandle_t;
                                      info: csrilu02Info_t; enable_boost: cint;
                                      tol: ptr cdouble; boost_val: ptr cuComplex): cusparseStatus_t {.
      cdecl, importc: "cusparseCcsrilu02_numericBoost", dyn.}
  proc cusparseZcsrilu02_numericBoost*(handle: cusparseHandle_t;
                                      info: csrilu02Info_t; enable_boost: cint;
                                      tol: ptr cdouble;
                                      boost_val: ptr cuDoubleComplex): cusparseStatus_t {.
      cdecl, importc: "cusparseZcsrilu02_numericBoost", dyn.}
  proc cusparseXcsrilu02_zeroPivot*(handle: cusparseHandle_t; info: csrilu02Info_t;
                                   position: ptr cint): cusparseStatus_t {.cdecl,
      importc: "cusparseXcsrilu02_zeroPivot", dyn.}
  proc cusparseScsrilu02_bufferSize*(handle: cusparseHandle_t; m: cint; nnz: cint;
                                    descrA: cusparseMatDescr_t;
                                    csrSortedValA: ptr cfloat;
                                    csrSortedRowPtrA: ptr cint;
                                    csrSortedColIndA: ptr cint;
                                    info: csrilu02Info_t;
                                    pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseScsrilu02_bufferSize", dyn.}
  proc cusparseDcsrilu02_bufferSize*(handle: cusparseHandle_t; m: cint; nnz: cint;
                                    descrA: cusparseMatDescr_t;
                                    csrSortedValA: ptr cdouble;
                                    csrSortedRowPtrA: ptr cint;
                                    csrSortedColIndA: ptr cint;
                                    info: csrilu02Info_t;
                                    pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseDcsrilu02_bufferSize", dyn.}
  proc cusparseCcsrilu02_bufferSize*(handle: cusparseHandle_t; m: cint; nnz: cint;
                                    descrA: cusparseMatDescr_t;
                                    csrSortedValA: ptr cuComplex;
                                    csrSortedRowPtrA: ptr cint;
                                    csrSortedColIndA: ptr cint;
                                    info: csrilu02Info_t;
                                    pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseCcsrilu02_bufferSize", dyn.}
  proc cusparseZcsrilu02_bufferSize*(handle: cusparseHandle_t; m: cint; nnz: cint;
                                    descrA: cusparseMatDescr_t;
                                    csrSortedValA: ptr cuDoubleComplex;
                                    csrSortedRowPtrA: ptr cint;
                                    csrSortedColIndA: ptr cint;
                                    info: csrilu02Info_t;
                                    pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseZcsrilu02_bufferSize", dyn.}
  proc cusparseScsrilu02_bufferSizeExt*(handle: cusparseHandle_t; m: cint; nnz: cint;
                                       descrA: cusparseMatDescr_t;
                                       csrSortedVal: ptr cfloat;
                                       csrSortedRowPtr: ptr cint;
                                       csrSortedColInd: ptr cint;
                                       info: csrilu02Info_t;
                                       pBufferSize: ptr csize): cusparseStatus_t {.
      cdecl, importc: "cusparseScsrilu02_bufferSizeExt", dyn.}
  proc cusparseDcsrilu02_bufferSizeExt*(handle: cusparseHandle_t; m: cint; nnz: cint;
                                       descrA: cusparseMatDescr_t;
                                       csrSortedVal: ptr cdouble;
                                       csrSortedRowPtr: ptr cint;
                                       csrSortedColInd: ptr cint;
                                       info: csrilu02Info_t;
                                       pBufferSize: ptr csize): cusparseStatus_t {.
      cdecl, importc: "cusparseDcsrilu02_bufferSizeExt", dyn.}
  proc cusparseCcsrilu02_bufferSizeExt*(handle: cusparseHandle_t; m: cint; nnz: cint;
                                       descrA: cusparseMatDescr_t;
                                       csrSortedVal: ptr cuComplex;
                                       csrSortedRowPtr: ptr cint;
                                       csrSortedColInd: ptr cint;
                                       info: csrilu02Info_t;
                                       pBufferSize: ptr csize): cusparseStatus_t {.
      cdecl, importc: "cusparseCcsrilu02_bufferSizeExt", dyn.}
  proc cusparseZcsrilu02_bufferSizeExt*(handle: cusparseHandle_t; m: cint; nnz: cint;
                                       descrA: cusparseMatDescr_t;
                                       csrSortedVal: ptr cuDoubleComplex;
                                       csrSortedRowPtr: ptr cint;
                                       csrSortedColInd: ptr cint;
                                       info: csrilu02Info_t;
                                       pBufferSize: ptr csize): cusparseStatus_t {.
      cdecl, importc: "cusparseZcsrilu02_bufferSizeExt", dyn.}
  proc cusparseScsrilu02_analysis*(handle: cusparseHandle_t; m: cint; nnz: cint;
                                  descrA: cusparseMatDescr_t;
                                  csrSortedValA: ptr cfloat;
                                  csrSortedRowPtrA: ptr cint;
                                  csrSortedColIndA: ptr cint; info: csrilu02Info_t;
                                  policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseScsrilu02_analysis", dyn.}
  proc cusparseDcsrilu02_analysis*(handle: cusparseHandle_t; m: cint; nnz: cint;
                                  descrA: cusparseMatDescr_t;
                                  csrSortedValA: ptr cdouble;
                                  csrSortedRowPtrA: ptr cint;
                                  csrSortedColIndA: ptr cint; info: csrilu02Info_t;
                                  policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseDcsrilu02_analysis", dyn.}
  proc cusparseCcsrilu02_analysis*(handle: cusparseHandle_t; m: cint; nnz: cint;
                                  descrA: cusparseMatDescr_t;
                                  csrSortedValA: ptr cuComplex;
                                  csrSortedRowPtrA: ptr cint;
                                  csrSortedColIndA: ptr cint; info: csrilu02Info_t;
                                  policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseCcsrilu02_analysis", dyn.}
  proc cusparseZcsrilu02_analysis*(handle: cusparseHandle_t; m: cint; nnz: cint;
                                  descrA: cusparseMatDescr_t;
                                  csrSortedValA: ptr cuDoubleComplex;
                                  csrSortedRowPtrA: ptr cint;
                                  csrSortedColIndA: ptr cint; info: csrilu02Info_t;
                                  policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseZcsrilu02_analysis", dyn.}
  proc cusparseScsrilu02*(handle: cusparseHandle_t; m: cint; nnz: cint;
                         descrA: cusparseMatDescr_t;
                         csrSortedValA_valM: ptr cfloat;
                         csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                         info: csrilu02Info_t; policy: cusparseSolvePolicy_t;
                         pBuffer: pointer): cusparseStatus_t {.cdecl,
      importc: "cusparseScsrilu02", dyn.}
    ##  matrix A values are updated inplace 
    ##                                                   to be the preconditioner M values
  proc cusparseDcsrilu02*(handle: cusparseHandle_t; m: cint; nnz: cint;
                         descrA: cusparseMatDescr_t;
                         csrSortedValA_valM: ptr cdouble;
                         csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                         info: csrilu02Info_t; policy: cusparseSolvePolicy_t;
                         pBuffer: pointer): cusparseStatus_t {.cdecl,
      importc: "cusparseDcsrilu02", dyn.}
    ##  matrix A values are updated inplace 
    ##                                                   to be the preconditioner M values
  proc cusparseCcsrilu02*(handle: cusparseHandle_t; m: cint; nnz: cint;
                         descrA: cusparseMatDescr_t;
                         csrSortedValA_valM: ptr cuComplex;
                         csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                         info: csrilu02Info_t; policy: cusparseSolvePolicy_t;
                         pBuffer: pointer): cusparseStatus_t {.cdecl,
      importc: "cusparseCcsrilu02", dyn.}
    ##  matrix A values are updated inplace 
    ##                                                   to be the preconditioner M values
  proc cusparseZcsrilu02*(handle: cusparseHandle_t; m: cint; nnz: cint;
                         descrA: cusparseMatDescr_t;
                         csrSortedValA_valM: ptr cuDoubleComplex;
                         csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                         info: csrilu02Info_t; policy: cusparseSolvePolicy_t;
                         pBuffer: pointer): cusparseStatus_t {.cdecl,
      importc: "cusparseZcsrilu02", dyn.}
    ##  matrix A values are updated inplace 
    ##                                                   to be the preconditioner M values
  ##  Description: Compute the incomplete-LU factorization with 0 fill-in (ILU0)
  ##    of the matrix A stored in block-CSR format based on the information in the opaque 
  ##    structure info that was obtained from the analysis phase (bsrsv2_analysis).
  ##    This routine implements algorithm 2 for this problem.
  proc cusparseSbsrilu02_numericBoost*(handle: cusparseHandle_t;
                                      info: bsrilu02Info_t; enable_boost: cint;
                                      tol: ptr cdouble; boost_val: ptr cfloat): cusparseStatus_t {.
      cdecl, importc: "cusparseSbsrilu02_numericBoost", dyn.}
  proc cusparseDbsrilu02_numericBoost*(handle: cusparseHandle_t;
                                      info: bsrilu02Info_t; enable_boost: cint;
                                      tol: ptr cdouble; boost_val: ptr cdouble): cusparseStatus_t {.
      cdecl, importc: "cusparseDbsrilu02_numericBoost", dyn.}
  proc cusparseCbsrilu02_numericBoost*(handle: cusparseHandle_t;
                                      info: bsrilu02Info_t; enable_boost: cint;
                                      tol: ptr cdouble; boost_val: ptr cuComplex): cusparseStatus_t {.
      cdecl, importc: "cusparseCbsrilu02_numericBoost", dyn.}
  proc cusparseZbsrilu02_numericBoost*(handle: cusparseHandle_t;
                                      info: bsrilu02Info_t; enable_boost: cint;
                                      tol: ptr cdouble;
                                      boost_val: ptr cuDoubleComplex): cusparseStatus_t {.
      cdecl, importc: "cusparseZbsrilu02_numericBoost", dyn.}
  proc cusparseXbsrilu02_zeroPivot*(handle: cusparseHandle_t; info: bsrilu02Info_t;
                                   position: ptr cint): cusparseStatus_t {.cdecl,
      importc: "cusparseXbsrilu02_zeroPivot", dyn.}
  proc cusparseSbsrilu02_bufferSize*(handle: cusparseHandle_t;
                                    dirA: cusparseDirection_t; mb: cint; nnzb: cint;
                                    descrA: cusparseMatDescr_t;
                                    bsrSortedVal: ptr cfloat;
                                    bsrSortedRowPtr: ptr cint;
                                    bsrSortedColInd: ptr cint; blockDim: cint;
                                    info: bsrilu02Info_t;
                                    pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseSbsrilu02_bufferSize", dyn.}
  proc cusparseDbsrilu02_bufferSize*(handle: cusparseHandle_t;
                                    dirA: cusparseDirection_t; mb: cint; nnzb: cint;
                                    descrA: cusparseMatDescr_t;
                                    bsrSortedVal: ptr cdouble;
                                    bsrSortedRowPtr: ptr cint;
                                    bsrSortedColInd: ptr cint; blockDim: cint;
                                    info: bsrilu02Info_t;
                                    pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseDbsrilu02_bufferSize", dyn.}
  proc cusparseCbsrilu02_bufferSize*(handle: cusparseHandle_t;
                                    dirA: cusparseDirection_t; mb: cint; nnzb: cint;
                                    descrA: cusparseMatDescr_t;
                                    bsrSortedVal: ptr cuComplex;
                                    bsrSortedRowPtr: ptr cint;
                                    bsrSortedColInd: ptr cint; blockDim: cint;
                                    info: bsrilu02Info_t;
                                    pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseCbsrilu02_bufferSize", dyn.}
  proc cusparseZbsrilu02_bufferSize*(handle: cusparseHandle_t;
                                    dirA: cusparseDirection_t; mb: cint; nnzb: cint;
                                    descrA: cusparseMatDescr_t;
                                    bsrSortedVal: ptr cuDoubleComplex;
                                    bsrSortedRowPtr: ptr cint;
                                    bsrSortedColInd: ptr cint; blockDim: cint;
                                    info: bsrilu02Info_t;
                                    pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseZbsrilu02_bufferSize", dyn.}
  proc cusparseSbsrilu02_bufferSizeExt*(handle: cusparseHandle_t;
                                       dirA: cusparseDirection_t; mb: cint;
                                       nnzb: cint; descrA: cusparseMatDescr_t;
                                       bsrSortedVal: ptr cfloat;
                                       bsrSortedRowPtr: ptr cint;
                                       bsrSortedColInd: ptr cint; blockSize: cint;
                                       info: bsrilu02Info_t;
                                       pBufferSize: ptr csize): cusparseStatus_t {.
      cdecl, importc: "cusparseSbsrilu02_bufferSizeExt", dyn.}
  proc cusparseDbsrilu02_bufferSizeExt*(handle: cusparseHandle_t;
                                       dirA: cusparseDirection_t; mb: cint;
                                       nnzb: cint; descrA: cusparseMatDescr_t;
                                       bsrSortedVal: ptr cdouble;
                                       bsrSortedRowPtr: ptr cint;
                                       bsrSortedColInd: ptr cint; blockSize: cint;
                                       info: bsrilu02Info_t;
                                       pBufferSize: ptr csize): cusparseStatus_t {.
      cdecl, importc: "cusparseDbsrilu02_bufferSizeExt", dyn.}
  proc cusparseCbsrilu02_bufferSizeExt*(handle: cusparseHandle_t;
                                       dirA: cusparseDirection_t; mb: cint;
                                       nnzb: cint; descrA: cusparseMatDescr_t;
                                       bsrSortedVal: ptr cuComplex;
                                       bsrSortedRowPtr: ptr cint;
                                       bsrSortedColInd: ptr cint; blockSize: cint;
                                       info: bsrilu02Info_t;
                                       pBufferSize: ptr csize): cusparseStatus_t {.
      cdecl, importc: "cusparseCbsrilu02_bufferSizeExt", dyn.}
  proc cusparseZbsrilu02_bufferSizeExt*(handle: cusparseHandle_t;
                                       dirA: cusparseDirection_t; mb: cint;
                                       nnzb: cint; descrA: cusparseMatDescr_t;
                                       bsrSortedVal: ptr cuDoubleComplex;
                                       bsrSortedRowPtr: ptr cint;
                                       bsrSortedColInd: ptr cint; blockSize: cint;
                                       info: bsrilu02Info_t;
                                       pBufferSize: ptr csize): cusparseStatus_t {.
      cdecl, importc: "cusparseZbsrilu02_bufferSizeExt", dyn.}
  proc cusparseSbsrilu02_analysis*(handle: cusparseHandle_t;
                                  dirA: cusparseDirection_t; mb: cint; nnzb: cint;
                                  descrA: cusparseMatDescr_t;
                                  bsrSortedVal: ptr cfloat;
                                  bsrSortedRowPtr: ptr cint;
                                  bsrSortedColInd: ptr cint; blockDim: cint;
                                  info: bsrilu02Info_t;
                                  policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseSbsrilu02_analysis", dyn.}
  proc cusparseDbsrilu02_analysis*(handle: cusparseHandle_t;
                                  dirA: cusparseDirection_t; mb: cint; nnzb: cint;
                                  descrA: cusparseMatDescr_t;
                                  bsrSortedVal: ptr cdouble;
                                  bsrSortedRowPtr: ptr cint;
                                  bsrSortedColInd: ptr cint; blockDim: cint;
                                  info: bsrilu02Info_t;
                                  policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseDbsrilu02_analysis", dyn.}
  proc cusparseCbsrilu02_analysis*(handle: cusparseHandle_t;
                                  dirA: cusparseDirection_t; mb: cint; nnzb: cint;
                                  descrA: cusparseMatDescr_t;
                                  bsrSortedVal: ptr cuComplex;
                                  bsrSortedRowPtr: ptr cint;
                                  bsrSortedColInd: ptr cint; blockDim: cint;
                                  info: bsrilu02Info_t;
                                  policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseCbsrilu02_analysis", dyn.}
  proc cusparseZbsrilu02_analysis*(handle: cusparseHandle_t;
                                  dirA: cusparseDirection_t; mb: cint; nnzb: cint;
                                  descrA: cusparseMatDescr_t;
                                  bsrSortedVal: ptr cuDoubleComplex;
                                  bsrSortedRowPtr: ptr cint;
                                  bsrSortedColInd: ptr cint; blockDim: cint;
                                  info: bsrilu02Info_t;
                                  policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseZbsrilu02_analysis", dyn.}
  proc cusparseSbsrilu02*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                         mb: cint; nnzb: cint; descra: cusparseMatDescr_t;
                         bsrSortedVal: ptr cfloat; bsrSortedRowPtr: ptr cint;
                         bsrSortedColInd: ptr cint; blockDim: cint;
                         info: bsrilu02Info_t; policy: cusparseSolvePolicy_t;
                         pBuffer: pointer): cusparseStatus_t {.cdecl,
      importc: "cusparseSbsrilu02", dyn.}
  proc cusparseDbsrilu02*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                         mb: cint; nnzb: cint; descra: cusparseMatDescr_t;
                         bsrSortedVal: ptr cdouble; bsrSortedRowPtr: ptr cint;
                         bsrSortedColInd: ptr cint; blockDim: cint;
                         info: bsrilu02Info_t; policy: cusparseSolvePolicy_t;
                         pBuffer: pointer): cusparseStatus_t {.cdecl,
      importc: "cusparseDbsrilu02", dyn.}
  proc cusparseCbsrilu02*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                         mb: cint; nnzb: cint; descra: cusparseMatDescr_t;
                         bsrSortedVal: ptr cuComplex; bsrSortedRowPtr: ptr cint;
                         bsrSortedColInd: ptr cint; blockDim: cint;
                         info: bsrilu02Info_t; policy: cusparseSolvePolicy_t;
                         pBuffer: pointer): cusparseStatus_t {.cdecl,
      importc: "cusparseCbsrilu02", dyn.}
  proc cusparseZbsrilu02*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                         mb: cint; nnzb: cint; descra: cusparseMatDescr_t;
                         bsrSortedVal: ptr cuDoubleComplex;
                         bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint;
                         blockDim: cint; info: bsrilu02Info_t;
                         policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseZbsrilu02", dyn.}
  ##  Description: Compute the incomplete-Cholesky factorization with 0 fill-in (IC0)
  ##    of the matrix A stored in CSR format based on the information in the opaque 
  ##    structure info that was obtained from the analysis phase (csrsv_analysis). 
  ##    This routine implements algorithm 1 for this problem.
  proc cusparseScsric0*(handle: cusparseHandle_t; trans: cusparseOperation_t;
                       m: cint; descrA: cusparseMatDescr_t;
                       csrSortedValA_ValM: ptr cfloat; csrSortedRowPtrA: ptr cint;
                       csrSortedColIndA: ptr cint;
                       info: cusparseSolveAnalysisInfo_t): cusparseStatus_t {.
      cdecl, importc: "cusparseScsric0", dyn.}
    ##  matrix A values are updated inplace 
    ##                                                  to be the preconditioner M values
  proc cusparseDcsric0*(handle: cusparseHandle_t; trans: cusparseOperation_t;
                       m: cint; descrA: cusparseMatDescr_t;
                       csrSortedValA_ValM: ptr cdouble; csrSortedRowPtrA: ptr cint;
                       csrSortedColIndA: ptr cint;
                       info: cusparseSolveAnalysisInfo_t): cusparseStatus_t {.
      cdecl, importc: "cusparseDcsric0", dyn.}
    ##  matrix A values are updated inplace 
    ##                                                  to be the preconditioner M values
  proc cusparseCcsric0*(handle: cusparseHandle_t; trans: cusparseOperation_t;
                       m: cint; descrA: cusparseMatDescr_t;
                       csrSortedValA_ValM: ptr cuComplex;
                       csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                       info: cusparseSolveAnalysisInfo_t): cusparseStatus_t {.
      cdecl, importc: "cusparseCcsric0", dyn.}
    ##  matrix A values are updated inplace 
    ##                                                  to be the preconditioner M values
  proc cusparseZcsric0*(handle: cusparseHandle_t; trans: cusparseOperation_t;
                       m: cint; descrA: cusparseMatDescr_t;
                       csrSortedValA_ValM: ptr cuDoubleComplex;
                       csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                       info: cusparseSolveAnalysisInfo_t): cusparseStatus_t {.
      cdecl, importc: "cusparseZcsric0", dyn.}
    ##  matrix A values are updated inplace 
    ##                                                  to be the preconditioner M values
  ##  Description: Compute the incomplete-Cholesky factorization with 0 fill-in (IC0)
  ##    of the matrix A stored in CSR format based on the information in the opaque 
  ##    structure info that was obtained from the analysis phase (csrsv2_analysis). 
  ##    This routine implements algorithm 2 for this problem.
  proc cusparseXcsric02_zeroPivot*(handle: cusparseHandle_t; info: csric02Info_t;
                                  position: ptr cint): cusparseStatus_t {.cdecl,
      importc: "cusparseXcsric02_zeroPivot", dyn.}
  proc cusparseScsric02_bufferSize*(handle: cusparseHandle_t; m: cint; nnz: cint;
                                   descrA: cusparseMatDescr_t;
                                   csrSortedValA: ptr cfloat;
                                   csrSortedRowPtrA: ptr cint;
                                   csrSortedColIndA: ptr cint; info: csric02Info_t;
                                   pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseScsric02_bufferSize", dyn.}
  proc cusparseDcsric02_bufferSize*(handle: cusparseHandle_t; m: cint; nnz: cint;
                                   descrA: cusparseMatDescr_t;
                                   csrSortedValA: ptr cdouble;
                                   csrSortedRowPtrA: ptr cint;
                                   csrSortedColIndA: ptr cint; info: csric02Info_t;
                                   pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseDcsric02_bufferSize", dyn.}
  proc cusparseCcsric02_bufferSize*(handle: cusparseHandle_t; m: cint; nnz: cint;
                                   descrA: cusparseMatDescr_t;
                                   csrSortedValA: ptr cuComplex;
                                   csrSortedRowPtrA: ptr cint;
                                   csrSortedColIndA: ptr cint; info: csric02Info_t;
                                   pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseCcsric02_bufferSize", dyn.}
  proc cusparseZcsric02_bufferSize*(handle: cusparseHandle_t; m: cint; nnz: cint;
                                   descrA: cusparseMatDescr_t;
                                   csrSortedValA: ptr cuDoubleComplex;
                                   csrSortedRowPtrA: ptr cint;
                                   csrSortedColIndA: ptr cint; info: csric02Info_t;
                                   pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseZcsric02_bufferSize", dyn.}
  proc cusparseScsric02_bufferSizeExt*(handle: cusparseHandle_t; m: cint; nnz: cint;
                                      descrA: cusparseMatDescr_t;
                                      csrSortedVal: ptr cfloat;
                                      csrSortedRowPtr: ptr cint;
                                      csrSortedColInd: ptr cint;
                                      info: csric02Info_t; pBufferSize: ptr csize): cusparseStatus_t {.
      cdecl, importc: "cusparseScsric02_bufferSizeExt", dyn.}
  proc cusparseDcsric02_bufferSizeExt*(handle: cusparseHandle_t; m: cint; nnz: cint;
                                      descrA: cusparseMatDescr_t;
                                      csrSortedVal: ptr cdouble;
                                      csrSortedRowPtr: ptr cint;
                                      csrSortedColInd: ptr cint;
                                      info: csric02Info_t; pBufferSize: ptr csize): cusparseStatus_t {.
      cdecl, importc: "cusparseDcsric02_bufferSizeExt", dyn.}
  proc cusparseCcsric02_bufferSizeExt*(handle: cusparseHandle_t; m: cint; nnz: cint;
                                      descrA: cusparseMatDescr_t;
                                      csrSortedVal: ptr cuComplex;
                                      csrSortedRowPtr: ptr cint;
                                      csrSortedColInd: ptr cint;
                                      info: csric02Info_t; pBufferSize: ptr csize): cusparseStatus_t {.
      cdecl, importc: "cusparseCcsric02_bufferSizeExt", dyn.}
  proc cusparseZcsric02_bufferSizeExt*(handle: cusparseHandle_t; m: cint; nnz: cint;
                                      descrA: cusparseMatDescr_t;
                                      csrSortedVal: ptr cuDoubleComplex;
                                      csrSortedRowPtr: ptr cint;
                                      csrSortedColInd: ptr cint;
                                      info: csric02Info_t; pBufferSize: ptr csize): cusparseStatus_t {.
      cdecl, importc: "cusparseZcsric02_bufferSizeExt", dyn.}
  proc cusparseScsric02_analysis*(handle: cusparseHandle_t; m: cint; nnz: cint;
                                 descrA: cusparseMatDescr_t;
                                 csrSortedValA: ptr cfloat;
                                 csrSortedRowPtrA: ptr cint;
                                 csrSortedColIndA: ptr cint; info: csric02Info_t;
                                 policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseScsric02_analysis", dyn.}
  proc cusparseDcsric02_analysis*(handle: cusparseHandle_t; m: cint; nnz: cint;
                                 descrA: cusparseMatDescr_t;
                                 csrSortedValA: ptr cdouble;
                                 csrSortedRowPtrA: ptr cint;
                                 csrSortedColIndA: ptr cint; info: csric02Info_t;
                                 policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseDcsric02_analysis", dyn.}
  proc cusparseCcsric02_analysis*(handle: cusparseHandle_t; m: cint; nnz: cint;
                                 descrA: cusparseMatDescr_t;
                                 csrSortedValA: ptr cuComplex;
                                 csrSortedRowPtrA: ptr cint;
                                 csrSortedColIndA: ptr cint; info: csric02Info_t;
                                 policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseCcsric02_analysis", dyn.}
  proc cusparseZcsric02_analysis*(handle: cusparseHandle_t; m: cint; nnz: cint;
                                 descrA: cusparseMatDescr_t;
                                 csrSortedValA: ptr cuDoubleComplex;
                                 csrSortedRowPtrA: ptr cint;
                                 csrSortedColIndA: ptr cint; info: csric02Info_t;
                                 policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseZcsric02_analysis", dyn.}
  proc cusparseScsric02*(handle: cusparseHandle_t; m: cint; nnz: cint;
                        descrA: cusparseMatDescr_t;
                        csrSortedValA_valM: ptr cfloat; csrSortedRowPtrA: ptr cint;
                        csrSortedColIndA: ptr cint; info: csric02Info_t;
                        policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseScsric02", dyn.}
    ##  matrix A values are updated inplace 
    ##                                                  to be the preconditioner M values
  proc cusparseDcsric02*(handle: cusparseHandle_t; m: cint; nnz: cint;
                        descrA: cusparseMatDescr_t;
                        csrSortedValA_valM: ptr cdouble;
                        csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                        info: csric02Info_t; policy: cusparseSolvePolicy_t;
                        pBuffer: pointer): cusparseStatus_t {.cdecl,
      importc: "cusparseDcsric02", dyn.}
    ##  matrix A values are updated inplace 
    ##                                                  to be the preconditioner M values
  proc cusparseCcsric02*(handle: cusparseHandle_t; m: cint; nnz: cint;
                        descrA: cusparseMatDescr_t;
                        csrSortedValA_valM: ptr cuComplex;
                        csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                        info: csric02Info_t; policy: cusparseSolvePolicy_t;
                        pBuffer: pointer): cusparseStatus_t {.cdecl,
      importc: "cusparseCcsric02", dyn.}
    ##  matrix A values are updated inplace 
    ##                                                  to be the preconditioner M values
  proc cusparseZcsric02*(handle: cusparseHandle_t; m: cint; nnz: cint;
                        descrA: cusparseMatDescr_t;
                        csrSortedValA_valM: ptr cuDoubleComplex;
                        csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                        info: csric02Info_t; policy: cusparseSolvePolicy_t;
                        pBuffer: pointer): cusparseStatus_t {.cdecl,
      importc: "cusparseZcsric02", dyn.}
    ##  matrix A values are updated inplace 
    ##                                                  to be the preconditioner M values
  ##  Description: Compute the incomplete-Cholesky factorization with 0 fill-in (IC0)
  ##    of the matrix A stored in block-CSR format based on the information in the opaque 
  ##    structure info that was obtained from the analysis phase (bsrsv2_analysis). 
  ##    This routine implements algorithm 1 for this problem.
  proc cusparseXbsric02_zeroPivot*(handle: cusparseHandle_t; info: bsric02Info_t;
                                  position: ptr cint): cusparseStatus_t {.cdecl,
      importc: "cusparseXbsric02_zeroPivot", dyn.}
  proc cusparseSbsric02_bufferSize*(handle: cusparseHandle_t;
                                   dirA: cusparseDirection_t; mb: cint; nnzb: cint;
                                   descrA: cusparseMatDescr_t;
                                   bsrSortedVal: ptr cfloat;
                                   bsrSortedRowPtr: ptr cint;
                                   bsrSortedColInd: ptr cint; blockDim: cint;
                                   info: bsric02Info_t;
                                   pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseSbsric02_bufferSize", dyn.}
  proc cusparseDbsric02_bufferSize*(handle: cusparseHandle_t;
                                   dirA: cusparseDirection_t; mb: cint; nnzb: cint;
                                   descrA: cusparseMatDescr_t;
                                   bsrSortedVal: ptr cdouble;
                                   bsrSortedRowPtr: ptr cint;
                                   bsrSortedColInd: ptr cint; blockDim: cint;
                                   info: bsric02Info_t;
                                   pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseDbsric02_bufferSize", dyn.}
  proc cusparseCbsric02_bufferSize*(handle: cusparseHandle_t;
                                   dirA: cusparseDirection_t; mb: cint; nnzb: cint;
                                   descrA: cusparseMatDescr_t;
                                   bsrSortedVal: ptr cuComplex;
                                   bsrSortedRowPtr: ptr cint;
                                   bsrSortedColInd: ptr cint; blockDim: cint;
                                   info: bsric02Info_t;
                                   pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseCbsric02_bufferSize", dyn.}
  proc cusparseZbsric02_bufferSize*(handle: cusparseHandle_t;
                                   dirA: cusparseDirection_t; mb: cint; nnzb: cint;
                                   descrA: cusparseMatDescr_t;
                                   bsrSortedVal: ptr cuDoubleComplex;
                                   bsrSortedRowPtr: ptr cint;
                                   bsrSortedColInd: ptr cint; blockDim: cint;
                                   info: bsric02Info_t;
                                   pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseZbsric02_bufferSize", dyn.}
  proc cusparseSbsric02_bufferSizeExt*(handle: cusparseHandle_t;
                                      dirA: cusparseDirection_t; mb: cint;
                                      nnzb: cint; descrA: cusparseMatDescr_t;
                                      bsrSortedVal: ptr cfloat;
                                      bsrSortedRowPtr: ptr cint;
                                      bsrSortedColInd: ptr cint; blockSize: cint;
                                      info: bsric02Info_t; pBufferSize: ptr csize): cusparseStatus_t {.
      cdecl, importc: "cusparseSbsric02_bufferSizeExt", dyn.}
  proc cusparseDbsric02_bufferSizeExt*(handle: cusparseHandle_t;
                                      dirA: cusparseDirection_t; mb: cint;
                                      nnzb: cint; descrA: cusparseMatDescr_t;
                                      bsrSortedVal: ptr cdouble;
                                      bsrSortedRowPtr: ptr cint;
                                      bsrSortedColInd: ptr cint; blockSize: cint;
                                      info: bsric02Info_t; pBufferSize: ptr csize): cusparseStatus_t {.
      cdecl, importc: "cusparseDbsric02_bufferSizeExt", dyn.}
  proc cusparseCbsric02_bufferSizeExt*(handle: cusparseHandle_t;
                                      dirA: cusparseDirection_t; mb: cint;
                                      nnzb: cint; descrA: cusparseMatDescr_t;
                                      bsrSortedVal: ptr cuComplex;
                                      bsrSortedRowPtr: ptr cint;
                                      bsrSortedColInd: ptr cint; blockSize: cint;
                                      info: bsric02Info_t; pBufferSize: ptr csize): cusparseStatus_t {.
      cdecl, importc: "cusparseCbsric02_bufferSizeExt", dyn.}
  proc cusparseZbsric02_bufferSizeExt*(handle: cusparseHandle_t;
                                      dirA: cusparseDirection_t; mb: cint;
                                      nnzb: cint; descrA: cusparseMatDescr_t;
                                      bsrSortedVal: ptr cuDoubleComplex;
                                      bsrSortedRowPtr: ptr cint;
                                      bsrSortedColInd: ptr cint; blockSize: cint;
                                      info: bsric02Info_t; pBufferSize: ptr csize): cusparseStatus_t {.
      cdecl, importc: "cusparseZbsric02_bufferSizeExt", dyn.}
  proc cusparseSbsric02_analysis*(handle: cusparseHandle_t;
                                 dirA: cusparseDirection_t; mb: cint; nnzb: cint;
                                 descrA: cusparseMatDescr_t;
                                 bsrSortedVal: ptr cfloat;
                                 bsrSortedRowPtr: ptr cint;
                                 bsrSortedColInd: ptr cint; blockDim: cint;
                                 info: bsric02Info_t;
                                 policy: cusparseSolvePolicy_t;
                                 pInputBuffer: pointer): cusparseStatus_t {.cdecl,
      importc: "cusparseSbsric02_analysis", dyn.}
  proc cusparseDbsric02_analysis*(handle: cusparseHandle_t;
                                 dirA: cusparseDirection_t; mb: cint; nnzb: cint;
                                 descrA: cusparseMatDescr_t;
                                 bsrSortedVal: ptr cdouble;
                                 bsrSortedRowPtr: ptr cint;
                                 bsrSortedColInd: ptr cint; blockDim: cint;
                                 info: bsric02Info_t;
                                 policy: cusparseSolvePolicy_t;
                                 pInputBuffer: pointer): cusparseStatus_t {.cdecl,
      importc: "cusparseDbsric02_analysis", dyn.}
  proc cusparseCbsric02_analysis*(handle: cusparseHandle_t;
                                 dirA: cusparseDirection_t; mb: cint; nnzb: cint;
                                 descrA: cusparseMatDescr_t;
                                 bsrSortedVal: ptr cuComplex;
                                 bsrSortedRowPtr: ptr cint;
                                 bsrSortedColInd: ptr cint; blockDim: cint;
                                 info: bsric02Info_t;
                                 policy: cusparseSolvePolicy_t;
                                 pInputBuffer: pointer): cusparseStatus_t {.cdecl,
      importc: "cusparseCbsric02_analysis", dyn.}
  proc cusparseZbsric02_analysis*(handle: cusparseHandle_t;
                                 dirA: cusparseDirection_t; mb: cint; nnzb: cint;
                                 descrA: cusparseMatDescr_t;
                                 bsrSortedVal: ptr cuDoubleComplex;
                                 bsrSortedRowPtr: ptr cint;
                                 bsrSortedColInd: ptr cint; blockDim: cint;
                                 info: bsric02Info_t;
                                 policy: cusparseSolvePolicy_t;
                                 pInputBuffer: pointer): cusparseStatus_t {.cdecl,
      importc: "cusparseZbsric02_analysis", dyn.}
  proc cusparseSbsric02*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                        mb: cint; nnzb: cint; descrA: cusparseMatDescr_t;
                        bsrSortedVal: ptr cfloat; bsrSortedRowPtr: ptr cint;
                        bsrSortedColInd: ptr cint; blockDim: cint;
                        info: bsric02Info_t; policy: cusparseSolvePolicy_t;
                        pBuffer: pointer): cusparseStatus_t {.cdecl,
      importc: "cusparseSbsric02", dyn.}
  proc cusparseDbsric02*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                        mb: cint; nnzb: cint; descrA: cusparseMatDescr_t;
                        bsrSortedVal: ptr cdouble; bsrSortedRowPtr: ptr cint;
                        bsrSortedColInd: ptr cint; blockDim: cint;
                        info: bsric02Info_t; policy: cusparseSolvePolicy_t;
                        pBuffer: pointer): cusparseStatus_t {.cdecl,
      importc: "cusparseDbsric02", dyn.}
  proc cusparseCbsric02*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                        mb: cint; nnzb: cint; descrA: cusparseMatDescr_t;
                        bsrSortedVal: ptr cuComplex; bsrSortedRowPtr: ptr cint;
                        bsrSortedColInd: ptr cint; blockDim: cint;
                        info: bsric02Info_t; policy: cusparseSolvePolicy_t;
                        pBuffer: pointer): cusparseStatus_t {.cdecl,
      importc: "cusparseCbsric02", dyn.}
  proc cusparseZbsric02*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                        mb: cint; nnzb: cint; descrA: cusparseMatDescr_t;
                        bsrSortedVal: ptr cuDoubleComplex;
                        bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint;
                        blockDim: cint; info: bsric02Info_t;
                        policy: cusparseSolvePolicy_t; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseZbsric02", dyn.}
  ##  Description: Solution of tridiagonal linear system A * X = F, 
  ##    with multiple right-hand-sides. The coefficient matrix A is 
  ##    composed of lower (dl), main (d) and upper (du) diagonals, and 
  ##    the right-hand-sides F are overwritten with the solution X. 
  ##    These routine use pivoting.
  proc cusparseSgtsv*(handle: cusparseHandle_t; m: cint; n: cint; dl: ptr cfloat;
                     d: ptr cfloat; du: ptr cfloat; B: ptr cfloat; ldb: cint): cusparseStatus_t {.
      cdecl, importc: "cusparseSgtsv", dyn.}
  proc cusparseDgtsv*(handle: cusparseHandle_t; m: cint; n: cint; dl: ptr cdouble;
                     d: ptr cdouble; du: ptr cdouble; B: ptr cdouble; ldb: cint): cusparseStatus_t {.
      cdecl, importc: "cusparseDgtsv", dyn.}
  proc cusparseCgtsv*(handle: cusparseHandle_t; m: cint; n: cint; dl: ptr cuComplex;
                     d: ptr cuComplex; du: ptr cuComplex; B: ptr cuComplex; ldb: cint): cusparseStatus_t {.
      cdecl, importc: "cusparseCgtsv", dyn.}
  proc cusparseZgtsv*(handle: cusparseHandle_t; m: cint; n: cint;
                     dl: ptr cuDoubleComplex; d: ptr cuDoubleComplex;
                     du: ptr cuDoubleComplex; B: ptr cuDoubleComplex; ldb: cint): cusparseStatus_t {.
      cdecl, importc: "cusparseZgtsv", dyn.}
  ##  Description: Solution of tridiagonal linear system A * X = F, 
  ##    with multiple right-hand-sides. The coefficient matrix A is 
  ##    composed of lower (dl), main (d) and upper (du) diagonals, and 
  ##    the right-hand-sides F are overwritten with the solution X. 
  ##    These routine does not use pivoting.
  proc cusparseSgtsv_nopivot*(handle: cusparseHandle_t; m: cint; n: cint;
                             dl: ptr cfloat; d: ptr cfloat; du: ptr cfloat;
                             B: ptr cfloat; ldb: cint): cusparseStatus_t {.cdecl,
      importc: "cusparseSgtsv_nopivot", dyn.}
  proc cusparseDgtsv_nopivot*(handle: cusparseHandle_t; m: cint; n: cint;
                             dl: ptr cdouble; d: ptr cdouble; du: ptr cdouble;
                             B: ptr cdouble; ldb: cint): cusparseStatus_t {.cdecl,
      importc: "cusparseDgtsv_nopivot", dyn.}
  proc cusparseCgtsv_nopivot*(handle: cusparseHandle_t; m: cint; n: cint;
                             dl: ptr cuComplex; d: ptr cuComplex; du: ptr cuComplex;
                             B: ptr cuComplex; ldb: cint): cusparseStatus_t {.cdecl,
      importc: "cusparseCgtsv_nopivot", dyn.}
  proc cusparseZgtsv_nopivot*(handle: cusparseHandle_t; m: cint; n: cint;
                             dl: ptr cuDoubleComplex; d: ptr cuDoubleComplex;
                             du: ptr cuDoubleComplex; B: ptr cuDoubleComplex;
                             ldb: cint): cusparseStatus_t {.cdecl,
      importc: "cusparseZgtsv_nopivot", dyn.}
  ##  Description: Solution of a set of tridiagonal linear systems 
  ##    A_{i} * x_{i} = f_{i} for i=1,...,batchCount. The coefficient 
  ##    matrices A_{i} are composed of lower (dl), main (d) and upper (du) 
  ##    diagonals and stored separated by a batchStride. Also, the 
  ##    right-hand-sides/solutions f_{i}/x_{i} are separated by a batchStride.
  proc cusparseSgtsvStridedBatch*(handle: cusparseHandle_t; m: cint; dl: ptr cfloat;
                                 d: ptr cfloat; du: ptr cfloat; x: ptr cfloat;
                                 batchCount: cint; batchStride: cint): cusparseStatus_t {.
      cdecl, importc: "cusparseSgtsvStridedBatch", dyn.}
  proc cusparseDgtsvStridedBatch*(handle: cusparseHandle_t; m: cint; dl: ptr cdouble;
                                 d: ptr cdouble; du: ptr cdouble; x: ptr cdouble;
                                 batchCount: cint; batchStride: cint): cusparseStatus_t {.
      cdecl, importc: "cusparseDgtsvStridedBatch", dyn.}
  proc cusparseCgtsvStridedBatch*(handle: cusparseHandle_t; m: cint;
                                 dl: ptr cuComplex; d: ptr cuComplex;
                                 du: ptr cuComplex; x: ptr cuComplex;
                                 batchCount: cint; batchStride: cint): cusparseStatus_t {.
      cdecl, importc: "cusparseCgtsvStridedBatch", dyn.}
  proc cusparseZgtsvStridedBatch*(handle: cusparseHandle_t; m: cint;
                                 dl: ptr cuDoubleComplex; d: ptr cuDoubleComplex;
                                 du: ptr cuDoubleComplex; x: ptr cuDoubleComplex;
                                 batchCount: cint; batchStride: cint): cusparseStatus_t {.
      cdecl, importc: "cusparseZgtsvStridedBatch", dyn.}
  ##  --- Sparse Level 4 routines ---
  ##  Description: Compute sparse - sparse matrix multiplication for matrices 
  ##    stored in CSR format.
  proc cusparseXcsrgemmNnz*(handle: cusparseHandle_t; transA: cusparseOperation_t;
                           transB: cusparseOperation_t; m: cint; n: cint; k: cint;
                           descrA: cusparseMatDescr_t; nnzA: cint;
                           csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                           descrB: cusparseMatDescr_t; nnzB: cint;
                           csrSortedRowPtrB: ptr cint; csrSortedColIndB: ptr cint;
                           descrC: cusparseMatDescr_t; csrSortedRowPtrC: ptr cint;
                           nnzTotalDevHostPtr: ptr cint): cusparseStatus_t {.cdecl,
      importc: "cusparseXcsrgemmNnz", dyn.}
  proc cusparseScsrgemm*(handle: cusparseHandle_t; transA: cusparseOperation_t;
                        transB: cusparseOperation_t; m: cint; n: cint; k: cint;
                        descrA: cusparseMatDescr_t; nnzA: cint;
                        csrSortedValA: ptr cfloat; csrSortedRowPtrA: ptr cint;
                        csrSortedColIndA: ptr cint; descrB: cusparseMatDescr_t;
                        nnzB: cint; csrSortedValB: ptr cfloat;
                        csrSortedRowPtrB: ptr cint; csrSortedColIndB: ptr cint;
                        descrC: cusparseMatDescr_t; csrSortedValC: ptr cfloat;
                        csrSortedRowPtrC: ptr cint; csrSortedColIndC: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseScsrgemm", dyn.}
  proc cusparseDcsrgemm*(handle: cusparseHandle_t; transA: cusparseOperation_t;
                        transB: cusparseOperation_t; m: cint; n: cint; k: cint;
                        descrA: cusparseMatDescr_t; nnzA: cint;
                        csrSortedValA: ptr cdouble; csrSortedRowPtrA: ptr cint;
                        csrSortedColIndA: ptr cint; descrB: cusparseMatDescr_t;
                        nnzB: cint; csrSortedValB: ptr cdouble;
                        csrSortedRowPtrB: ptr cint; csrSortedColIndB: ptr cint;
                        descrC: cusparseMatDescr_t; csrSortedValC: ptr cdouble;
                        csrSortedRowPtrC: ptr cint; csrSortedColIndC: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseDcsrgemm", dyn.}
  proc cusparseCcsrgemm*(handle: cusparseHandle_t; transA: cusparseOperation_t;
                        transB: cusparseOperation_t; m: cint; n: cint; k: cint;
                        descrA: cusparseMatDescr_t; nnzA: cint;
                        csrSortedValA: ptr cuComplex; csrSortedRowPtrA: ptr cint;
                        csrSortedColIndA: ptr cint; descrB: cusparseMatDescr_t;
                        nnzB: cint; csrSortedValB: ptr cuComplex;
                        csrSortedRowPtrB: ptr cint; csrSortedColIndB: ptr cint;
                        descrC: cusparseMatDescr_t; csrSortedValC: ptr cuComplex;
                        csrSortedRowPtrC: ptr cint; csrSortedColIndC: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseCcsrgemm", dyn.}
  proc cusparseZcsrgemm*(handle: cusparseHandle_t; transA: cusparseOperation_t;
                        transB: cusparseOperation_t; m: cint; n: cint; k: cint;
                        descrA: cusparseMatDescr_t; nnzA: cint;
                        csrSortedValA: ptr cuDoubleComplex;
                        csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                        descrB: cusparseMatDescr_t; nnzB: cint;
                        csrSortedValB: ptr cuDoubleComplex;
                        csrSortedRowPtrB: ptr cint; csrSortedColIndB: ptr cint;
                        descrC: cusparseMatDescr_t;
                        csrSortedValC: ptr cuDoubleComplex;
                        csrSortedRowPtrC: ptr cint; csrSortedColIndC: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseZcsrgemm", dyn.}
  ##  Description: Compute sparse - sparse matrix multiplication for matrices 
  ##    stored in CSR format.
  proc cusparseCreateCsrgemm2Info*(info: ptr csrgemm2Info_t): cusparseStatus_t {.
      cdecl, importc: "cusparseCreateCsrgemm2Info", dyn.}
  proc cusparseDestroyCsrgemm2Info*(info: csrgemm2Info_t): cusparseStatus_t {.cdecl,
      importc: "cusparseDestroyCsrgemm2Info", dyn.}
  proc cusparseScsrgemm2_bufferSizeExt*(handle: cusparseHandle_t; m: cint; n: cint;
                                       k: cint; alpha: ptr cfloat;
                                       descrA: cusparseMatDescr_t; nnzA: cint;
                                       csrSortedRowPtrA: ptr cint;
                                       csrSortedColIndA: ptr cint;
                                       descrB: cusparseMatDescr_t; nnzB: cint;
                                       csrSortedRowPtrB: ptr cint;
                                       csrSortedColIndB: ptr cint;
                                       beta: ptr cfloat;
                                       descrD: cusparseMatDescr_t; nnzD: cint;
                                       csrSortedRowPtrD: ptr cint;
                                       csrSortedColIndD: ptr cint;
                                       info: csrgemm2Info_t;
                                       pBufferSizeInBytes: ptr csize): cusparseStatus_t {.
      cdecl, importc: "cusparseScsrgemm2_bufferSizeExt", dyn.}
  proc cusparseDcsrgemm2_bufferSizeExt*(handle: cusparseHandle_t; m: cint; n: cint;
                                       k: cint; alpha: ptr cdouble;
                                       descrA: cusparseMatDescr_t; nnzA: cint;
                                       csrSortedRowPtrA: ptr cint;
                                       csrSortedColIndA: ptr cint;
                                       descrB: cusparseMatDescr_t; nnzB: cint;
                                       csrSortedRowPtrB: ptr cint;
                                       csrSortedColIndB: ptr cint;
                                       beta: ptr cdouble;
                                       descrD: cusparseMatDescr_t; nnzD: cint;
                                       csrSortedRowPtrD: ptr cint;
                                       csrSortedColIndD: ptr cint;
                                       info: csrgemm2Info_t;
                                       pBufferSizeInBytes: ptr csize): cusparseStatus_t {.
      cdecl, importc: "cusparseDcsrgemm2_bufferSizeExt", dyn.}
  proc cusparseCcsrgemm2_bufferSizeExt*(handle: cusparseHandle_t; m: cint; n: cint;
                                       k: cint; alpha: ptr cuComplex;
                                       descrA: cusparseMatDescr_t; nnzA: cint;
                                       csrSortedRowPtrA: ptr cint;
                                       csrSortedColIndA: ptr cint;
                                       descrB: cusparseMatDescr_t; nnzB: cint;
                                       csrSortedRowPtrB: ptr cint;
                                       csrSortedColIndB: ptr cint;
                                       beta: ptr cuComplex;
                                       descrD: cusparseMatDescr_t; nnzD: cint;
                                       csrSortedRowPtrD: ptr cint;
                                       csrSortedColIndD: ptr cint;
                                       info: csrgemm2Info_t;
                                       pBufferSizeInBytes: ptr csize): cusparseStatus_t {.
      cdecl, importc: "cusparseCcsrgemm2_bufferSizeExt", dyn.}
  proc cusparseZcsrgemm2_bufferSizeExt*(handle: cusparseHandle_t; m: cint; n: cint;
                                       k: cint; alpha: ptr cuDoubleComplex;
                                       descrA: cusparseMatDescr_t; nnzA: cint;
                                       csrSortedRowPtrA: ptr cint;
                                       csrSortedColIndA: ptr cint;
                                       descrB: cusparseMatDescr_t; nnzB: cint;
                                       csrSortedRowPtrB: ptr cint;
                                       csrSortedColIndB: ptr cint;
                                       beta: ptr cuDoubleComplex;
                                       descrD: cusparseMatDescr_t; nnzD: cint;
                                       csrSortedRowPtrD: ptr cint;
                                       csrSortedColIndD: ptr cint;
                                       info: csrgemm2Info_t;
                                       pBufferSizeInBytes: ptr csize): cusparseStatus_t {.
      cdecl, importc: "cusparseZcsrgemm2_bufferSizeExt", dyn.}
  proc cusparseXcsrgemm2Nnz*(handle: cusparseHandle_t; m: cint; n: cint; k: cint;
                            descrA: cusparseMatDescr_t; nnzA: cint;
                            csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                            descrB: cusparseMatDescr_t; nnzB: cint;
                            csrSortedRowPtrB: ptr cint; csrSortedColIndB: ptr cint;
                            descrD: cusparseMatDescr_t; nnzD: cint;
                            csrSortedRowPtrD: ptr cint; csrSortedColIndD: ptr cint;
                            descrC: cusparseMatDescr_t;
                            csrSortedRowPtrC: ptr cint;
                            nnzTotalDevHostPtr: ptr cint; info: csrgemm2Info_t;
                            pBuffer: pointer): cusparseStatus_t {.cdecl,
      importc: "cusparseXcsrgemm2Nnz", dyn.}
  proc cusparseScsrgemm2*(handle: cusparseHandle_t; m: cint; n: cint; k: cint;
                         alpha: ptr cfloat; descrA: cusparseMatDescr_t; nnzA: cint;
                         csrSortedValA: ptr cfloat; csrSortedRowPtrA: ptr cint;
                         csrSortedColIndA: ptr cint; descrB: cusparseMatDescr_t;
                         nnzB: cint; csrSortedValB: ptr cfloat;
                         csrSortedRowPtrB: ptr cint; csrSortedColIndB: ptr cint;
                         beta: ptr cfloat; descrD: cusparseMatDescr_t; nnzD: cint;
                         csrSortedValD: ptr cfloat; csrSortedRowPtrD: ptr cint;
                         csrSortedColIndD: ptr cint; descrC: cusparseMatDescr_t;
                         csrSortedValC: ptr cfloat; csrSortedRowPtrC: ptr cint;
                         csrSortedColIndC: ptr cint; info: csrgemm2Info_t;
                         pBuffer: pointer): cusparseStatus_t {.cdecl,
      importc: "cusparseScsrgemm2", dyn.}
  proc cusparseDcsrgemm2*(handle: cusparseHandle_t; m: cint; n: cint; k: cint;
                         alpha: ptr cdouble; descrA: cusparseMatDescr_t; nnzA: cint;
                         csrSortedValA: ptr cdouble; csrSortedRowPtrA: ptr cint;
                         csrSortedColIndA: ptr cint; descrB: cusparseMatDescr_t;
                         nnzB: cint; csrSortedValB: ptr cdouble;
                         csrSortedRowPtrB: ptr cint; csrSortedColIndB: ptr cint;
                         beta: ptr cdouble; descrD: cusparseMatDescr_t; nnzD: cint;
                         csrSortedValD: ptr cdouble; csrSortedRowPtrD: ptr cint;
                         csrSortedColIndD: ptr cint; descrC: cusparseMatDescr_t;
                         csrSortedValC: ptr cdouble; csrSortedRowPtrC: ptr cint;
                         csrSortedColIndC: ptr cint; info: csrgemm2Info_t;
                         pBuffer: pointer): cusparseStatus_t {.cdecl,
      importc: "cusparseDcsrgemm2", dyn.}
  proc cusparseCcsrgemm2*(handle: cusparseHandle_t; m: cint; n: cint; k: cint;
                         alpha: ptr cuComplex; descrA: cusparseMatDescr_t;
                         nnzA: cint; csrSortedValA: ptr cuComplex;
                         csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                         descrB: cusparseMatDescr_t; nnzB: cint;
                         csrSortedValB: ptr cuComplex; csrSortedRowPtrB: ptr cint;
                         csrSortedColIndB: ptr cint; beta: ptr cuComplex;
                         descrD: cusparseMatDescr_t; nnzD: cint;
                         csrSortedValD: ptr cuComplex; csrSortedRowPtrD: ptr cint;
                         csrSortedColIndD: ptr cint; descrC: cusparseMatDescr_t;
                         csrSortedValC: ptr cuComplex; csrSortedRowPtrC: ptr cint;
                         csrSortedColIndC: ptr cint; info: csrgemm2Info_t;
                         pBuffer: pointer): cusparseStatus_t {.cdecl,
      importc: "cusparseCcsrgemm2", dyn.}
  proc cusparseZcsrgemm2*(handle: cusparseHandle_t; m: cint; n: cint; k: cint;
                         alpha: ptr cuDoubleComplex; descrA: cusparseMatDescr_t;
                         nnzA: cint; csrSortedValA: ptr cuDoubleComplex;
                         csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                         descrB: cusparseMatDescr_t; nnzB: cint;
                         csrSortedValB: ptr cuDoubleComplex;
                         csrSortedRowPtrB: ptr cint; csrSortedColIndB: ptr cint;
                         beta: ptr cuDoubleComplex; descrD: cusparseMatDescr_t;
                         nnzD: cint; csrSortedValD: ptr cuDoubleComplex;
                         csrSortedRowPtrD: ptr cint; csrSortedColIndD: ptr cint;
                         descrC: cusparseMatDescr_t;
                         csrSortedValC: ptr cuDoubleComplex;
                         csrSortedRowPtrC: ptr cint; csrSortedColIndC: ptr cint;
                         info: csrgemm2Info_t; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseZcsrgemm2", dyn.}
  ##  Description: Compute sparse - sparse matrix addition of matrices 
  ##    stored in CSR format
  proc cusparseXcsrgeamNnz*(handle: cusparseHandle_t; m: cint; n: cint;
                           descrA: cusparseMatDescr_t; nnzA: cint;
                           csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                           descrB: cusparseMatDescr_t; nnzB: cint;
                           csrSortedRowPtrB: ptr cint; csrSortedColIndB: ptr cint;
                           descrC: cusparseMatDescr_t; csrSortedRowPtrC: ptr cint;
                           nnzTotalDevHostPtr: ptr cint): cusparseStatus_t {.cdecl,
      importc: "cusparseXcsrgeamNnz", dyn.}
  proc cusparseScsrgeam*(handle: cusparseHandle_t; m: cint; n: cint; alpha: ptr cfloat;
                        descrA: cusparseMatDescr_t; nnzA: cint;
                        csrSortedValA: ptr cfloat; csrSortedRowPtrA: ptr cint;
                        csrSortedColIndA: ptr cint; beta: ptr cfloat;
                        descrB: cusparseMatDescr_t; nnzB: cint;
                        csrSortedValB: ptr cfloat; csrSortedRowPtrB: ptr cint;
                        csrSortedColIndB: ptr cint; descrC: cusparseMatDescr_t;
                        csrSortedValC: ptr cfloat; csrSortedRowPtrC: ptr cint;
                        csrSortedColIndC: ptr cint): cusparseStatus_t {.cdecl,
      importc: "cusparseScsrgeam", dyn.}
  proc cusparseDcsrgeam*(handle: cusparseHandle_t; m: cint; n: cint;
                        alpha: ptr cdouble; descrA: cusparseMatDescr_t; nnzA: cint;
                        csrSortedValA: ptr cdouble; csrSortedRowPtrA: ptr cint;
                        csrSortedColIndA: ptr cint; beta: ptr cdouble;
                        descrB: cusparseMatDescr_t; nnzB: cint;
                        csrSortedValB: ptr cdouble; csrSortedRowPtrB: ptr cint;
                        csrSortedColIndB: ptr cint; descrC: cusparseMatDescr_t;
                        csrSortedValC: ptr cdouble; csrSortedRowPtrC: ptr cint;
                        csrSortedColIndC: ptr cint): cusparseStatus_t {.cdecl,
      importc: "cusparseDcsrgeam", dyn.}
  proc cusparseCcsrgeam*(handle: cusparseHandle_t; m: cint; n: cint;
                        alpha: ptr cuComplex; descrA: cusparseMatDescr_t; nnzA: cint;
                        csrSortedValA: ptr cuComplex; csrSortedRowPtrA: ptr cint;
                        csrSortedColIndA: ptr cint; beta: ptr cuComplex;
                        descrB: cusparseMatDescr_t; nnzB: cint;
                        csrSortedValB: ptr cuComplex; csrSortedRowPtrB: ptr cint;
                        csrSortedColIndB: ptr cint; descrC: cusparseMatDescr_t;
                        csrSortedValC: ptr cuComplex; csrSortedRowPtrC: ptr cint;
                        csrSortedColIndC: ptr cint): cusparseStatus_t {.cdecl,
      importc: "cusparseCcsrgeam", dyn.}
  proc cusparseZcsrgeam*(handle: cusparseHandle_t; m: cint; n: cint;
                        alpha: ptr cuDoubleComplex; descrA: cusparseMatDescr_t;
                        nnzA: cint; csrSortedValA: ptr cuDoubleComplex;
                        csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                        beta: ptr cuDoubleComplex; descrB: cusparseMatDescr_t;
                        nnzB: cint; csrSortedValB: ptr cuDoubleComplex;
                        csrSortedRowPtrB: ptr cint; csrSortedColIndB: ptr cint;
                        descrC: cusparseMatDescr_t;
                        csrSortedValC: ptr cuDoubleComplex;
                        csrSortedRowPtrC: ptr cint; csrSortedColIndC: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseZcsrgeam", dyn.}
  ##  --- Sparse Matrix Reorderings ---
  ##  Description: Find an approximate coloring of a matrix stored in CSR format.
  proc cusparseScsrcolor*(handle: cusparseHandle_t; m: cint; nnz: cint;
                         descrA: cusparseMatDescr_t; csrSortedValA: ptr cfloat;
                         csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                         fractionToColor: ptr cfloat; ncolors: ptr cint;
                         coloring: ptr cint; reordering: ptr cint;
                         info: cusparseColorInfo_t): cusparseStatus_t {.cdecl,
      importc: "cusparseScsrcolor", dyn.}
  proc cusparseDcsrcolor*(handle: cusparseHandle_t; m: cint; nnz: cint;
                         descrA: cusparseMatDescr_t; csrSortedValA: ptr cdouble;
                         csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                         fractionToColor: ptr cdouble; ncolors: ptr cint;
                         coloring: ptr cint; reordering: ptr cint;
                         info: cusparseColorInfo_t): cusparseStatus_t {.cdecl,
      importc: "cusparseDcsrcolor", dyn.}
  proc cusparseCcsrcolor*(handle: cusparseHandle_t; m: cint; nnz: cint;
                         descrA: cusparseMatDescr_t; csrSortedValA: ptr cuComplex;
                         csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                         fractionToColor: ptr cfloat; ncolors: ptr cint;
                         coloring: ptr cint; reordering: ptr cint;
                         info: cusparseColorInfo_t): cusparseStatus_t {.cdecl,
      importc: "cusparseCcsrcolor", dyn.}
  proc cusparseZcsrcolor*(handle: cusparseHandle_t; m: cint; nnz: cint;
                         descrA: cusparseMatDescr_t;
                         csrSortedValA: ptr cuDoubleComplex;
                         csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                         fractionToColor: ptr cdouble; ncolors: ptr cint;
                         coloring: ptr cint; reordering: ptr cint;
                         info: cusparseColorInfo_t): cusparseStatus_t {.cdecl,
      importc: "cusparseZcsrcolor", dyn.}
  ##  --- Sparse Format Conversion ---
  ##  Description: This routine finds the total number of non-zero elements and 
  ##    the number of non-zero elements per row or column in the dense matrix A.
  proc cusparseSnnz*(handle: cusparseHandle_t; dirA: cusparseDirection_t; m: cint;
                    n: cint; descrA: cusparseMatDescr_t; A: ptr cfloat; lda: cint;
                    nnzPerRowCol: ptr cint; nnzTotalDevHostPtr: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseSnnz", dyn.}
  proc cusparseDnnz*(handle: cusparseHandle_t; dirA: cusparseDirection_t; m: cint;
                    n: cint; descrA: cusparseMatDescr_t; A: ptr cdouble; lda: cint;
                    nnzPerRowCol: ptr cint; nnzTotalDevHostPtr: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseDnnz", dyn.}
  proc cusparseCnnz*(handle: cusparseHandle_t; dirA: cusparseDirection_t; m: cint;
                    n: cint; descrA: cusparseMatDescr_t; A: ptr cuComplex; lda: cint;
                    nnzPerRowCol: ptr cint; nnzTotalDevHostPtr: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseCnnz", dyn.}
  proc cusparseZnnz*(handle: cusparseHandle_t; dirA: cusparseDirection_t; m: cint;
                    n: cint; descrA: cusparseMatDescr_t; A: ptr cuDoubleComplex;
                    lda: cint; nnzPerRowCol: ptr cint; nnzTotalDevHostPtr: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseZnnz", dyn.}
  ##  --- Sparse Format Conversion ---
  ##  Description: This routine finds the total number of non-zero elements and 
  ##    the number of non-zero elements per row in a noncompressed csr matrix A.
  proc cusparseSnnz_compress*(handle: cusparseHandle_t; m: cint;
                             descr: cusparseMatDescr_t; values: ptr cfloat;
                             rowPtr: ptr cint; nnzPerRow: ptr cint;
                             nnzTotal: ptr cint; tol: cfloat): cusparseStatus_t {.
      cdecl, importc: "cusparseSnnz_compress", dyn.}
  proc cusparseDnnz_compress*(handle: cusparseHandle_t; m: cint;
                             descr: cusparseMatDescr_t; values: ptr cdouble;
                             rowPtr: ptr cint; nnzPerRow: ptr cint;
                             nnzTotal: ptr cint; tol: cdouble): cusparseStatus_t {.
      cdecl, importc: "cusparseDnnz_compress", dyn.}
  proc cusparseCnnz_compress*(handle: cusparseHandle_t; m: cint;
                             descr: cusparseMatDescr_t; values: ptr cuComplex;
                             rowPtr: ptr cint; nnzPerRow: ptr cint;
                             nnzTotal: ptr cint; tol: cuComplex): cusparseStatus_t {.
      cdecl, importc: "cusparseCnnz_compress", dyn.}
  proc cusparseZnnz_compress*(handle: cusparseHandle_t; m: cint;
                             descr: cusparseMatDescr_t;
                             values: ptr cuDoubleComplex; rowPtr: ptr cint;
                             nnzPerRow: ptr cint; nnzTotal: ptr cint;
                             tol: cuDoubleComplex): cusparseStatus_t {.cdecl,
      importc: "cusparseZnnz_compress", dyn.}
  ##  Description: This routine takes as input a csr form where the values may have 0 elements
  ##    and compresses it to return a csr form with no zeros.
  proc cusparseScsr2csr_compress*(handle: cusparseHandle_t; m: cint; n: cint;
                                 descra: cusparseMatDescr_t; inVal: ptr cfloat;
                                 inColInd: ptr cint; inRowPtr: ptr cint; inNnz: cint;
                                 nnzPerRow: ptr cint; outVal: ptr cfloat;
                                 outColInd: ptr cint; outRowPtr: ptr cint; tol: cfloat): cusparseStatus_t {.
      cdecl, importc: "cusparseScsr2csr_compress", dyn.}
  proc cusparseDcsr2csr_compress*(handle: cusparseHandle_t; m: cint; n: cint;
                                 descra: cusparseMatDescr_t; inVal: ptr cdouble;
                                 inColInd: ptr cint; inRowPtr: ptr cint; inNnz: cint;
                                 nnzPerRow: ptr cint; outVal: ptr cdouble;
                                 outColInd: ptr cint; outRowPtr: ptr cint;
                                 tol: cdouble): cusparseStatus_t {.cdecl,
      importc: "cusparseDcsr2csr_compress", dyn.}
    ## number of rows
    ## csr values array-the elements which are below a certain tolerance will be remvoed
    ## corresponding input noncompressed row pointer
    ## output: returns number of nonzeros per row
  proc cusparseCcsr2csr_compress*(handle: cusparseHandle_t; m: cint; n: cint;
                                 descra: cusparseMatDescr_t; inVal: ptr cuComplex;
                                 inColInd: ptr cint; inRowPtr: ptr cint; inNnz: cint;
                                 nnzPerRow: ptr cint; outVal: ptr cuComplex;
                                 outColInd: ptr cint; outRowPtr: ptr cint;
                                 tol: cuComplex): cusparseStatus_t {.cdecl,
      importc: "cusparseCcsr2csr_compress", dyn.}
    ## number of rows
    ## csr values array-the elements which are below a certain tolerance will be remvoed
    ## corresponding input noncompressed row pointer
    ## output: returns number of nonzeros per row
  proc cusparseZcsr2csr_compress*(handle: cusparseHandle_t; m: cint; n: cint;
                                 descra: cusparseMatDescr_t;
                                 inVal: ptr cuDoubleComplex; inColInd: ptr cint;
                                 inRowPtr: ptr cint; inNnz: cint;
                                 nnzPerRow: ptr cint; outVal: ptr cuDoubleComplex;
                                 outColInd: ptr cint; outRowPtr: ptr cint;
                                 tol: cuDoubleComplex): cusparseStatus_t {.cdecl,
      importc: "cusparseZcsr2csr_compress", dyn.}
    ## number of rows
    ## csr values array-the elements which are below a certain tolerance will be remvoed
    ## corresponding input noncompressed row pointer
    ## output: returns number of nonzeros per row
  ##  Description: This routine converts a dense matrix to a sparse matrix 
  ##    in the CSR storage format, using the information computed by the 
  ##    nnz routine.
  proc cusparseSdense2csr*(handle: cusparseHandle_t; m: cint; n: cint;
                          descrA: cusparseMatDescr_t; A: ptr cfloat; lda: cint;
                          nnzPerRow: ptr cint; csrSortedValA: ptr cfloat;
                          csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseSdense2csr", dyn.}
  proc cusparseDdense2csr*(handle: cusparseHandle_t; m: cint; n: cint;
                          descrA: cusparseMatDescr_t; A: ptr cdouble; lda: cint;
                          nnzPerRow: ptr cint; csrSortedValA: ptr cdouble;
                          csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseDdense2csr", dyn.}
  proc cusparseCdense2csr*(handle: cusparseHandle_t; m: cint; n: cint;
                          descrA: cusparseMatDescr_t; A: ptr cuComplex; lda: cint;
                          nnzPerRow: ptr cint; csrSortedValA: ptr cuComplex;
                          csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseCdense2csr", dyn.}
  proc cusparseZdense2csr*(handle: cusparseHandle_t; m: cint; n: cint;
                          descrA: cusparseMatDescr_t; A: ptr cuDoubleComplex;
                          lda: cint; nnzPerRow: ptr cint;
                          csrSortedValA: ptr cuDoubleComplex;
                          csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseZdense2csr", dyn.}
  ##  Description: This routine converts a sparse matrix in CSR storage format
  ##    to a dense matrix.
  proc cusparseScsr2dense*(handle: cusparseHandle_t; m: cint; n: cint;
                          descrA: cusparseMatDescr_t; csrSortedValA: ptr cfloat;
                          csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                          A: ptr cfloat; lda: cint): cusparseStatus_t {.cdecl,
      importc: "cusparseScsr2dense", dyn.}
  proc cusparseDcsr2dense*(handle: cusparseHandle_t; m: cint; n: cint;
                          descrA: cusparseMatDescr_t; csrSortedValA: ptr cdouble;
                          csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                          A: ptr cdouble; lda: cint): cusparseStatus_t {.cdecl,
      importc: "cusparseDcsr2dense", dyn.}
  proc cusparseCcsr2dense*(handle: cusparseHandle_t; m: cint; n: cint;
                          descrA: cusparseMatDescr_t;
                          csrSortedValA: ptr cuComplex; csrSortedRowPtrA: ptr cint;
                          csrSortedColIndA: ptr cint; A: ptr cuComplex; lda: cint): cusparseStatus_t {.
      cdecl, importc: "cusparseCcsr2dense", dyn.}
  proc cusparseZcsr2dense*(handle: cusparseHandle_t; m: cint; n: cint;
                          descrA: cusparseMatDescr_t;
                          csrSortedValA: ptr cuDoubleComplex;
                          csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                          A: ptr cuDoubleComplex; lda: cint): cusparseStatus_t {.
      cdecl, importc: "cusparseZcsr2dense", dyn.}
  ##  Description: This routine converts a dense matrix to a sparse matrix 
  ##    in the CSC storage format, using the information computed by the 
  ##    nnz routine.
  proc cusparseSdense2csc*(handle: cusparseHandle_t; m: cint; n: cint;
                          descrA: cusparseMatDescr_t; A: ptr cfloat; lda: cint;
                          nnzPerCol: ptr cint; cscSortedValA: ptr cfloat;
                          cscSortedRowIndA: ptr cint; cscSortedColPtrA: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseSdense2csc", dyn.}
  proc cusparseDdense2csc*(handle: cusparseHandle_t; m: cint; n: cint;
                          descrA: cusparseMatDescr_t; A: ptr cdouble; lda: cint;
                          nnzPerCol: ptr cint; cscSortedValA: ptr cdouble;
                          cscSortedRowIndA: ptr cint; cscSortedColPtrA: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseDdense2csc", dyn.}
  proc cusparseCdense2csc*(handle: cusparseHandle_t; m: cint; n: cint;
                          descrA: cusparseMatDescr_t; A: ptr cuComplex; lda: cint;
                          nnzPerCol: ptr cint; cscSortedValA: ptr cuComplex;
                          cscSortedRowIndA: ptr cint; cscSortedColPtrA: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseCdense2csc", dyn.}
  proc cusparseZdense2csc*(handle: cusparseHandle_t; m: cint; n: cint;
                          descrA: cusparseMatDescr_t; A: ptr cuDoubleComplex;
                          lda: cint; nnzPerCol: ptr cint;
                          cscSortedValA: ptr cuDoubleComplex;
                          cscSortedRowIndA: ptr cint; cscSortedColPtrA: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseZdense2csc", dyn.}
  ##  Description: This routine converts a sparse matrix in CSC storage format
  ##    to a dense matrix.
  proc cusparseScsc2dense*(handle: cusparseHandle_t; m: cint; n: cint;
                          descrA: cusparseMatDescr_t; cscSortedValA: ptr cfloat;
                          cscSortedRowIndA: ptr cint; cscSortedColPtrA: ptr cint;
                          A: ptr cfloat; lda: cint): cusparseStatus_t {.cdecl,
      importc: "cusparseScsc2dense", dyn.}
  proc cusparseDcsc2dense*(handle: cusparseHandle_t; m: cint; n: cint;
                          descrA: cusparseMatDescr_t; cscSortedValA: ptr cdouble;
                          cscSortedRowIndA: ptr cint; cscSortedColPtrA: ptr cint;
                          A: ptr cdouble; lda: cint): cusparseStatus_t {.cdecl,
      importc: "cusparseDcsc2dense", dyn.}
  proc cusparseCcsc2dense*(handle: cusparseHandle_t; m: cint; n: cint;
                          descrA: cusparseMatDescr_t;
                          cscSortedValA: ptr cuComplex; cscSortedRowIndA: ptr cint;
                          cscSortedColPtrA: ptr cint; A: ptr cuComplex; lda: cint): cusparseStatus_t {.
      cdecl, importc: "cusparseCcsc2dense", dyn.}
  proc cusparseZcsc2dense*(handle: cusparseHandle_t; m: cint; n: cint;
                          descrA: cusparseMatDescr_t;
                          cscSortedValA: ptr cuDoubleComplex;
                          cscSortedRowIndA: ptr cint; cscSortedColPtrA: ptr cint;
                          A: ptr cuDoubleComplex; lda: cint): cusparseStatus_t {.
      cdecl, importc: "cusparseZcsc2dense", dyn.}
  ##  Description: This routine compresses the indecis of rows or columns.
  ##    It can be interpreted as a conversion from COO to CSR sparse storage
  ##    format.
  proc cusparseXcoo2csr*(handle: cusparseHandle_t; cooRowInd: ptr cint; nnz: cint;
                        m: cint; csrSortedRowPtr: ptr cint;
                        idxBase: cusparseIndexBase_t): cusparseStatus_t {.cdecl,
      importc: "cusparseXcoo2csr", dyn.}
  ##  Description: This routine uncompresses the indecis of rows or columns.
  ##    It can be interpreted as a conversion from CSR to COO sparse storage
  ##    format.
  proc cusparseXcsr2coo*(handle: cusparseHandle_t; csrSortedRowPtr: ptr cint;
                        nnz: cint; m: cint; cooRowInd: ptr cint;
                        idxBase: cusparseIndexBase_t): cusparseStatus_t {.cdecl,
      importc: "cusparseXcsr2coo", dyn.}
  ##  Description: This routine converts a matrix from CSR to CSC sparse 
  ##    storage format. The resulting matrix can be re-interpreted as a 
  ##    transpose of the original matrix in CSR storage format.
  proc cusparseCsr2cscEx*(handle: cusparseHandle_t; m: cint; n: cint; nnz: cint;
                         csrSortedVal: pointer; csrSortedValtype: cudaDataType;
                         csrSortedRowPtr: ptr cint; csrSortedColInd: ptr cint;
                         cscSortedVal: pointer; cscSortedValtype: cudaDataType;
                         cscSortedRowInd: ptr cint; cscSortedColPtr: ptr cint;
                         copyValues: cusparseAction_t;
                         idxBase: cusparseIndexBase_t; executiontype: cudaDataType): cusparseStatus_t {.
      cdecl, importc: "cusparseCsr2cscEx", dyn.}
  proc cusparseScsr2csc*(handle: cusparseHandle_t; m: cint; n: cint; nnz: cint;
                        csrSortedVal: ptr cfloat; csrSortedRowPtr: ptr cint;
                        csrSortedColInd: ptr cint; cscSortedVal: ptr cfloat;
                        cscSortedRowInd: ptr cint; cscSortedColPtr: ptr cint;
                        copyValues: cusparseAction_t; idxBase: cusparseIndexBase_t): cusparseStatus_t {.
      cdecl, importc: "cusparseScsr2csc", dyn.}
  proc cusparseDcsr2csc*(handle: cusparseHandle_t; m: cint; n: cint; nnz: cint;
                        csrSortedVal: ptr cdouble; csrSortedRowPtr: ptr cint;
                        csrSortedColInd: ptr cint; cscSortedVal: ptr cdouble;
                        cscSortedRowInd: ptr cint; cscSortedColPtr: ptr cint;
                        copyValues: cusparseAction_t; idxBase: cusparseIndexBase_t): cusparseStatus_t {.
      cdecl, importc: "cusparseDcsr2csc", dyn.}
  proc cusparseCcsr2csc*(handle: cusparseHandle_t; m: cint; n: cint; nnz: cint;
                        csrSortedVal: ptr cuComplex; csrSortedRowPtr: ptr cint;
                        csrSortedColInd: ptr cint; cscSortedVal: ptr cuComplex;
                        cscSortedRowInd: ptr cint; cscSortedColPtr: ptr cint;
                        copyValues: cusparseAction_t; idxBase: cusparseIndexBase_t): cusparseStatus_t {.
      cdecl, importc: "cusparseCcsr2csc", dyn.}
  proc cusparseZcsr2csc*(handle: cusparseHandle_t; m: cint; n: cint; nnz: cint;
                        csrSortedVal: ptr cuDoubleComplex;
                        csrSortedRowPtr: ptr cint; csrSortedColInd: ptr cint;
                        cscSortedVal: ptr cuDoubleComplex;
                        cscSortedRowInd: ptr cint; cscSortedColPtr: ptr cint;
                        copyValues: cusparseAction_t; idxBase: cusparseIndexBase_t): cusparseStatus_t {.
      cdecl, importc: "cusparseZcsr2csc", dyn.}
  ##  Description: This routine converts a dense matrix to a sparse matrix 
  ##    in HYB storage format.
  proc cusparseSdense2hyb*(handle: cusparseHandle_t; m: cint; n: cint;
                          descrA: cusparseMatDescr_t; A: ptr cfloat; lda: cint;
                          nnzPerRow: ptr cint; hybA: cusparseHybMat_t;
                          userEllWidth: cint;
                          partitionType: cusparseHybPartition_t): cusparseStatus_t {.
      cdecl, importc: "cusparseSdense2hyb", dyn.}
  proc cusparseDdense2hyb*(handle: cusparseHandle_t; m: cint; n: cint;
                          descrA: cusparseMatDescr_t; A: ptr cdouble; lda: cint;
                          nnzPerRow: ptr cint; hybA: cusparseHybMat_t;
                          userEllWidth: cint;
                          partitionType: cusparseHybPartition_t): cusparseStatus_t {.
      cdecl, importc: "cusparseDdense2hyb", dyn.}
  proc cusparseCdense2hyb*(handle: cusparseHandle_t; m: cint; n: cint;
                          descrA: cusparseMatDescr_t; A: ptr cuComplex; lda: cint;
                          nnzPerRow: ptr cint; hybA: cusparseHybMat_t;
                          userEllWidth: cint;
                          partitionType: cusparseHybPartition_t): cusparseStatus_t {.
      cdecl, importc: "cusparseCdense2hyb", dyn.}
  proc cusparseZdense2hyb*(handle: cusparseHandle_t; m: cint; n: cint;
                          descrA: cusparseMatDescr_t; A: ptr cuDoubleComplex;
                          lda: cint; nnzPerRow: ptr cint; hybA: cusparseHybMat_t;
                          userEllWidth: cint;
                          partitionType: cusparseHybPartition_t): cusparseStatus_t {.
      cdecl, importc: "cusparseZdense2hyb", dyn.}
  ##  Description: This routine converts a sparse matrix in HYB storage format
  ##    to a dense matrix.
  proc cusparseShyb2dense*(handle: cusparseHandle_t; descrA: cusparseMatDescr_t;
                          hybA: cusparseHybMat_t; A: ptr cfloat; lda: cint): cusparseStatus_t {.
      cdecl, importc: "cusparseShyb2dense", dyn.}
  proc cusparseDhyb2dense*(handle: cusparseHandle_t; descrA: cusparseMatDescr_t;
                          hybA: cusparseHybMat_t; A: ptr cdouble; lda: cint): cusparseStatus_t {.
      cdecl, importc: "cusparseDhyb2dense", dyn.}
  proc cusparseChyb2dense*(handle: cusparseHandle_t; descrA: cusparseMatDescr_t;
                          hybA: cusparseHybMat_t; A: ptr cuComplex; lda: cint): cusparseStatus_t {.
      cdecl, importc: "cusparseChyb2dense", dyn.}
  proc cusparseZhyb2dense*(handle: cusparseHandle_t; descrA: cusparseMatDescr_t;
                          hybA: cusparseHybMat_t; A: ptr cuDoubleComplex; lda: cint): cusparseStatus_t {.
      cdecl, importc: "cusparseZhyb2dense", dyn.}
  ##  Description: This routine converts a sparse matrix in CSR storage format
  ##    to a sparse matrix in HYB storage format.
  proc cusparseScsr2hyb*(handle: cusparseHandle_t; m: cint; n: cint;
                        descrA: cusparseMatDescr_t; csrSortedValA: ptr cfloat;
                        csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                        hybA: cusparseHybMat_t; userEllWidth: cint;
                        partitionType: cusparseHybPartition_t): cusparseStatus_t {.
      cdecl, importc: "cusparseScsr2hyb", dyn.}
  proc cusparseDcsr2hyb*(handle: cusparseHandle_t; m: cint; n: cint;
                        descrA: cusparseMatDescr_t; csrSortedValA: ptr cdouble;
                        csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                        hybA: cusparseHybMat_t; userEllWidth: cint;
                        partitionType: cusparseHybPartition_t): cusparseStatus_t {.
      cdecl, importc: "cusparseDcsr2hyb", dyn.}
  proc cusparseCcsr2hyb*(handle: cusparseHandle_t; m: cint; n: cint;
                        descrA: cusparseMatDescr_t; csrSortedValA: ptr cuComplex;
                        csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                        hybA: cusparseHybMat_t; userEllWidth: cint;
                        partitionType: cusparseHybPartition_t): cusparseStatus_t {.
      cdecl, importc: "cusparseCcsr2hyb", dyn.}
  proc cusparseZcsr2hyb*(handle: cusparseHandle_t; m: cint; n: cint;
                        descrA: cusparseMatDescr_t;
                        csrSortedValA: ptr cuDoubleComplex;
                        csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                        hybA: cusparseHybMat_t; userEllWidth: cint;
                        partitionType: cusparseHybPartition_t): cusparseStatus_t {.
      cdecl, importc: "cusparseZcsr2hyb", dyn.}
  ##  Description: This routine converts a sparse matrix in HYB storage format
  ##    to a sparse matrix in CSR storage format.
  proc cusparseShyb2csr*(handle: cusparseHandle_t; descrA: cusparseMatDescr_t;
                        hybA: cusparseHybMat_t; csrSortedValA: ptr cfloat;
                        csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseShyb2csr", dyn.}
  proc cusparseDhyb2csr*(handle: cusparseHandle_t; descrA: cusparseMatDescr_t;
                        hybA: cusparseHybMat_t; csrSortedValA: ptr cdouble;
                        csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseDhyb2csr", dyn.}
  proc cusparseChyb2csr*(handle: cusparseHandle_t; descrA: cusparseMatDescr_t;
                        hybA: cusparseHybMat_t; csrSortedValA: ptr cuComplex;
                        csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseChyb2csr", dyn.}
  proc cusparseZhyb2csr*(handle: cusparseHandle_t; descrA: cusparseMatDescr_t;
                        hybA: cusparseHybMat_t;
                        csrSortedValA: ptr cuDoubleComplex;
                        csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseZhyb2csr", dyn.}
  ##  Description: This routine converts a sparse matrix in CSC storage format
  ##    to a sparse matrix in HYB storage format.
  proc cusparseScsc2hyb*(handle: cusparseHandle_t; m: cint; n: cint;
                        descrA: cusparseMatDescr_t; cscSortedValA: ptr cfloat;
                        cscSortedRowIndA: ptr cint; cscSortedColPtrA: ptr cint;
                        hybA: cusparseHybMat_t; userEllWidth: cint;
                        partitionType: cusparseHybPartition_t): cusparseStatus_t {.
      cdecl, importc: "cusparseScsc2hyb", dyn.}
  proc cusparseDcsc2hyb*(handle: cusparseHandle_t; m: cint; n: cint;
                        descrA: cusparseMatDescr_t; cscSortedValA: ptr cdouble;
                        cscSortedRowIndA: ptr cint; cscSortedColPtrA: ptr cint;
                        hybA: cusparseHybMat_t; userEllWidth: cint;
                        partitionType: cusparseHybPartition_t): cusparseStatus_t {.
      cdecl, importc: "cusparseDcsc2hyb", dyn.}
  proc cusparseCcsc2hyb*(handle: cusparseHandle_t; m: cint; n: cint;
                        descrA: cusparseMatDescr_t; cscSortedValA: ptr cuComplex;
                        cscSortedRowIndA: ptr cint; cscSortedColPtrA: ptr cint;
                        hybA: cusparseHybMat_t; userEllWidth: cint;
                        partitionType: cusparseHybPartition_t): cusparseStatus_t {.
      cdecl, importc: "cusparseCcsc2hyb", dyn.}
  proc cusparseZcsc2hyb*(handle: cusparseHandle_t; m: cint; n: cint;
                        descrA: cusparseMatDescr_t;
                        cscSortedValA: ptr cuDoubleComplex;
                        cscSortedRowIndA: ptr cint; cscSortedColPtrA: ptr cint;
                        hybA: cusparseHybMat_t; userEllWidth: cint;
                        partitionType: cusparseHybPartition_t): cusparseStatus_t {.
      cdecl, importc: "cusparseZcsc2hyb", dyn.}
  ##  Description: This routine converts a sparse matrix in HYB storage format
  ##    to a sparse matrix in CSC storage format.
  proc cusparseShyb2csc*(handle: cusparseHandle_t; descrA: cusparseMatDescr_t;
                        hybA: cusparseHybMat_t; cscSortedVal: ptr cfloat;
                        cscSortedRowInd: ptr cint; cscSortedColPtr: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseShyb2csc", dyn.}
  proc cusparseDhyb2csc*(handle: cusparseHandle_t; descrA: cusparseMatDescr_t;
                        hybA: cusparseHybMat_t; cscSortedVal: ptr cdouble;
                        cscSortedRowInd: ptr cint; cscSortedColPtr: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseDhyb2csc", dyn.}
  proc cusparseChyb2csc*(handle: cusparseHandle_t; descrA: cusparseMatDescr_t;
                        hybA: cusparseHybMat_t; cscSortedVal: ptr cuComplex;
                        cscSortedRowInd: ptr cint; cscSortedColPtr: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseChyb2csc", dyn.}
  proc cusparseZhyb2csc*(handle: cusparseHandle_t; descrA: cusparseMatDescr_t;
                        hybA: cusparseHybMat_t; cscSortedVal: ptr cuDoubleComplex;
                        cscSortedRowInd: ptr cint; cscSortedColPtr: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseZhyb2csc", dyn.}
  ##  Description: This routine converts a sparse matrix in CSR storage format
  ##    to a sparse matrix in block-CSR storage format.
  proc cusparseXcsr2bsrNnz*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                           m: cint; n: cint; descrA: cusparseMatDescr_t;
                           csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                           blockDim: cint; descrC: cusparseMatDescr_t;
                           bsrSortedRowPtrC: ptr cint; nnzTotalDevHostPtr: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseXcsr2bsrNnz", dyn.}
  proc cusparseScsr2bsr*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                        m: cint; n: cint; descrA: cusparseMatDescr_t;
                        csrSortedValA: ptr cfloat; csrSortedRowPtrA: ptr cint;
                        csrSortedColIndA: ptr cint; blockDim: cint;
                        descrC: cusparseMatDescr_t; bsrSortedValC: ptr cfloat;
                        bsrSortedRowPtrC: ptr cint; bsrSortedColIndC: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseScsr2bsr", dyn.}
  proc cusparseDcsr2bsr*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                        m: cint; n: cint; descrA: cusparseMatDescr_t;
                        csrSortedValA: ptr cdouble; csrSortedRowPtrA: ptr cint;
                        csrSortedColIndA: ptr cint; blockDim: cint;
                        descrC: cusparseMatDescr_t; bsrSortedValC: ptr cdouble;
                        bsrSortedRowPtrC: ptr cint; bsrSortedColIndC: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseDcsr2bsr", dyn.}
  proc cusparseCcsr2bsr*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                        m: cint; n: cint; descrA: cusparseMatDescr_t;
                        csrSortedValA: ptr cuComplex; csrSortedRowPtrA: ptr cint;
                        csrSortedColIndA: ptr cint; blockDim: cint;
                        descrC: cusparseMatDescr_t; bsrSortedValC: ptr cuComplex;
                        bsrSortedRowPtrC: ptr cint; bsrSortedColIndC: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseCcsr2bsr", dyn.}
  proc cusparseZcsr2bsr*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                        m: cint; n: cint; descrA: cusparseMatDescr_t;
                        csrSortedValA: ptr cuDoubleComplex;
                        csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                        blockDim: cint; descrC: cusparseMatDescr_t;
                        bsrSortedValC: ptr cuDoubleComplex;
                        bsrSortedRowPtrC: ptr cint; bsrSortedColIndC: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseZcsr2bsr", dyn.}
  ##  Description: This routine converts a sparse matrix in block-CSR storage format
  ##    to a sparse matrix in CSR storage format.
  proc cusparseSbsr2csr*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                        mb: cint; nb: cint; descrA: cusparseMatDescr_t;
                        bsrSortedValA: ptr cfloat; bsrSortedRowPtrA: ptr cint;
                        bsrSortedColIndA: ptr cint; blockDim: cint;
                        descrC: cusparseMatDescr_t; csrSortedValC: ptr cfloat;
                        csrSortedRowPtrC: ptr cint; csrSortedColIndC: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseSbsr2csr", dyn.}
  proc cusparseDbsr2csr*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                        mb: cint; nb: cint; descrA: cusparseMatDescr_t;
                        bsrSortedValA: ptr cdouble; bsrSortedRowPtrA: ptr cint;
                        bsrSortedColIndA: ptr cint; blockDim: cint;
                        descrC: cusparseMatDescr_t; csrSortedValC: ptr cdouble;
                        csrSortedRowPtrC: ptr cint; csrSortedColIndC: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseDbsr2csr", dyn.}
  proc cusparseCbsr2csr*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                        mb: cint; nb: cint; descrA: cusparseMatDescr_t;
                        bsrSortedValA: ptr cuComplex; bsrSortedRowPtrA: ptr cint;
                        bsrSortedColIndA: ptr cint; blockDim: cint;
                        descrC: cusparseMatDescr_t; csrSortedValC: ptr cuComplex;
                        csrSortedRowPtrC: ptr cint; csrSortedColIndC: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseCbsr2csr", dyn.}
  proc cusparseZbsr2csr*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                        mb: cint; nb: cint; descrA: cusparseMatDescr_t;
                        bsrSortedValA: ptr cuDoubleComplex;
                        bsrSortedRowPtrA: ptr cint; bsrSortedColIndA: ptr cint;
                        blockDim: cint; descrC: cusparseMatDescr_t;
                        csrSortedValC: ptr cuDoubleComplex;
                        csrSortedRowPtrC: ptr cint; csrSortedColIndC: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseZbsr2csr", dyn.}
  ##  Description: This routine converts a sparse matrix in general block-CSR storage format
  ##    to a sparse matrix in general block-CSC storage format.
  proc cusparseSgebsr2gebsc_bufferSize*(handle: cusparseHandle_t; mb: cint; nb: cint;
                                       nnzb: cint; bsrSortedVal: ptr cfloat;
                                       bsrSortedRowPtr: ptr cint;
                                       bsrSortedColInd: ptr cint;
                                       rowBlockDim: cint; colBlockDim: cint;
                                       pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseSgebsr2gebsc_bufferSize", dyn.}
  proc cusparseDgebsr2gebsc_bufferSize*(handle: cusparseHandle_t; mb: cint; nb: cint;
                                       nnzb: cint; bsrSortedVal: ptr cdouble;
                                       bsrSortedRowPtr: ptr cint;
                                       bsrSortedColInd: ptr cint;
                                       rowBlockDim: cint; colBlockDim: cint;
                                       pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseDgebsr2gebsc_bufferSize", dyn.}
  proc cusparseCgebsr2gebsc_bufferSize*(handle: cusparseHandle_t; mb: cint; nb: cint;
                                       nnzb: cint; bsrSortedVal: ptr cuComplex;
                                       bsrSortedRowPtr: ptr cint;
                                       bsrSortedColInd: ptr cint;
                                       rowBlockDim: cint; colBlockDim: cint;
                                       pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseCgebsr2gebsc_bufferSize", dyn.}
  proc cusparseZgebsr2gebsc_bufferSize*(handle: cusparseHandle_t; mb: cint; nb: cint;
                                       nnzb: cint;
                                       bsrSortedVal: ptr cuDoubleComplex;
                                       bsrSortedRowPtr: ptr cint;
                                       bsrSortedColInd: ptr cint;
                                       rowBlockDim: cint; colBlockDim: cint;
                                       pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseZgebsr2gebsc_bufferSize", dyn.}
  proc cusparseSgebsr2gebsc_bufferSizeExt*(handle: cusparseHandle_t; mb: cint;
      nb: cint; nnzb: cint; bsrSortedVal: ptr cfloat; bsrSortedRowPtr: ptr cint;
      bsrSortedColInd: ptr cint; rowBlockDim: cint; colBlockDim: cint;
      pBufferSize: ptr csize): cusparseStatus_t {.cdecl,
      importc: "cusparseSgebsr2gebsc_bufferSizeExt", dyn.}
  proc cusparseDgebsr2gebsc_bufferSizeExt*(handle: cusparseHandle_t; mb: cint;
      nb: cint; nnzb: cint; bsrSortedVal: ptr cdouble; bsrSortedRowPtr: ptr cint;
      bsrSortedColInd: ptr cint; rowBlockDim: cint; colBlockDim: cint;
      pBufferSize: ptr csize): cusparseStatus_t {.cdecl,
      importc: "cusparseDgebsr2gebsc_bufferSizeExt", dyn.}
  proc cusparseCgebsr2gebsc_bufferSizeExt*(handle: cusparseHandle_t; mb: cint;
      nb: cint; nnzb: cint; bsrSortedVal: ptr cuComplex; bsrSortedRowPtr: ptr cint;
      bsrSortedColInd: ptr cint; rowBlockDim: cint; colBlockDim: cint;
      pBufferSize: ptr csize): cusparseStatus_t {.cdecl,
      importc: "cusparseCgebsr2gebsc_bufferSizeExt", dyn.}
  proc cusparseZgebsr2gebsc_bufferSizeExt*(handle: cusparseHandle_t; mb: cint;
      nb: cint; nnzb: cint; bsrSortedVal: ptr cuDoubleComplex;
      bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint; rowBlockDim: cint;
      colBlockDim: cint; pBufferSize: ptr csize): cusparseStatus_t {.cdecl,
      importc: "cusparseZgebsr2gebsc_bufferSizeExt", dyn.}
  proc cusparseSgebsr2gebsc*(handle: cusparseHandle_t; mb: cint; nb: cint; nnzb: cint;
                            bsrSortedVal: ptr cfloat; bsrSortedRowPtr: ptr cint;
                            bsrSortedColInd: ptr cint; rowBlockDim: cint;
                            colBlockDim: cint; bscVal: ptr cfloat;
                            bscRowInd: ptr cint; bscColPtr: ptr cint;
                            copyValues: cusparseAction_t;
                            baseIdx: cusparseIndexBase_t; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseSgebsr2gebsc", dyn.}
  proc cusparseDgebsr2gebsc*(handle: cusparseHandle_t; mb: cint; nb: cint; nnzb: cint;
                            bsrSortedVal: ptr cdouble; bsrSortedRowPtr: ptr cint;
                            bsrSortedColInd: ptr cint; rowBlockDim: cint;
                            colBlockDim: cint; bscVal: ptr cdouble;
                            bscRowInd: ptr cint; bscColPtr: ptr cint;
                            copyValues: cusparseAction_t;
                            baseIdx: cusparseIndexBase_t; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseDgebsr2gebsc", dyn.}
  proc cusparseCgebsr2gebsc*(handle: cusparseHandle_t; mb: cint; nb: cint; nnzb: cint;
                            bsrSortedVal: ptr cuComplex; bsrSortedRowPtr: ptr cint;
                            bsrSortedColInd: ptr cint; rowBlockDim: cint;
                            colBlockDim: cint; bscVal: ptr cuComplex;
                            bscRowInd: ptr cint; bscColPtr: ptr cint;
                            copyValues: cusparseAction_t;
                            baseIdx: cusparseIndexBase_t; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseCgebsr2gebsc", dyn.}
  proc cusparseZgebsr2gebsc*(handle: cusparseHandle_t; mb: cint; nb: cint; nnzb: cint;
                            bsrSortedVal: ptr cuDoubleComplex;
                            bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint;
                            rowBlockDim: cint; colBlockDim: cint;
                            bscVal: ptr cuDoubleComplex; bscRowInd: ptr cint;
                            bscColPtr: ptr cint; copyValues: cusparseAction_t;
                            baseIdx: cusparseIndexBase_t; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseZgebsr2gebsc", dyn.}
  ##  Description: This routine converts a sparse matrix in general block-CSR storage format
  ##    to a sparse matrix in CSR storage format.
  proc cusparseXgebsr2csr*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                          mb: cint; nb: cint; descrA: cusparseMatDescr_t;
                          bsrSortedRowPtrA: ptr cint; bsrSortedColIndA: ptr cint;
                          rowBlockDim: cint; colBlockDim: cint;
                          descrC: cusparseMatDescr_t; csrSortedRowPtrC: ptr cint;
                          csrSortedColIndC: ptr cint): cusparseStatus_t {.cdecl,
      importc: "cusparseXgebsr2csr", dyn.}
  proc cusparseSgebsr2csr*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                          mb: cint; nb: cint; descrA: cusparseMatDescr_t;
                          bsrSortedValA: ptr cfloat; bsrSortedRowPtrA: ptr cint;
                          bsrSortedColIndA: ptr cint; rowBlockDim: cint;
                          colBlockDim: cint; descrC: cusparseMatDescr_t;
                          csrSortedValC: ptr cfloat; csrSortedRowPtrC: ptr cint;
                          csrSortedColIndC: ptr cint): cusparseStatus_t {.cdecl,
      importc: "cusparseSgebsr2csr", dyn.}
  proc cusparseDgebsr2csr*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                          mb: cint; nb: cint; descrA: cusparseMatDescr_t;
                          bsrSortedValA: ptr cdouble; bsrSortedRowPtrA: ptr cint;
                          bsrSortedColIndA: ptr cint; rowBlockDim: cint;
                          colBlockDim: cint; descrC: cusparseMatDescr_t;
                          csrSortedValC: ptr cdouble; csrSortedRowPtrC: ptr cint;
                          csrSortedColIndC: ptr cint): cusparseStatus_t {.cdecl,
      importc: "cusparseDgebsr2csr", dyn.}
  proc cusparseCgebsr2csr*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                          mb: cint; nb: cint; descrA: cusparseMatDescr_t;
                          bsrSortedValA: ptr cuComplex; bsrSortedRowPtrA: ptr cint;
                          bsrSortedColIndA: ptr cint; rowBlockDim: cint;
                          colBlockDim: cint; descrC: cusparseMatDescr_t;
                          csrSortedValC: ptr cuComplex; csrSortedRowPtrC: ptr cint;
                          csrSortedColIndC: ptr cint): cusparseStatus_t {.cdecl,
      importc: "cusparseCgebsr2csr", dyn.}
  proc cusparseZgebsr2csr*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                          mb: cint; nb: cint; descrA: cusparseMatDescr_t;
                          bsrSortedValA: ptr cuDoubleComplex;
                          bsrSortedRowPtrA: ptr cint; bsrSortedColIndA: ptr cint;
                          rowBlockDim: cint; colBlockDim: cint;
                          descrC: cusparseMatDescr_t;
                          csrSortedValC: ptr cuDoubleComplex;
                          csrSortedRowPtrC: ptr cint; csrSortedColIndC: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseZgebsr2csr", dyn.}
  ##  Description: This routine converts a sparse matrix in CSR storage format
  ##    to a sparse matrix in general block-CSR storage format.
  proc cusparseScsr2gebsr_bufferSize*(handle: cusparseHandle_t;
                                     dirA: cusparseDirection_t; m: cint; n: cint;
                                     descrA: cusparseMatDescr_t;
                                     csrSortedValA: ptr cfloat;
                                     csrSortedRowPtrA: ptr cint;
                                     csrSortedColIndA: ptr cint; rowBlockDim: cint;
                                     colBlockDim: cint;
                                     pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseScsr2gebsr_bufferSize", dyn.}
  proc cusparseDcsr2gebsr_bufferSize*(handle: cusparseHandle_t;
                                     dirA: cusparseDirection_t; m: cint; n: cint;
                                     descrA: cusparseMatDescr_t;
                                     csrSortedValA: ptr cdouble;
                                     csrSortedRowPtrA: ptr cint;
                                     csrSortedColIndA: ptr cint; rowBlockDim: cint;
                                     colBlockDim: cint;
                                     pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseDcsr2gebsr_bufferSize", dyn.}
  proc cusparseCcsr2gebsr_bufferSize*(handle: cusparseHandle_t;
                                     dirA: cusparseDirection_t; m: cint; n: cint;
                                     descrA: cusparseMatDescr_t;
                                     csrSortedValA: ptr cuComplex;
                                     csrSortedRowPtrA: ptr cint;
                                     csrSortedColIndA: ptr cint; rowBlockDim: cint;
                                     colBlockDim: cint;
                                     pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseCcsr2gebsr_bufferSize", dyn.}
  proc cusparseZcsr2gebsr_bufferSize*(handle: cusparseHandle_t;
                                     dirA: cusparseDirection_t; m: cint; n: cint;
                                     descrA: cusparseMatDescr_t;
                                     csrSortedValA: ptr cuDoubleComplex;
                                     csrSortedRowPtrA: ptr cint;
                                     csrSortedColIndA: ptr cint; rowBlockDim: cint;
                                     colBlockDim: cint;
                                     pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseZcsr2gebsr_bufferSize", dyn.}
  proc cusparseScsr2gebsr_bufferSizeExt*(handle: cusparseHandle_t;
                                        dirA: cusparseDirection_t; m: cint; n: cint;
                                        descrA: cusparseMatDescr_t;
                                        csrSortedValA: ptr cfloat;
                                        csrSortedRowPtrA: ptr cint;
                                        csrSortedColIndA: ptr cint;
                                        rowBlockDim: cint; colBlockDim: cint;
                                        pBufferSize: ptr csize): cusparseStatus_t {.
      cdecl, importc: "cusparseScsr2gebsr_bufferSizeExt", dyn.}
  proc cusparseDcsr2gebsr_bufferSizeExt*(handle: cusparseHandle_t;
                                        dirA: cusparseDirection_t; m: cint; n: cint;
                                        descrA: cusparseMatDescr_t;
                                        csrSortedValA: ptr cdouble;
                                        csrSortedRowPtrA: ptr cint;
                                        csrSortedColIndA: ptr cint;
                                        rowBlockDim: cint; colBlockDim: cint;
                                        pBufferSize: ptr csize): cusparseStatus_t {.
      cdecl, importc: "cusparseDcsr2gebsr_bufferSizeExt", dyn.}
  proc cusparseCcsr2gebsr_bufferSizeExt*(handle: cusparseHandle_t;
                                        dirA: cusparseDirection_t; m: cint; n: cint;
                                        descrA: cusparseMatDescr_t;
                                        csrSortedValA: ptr cuComplex;
                                        csrSortedRowPtrA: ptr cint;
                                        csrSortedColIndA: ptr cint;
                                        rowBlockDim: cint; colBlockDim: cint;
                                        pBufferSize: ptr csize): cusparseStatus_t {.
      cdecl, importc: "cusparseCcsr2gebsr_bufferSizeExt", dyn.}
  proc cusparseZcsr2gebsr_bufferSizeExt*(handle: cusparseHandle_t;
                                        dirA: cusparseDirection_t; m: cint; n: cint;
                                        descrA: cusparseMatDescr_t;
                                        csrSortedValA: ptr cuDoubleComplex;
                                        csrSortedRowPtrA: ptr cint;
                                        csrSortedColIndA: ptr cint;
                                        rowBlockDim: cint; colBlockDim: cint;
                                        pBufferSize: ptr csize): cusparseStatus_t {.
      cdecl, importc: "cusparseZcsr2gebsr_bufferSizeExt", dyn.}
  proc cusparseXcsr2gebsrNnz*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                             m: cint; n: cint; descrA: cusparseMatDescr_t;
                             csrSortedRowPtrA: ptr cint;
                             csrSortedColIndA: ptr cint;
                             descrC: cusparseMatDescr_t;
                             bsrSortedRowPtrC: ptr cint; rowBlockDim: cint;
                             colBlockDim: cint; nnzTotalDevHostPtr: ptr cint;
                             pBuffer: pointer): cusparseStatus_t {.cdecl,
      importc: "cusparseXcsr2gebsrNnz", dyn.}
  proc cusparseScsr2gebsr*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                          m: cint; n: cint; descrA: cusparseMatDescr_t;
                          csrSortedValA: ptr cfloat; csrSortedRowPtrA: ptr cint;
                          csrSortedColIndA: ptr cint; descrC: cusparseMatDescr_t;
                          bsrSortedValC: ptr cfloat; bsrSortedRowPtrC: ptr cint;
                          bsrSortedColIndC: ptr cint; rowBlockDim: cint;
                          colBlockDim: cint; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseScsr2gebsr", dyn.}
  proc cusparseDcsr2gebsr*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                          m: cint; n: cint; descrA: cusparseMatDescr_t;
                          csrSortedValA: ptr cdouble; csrSortedRowPtrA: ptr cint;
                          csrSortedColIndA: ptr cint; descrC: cusparseMatDescr_t;
                          bsrSortedValC: ptr cdouble; bsrSortedRowPtrC: ptr cint;
                          bsrSortedColIndC: ptr cint; rowBlockDim: cint;
                          colBlockDim: cint; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseDcsr2gebsr", dyn.}
  proc cusparseCcsr2gebsr*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                          m: cint; n: cint; descrA: cusparseMatDescr_t;
                          csrSortedValA: ptr cuComplex; csrSortedRowPtrA: ptr cint;
                          csrSortedColIndA: ptr cint; descrC: cusparseMatDescr_t;
                          bsrSortedValC: ptr cuComplex; bsrSortedRowPtrC: ptr cint;
                          bsrSortedColIndC: ptr cint; rowBlockDim: cint;
                          colBlockDim: cint; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseCcsr2gebsr", dyn.}
  proc cusparseZcsr2gebsr*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                          m: cint; n: cint; descrA: cusparseMatDescr_t;
                          csrSortedValA: ptr cuDoubleComplex;
                          csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                          descrC: cusparseMatDescr_t;
                          bsrSortedValC: ptr cuDoubleComplex;
                          bsrSortedRowPtrC: ptr cint; bsrSortedColIndC: ptr cint;
                          rowBlockDim: cint; colBlockDim: cint; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseZcsr2gebsr", dyn.}
  ##  Description: This routine converts a sparse matrix in general block-CSR storage format
  ##    to a sparse matrix in general block-CSR storage format with different block size.
  proc cusparseSgebsr2gebsr_bufferSize*(handle: cusparseHandle_t;
                                       dirA: cusparseDirection_t; mb: cint;
                                       nb: cint; nnzb: cint;
                                       descrA: cusparseMatDescr_t;
                                       bsrSortedValA: ptr cfloat;
                                       bsrSortedRowPtrA: ptr cint;
                                       bsrSortedColIndA: ptr cint;
                                       rowBlockDimA: cint; colBlockDimA: cint;
                                       rowBlockDimC: cint; colBlockDimC: cint;
                                       pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseSgebsr2gebsr_bufferSize", dyn.}
  proc cusparseDgebsr2gebsr_bufferSize*(handle: cusparseHandle_t;
                                       dirA: cusparseDirection_t; mb: cint;
                                       nb: cint; nnzb: cint;
                                       descrA: cusparseMatDescr_t;
                                       bsrSortedValA: ptr cdouble;
                                       bsrSortedRowPtrA: ptr cint;
                                       bsrSortedColIndA: ptr cint;
                                       rowBlockDimA: cint; colBlockDimA: cint;
                                       rowBlockDimC: cint; colBlockDimC: cint;
                                       pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseDgebsr2gebsr_bufferSize", dyn.}
  proc cusparseCgebsr2gebsr_bufferSize*(handle: cusparseHandle_t;
                                       dirA: cusparseDirection_t; mb: cint;
                                       nb: cint; nnzb: cint;
                                       descrA: cusparseMatDescr_t;
                                       bsrSortedValA: ptr cuComplex;
                                       bsrSortedRowPtrA: ptr cint;
                                       bsrSortedColIndA: ptr cint;
                                       rowBlockDimA: cint; colBlockDimA: cint;
                                       rowBlockDimC: cint; colBlockDimC: cint;
                                       pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseCgebsr2gebsr_bufferSize", dyn.}
  proc cusparseZgebsr2gebsr_bufferSize*(handle: cusparseHandle_t;
                                       dirA: cusparseDirection_t; mb: cint;
                                       nb: cint; nnzb: cint;
                                       descrA: cusparseMatDescr_t;
                                       bsrSortedValA: ptr cuDoubleComplex;
                                       bsrSortedRowPtrA: ptr cint;
                                       bsrSortedColIndA: ptr cint;
                                       rowBlockDimA: cint; colBlockDimA: cint;
                                       rowBlockDimC: cint; colBlockDimC: cint;
                                       pBufferSizeInBytes: ptr cint): cusparseStatus_t {.
      cdecl, importc: "cusparseZgebsr2gebsr_bufferSize", dyn.}
  proc cusparseSgebsr2gebsr_bufferSizeExt*(handle: cusparseHandle_t;
      dirA: cusparseDirection_t; mb: cint; nb: cint; nnzb: cint;
      descrA: cusparseMatDescr_t; bsrSortedValA: ptr cfloat;
      bsrSortedRowPtrA: ptr cint; bsrSortedColIndA: ptr cint; rowBlockDimA: cint;
      colBlockDimA: cint; rowBlockDimC: cint; colBlockDimC: cint;
      pBufferSize: ptr csize): cusparseStatus_t {.cdecl,
      importc: "cusparseSgebsr2gebsr_bufferSizeExt", dyn.}
  proc cusparseDgebsr2gebsr_bufferSizeExt*(handle: cusparseHandle_t;
      dirA: cusparseDirection_t; mb: cint; nb: cint; nnzb: cint;
      descrA: cusparseMatDescr_t; bsrSortedValA: ptr cdouble;
      bsrSortedRowPtrA: ptr cint; bsrSortedColIndA: ptr cint; rowBlockDimA: cint;
      colBlockDimA: cint; rowBlockDimC: cint; colBlockDimC: cint;
      pBufferSize: ptr csize): cusparseStatus_t {.cdecl,
      importc: "cusparseDgebsr2gebsr_bufferSizeExt", dyn.}
  proc cusparseCgebsr2gebsr_bufferSizeExt*(handle: cusparseHandle_t;
      dirA: cusparseDirection_t; mb: cint; nb: cint; nnzb: cint;
      descrA: cusparseMatDescr_t; bsrSortedValA: ptr cuComplex;
      bsrSortedRowPtrA: ptr cint; bsrSortedColIndA: ptr cint; rowBlockDimA: cint;
      colBlockDimA: cint; rowBlockDimC: cint; colBlockDimC: cint;
      pBufferSize: ptr csize): cusparseStatus_t {.cdecl,
      importc: "cusparseCgebsr2gebsr_bufferSizeExt", dyn.}
  proc cusparseZgebsr2gebsr_bufferSizeExt*(handle: cusparseHandle_t;
      dirA: cusparseDirection_t; mb: cint; nb: cint; nnzb: cint;
      descrA: cusparseMatDescr_t; bsrSortedValA: ptr cuDoubleComplex;
      bsrSortedRowPtrA: ptr cint; bsrSortedColIndA: ptr cint; rowBlockDimA: cint;
      colBlockDimA: cint; rowBlockDimC: cint; colBlockDimC: cint;
      pBufferSize: ptr csize): cusparseStatus_t {.cdecl,
      importc: "cusparseZgebsr2gebsr_bufferSizeExt", dyn.}
  proc cusparseXgebsr2gebsrNnz*(handle: cusparseHandle_t;
                               dirA: cusparseDirection_t; mb: cint; nb: cint;
                               nnzb: cint; descrA: cusparseMatDescr_t;
                               bsrSortedRowPtrA: ptr cint;
                               bsrSortedColIndA: ptr cint; rowBlockDimA: cint;
                               colBlockDimA: cint; descrC: cusparseMatDescr_t;
                               bsrSortedRowPtrC: ptr cint; rowBlockDimC: cint;
                               colBlockDimC: cint; nnzTotalDevHostPtr: ptr cint;
                               pBuffer: pointer): cusparseStatus_t {.cdecl,
      importc: "cusparseXgebsr2gebsrNnz", dyn.}
  proc cusparseSgebsr2gebsr*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                            mb: cint; nb: cint; nnzb: cint;
                            descrA: cusparseMatDescr_t; bsrSortedValA: ptr cfloat;
                            bsrSortedRowPtrA: ptr cint; bsrSortedColIndA: ptr cint;
                            rowBlockDimA: cint; colBlockDimA: cint;
                            descrC: cusparseMatDescr_t; bsrSortedValC: ptr cfloat;
                            bsrSortedRowPtrC: ptr cint; bsrSortedColIndC: ptr cint;
                            rowBlockDimC: cint; colBlockDimC: cint; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseSgebsr2gebsr", dyn.}
  proc cusparseDgebsr2gebsr*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                            mb: cint; nb: cint; nnzb: cint;
                            descrA: cusparseMatDescr_t;
                            bsrSortedValA: ptr cdouble; bsrSortedRowPtrA: ptr cint;
                            bsrSortedColIndA: ptr cint; rowBlockDimA: cint;
                            colBlockDimA: cint; descrC: cusparseMatDescr_t;
                            bsrSortedValC: ptr cdouble; bsrSortedRowPtrC: ptr cint;
                            bsrSortedColIndC: ptr cint; rowBlockDimC: cint;
                            colBlockDimC: cint; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseDgebsr2gebsr", dyn.}
  proc cusparseCgebsr2gebsr*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                            mb: cint; nb: cint; nnzb: cint;
                            descrA: cusparseMatDescr_t;
                            bsrSortedValA: ptr cuComplex;
                            bsrSortedRowPtrA: ptr cint; bsrSortedColIndA: ptr cint;
                            rowBlockDimA: cint; colBlockDimA: cint;
                            descrC: cusparseMatDescr_t;
                            bsrSortedValC: ptr cuComplex;
                            bsrSortedRowPtrC: ptr cint; bsrSortedColIndC: ptr cint;
                            rowBlockDimC: cint; colBlockDimC: cint; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseCgebsr2gebsr", dyn.}
  proc cusparseZgebsr2gebsr*(handle: cusparseHandle_t; dirA: cusparseDirection_t;
                            mb: cint; nb: cint; nnzb: cint;
                            descrA: cusparseMatDescr_t;
                            bsrSortedValA: ptr cuDoubleComplex;
                            bsrSortedRowPtrA: ptr cint; bsrSortedColIndA: ptr cint;
                            rowBlockDimA: cint; colBlockDimA: cint;
                            descrC: cusparseMatDescr_t;
                            bsrSortedValC: ptr cuDoubleComplex;
                            bsrSortedRowPtrC: ptr cint; bsrSortedColIndC: ptr cint;
                            rowBlockDimC: cint; colBlockDimC: cint; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseZgebsr2gebsr", dyn.}
  ##  --- Sparse Matrix Sorting ---
  ##  Description: Create a identity sequence p=[0,1,...,n-1].
  proc cusparseCreateIdentityPermutation*(handle: cusparseHandle_t; n: cint;
      p: ptr cint): cusparseStatus_t {.cdecl, importc: "cusparseCreateIdentityPermutation",
                                   dyn.}
  ##  Description: Sort sparse matrix stored in COO format
  proc cusparseXcoosort_bufferSizeExt*(handle: cusparseHandle_t; m: cint; n: cint;
                                      nnz: cint; cooRowsA: ptr cint;
                                      cooColsA: ptr cint;
                                      pBufferSizeInBytes: ptr csize): cusparseStatus_t {.
      cdecl, importc: "cusparseXcoosort_bufferSizeExt", dyn.}
  proc cusparseXcoosortByRow*(handle: cusparseHandle_t; m: cint; n: cint; nnz: cint;
                             cooRowsA: ptr cint; cooColsA: ptr cint; P: ptr cint;
                             pBuffer: pointer): cusparseStatus_t {.cdecl,
      importc: "cusparseXcoosortByRow", dyn.}
  proc cusparseXcoosortByColumn*(handle: cusparseHandle_t; m: cint; n: cint; nnz: cint;
                                cooRowsA: ptr cint; cooColsA: ptr cint; P: ptr cint;
                                pBuffer: pointer): cusparseStatus_t {.cdecl,
      importc: "cusparseXcoosortByColumn", dyn.}
  ##  Description: Sort sparse matrix stored in CSR format
  proc cusparseXcsrsort_bufferSizeExt*(handle: cusparseHandle_t; m: cint; n: cint;
                                      nnz: cint; csrRowPtrA: ptr cint;
                                      csrColIndA: ptr cint;
                                      pBufferSizeInBytes: ptr csize): cusparseStatus_t {.
      cdecl, importc: "cusparseXcsrsort_bufferSizeExt", dyn.}
  proc cusparseXcsrsort*(handle: cusparseHandle_t; m: cint; n: cint; nnz: cint;
                        descrA: cusparseMatDescr_t; csrRowPtrA: ptr cint;
                        csrColIndA: ptr cint; P: ptr cint; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseXcsrsort", dyn.}
  ##  Description: Sort sparse matrix stored in CSC format
  proc cusparseXcscsort_bufferSizeExt*(handle: cusparseHandle_t; m: cint; n: cint;
                                      nnz: cint; cscColPtrA: ptr cint;
                                      cscRowIndA: ptr cint;
                                      pBufferSizeInBytes: ptr csize): cusparseStatus_t {.
      cdecl, importc: "cusparseXcscsort_bufferSizeExt", dyn.}
  proc cusparseXcscsort*(handle: cusparseHandle_t; m: cint; n: cint; nnz: cint;
                        descrA: cusparseMatDescr_t; cscColPtrA: ptr cint;
                        cscRowIndA: ptr cint; P: ptr cint; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseXcscsort", dyn.}
  ##  Description: Wrapper that sorts sparse matrix stored in CSR format 
  ##    (without exposing the permutation).
  proc cusparseScsru2csr_bufferSizeExt*(handle: cusparseHandle_t; m: cint; n: cint;
                                       nnz: cint; csrVal: ptr cfloat;
                                       csrRowPtr: ptr cint; csrColInd: ptr cint;
                                       info: csru2csrInfo_t;
                                       pBufferSizeInBytes: ptr csize): cusparseStatus_t {.
      cdecl, importc: "cusparseScsru2csr_bufferSizeExt", dyn.}
  proc cusparseDcsru2csr_bufferSizeExt*(handle: cusparseHandle_t; m: cint; n: cint;
                                       nnz: cint; csrVal: ptr cdouble;
                                       csrRowPtr: ptr cint; csrColInd: ptr cint;
                                       info: csru2csrInfo_t;
                                       pBufferSizeInBytes: ptr csize): cusparseStatus_t {.
      cdecl, importc: "cusparseDcsru2csr_bufferSizeExt", dyn.}
  proc cusparseCcsru2csr_bufferSizeExt*(handle: cusparseHandle_t; m: cint; n: cint;
                                       nnz: cint; csrVal: ptr cuComplex;
                                       csrRowPtr: ptr cint; csrColInd: ptr cint;
                                       info: csru2csrInfo_t;
                                       pBufferSizeInBytes: ptr csize): cusparseStatus_t {.
      cdecl, importc: "cusparseCcsru2csr_bufferSizeExt", dyn.}
  proc cusparseZcsru2csr_bufferSizeExt*(handle: cusparseHandle_t; m: cint; n: cint;
                                       nnz: cint; csrVal: ptr cuDoubleComplex;
                                       csrRowPtr: ptr cint; csrColInd: ptr cint;
                                       info: csru2csrInfo_t;
                                       pBufferSizeInBytes: ptr csize): cusparseStatus_t {.
      cdecl, importc: "cusparseZcsru2csr_bufferSizeExt", dyn.}
  proc cusparseScsru2csr*(handle: cusparseHandle_t; m: cint; n: cint; nnz: cint;
                         descrA: cusparseMatDescr_t; csrVal: ptr cfloat;
                         csrRowPtr: ptr cint; csrColInd: ptr cint;
                         info: csru2csrInfo_t; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseScsru2csr", dyn.}
  proc cusparseDcsru2csr*(handle: cusparseHandle_t; m: cint; n: cint; nnz: cint;
                         descrA: cusparseMatDescr_t; csrVal: ptr cdouble;
                         csrRowPtr: ptr cint; csrColInd: ptr cint;
                         info: csru2csrInfo_t; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseDcsru2csr", dyn.}
  proc cusparseCcsru2csr*(handle: cusparseHandle_t; m: cint; n: cint; nnz: cint;
                         descrA: cusparseMatDescr_t; csrVal: ptr cuComplex;
                         csrRowPtr: ptr cint; csrColInd: ptr cint;
                         info: csru2csrInfo_t; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseCcsru2csr", dyn.}
  proc cusparseZcsru2csr*(handle: cusparseHandle_t; m: cint; n: cint; nnz: cint;
                         descrA: cusparseMatDescr_t; csrVal: ptr cuDoubleComplex;
                         csrRowPtr: ptr cint; csrColInd: ptr cint;
                         info: csru2csrInfo_t; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseZcsru2csr", dyn.}
  ##  Description: Wrapper that un-sorts sparse matrix stored in CSR format 
  ##    (without exposing the permutation).
  proc cusparseScsr2csru*(handle: cusparseHandle_t; m: cint; n: cint; nnz: cint;
                         descrA: cusparseMatDescr_t; csrVal: ptr cfloat;
                         csrRowPtr: ptr cint; csrColInd: ptr cint;
                         info: csru2csrInfo_t; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseScsr2csru", dyn.}
  proc cusparseDcsr2csru*(handle: cusparseHandle_t; m: cint; n: cint; nnz: cint;
                         descrA: cusparseMatDescr_t; csrVal: ptr cdouble;
                         csrRowPtr: ptr cint; csrColInd: ptr cint;
                         info: csru2csrInfo_t; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseDcsr2csru", dyn.}
  proc cusparseCcsr2csru*(handle: cusparseHandle_t; m: cint; n: cint; nnz: cint;
                         descrA: cusparseMatDescr_t; csrVal: ptr cuComplex;
                         csrRowPtr: ptr cint; csrColInd: ptr cint;
                         info: csru2csrInfo_t; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseCcsr2csru", dyn.}
  proc cusparseZcsr2csru*(handle: cusparseHandle_t; m: cint; n: cint; nnz: cint;
                         descrA: cusparseMatDescr_t; csrVal: ptr cuDoubleComplex;
                         csrRowPtr: ptr cint; csrColInd: ptr cint;
                         info: csru2csrInfo_t; pBuffer: pointer): cusparseStatus_t {.
      cdecl, importc: "cusparseZcsr2csru", dyn.}