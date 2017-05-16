 {.deadCodeElim: on.}
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
  library_types

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
    Status_t* {.size: sizeof(cint).} = enum
      CUSPARSE_STATUS_SUCCESS = 0, CUSPARSE_STATUS_NOT_INITIALIZED = 1,
      CUSPARSE_STATUS_ALLOC_FAILED = 2, CUSPARSE_STATUS_INVALID_VALUE = 3,
      CUSPARSE_STATUS_ARCH_MISMATCH = 4, CUSPARSE_STATUS_MAPPING_ERROR = 5,
      CUSPARSE_STATUS_EXECUTION_FAILED = 6, CUSPARSE_STATUS_INTERNAL_ERROR = 7,
      CUSPARSE_STATUS_MATRIX_TYPE_NOT_SUPPORTED = 8, CUSPARSE_STATUS_ZERO_PIVOT = 9
  ##  Opaque structure holding CUSPARSE library context
  type
    Context* = object
    
  type
    Handle_t* = ptr Context
  ##  Opaque structure holding the matrix descriptor
  type
    MatDescr* = object
    
  type
    MatDescr_t* = ptr MatDescr
  ##  Opaque structure holding the sparse triangular solve information
  type
    SolveAnalysisInfo* = object
    
  type
    SolveAnalysisInfo_t* = ptr SolveAnalysisInfo
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
    HybMat* = object
    
  type
    HybMat_t* = ptr HybMat
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
    ColorInfo* = object
    
  type
    ColorInfo_t* = ptr ColorInfo
  ##  Types definitions
  type
    PointerMode_t* {.size: sizeof(cint).} = enum
      CUSPARSE_POINTER_MODE_HOST = 0, CUSPARSE_POINTER_MODE_DEVICE = 1
    Action_t* {.size: sizeof(cint).} = enum
      CUSPARSE_ACTION_SYMBOLIC = 0, CUSPARSE_ACTION_NUMERIC = 1
    MatrixType_t* {.size: sizeof(cint).} = enum
      CUSPARSE_MATRIX_TYPE_GENERAL = 0, CUSPARSE_MATRIX_TYPE_SYMMETRIC = 1,
      CUSPARSE_MATRIX_TYPE_HERMITIAN = 2, CUSPARSE_MATRIX_TYPE_TRIANGULAR = 3
    FillMode_t* {.size: sizeof(cint).} = enum
      CUSPARSE_FILL_MODE_LOWER = 0, CUSPARSE_FILL_MODE_UPPER = 1
    DiagType_t* {.size: sizeof(cint).} = enum
      CUSPARSE_DIAG_TYPE_NON_UNIT = 0, CUSPARSE_DIAG_TYPE_UNIT = 1
    IndexBase_t* {.size: sizeof(cint).} = enum
      CUSPARSE_INDEX_BASE_ZERO = 0, CUSPARSE_INDEX_BASE_ONE = 1
    Operation_t* {.size: sizeof(cint).} = enum
      CUSPARSE_OPERATION_NON_TRANSPOSE = 0, CUSPARSE_OPERATION_TRANSPOSE = 1,
      CUSPARSE_OPERATION_CONJUGATE_TRANSPOSE = 2
    Direction_t* {.size: sizeof(cint).} = enum
      CUSPARSE_DIRECTION_ROW = 0, CUSPARSE_DIRECTION_COLUMN = 1
    HybPartition_t* {.size: sizeof(cint).} = enum
      CUSPARSE_HYB_PARTITION_AUTO = 0, ##  automatically decide how to split the data into regular/irregular part
      CUSPARSE_HYB_PARTITION_USER = 1, ##  store data into regular part up to a user specified treshhold
      CUSPARSE_HYB_PARTITION_MAX = 2
  ##  used in csrsv2, csric02, and csrilu02
  type
    SolvePolicy_t* {.size: sizeof(cint).} = enum
      CUSPARSE_SOLVE_POLICY_NO_LEVEL = 0, ##  no level information is generated, only reports structural zero.
      CUSPARSE_SOLVE_POLICY_USE_LEVEL = 1
    SideMode_t* {.size: sizeof(cint).} = enum
      CUSPARSE_SIDE_LEFT = 0, CUSPARSE_SIDE_RIGHT = 1
    ColorAlg_t* {.size: sizeof(cint).} = enum
      CUSPARSE_COLOR_ALG0 = 0,  ##  default
      CUSPARSE_COLOR_ALG1 = 1
    AlgMode_t* {.size: sizeof(cint).} = enum
      CUSPARSE_ALG0 = 0,        ## default, naive
      CUSPARSE_ALG1 = 1
  ##  CUSPARSE initialization and managment routines
  proc Create*(handle: ptr Handle_t): Status_t {.cdecl, cdecl,
      importc: "cusparseCreate", dynlib: libName.}
  proc Destroy*(handle: Handle_t): Status_t {.cdecl, cdecl,
      importc: "cusparseDestroy", dynlib: libName.}
  proc GetVersion*(handle: Handle_t; version: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseGetVersion", dynlib: libName.}
  proc GetProperty*(`type`: libraryPropertyType; value: ptr cint): Status_t {.cdecl,
      cdecl, importc: "cusparseGetProperty", dynlib: libName.}
  proc SetStream*(handle: Handle_t; streamId: cudaStream_t): Status_t {.cdecl, cdecl,
      importc: "cusparseSetStream", dynlib: libName.}
  proc GetStream*(handle: Handle_t; streamId: ptr cudaStream_t): Status_t {.cdecl,
      cdecl, importc: "cusparseGetStream", dynlib: libName.}
  ##  CUSPARSE type creation, destruction, set and get routines
  proc GetPointerMode*(handle: Handle_t; mode: ptr PointerMode_t): Status_t {.cdecl,
      cdecl, importc: "cusparseGetPointerMode", dynlib: libName.}
  proc SetPointerMode*(handle: Handle_t; mode: PointerMode_t): Status_t {.cdecl, cdecl,
      importc: "cusparseSetPointerMode", dynlib: libName.}
  ##  sparse matrix descriptor
  ##  When the matrix descriptor is created, its fields are initialized to: 
  ##    CUSPARSE_MATRIX_TYPE_GENERAL
  ##    CUSPARSE_INDEX_BASE_ZERO
  ##    All other fields are uninitialized
  ## 
  proc CreateMatDescr*(descrA: ptr MatDescr_t): Status_t {.cdecl, cdecl,
      importc: "cusparseCreateMatDescr", dynlib: libName.}
  proc DestroyMatDescr*(descrA: MatDescr_t): Status_t {.cdecl, cdecl,
      importc: "cusparseDestroyMatDescr", dynlib: libName.}
  proc CopyMatDescr*(dest: MatDescr_t; src: MatDescr_t): Status_t {.cdecl, cdecl,
      importc: "cusparseCopyMatDescr", dynlib: libName.}
  proc SetMatType*(descrA: MatDescr_t; `type`: MatrixType_t): Status_t {.cdecl, cdecl,
      importc: "cusparseSetMatType", dynlib: libName.}
  proc GetMatType*(descrA: MatDescr_t): MatrixType_t {.cdecl, cdecl,
      importc: "cusparseGetMatType", dynlib: libName.}
  proc SetMatFillMode*(descrA: MatDescr_t; fillMode: FillMode_t): Status_t {.cdecl,
      cdecl, importc: "cusparseSetMatFillMode", dynlib: libName.}
  proc GetMatFillMode*(descrA: MatDescr_t): FillMode_t {.cdecl, cdecl,
      importc: "cusparseGetMatFillMode", dynlib: libName.}
  proc SetMatDiagType*(descrA: MatDescr_t; diagType: DiagType_t): Status_t {.cdecl,
      cdecl, importc: "cusparseSetMatDiagType", dynlib: libName.}
  proc GetMatDiagType*(descrA: MatDescr_t): DiagType_t {.cdecl, cdecl,
      importc: "cusparseGetMatDiagType", dynlib: libName.}
  proc SetMatIndexBase*(descrA: MatDescr_t; base: IndexBase_t): Status_t {.cdecl,
      cdecl, importc: "cusparseSetMatIndexBase", dynlib: libName.}
  proc GetMatIndexBase*(descrA: MatDescr_t): IndexBase_t {.cdecl, cdecl,
      importc: "cusparseGetMatIndexBase", dynlib: libName.}
  ##  sparse triangular solve and incomplete-LU and Cholesky (algorithm 1)
  proc CreateSolveAnalysisInfo*(info: ptr SolveAnalysisInfo_t): Status_t {.cdecl,
      cdecl, importc: "cusparseCreateSolveAnalysisInfo", dynlib: libName.}
  proc DestroySolveAnalysisInfo*(info: SolveAnalysisInfo_t): Status_t {.cdecl, cdecl,
      importc: "cusparseDestroySolveAnalysisInfo", dynlib: libName.}
  proc GetLevelInfo*(handle: Handle_t; info: SolveAnalysisInfo_t; nlevels: ptr cint;
                    levelPtr: ptr ptr cint; levelInd: ptr ptr cint): Status_t {.cdecl,
      cdecl, importc: "cusparseGetLevelInfo", dynlib: libName.}
  ##  sparse triangular solve (algorithm 2)
  proc CreateCsrsv2Info*(info: ptr csrsv2Info_t): Status_t {.cdecl, cdecl,
      importc: "cusparseCreateCsrsv2Info", dynlib: libName.}
  proc DestroyCsrsv2Info*(info: csrsv2Info_t): Status_t {.cdecl, cdecl,
      importc: "cusparseDestroyCsrsv2Info", dynlib: libName.}
  ##  incomplete Cholesky (algorithm 2)
  proc CreateCsric02Info*(info: ptr csric02Info_t): Status_t {.cdecl, cdecl,
      importc: "cusparseCreateCsric02Info", dynlib: libName.}
  proc DestroyCsric02Info*(info: csric02Info_t): Status_t {.cdecl, cdecl,
      importc: "cusparseDestroyCsric02Info", dynlib: libName.}
  proc CreateBsric02Info*(info: ptr bsric02Info_t): Status_t {.cdecl, cdecl,
      importc: "cusparseCreateBsric02Info", dynlib: libName.}
  proc DestroyBsric02Info*(info: bsric02Info_t): Status_t {.cdecl, cdecl,
      importc: "cusparseDestroyBsric02Info", dynlib: libName.}
  ##  incomplete LU (algorithm 2)
  proc CreateCsrilu02Info*(info: ptr csrilu02Info_t): Status_t {.cdecl, cdecl,
      importc: "cusparseCreateCsrilu02Info", dynlib: libName.}
  proc DestroyCsrilu02Info*(info: csrilu02Info_t): Status_t {.cdecl, cdecl,
      importc: "cusparseDestroyCsrilu02Info", dynlib: libName.}
  proc CreateBsrilu02Info*(info: ptr bsrilu02Info_t): Status_t {.cdecl, cdecl,
      importc: "cusparseCreateBsrilu02Info", dynlib: libName.}
  proc DestroyBsrilu02Info*(info: bsrilu02Info_t): Status_t {.cdecl, cdecl,
      importc: "cusparseDestroyBsrilu02Info", dynlib: libName.}
  ##  block-CSR triangular solve (algorithm 2)
  proc CreateBsrsv2Info*(info: ptr bsrsv2Info_t): Status_t {.cdecl, cdecl,
      importc: "cusparseCreateBsrsv2Info", dynlib: libName.}
  proc DestroyBsrsv2Info*(info: bsrsv2Info_t): Status_t {.cdecl, cdecl,
      importc: "cusparseDestroyBsrsv2Info", dynlib: libName.}
  proc CreateBsrsm2Info*(info: ptr bsrsm2Info_t): Status_t {.cdecl, cdecl,
      importc: "cusparseCreateBsrsm2Info", dynlib: libName.}
  proc DestroyBsrsm2Info*(info: bsrsm2Info_t): Status_t {.cdecl, cdecl,
      importc: "cusparseDestroyBsrsm2Info", dynlib: libName.}
  ##  hybrid (HYB) format
  proc CreateHybMat*(hybA: ptr HybMat_t): Status_t {.cdecl, cdecl,
      importc: "cusparseCreateHybMat", dynlib: libName.}
  proc DestroyHybMat*(hybA: HybMat_t): Status_t {.cdecl, cdecl,
      importc: "cusparseDestroyHybMat", dynlib: libName.}
  ##  sorting information
  proc CreateCsru2csrInfo*(info: ptr csru2csrInfo_t): Status_t {.cdecl, cdecl,
      importc: "cusparseCreateCsru2csrInfo", dynlib: libName.}
  proc DestroyCsru2csrInfo*(info: csru2csrInfo_t): Status_t {.cdecl, cdecl,
      importc: "cusparseDestroyCsru2csrInfo", dynlib: libName.}
  ##  coloring info
  proc CreateColorInfo*(info: ptr ColorInfo_t): Status_t {.cdecl, cdecl,
      importc: "cusparseCreateColorInfo", dynlib: libName.}
  proc DestroyColorInfo*(info: ColorInfo_t): Status_t {.cdecl, cdecl,
      importc: "cusparseDestroyColorInfo", dynlib: libName.}
  proc SetColorAlgs*(info: ColorInfo_t; alg: ColorAlg_t): Status_t {.cdecl, cdecl,
      importc: "cusparseSetColorAlgs", dynlib: libName.}
  proc GetColorAlgs*(info: ColorInfo_t; alg: ptr ColorAlg_t): Status_t {.cdecl, cdecl,
      importc: "cusparseGetColorAlgs", dynlib: libName.}
  ##  --- Sparse Level 1 routines ---
  ##  Description: Addition of a scalar multiple of a sparse vector x  
  ##    and a dense vector y.
  proc Saxpyi*(handle: Handle_t; nnz: cint; alpha: ptr cfloat; xVal: ptr cfloat;
              xInd: ptr cint; y: ptr cfloat; idxBase: IndexBase_t): Status_t {.cdecl,
      cdecl, importc: "cusparseSaxpyi", dynlib: libName.}
  proc Daxpyi*(handle: Handle_t; nnz: cint; alpha: ptr cdouble; xVal: ptr cdouble;
              xInd: ptr cint; y: ptr cdouble; idxBase: IndexBase_t): Status_t {.cdecl,
      cdecl, importc: "cusparseDaxpyi", dynlib: libName.}
  proc Caxpyi*(handle: Handle_t; nnz: cint; alpha: ptr cuComplex; xVal: ptr cuComplex;
              xInd: ptr cint; y: ptr cuComplex; idxBase: IndexBase_t): Status_t {.cdecl,
      cdecl, importc: "cusparseCaxpyi", dynlib: libName.}
  proc Zaxpyi*(handle: Handle_t; nnz: cint; alpha: ptr cuDoubleComplex;
              xVal: ptr cuDoubleComplex; xInd: ptr cint; y: ptr cuDoubleComplex;
              idxBase: IndexBase_t): Status_t {.cdecl, cdecl,
      importc: "cusparseZaxpyi", dynlib: libName.}
  ##  Description: dot product of a sparse vector x and a dense vector y.
  proc Sdoti*(handle: Handle_t; nnz: cint; xVal: ptr cfloat; xInd: ptr cint; y: ptr cfloat;
             resultDevHostPtr: ptr cfloat; idxBase: IndexBase_t): Status_t {.cdecl,
      cdecl, importc: "cusparseSdoti", dynlib: libName.}
  proc Ddoti*(handle: Handle_t; nnz: cint; xVal: ptr cdouble; xInd: ptr cint;
             y: ptr cdouble; resultDevHostPtr: ptr cdouble; idxBase: IndexBase_t): Status_t {.
      cdecl, cdecl, importc: "cusparseDdoti", dynlib: libName.}
  proc Cdoti*(handle: Handle_t; nnz: cint; xVal: ptr cuComplex; xInd: ptr cint;
             y: ptr cuComplex; resultDevHostPtr: ptr cuComplex; idxBase: IndexBase_t): Status_t {.
      cdecl, cdecl, importc: "cusparseCdoti", dynlib: libName.}
  proc Zdoti*(handle: Handle_t; nnz: cint; xVal: ptr cuDoubleComplex; xInd: ptr cint;
             y: ptr cuDoubleComplex; resultDevHostPtr: ptr cuDoubleComplex;
             idxBase: IndexBase_t): Status_t {.cdecl, cdecl,
      importc: "cusparseZdoti", dynlib: libName.}
  ##  Description: dot product of complex conjugate of a sparse vector x
  ##    and a dense vector y.
  proc Cdotci*(handle: Handle_t; nnz: cint; xVal: ptr cuComplex; xInd: ptr cint;
              y: ptr cuComplex; resultDevHostPtr: ptr cuComplex; idxBase: IndexBase_t): Status_t {.
      cdecl, cdecl, importc: "cusparseCdotci", dynlib: libName.}
  proc Zdotci*(handle: Handle_t; nnz: cint; xVal: ptr cuDoubleComplex; xInd: ptr cint;
              y: ptr cuDoubleComplex; resultDevHostPtr: ptr cuDoubleComplex;
              idxBase: IndexBase_t): Status_t {.cdecl, cdecl,
      importc: "cusparseZdotci", dynlib: libName.}
  ##  Description: Gather of non-zero elements from dense vector y into 
  ##    sparse vector x.
  proc Sgthr*(handle: Handle_t; nnz: cint; y: ptr cfloat; xVal: ptr cfloat; xInd: ptr cint;
             idxBase: IndexBase_t): Status_t {.cdecl, cdecl,
      importc: "cusparseSgthr", dynlib: libName.}
  proc Dgthr*(handle: Handle_t; nnz: cint; y: ptr cdouble; xVal: ptr cdouble;
             xInd: ptr cint; idxBase: IndexBase_t): Status_t {.cdecl, cdecl,
      importc: "cusparseDgthr", dynlib: libName.}
  proc Cgthr*(handle: Handle_t; nnz: cint; y: ptr cuComplex; xVal: ptr cuComplex;
             xInd: ptr cint; idxBase: IndexBase_t): Status_t {.cdecl, cdecl,
      importc: "cusparseCgthr", dynlib: libName.}
  proc Zgthr*(handle: Handle_t; nnz: cint; y: ptr cuDoubleComplex;
             xVal: ptr cuDoubleComplex; xInd: ptr cint; idxBase: IndexBase_t): Status_t {.
      cdecl, cdecl, importc: "cusparseZgthr", dynlib: libName.}
  ##  Description: Gather of non-zero elements from desne vector y into 
  ##    sparse vector x (also replacing these elements in y by zeros).
  proc Sgthrz*(handle: Handle_t; nnz: cint; y: ptr cfloat; xVal: ptr cfloat;
              xInd: ptr cint; idxBase: IndexBase_t): Status_t {.cdecl, cdecl,
      importc: "cusparseSgthrz", dynlib: libName.}
  proc Dgthrz*(handle: Handle_t; nnz: cint; y: ptr cdouble; xVal: ptr cdouble;
              xInd: ptr cint; idxBase: IndexBase_t): Status_t {.cdecl, cdecl,
      importc: "cusparseDgthrz", dynlib: libName.}
  proc Cgthrz*(handle: Handle_t; nnz: cint; y: ptr cuComplex; xVal: ptr cuComplex;
              xInd: ptr cint; idxBase: IndexBase_t): Status_t {.cdecl, cdecl,
      importc: "cusparseCgthrz", dynlib: libName.}
  proc Zgthrz*(handle: Handle_t; nnz: cint; y: ptr cuDoubleComplex;
              xVal: ptr cuDoubleComplex; xInd: ptr cint; idxBase: IndexBase_t): Status_t {.
      cdecl, cdecl, importc: "cusparseZgthrz", dynlib: libName.}
  ##  Description: Scatter of elements of the sparse vector x into 
  ##    dense vector y.
  proc Ssctr*(handle: Handle_t; nnz: cint; xVal: ptr cfloat; xInd: ptr cint; y: ptr cfloat;
             idxBase: IndexBase_t): Status_t {.cdecl, cdecl,
      importc: "cusparseSsctr", dynlib: libName.}
  proc Dsctr*(handle: Handle_t; nnz: cint; xVal: ptr cdouble; xInd: ptr cint;
             y: ptr cdouble; idxBase: IndexBase_t): Status_t {.cdecl, cdecl,
      importc: "cusparseDsctr", dynlib: libName.}
  proc Csctr*(handle: Handle_t; nnz: cint; xVal: ptr cuComplex; xInd: ptr cint;
             y: ptr cuComplex; idxBase: IndexBase_t): Status_t {.cdecl, cdecl,
      importc: "cusparseCsctr", dynlib: libName.}
  proc Zsctr*(handle: Handle_t; nnz: cint; xVal: ptr cuDoubleComplex; xInd: ptr cint;
             y: ptr cuDoubleComplex; idxBase: IndexBase_t): Status_t {.cdecl, cdecl,
      importc: "cusparseZsctr", dynlib: libName.}
  ##  Description: Givens rotation, where c and s are cosine and sine, 
  ##    x and y are sparse and dense vectors, respectively.
  proc Sroti*(handle: Handle_t; nnz: cint; xVal: ptr cfloat; xInd: ptr cint; y: ptr cfloat;
             c: ptr cfloat; s: ptr cfloat; idxBase: IndexBase_t): Status_t {.cdecl, cdecl,
      importc: "cusparseSroti", dynlib: libName.}
  proc Droti*(handle: Handle_t; nnz: cint; xVal: ptr cdouble; xInd: ptr cint;
             y: ptr cdouble; c: ptr cdouble; s: ptr cdouble; idxBase: IndexBase_t): Status_t {.
      cdecl, cdecl, importc: "cusparseDroti", dynlib: libName.}
  ##  --- Sparse Level 2 routines ---
  proc Sgemvi*(handle: Handle_t; transA: Operation_t; m: cint; n: cint;
              alpha: ptr cfloat; A: ptr cfloat; lda: cint; nnz: cint; xVal: ptr cfloat;
              xInd: ptr cint; beta: ptr cfloat; y: ptr cfloat; idxBase: IndexBase_t;
              pBuffer: pointer): Status_t {.cdecl, cdecl, importc: "cusparseSgemvi",
      dynlib: libName.}
    ##  host or device pointer
    ##  host or device pointer
  proc Sgemvi_bufferSize*(handle: Handle_t; transA: Operation_t; m: cint; n: cint;
                         nnz: cint; pBufferSize: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseSgemvi_bufferSize", dynlib: libName.}
  proc Dgemvi*(handle: Handle_t; transA: Operation_t; m: cint; n: cint;
              alpha: ptr cdouble; A: ptr cdouble; lda: cint; nnz: cint; xVal: ptr cdouble;
              xInd: ptr cint; beta: ptr cdouble; y: ptr cdouble; idxBase: IndexBase_t;
              pBuffer: pointer): Status_t {.cdecl, cdecl, importc: "cusparseDgemvi",
      dynlib: libName.}
    ##  host or device pointer
    ##  host or device pointer
  proc Dgemvi_bufferSize*(handle: Handle_t; transA: Operation_t; m: cint; n: cint;
                         nnz: cint; pBufferSize: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseDgemvi_bufferSize", dynlib: libName.}
  proc Cgemvi*(handle: Handle_t; transA: Operation_t; m: cint; n: cint;
              alpha: ptr cuComplex; A: ptr cuComplex; lda: cint; nnz: cint;
              xVal: ptr cuComplex; xInd: ptr cint; beta: ptr cuComplex; y: ptr cuComplex;
              idxBase: IndexBase_t; pBuffer: pointer): Status_t {.cdecl, cdecl,
      importc: "cusparseCgemvi", dynlib: libName.}
    ##  host or device pointer
    ##  host or device pointer
  proc Cgemvi_bufferSize*(handle: Handle_t; transA: Operation_t; m: cint; n: cint;
                         nnz: cint; pBufferSize: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseCgemvi_bufferSize", dynlib: libName.}
  proc Zgemvi*(handle: Handle_t; transA: Operation_t; m: cint; n: cint;
              alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex; lda: cint; nnz: cint;
              xVal: ptr cuDoubleComplex; xInd: ptr cint; beta: ptr cuDoubleComplex;
              y: ptr cuDoubleComplex; idxBase: IndexBase_t; pBuffer: pointer): Status_t {.
      cdecl, cdecl, importc: "cusparseZgemvi", dynlib: libName.}
    ##  host or device pointer
    ##  host or device pointer
  proc Zgemvi_bufferSize*(handle: Handle_t; transA: Operation_t; m: cint; n: cint;
                         nnz: cint; pBufferSize: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseZgemvi_bufferSize", dynlib: libName.}
  ##  Description: Matrix-vector multiplication  y = alpha * op(A) * x  + beta * y, 
  ##    where A is a sparse matrix in CSR storage format, x and y are dense vectors.
  proc Scsrmv*(handle: Handle_t; transA: Operation_t; m: cint; n: cint; nnz: cint;
              alpha: ptr cfloat; descrA: MatDescr_t; csrSortedValA: ptr cfloat;
              csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint; x: ptr cfloat;
              beta: ptr cfloat; y: ptr cfloat): Status_t {.cdecl, cdecl,
      importc: "cusparseScsrmv", dynlib: libName.}
  proc Dcsrmv*(handle: Handle_t; transA: Operation_t; m: cint; n: cint; nnz: cint;
              alpha: ptr cdouble; descrA: MatDescr_t; csrSortedValA: ptr cdouble;
              csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint; x: ptr cdouble;
              beta: ptr cdouble; y: ptr cdouble): Status_t {.cdecl, cdecl,
      importc: "cusparseDcsrmv", dynlib: libName.}
  proc Ccsrmv*(handle: Handle_t; transA: Operation_t; m: cint; n: cint; nnz: cint;
              alpha: ptr cuComplex; descrA: MatDescr_t; csrSortedValA: ptr cuComplex;
              csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
              x: ptr cuComplex; beta: ptr cuComplex; y: ptr cuComplex): Status_t {.cdecl,
      cdecl, importc: "cusparseCcsrmv", dynlib: libName.}
  proc Zcsrmv*(handle: Handle_t; transA: Operation_t; m: cint; n: cint; nnz: cint;
              alpha: ptr cuDoubleComplex; descrA: MatDescr_t;
              csrSortedValA: ptr cuDoubleComplex; csrSortedRowPtrA: ptr cint;
              csrSortedColIndA: ptr cint; x: ptr cuDoubleComplex;
              beta: ptr cuDoubleComplex; y: ptr cuDoubleComplex): Status_t {.cdecl,
      cdecl, importc: "cusparseZcsrmv", dynlib: libName.}
  ## Returns number of bytes
  proc CsrmvEx_bufferSize*(handle: Handle_t; alg: AlgMode_t; transA: Operation_t;
                          m: cint; n: cint; nnz: cint; alpha: pointer;
                          alphatype: cudaDataType; descrA: MatDescr_t;
                          csrValA: pointer; csrValAtype: cudaDataType;
                          csrRowPtrA: ptr cint; csrColIndA: ptr cint; x: pointer;
                          xtype: cudaDataType; beta: pointer;
                          betatype: cudaDataType; y: pointer; ytype: cudaDataType;
                          executiontype: cudaDataType;
                          bufferSizeInBytes: ptr csize): Status_t {.cdecl, cdecl,
      importc: "cusparseCsrmvEx_bufferSize", dynlib: libName.}
  proc CsrmvEx*(handle: Handle_t; alg: AlgMode_t; transA: Operation_t; m: cint; n: cint;
               nnz: cint; alpha: pointer; alphatype: cudaDataType; descrA: MatDescr_t;
               csrValA: pointer; csrValAtype: cudaDataType; csrRowPtrA: ptr cint;
               csrColIndA: ptr cint; x: pointer; xtype: cudaDataType; beta: pointer;
               betatype: cudaDataType; y: pointer; ytype: cudaDataType;
               executiontype: cudaDataType; buffer: pointer): Status_t {.cdecl, cdecl,
      importc: "cusparseCsrmvEx", dynlib: libName.}
  ##  Description: Matrix-vector multiplication  y = alpha * op(A) * x  + beta * y, 
  ##    where A is a sparse matrix in CSR storage format, x and y are dense vectors
  ##    using a Merge Path load-balancing implementation.
  proc Scsrmv_mp*(handle: Handle_t; transA: Operation_t; m: cint; n: cint; nnz: cint;
                 alpha: ptr cfloat; descrA: MatDescr_t; csrSortedValA: ptr cfloat;
                 csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                 x: ptr cfloat; beta: ptr cfloat; y: ptr cfloat): Status_t {.cdecl, cdecl,
      importc: "cusparseScsrmv_mp", dynlib: libName.}
  proc Dcsrmv_mp*(handle: Handle_t; transA: Operation_t; m: cint; n: cint; nnz: cint;
                 alpha: ptr cdouble; descrA: MatDescr_t; csrSortedValA: ptr cdouble;
                 csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                 x: ptr cdouble; beta: ptr cdouble; y: ptr cdouble): Status_t {.cdecl,
      cdecl, importc: "cusparseDcsrmv_mp", dynlib: libName.}
  proc Ccsrmv_mp*(handle: Handle_t; transA: Operation_t; m: cint; n: cint; nnz: cint;
                 alpha: ptr cuComplex; descrA: MatDescr_t;
                 csrSortedValA: ptr cuComplex; csrSortedRowPtrA: ptr cint;
                 csrSortedColIndA: ptr cint; x: ptr cuComplex; beta: ptr cuComplex;
                 y: ptr cuComplex): Status_t {.cdecl, cdecl,
      importc: "cusparseCcsrmv_mp", dynlib: libName.}
  proc Zcsrmv_mp*(handle: Handle_t; transA: Operation_t; m: cint; n: cint; nnz: cint;
                 alpha: ptr cuDoubleComplex; descrA: MatDescr_t;
                 csrSortedValA: ptr cuDoubleComplex; csrSortedRowPtrA: ptr cint;
                 csrSortedColIndA: ptr cint; x: ptr cuDoubleComplex;
                 beta: ptr cuDoubleComplex; y: ptr cuDoubleComplex): Status_t {.cdecl,
      cdecl, importc: "cusparseZcsrmv_mp", dynlib: libName.}
  ##  Description: Matrix-vector multiplication  y = alpha * op(A) * x  + beta * y, 
  ##    where A is a sparse matrix in HYB storage format, x and y are dense vectors.
  proc Shybmv*(handle: Handle_t; transA: Operation_t; alpha: ptr cfloat;
              descrA: MatDescr_t; hybA: HybMat_t; x: ptr cfloat; beta: ptr cfloat;
              y: ptr cfloat): Status_t {.cdecl, cdecl, importc: "cusparseShybmv",
                                     dynlib: libName.}
  proc Dhybmv*(handle: Handle_t; transA: Operation_t; alpha: ptr cdouble;
              descrA: MatDescr_t; hybA: HybMat_t; x: ptr cdouble; beta: ptr cdouble;
              y: ptr cdouble): Status_t {.cdecl, cdecl, importc: "cusparseDhybmv",
                                      dynlib: libName.}
  proc Chybmv*(handle: Handle_t; transA: Operation_t; alpha: ptr cuComplex;
              descrA: MatDescr_t; hybA: HybMat_t; x: ptr cuComplex;
              beta: ptr cuComplex; y: ptr cuComplex): Status_t {.cdecl, cdecl,
      importc: "cusparseChybmv", dynlib: libName.}
  proc Zhybmv*(handle: Handle_t; transA: Operation_t; alpha: ptr cuDoubleComplex;
              descrA: MatDescr_t; hybA: HybMat_t; x: ptr cuDoubleComplex;
              beta: ptr cuDoubleComplex; y: ptr cuDoubleComplex): Status_t {.cdecl,
      cdecl, importc: "cusparseZhybmv", dynlib: libName.}
  ##  Description: Matrix-vector multiplication  y = alpha * op(A) * x  + beta * y, 
  ##    where A is a sparse matrix in BSR storage format, x and y are dense vectors.
  proc Sbsrmv*(handle: Handle_t; dirA: Direction_t; transA: Operation_t; mb: cint;
              nb: cint; nnzb: cint; alpha: ptr cfloat; descrA: MatDescr_t;
              bsrSortedValA: ptr cfloat; bsrSortedRowPtrA: ptr cint;
              bsrSortedColIndA: ptr cint; blockDim: cint; x: ptr cfloat;
              beta: ptr cfloat; y: ptr cfloat): Status_t {.cdecl, cdecl,
      importc: "cusparseSbsrmv", dynlib: libName.}
  proc Dbsrmv*(handle: Handle_t; dirA: Direction_t; transA: Operation_t; mb: cint;
              nb: cint; nnzb: cint; alpha: ptr cdouble; descrA: MatDescr_t;
              bsrSortedValA: ptr cdouble; bsrSortedRowPtrA: ptr cint;
              bsrSortedColIndA: ptr cint; blockDim: cint; x: ptr cdouble;
              beta: ptr cdouble; y: ptr cdouble): Status_t {.cdecl, cdecl,
      importc: "cusparseDbsrmv", dynlib: libName.}
  proc Cbsrmv*(handle: Handle_t; dirA: Direction_t; transA: Operation_t; mb: cint;
              nb: cint; nnzb: cint; alpha: ptr cuComplex; descrA: MatDescr_t;
              bsrSortedValA: ptr cuComplex; bsrSortedRowPtrA: ptr cint;
              bsrSortedColIndA: ptr cint; blockDim: cint; x: ptr cuComplex;
              beta: ptr cuComplex; y: ptr cuComplex): Status_t {.cdecl, cdecl,
      importc: "cusparseCbsrmv", dynlib: libName.}
  proc Zbsrmv*(handle: Handle_t; dirA: Direction_t; transA: Operation_t; mb: cint;
              nb: cint; nnzb: cint; alpha: ptr cuDoubleComplex; descrA: MatDescr_t;
              bsrSortedValA: ptr cuDoubleComplex; bsrSortedRowPtrA: ptr cint;
              bsrSortedColIndA: ptr cint; blockDim: cint; x: ptr cuDoubleComplex;
              beta: ptr cuDoubleComplex; y: ptr cuDoubleComplex): Status_t {.cdecl,
      cdecl, importc: "cusparseZbsrmv", dynlib: libName.}
  ##  Description: Matrix-vector multiplication  y = alpha * op(A) * x  + beta * y, 
  ##    where A is a sparse matrix in extended BSR storage format, x and y are dense 
  ##    vectors.
  proc Sbsrxmv*(handle: Handle_t; dirA: Direction_t; transA: Operation_t;
               sizeOfMask: cint; mb: cint; nb: cint; nnzb: cint; alpha: ptr cfloat;
               descrA: MatDescr_t; bsrSortedValA: ptr cfloat;
               bsrSortedMaskPtrA: ptr cint; bsrSortedRowPtrA: ptr cint;
               bsrSortedEndPtrA: ptr cint; bsrSortedColIndA: ptr cint; blockDim: cint;
               x: ptr cfloat; beta: ptr cfloat; y: ptr cfloat): Status_t {.cdecl, cdecl,
      importc: "cusparseSbsrxmv", dynlib: libName.}
  proc Dbsrxmv*(handle: Handle_t; dirA: Direction_t; transA: Operation_t;
               sizeOfMask: cint; mb: cint; nb: cint; nnzb: cint; alpha: ptr cdouble;
               descrA: MatDescr_t; bsrSortedValA: ptr cdouble;
               bsrSortedMaskPtrA: ptr cint; bsrSortedRowPtrA: ptr cint;
               bsrSortedEndPtrA: ptr cint; bsrSortedColIndA: ptr cint; blockDim: cint;
               x: ptr cdouble; beta: ptr cdouble; y: ptr cdouble): Status_t {.cdecl, cdecl,
      importc: "cusparseDbsrxmv", dynlib: libName.}
  proc Cbsrxmv*(handle: Handle_t; dirA: Direction_t; transA: Operation_t;
               sizeOfMask: cint; mb: cint; nb: cint; nnzb: cint; alpha: ptr cuComplex;
               descrA: MatDescr_t; bsrSortedValA: ptr cuComplex;
               bsrSortedMaskPtrA: ptr cint; bsrSortedRowPtrA: ptr cint;
               bsrSortedEndPtrA: ptr cint; bsrSortedColIndA: ptr cint; blockDim: cint;
               x: ptr cuComplex; beta: ptr cuComplex; y: ptr cuComplex): Status_t {.cdecl,
      cdecl, importc: "cusparseCbsrxmv", dynlib: libName.}
  proc Zbsrxmv*(handle: Handle_t; dirA: Direction_t; transA: Operation_t;
               sizeOfMask: cint; mb: cint; nb: cint; nnzb: cint;
               alpha: ptr cuDoubleComplex; descrA: MatDescr_t;
               bsrSortedValA: ptr cuDoubleComplex; bsrSortedMaskPtrA: ptr cint;
               bsrSortedRowPtrA: ptr cint; bsrSortedEndPtrA: ptr cint;
               bsrSortedColIndA: ptr cint; blockDim: cint; x: ptr cuDoubleComplex;
               beta: ptr cuDoubleComplex; y: ptr cuDoubleComplex): Status_t {.cdecl,
      cdecl, importc: "cusparseZbsrxmv", dynlib: libName.}
  ##  Description: Solution of triangular linear system op(A) * x = alpha * f, 
  ##    where A is a sparse matrix in CSR storage format, rhs f and solution x 
  ##    are dense vectors. This routine implements algorithm 1 for the solve.
  proc Csrsv_analysisEx*(handle: Handle_t; transA: Operation_t; m: cint; nnz: cint;
                        descrA: MatDescr_t; csrSortedValA: pointer;
                        csrSortedValAtype: cudaDataType;
                        csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                        info: SolveAnalysisInfo_t; executiontype: cudaDataType): Status_t {.
      cdecl, cdecl, importc: "cusparseCsrsv_analysisEx", dynlib: libName.}
  proc Scsrsv_analysis*(handle: Handle_t; transA: Operation_t; m: cint; nnz: cint;
                       descrA: MatDescr_t; csrSortedValA: ptr cfloat;
                       csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                       info: SolveAnalysisInfo_t): Status_t {.cdecl, cdecl,
      importc: "cusparseScsrsv_analysis", dynlib: libName.}
  proc Dcsrsv_analysis*(handle: Handle_t; transA: Operation_t; m: cint; nnz: cint;
                       descrA: MatDescr_t; csrSortedValA: ptr cdouble;
                       csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                       info: SolveAnalysisInfo_t): Status_t {.cdecl, cdecl,
      importc: "cusparseDcsrsv_analysis", dynlib: libName.}
  proc Ccsrsv_analysis*(handle: Handle_t; transA: Operation_t; m: cint; nnz: cint;
                       descrA: MatDescr_t; csrSortedValA: ptr cuComplex;
                       csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                       info: SolveAnalysisInfo_t): Status_t {.cdecl, cdecl,
      importc: "cusparseCcsrsv_analysis", dynlib: libName.}
  proc Zcsrsv_analysis*(handle: Handle_t; transA: Operation_t; m: cint; nnz: cint;
                       descrA: MatDescr_t; csrSortedValA: ptr cuDoubleComplex;
                       csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                       info: SolveAnalysisInfo_t): Status_t {.cdecl, cdecl,
      importc: "cusparseZcsrsv_analysis", dynlib: libName.}
  proc Csrsv_solveEx*(handle: Handle_t; transA: Operation_t; m: cint; alpha: pointer;
                     alphatype: cudaDataType; descrA: MatDescr_t;
                     csrSortedValA: pointer; csrSortedValAtype: cudaDataType;
                     csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                     info: SolveAnalysisInfo_t; f: pointer; ftype: cudaDataType;
                     x: pointer; xtype: cudaDataType; executiontype: cudaDataType): Status_t {.
      cdecl, cdecl, importc: "cusparseCsrsv_solveEx", dynlib: libName.}
  proc Scsrsv_solve*(handle: Handle_t; transA: Operation_t; m: cint; alpha: ptr cfloat;
                    descrA: MatDescr_t; csrSortedValA: ptr cfloat;
                    csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                    info: SolveAnalysisInfo_t; f: ptr cfloat; x: ptr cfloat): Status_t {.
      cdecl, cdecl, importc: "cusparseScsrsv_solve", dynlib: libName.}
  proc Dcsrsv_solve*(handle: Handle_t; transA: Operation_t; m: cint;
                    alpha: ptr cdouble; descrA: MatDescr_t;
                    csrSortedValA: ptr cdouble; csrSortedRowPtrA: ptr cint;
                    csrSortedColIndA: ptr cint; info: SolveAnalysisInfo_t;
                    f: ptr cdouble; x: ptr cdouble): Status_t {.cdecl, cdecl,
      importc: "cusparseDcsrsv_solve", dynlib: libName.}
  proc Ccsrsv_solve*(handle: Handle_t; transA: Operation_t; m: cint;
                    alpha: ptr cuComplex; descrA: MatDescr_t;
                    csrSortedValA: ptr cuComplex; csrSortedRowPtrA: ptr cint;
                    csrSortedColIndA: ptr cint; info: SolveAnalysisInfo_t;
                    f: ptr cuComplex; x: ptr cuComplex): Status_t {.cdecl, cdecl,
      importc: "cusparseCcsrsv_solve", dynlib: libName.}
  proc Zcsrsv_solve*(handle: Handle_t; transA: Operation_t; m: cint;
                    alpha: ptr cuDoubleComplex; descrA: MatDescr_t;
                    csrSortedValA: ptr cuDoubleComplex; csrSortedRowPtrA: ptr cint;
                    csrSortedColIndA: ptr cint; info: SolveAnalysisInfo_t;
                    f: ptr cuDoubleComplex; x: ptr cuDoubleComplex): Status_t {.cdecl,
      cdecl, importc: "cusparseZcsrsv_solve", dynlib: libName.}
  ##  Description: Solution of triangular linear system op(A) * x = alpha * f, 
  ##    where A is a sparse matrix in CSR storage format, rhs f and solution y 
  ##    are dense vectors. This routine implements algorithm 1 for this problem. 
  ##    Also, it provides a utility function to query size of buffer used.
  proc Xcsrsv2_zeroPivot*(handle: Handle_t; info: csrsv2Info_t; position: ptr cint): Status_t {.
      cdecl, cdecl, importc: "cusparseXcsrsv2_zeroPivot", dynlib: libName.}
  proc Scsrsv2_bufferSize*(handle: Handle_t; transA: Operation_t; m: cint; nnz: cint;
                          descrA: MatDescr_t; csrSortedValA: ptr cfloat;
                          csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                          info: csrsv2Info_t; pBufferSizeInBytes: ptr cint): Status_t {.
      cdecl, cdecl, importc: "cusparseScsrsv2_bufferSize", dynlib: libName.}
  proc Dcsrsv2_bufferSize*(handle: Handle_t; transA: Operation_t; m: cint; nnz: cint;
                          descrA: MatDescr_t; csrSortedValA: ptr cdouble;
                          csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                          info: csrsv2Info_t; pBufferSizeInBytes: ptr cint): Status_t {.
      cdecl, cdecl, importc: "cusparseDcsrsv2_bufferSize", dynlib: libName.}
  proc Ccsrsv2_bufferSize*(handle: Handle_t; transA: Operation_t; m: cint; nnz: cint;
                          descrA: MatDescr_t; csrSortedValA: ptr cuComplex;
                          csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                          info: csrsv2Info_t; pBufferSizeInBytes: ptr cint): Status_t {.
      cdecl, cdecl, importc: "cusparseCcsrsv2_bufferSize", dynlib: libName.}
  proc Zcsrsv2_bufferSize*(handle: Handle_t; transA: Operation_t; m: cint; nnz: cint;
                          descrA: MatDescr_t; csrSortedValA: ptr cuDoubleComplex;
                          csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                          info: csrsv2Info_t; pBufferSizeInBytes: ptr cint): Status_t {.
      cdecl, cdecl, importc: "cusparseZcsrsv2_bufferSize", dynlib: libName.}
  proc Scsrsv2_bufferSizeExt*(handle: Handle_t; transA: Operation_t; m: cint;
                             nnz: cint; descrA: MatDescr_t;
                             csrSortedValA: ptr cfloat; csrSortedRowPtrA: ptr cint;
                             csrSortedColIndA: ptr cint; info: csrsv2Info_t;
                             pBufferSize: ptr csize): Status_t {.cdecl, cdecl,
      importc: "cusparseScsrsv2_bufferSizeExt", dynlib: libName.}
  proc Dcsrsv2_bufferSizeExt*(handle: Handle_t; transA: Operation_t; m: cint;
                             nnz: cint; descrA: MatDescr_t;
                             csrSortedValA: ptr cdouble;
                             csrSortedRowPtrA: ptr cint;
                             csrSortedColIndA: ptr cint; info: csrsv2Info_t;
                             pBufferSize: ptr csize): Status_t {.cdecl, cdecl,
      importc: "cusparseDcsrsv2_bufferSizeExt", dynlib: libName.}
  proc Ccsrsv2_bufferSizeExt*(handle: Handle_t; transA: Operation_t; m: cint;
                             nnz: cint; descrA: MatDescr_t;
                             csrSortedValA: ptr cuComplex;
                             csrSortedRowPtrA: ptr cint;
                             csrSortedColIndA: ptr cint; info: csrsv2Info_t;
                             pBufferSize: ptr csize): Status_t {.cdecl, cdecl,
      importc: "cusparseCcsrsv2_bufferSizeExt", dynlib: libName.}
  proc Zcsrsv2_bufferSizeExt*(handle: Handle_t; transA: Operation_t; m: cint;
                             nnz: cint; descrA: MatDescr_t;
                             csrSortedValA: ptr cuDoubleComplex;
                             csrSortedRowPtrA: ptr cint;
                             csrSortedColIndA: ptr cint; info: csrsv2Info_t;
                             pBufferSize: ptr csize): Status_t {.cdecl, cdecl,
      importc: "cusparseZcsrsv2_bufferSizeExt", dynlib: libName.}
  proc Scsrsv2_analysis*(handle: Handle_t; transA: Operation_t; m: cint; nnz: cint;
                        descrA: MatDescr_t; csrSortedValA: ptr cfloat;
                        csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                        info: csrsv2Info_t; policy: SolvePolicy_t; pBuffer: pointer): Status_t {.
      cdecl, cdecl, importc: "cusparseScsrsv2_analysis", dynlib: libName.}
  proc Dcsrsv2_analysis*(handle: Handle_t; transA: Operation_t; m: cint; nnz: cint;
                        descrA: MatDescr_t; csrSortedValA: ptr cdouble;
                        csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                        info: csrsv2Info_t; policy: SolvePolicy_t; pBuffer: pointer): Status_t {.
      cdecl, cdecl, importc: "cusparseDcsrsv2_analysis", dynlib: libName.}
  proc Ccsrsv2_analysis*(handle: Handle_t; transA: Operation_t; m: cint; nnz: cint;
                        descrA: MatDescr_t; csrSortedValA: ptr cuComplex;
                        csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                        info: csrsv2Info_t; policy: SolvePolicy_t; pBuffer: pointer): Status_t {.
      cdecl, cdecl, importc: "cusparseCcsrsv2_analysis", dynlib: libName.}
  proc Zcsrsv2_analysis*(handle: Handle_t; transA: Operation_t; m: cint; nnz: cint;
                        descrA: MatDescr_t; csrSortedValA: ptr cuDoubleComplex;
                        csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                        info: csrsv2Info_t; policy: SolvePolicy_t; pBuffer: pointer): Status_t {.
      cdecl, cdecl, importc: "cusparseZcsrsv2_analysis", dynlib: libName.}
  proc Scsrsv2_solve*(handle: Handle_t; transA: Operation_t; m: cint; nnz: cint;
                     alpha: ptr cfloat; descrA: MatDescr_t;
                     csrSortedValA: ptr cfloat; csrSortedRowPtrA: ptr cint;
                     csrSortedColIndA: ptr cint; info: csrsv2Info_t; f: ptr cfloat;
                     x: ptr cfloat; policy: SolvePolicy_t; pBuffer: pointer): Status_t {.
      cdecl, cdecl, importc: "cusparseScsrsv2_solve", dynlib: libName.}
  proc Dcsrsv2_solve*(handle: Handle_t; transA: Operation_t; m: cint; nnz: cint;
                     alpha: ptr cdouble; descrA: MatDescr_t;
                     csrSortedValA: ptr cdouble; csrSortedRowPtrA: ptr cint;
                     csrSortedColIndA: ptr cint; info: csrsv2Info_t; f: ptr cdouble;
                     x: ptr cdouble; policy: SolvePolicy_t; pBuffer: pointer): Status_t {.
      cdecl, cdecl, importc: "cusparseDcsrsv2_solve", dynlib: libName.}
  proc Ccsrsv2_solve*(handle: Handle_t; transA: Operation_t; m: cint; nnz: cint;
                     alpha: ptr cuComplex; descrA: MatDescr_t;
                     csrSortedValA: ptr cuComplex; csrSortedRowPtrA: ptr cint;
                     csrSortedColIndA: ptr cint; info: csrsv2Info_t;
                     f: ptr cuComplex; x: ptr cuComplex; policy: SolvePolicy_t;
                     pBuffer: pointer): Status_t {.cdecl, cdecl,
      importc: "cusparseCcsrsv2_solve", dynlib: libName.}
  proc Zcsrsv2_solve*(handle: Handle_t; transA: Operation_t; m: cint; nnz: cint;
                     alpha: ptr cuDoubleComplex; descrA: MatDescr_t;
                     csrSortedValA: ptr cuDoubleComplex;
                     csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                     info: csrsv2Info_t; f: ptr cuDoubleComplex;
                     x: ptr cuDoubleComplex; policy: SolvePolicy_t; pBuffer: pointer): Status_t {.
      cdecl, cdecl, importc: "cusparseZcsrsv2_solve", dynlib: libName.}
  ##  Description: Solution of triangular linear system op(A) * x = alpha * f, 
  ##    where A is a sparse matrix in block-CSR storage format, rhs f and solution y 
  ##    are dense vectors. This routine implements algorithm 2 for this problem. 
  ##    Also, it provides a utility function to query size of buffer used.
  proc Xbsrsv2_zeroPivot*(handle: Handle_t; info: bsrsv2Info_t; position: ptr cint): Status_t {.
      cdecl, cdecl, importc: "cusparseXbsrsv2_zeroPivot", dynlib: libName.}
  proc Sbsrsv2_bufferSize*(handle: Handle_t; dirA: Direction_t; transA: Operation_t;
                          mb: cint; nnzb: cint; descrA: MatDescr_t;
                          bsrSortedValA: ptr cfloat; bsrSortedRowPtrA: ptr cint;
                          bsrSortedColIndA: ptr cint; blockDim: cint;
                          info: bsrsv2Info_t; pBufferSizeInBytes: ptr cint): Status_t {.
      cdecl, cdecl, importc: "cusparseSbsrsv2_bufferSize", dynlib: libName.}
  proc Dbsrsv2_bufferSize*(handle: Handle_t; dirA: Direction_t; transA: Operation_t;
                          mb: cint; nnzb: cint; descrA: MatDescr_t;
                          bsrSortedValA: ptr cdouble; bsrSortedRowPtrA: ptr cint;
                          bsrSortedColIndA: ptr cint; blockDim: cint;
                          info: bsrsv2Info_t; pBufferSizeInBytes: ptr cint): Status_t {.
      cdecl, cdecl, importc: "cusparseDbsrsv2_bufferSize", dynlib: libName.}
  proc Cbsrsv2_bufferSize*(handle: Handle_t; dirA: Direction_t; transA: Operation_t;
                          mb: cint; nnzb: cint; descrA: MatDescr_t;
                          bsrSortedValA: ptr cuComplex; bsrSortedRowPtrA: ptr cint;
                          bsrSortedColIndA: ptr cint; blockDim: cint;
                          info: bsrsv2Info_t; pBufferSizeInBytes: ptr cint): Status_t {.
      cdecl, cdecl, importc: "cusparseCbsrsv2_bufferSize", dynlib: libName.}
  proc Zbsrsv2_bufferSize*(handle: Handle_t; dirA: Direction_t; transA: Operation_t;
                          mb: cint; nnzb: cint; descrA: MatDescr_t;
                          bsrSortedValA: ptr cuDoubleComplex;
                          bsrSortedRowPtrA: ptr cint; bsrSortedColIndA: ptr cint;
                          blockDim: cint; info: bsrsv2Info_t;
                          pBufferSizeInBytes: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseZbsrsv2_bufferSize", dynlib: libName.}
  proc Sbsrsv2_bufferSizeExt*(handle: Handle_t; dirA: Direction_t;
                             transA: Operation_t; mb: cint; nnzb: cint;
                             descrA: MatDescr_t; bsrSortedValA: ptr cfloat;
                             bsrSortedRowPtrA: ptr cint;
                             bsrSortedColIndA: ptr cint; blockSize: cint;
                             info: bsrsv2Info_t; pBufferSize: ptr csize): Status_t {.
      cdecl, cdecl, importc: "cusparseSbsrsv2_bufferSizeExt", dynlib: libName.}
  proc Dbsrsv2_bufferSizeExt*(handle: Handle_t; dirA: Direction_t;
                             transA: Operation_t; mb: cint; nnzb: cint;
                             descrA: MatDescr_t; bsrSortedValA: ptr cdouble;
                             bsrSortedRowPtrA: ptr cint;
                             bsrSortedColIndA: ptr cint; blockSize: cint;
                             info: bsrsv2Info_t; pBufferSize: ptr csize): Status_t {.
      cdecl, cdecl, importc: "cusparseDbsrsv2_bufferSizeExt", dynlib: libName.}
  proc Cbsrsv2_bufferSizeExt*(handle: Handle_t; dirA: Direction_t;
                             transA: Operation_t; mb: cint; nnzb: cint;
                             descrA: MatDescr_t; bsrSortedValA: ptr cuComplex;
                             bsrSortedRowPtrA: ptr cint;
                             bsrSortedColIndA: ptr cint; blockSize: cint;
                             info: bsrsv2Info_t; pBufferSize: ptr csize): Status_t {.
      cdecl, cdecl, importc: "cusparseCbsrsv2_bufferSizeExt", dynlib: libName.}
  proc Zbsrsv2_bufferSizeExt*(handle: Handle_t; dirA: Direction_t;
                             transA: Operation_t; mb: cint; nnzb: cint;
                             descrA: MatDescr_t;
                             bsrSortedValA: ptr cuDoubleComplex;
                             bsrSortedRowPtrA: ptr cint;
                             bsrSortedColIndA: ptr cint; blockSize: cint;
                             info: bsrsv2Info_t; pBufferSize: ptr csize): Status_t {.
      cdecl, cdecl, importc: "cusparseZbsrsv2_bufferSizeExt", dynlib: libName.}
  proc Sbsrsv2_analysis*(handle: Handle_t; dirA: Direction_t; transA: Operation_t;
                        mb: cint; nnzb: cint; descrA: MatDescr_t;
                        bsrSortedValA: ptr cfloat; bsrSortedRowPtrA: ptr cint;
                        bsrSortedColIndA: ptr cint; blockDim: cint;
                        info: bsrsv2Info_t; policy: SolvePolicy_t; pBuffer: pointer): Status_t {.
      cdecl, cdecl, importc: "cusparseSbsrsv2_analysis", dynlib: libName.}
  proc Dbsrsv2_analysis*(handle: Handle_t; dirA: Direction_t; transA: Operation_t;
                        mb: cint; nnzb: cint; descrA: MatDescr_t;
                        bsrSortedValA: ptr cdouble; bsrSortedRowPtrA: ptr cint;
                        bsrSortedColIndA: ptr cint; blockDim: cint;
                        info: bsrsv2Info_t; policy: SolvePolicy_t; pBuffer: pointer): Status_t {.
      cdecl, cdecl, importc: "cusparseDbsrsv2_analysis", dynlib: libName.}
  proc Cbsrsv2_analysis*(handle: Handle_t; dirA: Direction_t; transA: Operation_t;
                        mb: cint; nnzb: cint; descrA: MatDescr_t;
                        bsrSortedValA: ptr cuComplex; bsrSortedRowPtrA: ptr cint;
                        bsrSortedColIndA: ptr cint; blockDim: cint;
                        info: bsrsv2Info_t; policy: SolvePolicy_t; pBuffer: pointer): Status_t {.
      cdecl, cdecl, importc: "cusparseCbsrsv2_analysis", dynlib: libName.}
  proc Zbsrsv2_analysis*(handle: Handle_t; dirA: Direction_t; transA: Operation_t;
                        mb: cint; nnzb: cint; descrA: MatDescr_t;
                        bsrSortedValA: ptr cuDoubleComplex;
                        bsrSortedRowPtrA: ptr cint; bsrSortedColIndA: ptr cint;
                        blockDim: cint; info: bsrsv2Info_t; policy: SolvePolicy_t;
                        pBuffer: pointer): Status_t {.cdecl, cdecl,
      importc: "cusparseZbsrsv2_analysis", dynlib: libName.}
  proc Sbsrsv2_solve*(handle: Handle_t; dirA: Direction_t; transA: Operation_t;
                     mb: cint; nnzb: cint; alpha: ptr cfloat; descrA: MatDescr_t;
                     bsrSortedValA: ptr cfloat; bsrSortedRowPtrA: ptr cint;
                     bsrSortedColIndA: ptr cint; blockDim: cint; info: bsrsv2Info_t;
                     f: ptr cfloat; x: ptr cfloat; policy: SolvePolicy_t;
                     pBuffer: pointer): Status_t {.cdecl, cdecl,
      importc: "cusparseSbsrsv2_solve", dynlib: libName.}
  proc Dbsrsv2_solve*(handle: Handle_t; dirA: Direction_t; transA: Operation_t;
                     mb: cint; nnzb: cint; alpha: ptr cdouble; descrA: MatDescr_t;
                     bsrSortedValA: ptr cdouble; bsrSortedRowPtrA: ptr cint;
                     bsrSortedColIndA: ptr cint; blockDim: cint; info: bsrsv2Info_t;
                     f: ptr cdouble; x: ptr cdouble; policy: SolvePolicy_t;
                     pBuffer: pointer): Status_t {.cdecl, cdecl,
      importc: "cusparseDbsrsv2_solve", dynlib: libName.}
  proc Cbsrsv2_solve*(handle: Handle_t; dirA: Direction_t; transA: Operation_t;
                     mb: cint; nnzb: cint; alpha: ptr cuComplex; descrA: MatDescr_t;
                     bsrSortedValA: ptr cuComplex; bsrSortedRowPtrA: ptr cint;
                     bsrSortedColIndA: ptr cint; blockDim: cint; info: bsrsv2Info_t;
                     f: ptr cuComplex; x: ptr cuComplex; policy: SolvePolicy_t;
                     pBuffer: pointer): Status_t {.cdecl, cdecl,
      importc: "cusparseCbsrsv2_solve", dynlib: libName.}
  proc Zbsrsv2_solve*(handle: Handle_t; dirA: Direction_t; transA: Operation_t;
                     mb: cint; nnzb: cint; alpha: ptr cuDoubleComplex;
                     descrA: MatDescr_t; bsrSortedValA: ptr cuDoubleComplex;
                     bsrSortedRowPtrA: ptr cint; bsrSortedColIndA: ptr cint;
                     blockDim: cint; info: bsrsv2Info_t; f: ptr cuDoubleComplex;
                     x: ptr cuDoubleComplex; policy: SolvePolicy_t; pBuffer: pointer): Status_t {.
      cdecl, cdecl, importc: "cusparseZbsrsv2_solve", dynlib: libName.}
  ##  Description: Solution of triangular linear system op(A) * x = alpha * f, 
  ##    where A is a sparse matrix in HYB storage format, rhs f and solution x 
  ##    are dense vectors.
  proc Shybsv_analysis*(handle: Handle_t; transA: Operation_t; descrA: MatDescr_t;
                       hybA: HybMat_t; info: SolveAnalysisInfo_t): Status_t {.cdecl,
      cdecl, importc: "cusparseShybsv_analysis", dynlib: libName.}
  proc Dhybsv_analysis*(handle: Handle_t; transA: Operation_t; descrA: MatDescr_t;
                       hybA: HybMat_t; info: SolveAnalysisInfo_t): Status_t {.cdecl,
      cdecl, importc: "cusparseDhybsv_analysis", dynlib: libName.}
  proc Chybsv_analysis*(handle: Handle_t; transA: Operation_t; descrA: MatDescr_t;
                       hybA: HybMat_t; info: SolveAnalysisInfo_t): Status_t {.cdecl,
      cdecl, importc: "cusparseChybsv_analysis", dynlib: libName.}
  proc Zhybsv_analysis*(handle: Handle_t; transA: Operation_t; descrA: MatDescr_t;
                       hybA: HybMat_t; info: SolveAnalysisInfo_t): Status_t {.cdecl,
      cdecl, importc: "cusparseZhybsv_analysis", dynlib: libName.}
  proc Shybsv_solve*(handle: Handle_t; trans: Operation_t; alpha: ptr cfloat;
                    descra: MatDescr_t; hybA: HybMat_t; info: SolveAnalysisInfo_t;
                    f: ptr cfloat; x: ptr cfloat): Status_t {.cdecl, cdecl,
      importc: "cusparseShybsv_solve", dynlib: libName.}
  proc Chybsv_solve*(handle: Handle_t; trans: Operation_t; alpha: ptr cuComplex;
                    descra: MatDescr_t; hybA: HybMat_t; info: SolveAnalysisInfo_t;
                    f: ptr cuComplex; x: ptr cuComplex): Status_t {.cdecl, cdecl,
      importc: "cusparseChybsv_solve", dynlib: libName.}
  proc Dhybsv_solve*(handle: Handle_t; trans: Operation_t; alpha: ptr cdouble;
                    descra: MatDescr_t; hybA: HybMat_t; info: SolveAnalysisInfo_t;
                    f: ptr cdouble; x: ptr cdouble): Status_t {.cdecl, cdecl,
      importc: "cusparseDhybsv_solve", dynlib: libName.}
  proc Zhybsv_solve*(handle: Handle_t; trans: Operation_t;
                    alpha: ptr cuDoubleComplex; descra: MatDescr_t; hybA: HybMat_t;
                    info: SolveAnalysisInfo_t; f: ptr cuDoubleComplex;
                    x: ptr cuDoubleComplex): Status_t {.cdecl, cdecl,
      importc: "cusparseZhybsv_solve", dynlib: libName.}
  ##  --- Sparse Level 3 routines ---
  ##  Description: sparse - dense matrix multiplication C = alpha * op(A) * B  + beta * C, 
  ##    where A is a sparse matrix in CSR format, B and C are dense tall matrices.
  proc Scsrmm*(handle: Handle_t; transA: Operation_t; m: cint; n: cint; k: cint; nnz: cint;
              alpha: ptr cfloat; descrA: MatDescr_t; csrSortedValA: ptr cfloat;
              csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint; B: ptr cfloat;
              ldb: cint; beta: ptr cfloat; C: ptr cfloat; ldc: cint): Status_t {.cdecl,
      cdecl, importc: "cusparseScsrmm", dynlib: libName.}
  proc Dcsrmm*(handle: Handle_t; transA: Operation_t; m: cint; n: cint; k: cint; nnz: cint;
              alpha: ptr cdouble; descrA: MatDescr_t; csrSortedValA: ptr cdouble;
              csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint; B: ptr cdouble;
              ldb: cint; beta: ptr cdouble; C: ptr cdouble; ldc: cint): Status_t {.cdecl,
      cdecl, importc: "cusparseDcsrmm", dynlib: libName.}
  proc Ccsrmm*(handle: Handle_t; transA: Operation_t; m: cint; n: cint; k: cint; nnz: cint;
              alpha: ptr cuComplex; descrA: MatDescr_t; csrSortedValA: ptr cuComplex;
              csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
              B: ptr cuComplex; ldb: cint; beta: ptr cuComplex; C: ptr cuComplex; ldc: cint): Status_t {.
      cdecl, cdecl, importc: "cusparseCcsrmm", dynlib: libName.}
  proc Zcsrmm*(handle: Handle_t; transA: Operation_t; m: cint; n: cint; k: cint; nnz: cint;
              alpha: ptr cuDoubleComplex; descrA: MatDescr_t;
              csrSortedValA: ptr cuDoubleComplex; csrSortedRowPtrA: ptr cint;
              csrSortedColIndA: ptr cint; B: ptr cuDoubleComplex; ldb: cint;
              beta: ptr cuDoubleComplex; C: ptr cuDoubleComplex; ldc: cint): Status_t {.
      cdecl, cdecl, importc: "cusparseZcsrmm", dynlib: libName.}
  ##  Description: sparse - dense matrix multiplication C = alpha * op(A) * B  + beta * C, 
  ##    where A is a sparse matrix in CSR format, B and C are dense tall matrices.
  ##    This routine allows transposition of matrix B, which may improve performance.
  proc Scsrmm2*(handle: Handle_t; transA: Operation_t; transB: Operation_t; m: cint;
               n: cint; k: cint; nnz: cint; alpha: ptr cfloat; descrA: MatDescr_t;
               csrSortedValA: ptr cfloat; csrSortedRowPtrA: ptr cint;
               csrSortedColIndA: ptr cint; B: ptr cfloat; ldb: cint; beta: ptr cfloat;
               C: ptr cfloat; ldc: cint): Status_t {.cdecl, cdecl,
      importc: "cusparseScsrmm2", dynlib: libName.}
  proc Dcsrmm2*(handle: Handle_t; transA: Operation_t; transB: Operation_t; m: cint;
               n: cint; k: cint; nnz: cint; alpha: ptr cdouble; descrA: MatDescr_t;
               csrSortedValA: ptr cdouble; csrSortedRowPtrA: ptr cint;
               csrSortedColIndA: ptr cint; B: ptr cdouble; ldb: cint; beta: ptr cdouble;
               C: ptr cdouble; ldc: cint): Status_t {.cdecl, cdecl,
      importc: "cusparseDcsrmm2", dynlib: libName.}
  proc Ccsrmm2*(handle: Handle_t; transA: Operation_t; transB: Operation_t; m: cint;
               n: cint; k: cint; nnz: cint; alpha: ptr cuComplex; descrA: MatDescr_t;
               csrSortedValA: ptr cuComplex; csrSortedRowPtrA: ptr cint;
               csrSortedColIndA: ptr cint; B: ptr cuComplex; ldb: cint;
               beta: ptr cuComplex; C: ptr cuComplex; ldc: cint): Status_t {.cdecl, cdecl,
      importc: "cusparseCcsrmm2", dynlib: libName.}
  proc Zcsrmm2*(handle: Handle_t; transA: Operation_t; transB: Operation_t; m: cint;
               n: cint; k: cint; nnz: cint; alpha: ptr cuDoubleComplex;
               descrA: MatDescr_t; csrSortedValA: ptr cuDoubleComplex;
               csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
               B: ptr cuDoubleComplex; ldb: cint; beta: ptr cuDoubleComplex;
               C: ptr cuDoubleComplex; ldc: cint): Status_t {.cdecl, cdecl,
      importc: "cusparseZcsrmm2", dynlib: libName.}
  ##  Description: sparse - dense matrix multiplication C = alpha * op(A) * B  + beta * C, 
  ##    where A is a sparse matrix in block-CSR format, B and C are dense tall matrices.
  ##    This routine allows transposition of matrix B, which may improve performance.
  proc Sbsrmm*(handle: Handle_t; dirA: Direction_t; transA: Operation_t;
              transB: Operation_t; mb: cint; n: cint; kb: cint; nnzb: cint;
              alpha: ptr cfloat; descrA: MatDescr_t; bsrSortedValA: ptr cfloat;
              bsrSortedRowPtrA: ptr cint; bsrSortedColIndA: ptr cint; blockSize: cint;
              B: ptr cfloat; ldb: cint; beta: ptr cfloat; C: ptr cfloat; ldc: cint): Status_t {.
      cdecl, cdecl, importc: "cusparseSbsrmm", dynlib: libName.}
  proc Dbsrmm*(handle: Handle_t; dirA: Direction_t; transA: Operation_t;
              transB: Operation_t; mb: cint; n: cint; kb: cint; nnzb: cint;
              alpha: ptr cdouble; descrA: MatDescr_t; bsrSortedValA: ptr cdouble;
              bsrSortedRowPtrA: ptr cint; bsrSortedColIndA: ptr cint; blockSize: cint;
              B: ptr cdouble; ldb: cint; beta: ptr cdouble; C: ptr cdouble; ldc: cint): Status_t {.
      cdecl, cdecl, importc: "cusparseDbsrmm", dynlib: libName.}
  proc Cbsrmm*(handle: Handle_t; dirA: Direction_t; transA: Operation_t;
              transB: Operation_t; mb: cint; n: cint; kb: cint; nnzb: cint;
              alpha: ptr cuComplex; descrA: MatDescr_t; bsrSortedValA: ptr cuComplex;
              bsrSortedRowPtrA: ptr cint; bsrSortedColIndA: ptr cint; blockSize: cint;
              B: ptr cuComplex; ldb: cint; beta: ptr cuComplex; C: ptr cuComplex; ldc: cint): Status_t {.
      cdecl, cdecl, importc: "cusparseCbsrmm", dynlib: libName.}
  proc Zbsrmm*(handle: Handle_t; dirA: Direction_t; transA: Operation_t;
              transB: Operation_t; mb: cint; n: cint; kb: cint; nnzb: cint;
              alpha: ptr cuDoubleComplex; descrA: MatDescr_t;
              bsrSortedValA: ptr cuDoubleComplex; bsrSortedRowPtrA: ptr cint;
              bsrSortedColIndA: ptr cint; blockSize: cint; B: ptr cuDoubleComplex;
              ldb: cint; beta: ptr cuDoubleComplex; C: ptr cuDoubleComplex; ldc: cint): Status_t {.
      cdecl, cdecl, importc: "cusparseZbsrmm", dynlib: libName.}
  ##  Description: dense - sparse matrix multiplication C = alpha * A * B  + beta * C, 
  ##    where A is column-major dense matrix, B is a sparse matrix in CSC format, 
  ##    and C is column-major dense matrix.
  proc Sgemmi*(handle: Handle_t; m: cint; n: cint; k: cint; nnz: cint; alpha: ptr cfloat;
              A: ptr cfloat; lda: cint; cscValB: ptr cfloat; cscColPtrB: ptr cint;
              cscRowIndB: ptr cint; beta: ptr cfloat; C: ptr cfloat; ldc: cint): Status_t {.
      cdecl, cdecl, importc: "cusparseSgemmi", dynlib: libName.}
    ##  host or device pointer
    ##  host or device pointer
  proc Dgemmi*(handle: Handle_t; m: cint; n: cint; k: cint; nnz: cint; alpha: ptr cdouble;
              A: ptr cdouble; lda: cint; cscValB: ptr cdouble; cscColPtrB: ptr cint;
              cscRowIndB: ptr cint; beta: ptr cdouble; C: ptr cdouble; ldc: cint): Status_t {.
      cdecl, cdecl, importc: "cusparseDgemmi", dynlib: libName.}
    ##  host or device pointer
    ##  host or device pointer
  proc Cgemmi*(handle: Handle_t; m: cint; n: cint; k: cint; nnz: cint;
              alpha: ptr cuComplex; A: ptr cuComplex; lda: cint; cscValB: ptr cuComplex;
              cscColPtrB: ptr cint; cscRowIndB: ptr cint; beta: ptr cuComplex;
              C: ptr cuComplex; ldc: cint): Status_t {.cdecl, cdecl,
      importc: "cusparseCgemmi", dynlib: libName.}
    ##  host or device pointer
    ##  host or device pointer
  proc Zgemmi*(handle: Handle_t; m: cint; n: cint; k: cint; nnz: cint;
              alpha: ptr cuDoubleComplex; A: ptr cuDoubleComplex; lda: cint;
              cscValB: ptr cuDoubleComplex; cscColPtrB: ptr cint;
              cscRowIndB: ptr cint; beta: ptr cuDoubleComplex; C: ptr cuDoubleComplex;
              ldc: cint): Status_t {.cdecl, cdecl, importc: "cusparseZgemmi",
                                  dynlib: libName.}
    ##  host or device pointer
    ##  host or device pointer
  ##  Description: Solution of triangular linear system op(A) * X = alpha * F, 
  ##    with multiple right-hand-sides, where A is a sparse matrix in CSR storage 
  ##    format, rhs F and solution X are dense tall matrices. 
  ##    This routine implements algorithm 1 for this problem.
  proc Scsrsm_analysis*(handle: Handle_t; transA: Operation_t; m: cint; nnz: cint;
                       descrA: MatDescr_t; csrSortedValA: ptr cfloat;
                       csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                       info: SolveAnalysisInfo_t): Status_t {.cdecl, cdecl,
      importc: "cusparseScsrsm_analysis", dynlib: libName.}
  proc Dcsrsm_analysis*(handle: Handle_t; transA: Operation_t; m: cint; nnz: cint;
                       descrA: MatDescr_t; csrSortedValA: ptr cdouble;
                       csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                       info: SolveAnalysisInfo_t): Status_t {.cdecl, cdecl,
      importc: "cusparseDcsrsm_analysis", dynlib: libName.}
  proc Ccsrsm_analysis*(handle: Handle_t; transA: Operation_t; m: cint; nnz: cint;
                       descrA: MatDescr_t; csrSortedValA: ptr cuComplex;
                       csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                       info: SolveAnalysisInfo_t): Status_t {.cdecl, cdecl,
      importc: "cusparseCcsrsm_analysis", dynlib: libName.}
  proc Zcsrsm_analysis*(handle: Handle_t; transA: Operation_t; m: cint; nnz: cint;
                       descrA: MatDescr_t; csrSortedValA: ptr cuDoubleComplex;
                       csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                       info: SolveAnalysisInfo_t): Status_t {.cdecl, cdecl,
      importc: "cusparseZcsrsm_analysis", dynlib: libName.}
  proc Scsrsm_solve*(handle: Handle_t; transA: Operation_t; m: cint; n: cint;
                    alpha: ptr cfloat; descrA: MatDescr_t; csrSortedValA: ptr cfloat;
                    csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                    info: SolveAnalysisInfo_t; F: ptr cfloat; ldf: cint; X: ptr cfloat;
                    ldx: cint): Status_t {.cdecl, cdecl,
                                        importc: "cusparseScsrsm_solve",
                                        dynlib: libName.}
  proc Dcsrsm_solve*(handle: Handle_t; transA: Operation_t; m: cint; n: cint;
                    alpha: ptr cdouble; descrA: MatDescr_t;
                    csrSortedValA: ptr cdouble; csrSortedRowPtrA: ptr cint;
                    csrSortedColIndA: ptr cint; info: SolveAnalysisInfo_t;
                    F: ptr cdouble; ldf: cint; X: ptr cdouble; ldx: cint): Status_t {.
      cdecl, cdecl, importc: "cusparseDcsrsm_solve", dynlib: libName.}
  proc Ccsrsm_solve*(handle: Handle_t; transA: Operation_t; m: cint; n: cint;
                    alpha: ptr cuComplex; descrA: MatDescr_t;
                    csrSortedValA: ptr cuComplex; csrSortedRowPtrA: ptr cint;
                    csrSortedColIndA: ptr cint; info: SolveAnalysisInfo_t;
                    F: ptr cuComplex; ldf: cint; X: ptr cuComplex; ldx: cint): Status_t {.
      cdecl, cdecl, importc: "cusparseCcsrsm_solve", dynlib: libName.}
  proc Zcsrsm_solve*(handle: Handle_t; transA: Operation_t; m: cint; n: cint;
                    alpha: ptr cuDoubleComplex; descrA: MatDescr_t;
                    csrSortedValA: ptr cuDoubleComplex; csrSortedRowPtrA: ptr cint;
                    csrSortedColIndA: ptr cint; info: SolveAnalysisInfo_t;
                    F: ptr cuDoubleComplex; ldf: cint; X: ptr cuDoubleComplex; ldx: cint): Status_t {.
      cdecl, cdecl, importc: "cusparseZcsrsm_solve", dynlib: libName.}
  ##  Description: Solution of triangular linear system op(A) * X = alpha * F, 
  ##    with multiple right-hand-sides, where A is a sparse matrix in CSR storage 
  ##    format, rhs F and solution X are dense tall matrices.
  ##    This routine implements algorithm 2 for this problem.
  proc Xbsrsm2_zeroPivot*(handle: Handle_t; info: bsrsm2Info_t; position: ptr cint): Status_t {.
      cdecl, cdecl, importc: "cusparseXbsrsm2_zeroPivot", dynlib: libName.}
  proc Sbsrsm2_bufferSize*(handle: Handle_t; dirA: Direction_t; transA: Operation_t;
                          transXY: Operation_t; mb: cint; n: cint; nnzb: cint;
                          descrA: MatDescr_t; bsrSortedVal: ptr cfloat;
                          bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint;
                          blockSize: cint; info: bsrsm2Info_t;
                          pBufferSizeInBytes: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseSbsrsm2_bufferSize", dynlib: libName.}
  proc Dbsrsm2_bufferSize*(handle: Handle_t; dirA: Direction_t; transA: Operation_t;
                          transXY: Operation_t; mb: cint; n: cint; nnzb: cint;
                          descrA: MatDescr_t; bsrSortedVal: ptr cdouble;
                          bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint;
                          blockSize: cint; info: bsrsm2Info_t;
                          pBufferSizeInBytes: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseDbsrsm2_bufferSize", dynlib: libName.}
  proc Cbsrsm2_bufferSize*(handle: Handle_t; dirA: Direction_t; transA: Operation_t;
                          transXY: Operation_t; mb: cint; n: cint; nnzb: cint;
                          descrA: MatDescr_t; bsrSortedVal: ptr cuComplex;
                          bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint;
                          blockSize: cint; info: bsrsm2Info_t;
                          pBufferSizeInBytes: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseCbsrsm2_bufferSize", dynlib: libName.}
  proc Zbsrsm2_bufferSize*(handle: Handle_t; dirA: Direction_t; transA: Operation_t;
                          transXY: Operation_t; mb: cint; n: cint; nnzb: cint;
                          descrA: MatDescr_t; bsrSortedVal: ptr cuDoubleComplex;
                          bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint;
                          blockSize: cint; info: bsrsm2Info_t;
                          pBufferSizeInBytes: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseZbsrsm2_bufferSize", dynlib: libName.}
  proc Sbsrsm2_bufferSizeExt*(handle: Handle_t; dirA: Direction_t;
                             transA: Operation_t; transB: Operation_t; mb: cint;
                             n: cint; nnzb: cint; descrA: MatDescr_t;
                             bsrSortedVal: ptr cfloat; bsrSortedRowPtr: ptr cint;
                             bsrSortedColInd: ptr cint; blockSize: cint;
                             info: bsrsm2Info_t; pBufferSize: ptr csize): Status_t {.
      cdecl, cdecl, importc: "cusparseSbsrsm2_bufferSizeExt", dynlib: libName.}
  proc Dbsrsm2_bufferSizeExt*(handle: Handle_t; dirA: Direction_t;
                             transA: Operation_t; transB: Operation_t; mb: cint;
                             n: cint; nnzb: cint; descrA: MatDescr_t;
                             bsrSortedVal: ptr cdouble; bsrSortedRowPtr: ptr cint;
                             bsrSortedColInd: ptr cint; blockSize: cint;
                             info: bsrsm2Info_t; pBufferSize: ptr csize): Status_t {.
      cdecl, cdecl, importc: "cusparseDbsrsm2_bufferSizeExt", dynlib: libName.}
  proc Cbsrsm2_bufferSizeExt*(handle: Handle_t; dirA: Direction_t;
                             transA: Operation_t; transB: Operation_t; mb: cint;
                             n: cint; nnzb: cint; descrA: MatDescr_t;
                             bsrSortedVal: ptr cuComplex;
                             bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint;
                             blockSize: cint; info: bsrsm2Info_t;
                             pBufferSize: ptr csize): Status_t {.cdecl, cdecl,
      importc: "cusparseCbsrsm2_bufferSizeExt", dynlib: libName.}
  proc Zbsrsm2_bufferSizeExt*(handle: Handle_t; dirA: Direction_t;
                             transA: Operation_t; transB: Operation_t; mb: cint;
                             n: cint; nnzb: cint; descrA: MatDescr_t;
                             bsrSortedVal: ptr cuDoubleComplex;
                             bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint;
                             blockSize: cint; info: bsrsm2Info_t;
                             pBufferSize: ptr csize): Status_t {.cdecl, cdecl,
      importc: "cusparseZbsrsm2_bufferSizeExt", dynlib: libName.}
  proc Sbsrsm2_analysis*(handle: Handle_t; dirA: Direction_t; transA: Operation_t;
                        transXY: Operation_t; mb: cint; n: cint; nnzb: cint;
                        descrA: MatDescr_t; bsrSortedVal: ptr cfloat;
                        bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint;
                        blockSize: cint; info: bsrsm2Info_t; policy: SolvePolicy_t;
                        pBuffer: pointer): Status_t {.cdecl, cdecl,
      importc: "cusparseSbsrsm2_analysis", dynlib: libName.}
  proc Dbsrsm2_analysis*(handle: Handle_t; dirA: Direction_t; transA: Operation_t;
                        transXY: Operation_t; mb: cint; n: cint; nnzb: cint;
                        descrA: MatDescr_t; bsrSortedVal: ptr cdouble;
                        bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint;
                        blockSize: cint; info: bsrsm2Info_t; policy: SolvePolicy_t;
                        pBuffer: pointer): Status_t {.cdecl, cdecl,
      importc: "cusparseDbsrsm2_analysis", dynlib: libName.}
  proc Cbsrsm2_analysis*(handle: Handle_t; dirA: Direction_t; transA: Operation_t;
                        transXY: Operation_t; mb: cint; n: cint; nnzb: cint;
                        descrA: MatDescr_t; bsrSortedVal: ptr cuComplex;
                        bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint;
                        blockSize: cint; info: bsrsm2Info_t; policy: SolvePolicy_t;
                        pBuffer: pointer): Status_t {.cdecl, cdecl,
      importc: "cusparseCbsrsm2_analysis", dynlib: libName.}
  proc Zbsrsm2_analysis*(handle: Handle_t; dirA: Direction_t; transA: Operation_t;
                        transXY: Operation_t; mb: cint; n: cint; nnzb: cint;
                        descrA: MatDescr_t; bsrSortedVal: ptr cuDoubleComplex;
                        bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint;
                        blockSize: cint; info: bsrsm2Info_t; policy: SolvePolicy_t;
                        pBuffer: pointer): Status_t {.cdecl, cdecl,
      importc: "cusparseZbsrsm2_analysis", dynlib: libName.}
  proc Sbsrsm2_solve*(handle: Handle_t; dirA: Direction_t; transA: Operation_t;
                     transXY: Operation_t; mb: cint; n: cint; nnzb: cint;
                     alpha: ptr cfloat; descrA: MatDescr_t; bsrSortedVal: ptr cfloat;
                     bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint;
                     blockSize: cint; info: bsrsm2Info_t; F: ptr cfloat; ldf: cint;
                     X: ptr cfloat; ldx: cint; policy: SolvePolicy_t; pBuffer: pointer): Status_t {.
      cdecl, cdecl, importc: "cusparseSbsrsm2_solve", dynlib: libName.}
  proc Dbsrsm2_solve*(handle: Handle_t; dirA: Direction_t; transA: Operation_t;
                     transXY: Operation_t; mb: cint; n: cint; nnzb: cint;
                     alpha: ptr cdouble; descrA: MatDescr_t;
                     bsrSortedVal: ptr cdouble; bsrSortedRowPtr: ptr cint;
                     bsrSortedColInd: ptr cint; blockSize: cint; info: bsrsm2Info_t;
                     F: ptr cdouble; ldf: cint; X: ptr cdouble; ldx: cint;
                     policy: SolvePolicy_t; pBuffer: pointer): Status_t {.cdecl,
      cdecl, importc: "cusparseDbsrsm2_solve", dynlib: libName.}
  proc Cbsrsm2_solve*(handle: Handle_t; dirA: Direction_t; transA: Operation_t;
                     transXY: Operation_t; mb: cint; n: cint; nnzb: cint;
                     alpha: ptr cuComplex; descrA: MatDescr_t;
                     bsrSortedVal: ptr cuComplex; bsrSortedRowPtr: ptr cint;
                     bsrSortedColInd: ptr cint; blockSize: cint; info: bsrsm2Info_t;
                     F: ptr cuComplex; ldf: cint; X: ptr cuComplex; ldx: cint;
                     policy: SolvePolicy_t; pBuffer: pointer): Status_t {.cdecl,
      cdecl, importc: "cusparseCbsrsm2_solve", dynlib: libName.}
  proc Zbsrsm2_solve*(handle: Handle_t; dirA: Direction_t; transA: Operation_t;
                     transXY: Operation_t; mb: cint; n: cint; nnzb: cint;
                     alpha: ptr cuDoubleComplex; descrA: MatDescr_t;
                     bsrSortedVal: ptr cuDoubleComplex; bsrSortedRowPtr: ptr cint;
                     bsrSortedColInd: ptr cint; blockSize: cint; info: bsrsm2Info_t;
                     F: ptr cuDoubleComplex; ldf: cint; X: ptr cuDoubleComplex;
                     ldx: cint; policy: SolvePolicy_t; pBuffer: pointer): Status_t {.
      cdecl, cdecl, importc: "cusparseZbsrsm2_solve", dynlib: libName.}
  ##  --- Preconditioners ---
  ##  Description: Compute the incomplete-LU factorization with 0 fill-in (ILU0)
  ##    of the matrix A stored in CSR format based on the information in the opaque 
  ##    structure info that was obtained from the analysis phase (csrsv_analysis). 
  ##    This routine implements algorithm 1 for this problem.
  proc Csrilu0Ex*(handle: Handle_t; trans: Operation_t; m: cint; descrA: MatDescr_t;
                 csrSortedValA_ValM: pointer;
                 csrSortedValA_ValMtype: cudaDataType; csrSortedRowPtrA: ptr cint;
                 csrSortedColIndA: ptr cint; info: SolveAnalysisInfo_t;
                 executiontype: cudaDataType): Status_t {.cdecl, cdecl,
      importc: "cusparseCsrilu0Ex", dynlib: libName.}
    ##  matrix A values are updated inplace 
    ##                                                  to be the preconditioner M values
  proc Scsrilu0*(handle: Handle_t; trans: Operation_t; m: cint; descrA: MatDescr_t;
                csrSortedValA_ValM: ptr cfloat; csrSortedRowPtrA: ptr cint;
                csrSortedColIndA: ptr cint; info: SolveAnalysisInfo_t): Status_t {.
      cdecl, cdecl, importc: "cusparseScsrilu0", dynlib: libName.}
    ##  matrix A values are updated inplace 
    ##                                                  to be the preconditioner M values
  proc Dcsrilu0*(handle: Handle_t; trans: Operation_t; m: cint; descrA: MatDescr_t;
                csrSortedValA_ValM: ptr cdouble; csrSortedRowPtrA: ptr cint;
                csrSortedColIndA: ptr cint; info: SolveAnalysisInfo_t): Status_t {.
      cdecl, cdecl, importc: "cusparseDcsrilu0", dynlib: libName.}
    ##  matrix A values are updated inplace 
    ##                                                  to be the preconditioner M values
  proc Ccsrilu0*(handle: Handle_t; trans: Operation_t; m: cint; descrA: MatDescr_t;
                csrSortedValA_ValM: ptr cuComplex; csrSortedRowPtrA: ptr cint;
                csrSortedColIndA: ptr cint; info: SolveAnalysisInfo_t): Status_t {.
      cdecl, cdecl, importc: "cusparseCcsrilu0", dynlib: libName.}
    ##  matrix A values are updated inplace 
    ##                                                  to be the preconditioner M values
  proc Zcsrilu0*(handle: Handle_t; trans: Operation_t; m: cint; descrA: MatDescr_t;
                csrSortedValA_ValM: ptr cuDoubleComplex;
                csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                info: SolveAnalysisInfo_t): Status_t {.cdecl, cdecl,
      importc: "cusparseZcsrilu0", dynlib: libName.}
    ##  matrix A values are updated inplace 
    ##                                                  to be the preconditioner M values
  ##  Description: Compute the incomplete-LU factorization with 0 fill-in (ILU0)
  ##    of the matrix A stored in CSR format based on the information in the opaque 
  ##    structure info that was obtained from the analysis phase (csrsv2_analysis).
  ##    This routine implements algorithm 2 for this problem.
  proc Scsrilu02_numericBoost*(handle: Handle_t; info: csrilu02Info_t;
                              enable_boost: cint; tol: ptr cdouble;
                              boost_val: ptr cfloat): Status_t {.cdecl, cdecl,
      importc: "cusparseScsrilu02_numericBoost", dynlib: libName.}
  proc Dcsrilu02_numericBoost*(handle: Handle_t; info: csrilu02Info_t;
                              enable_boost: cint; tol: ptr cdouble;
                              boost_val: ptr cdouble): Status_t {.cdecl, cdecl,
      importc: "cusparseDcsrilu02_numericBoost", dynlib: libName.}
  proc Ccsrilu02_numericBoost*(handle: Handle_t; info: csrilu02Info_t;
                              enable_boost: cint; tol: ptr cdouble;
                              boost_val: ptr cuComplex): Status_t {.cdecl, cdecl,
      importc: "cusparseCcsrilu02_numericBoost", dynlib: libName.}
  proc Zcsrilu02_numericBoost*(handle: Handle_t; info: csrilu02Info_t;
                              enable_boost: cint; tol: ptr cdouble;
                              boost_val: ptr cuDoubleComplex): Status_t {.cdecl,
      cdecl, importc: "cusparseZcsrilu02_numericBoost", dynlib: libName.}
  proc Xcsrilu02_zeroPivot*(handle: Handle_t; info: csrilu02Info_t;
                           position: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseXcsrilu02_zeroPivot", dynlib: libName.}
  proc Scsrilu02_bufferSize*(handle: Handle_t; m: cint; nnz: cint; descrA: MatDescr_t;
                            csrSortedValA: ptr cfloat; csrSortedRowPtrA: ptr cint;
                            csrSortedColIndA: ptr cint; info: csrilu02Info_t;
                            pBufferSizeInBytes: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseScsrilu02_bufferSize", dynlib: libName.}
  proc Dcsrilu02_bufferSize*(handle: Handle_t; m: cint; nnz: cint; descrA: MatDescr_t;
                            csrSortedValA: ptr cdouble; csrSortedRowPtrA: ptr cint;
                            csrSortedColIndA: ptr cint; info: csrilu02Info_t;
                            pBufferSizeInBytes: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseDcsrilu02_bufferSize", dynlib: libName.}
  proc Ccsrilu02_bufferSize*(handle: Handle_t; m: cint; nnz: cint; descrA: MatDescr_t;
                            csrSortedValA: ptr cuComplex;
                            csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                            info: csrilu02Info_t; pBufferSizeInBytes: ptr cint): Status_t {.
      cdecl, cdecl, importc: "cusparseCcsrilu02_bufferSize", dynlib: libName.}
  proc Zcsrilu02_bufferSize*(handle: Handle_t; m: cint; nnz: cint; descrA: MatDescr_t;
                            csrSortedValA: ptr cuDoubleComplex;
                            csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                            info: csrilu02Info_t; pBufferSizeInBytes: ptr cint): Status_t {.
      cdecl, cdecl, importc: "cusparseZcsrilu02_bufferSize", dynlib: libName.}
  proc Scsrilu02_bufferSizeExt*(handle: Handle_t; m: cint; nnz: cint;
                               descrA: MatDescr_t; csrSortedVal: ptr cfloat;
                               csrSortedRowPtr: ptr cint;
                               csrSortedColInd: ptr cint; info: csrilu02Info_t;
                               pBufferSize: ptr csize): Status_t {.cdecl, cdecl,
      importc: "cusparseScsrilu02_bufferSizeExt", dynlib: libName.}
  proc Dcsrilu02_bufferSizeExt*(handle: Handle_t; m: cint; nnz: cint;
                               descrA: MatDescr_t; csrSortedVal: ptr cdouble;
                               csrSortedRowPtr: ptr cint;
                               csrSortedColInd: ptr cint; info: csrilu02Info_t;
                               pBufferSize: ptr csize): Status_t {.cdecl, cdecl,
      importc: "cusparseDcsrilu02_bufferSizeExt", dynlib: libName.}
  proc Ccsrilu02_bufferSizeExt*(handle: Handle_t; m: cint; nnz: cint;
                               descrA: MatDescr_t; csrSortedVal: ptr cuComplex;
                               csrSortedRowPtr: ptr cint;
                               csrSortedColInd: ptr cint; info: csrilu02Info_t;
                               pBufferSize: ptr csize): Status_t {.cdecl, cdecl,
      importc: "cusparseCcsrilu02_bufferSizeExt", dynlib: libName.}
  proc Zcsrilu02_bufferSizeExt*(handle: Handle_t; m: cint; nnz: cint;
                               descrA: MatDescr_t;
                               csrSortedVal: ptr cuDoubleComplex;
                               csrSortedRowPtr: ptr cint;
                               csrSortedColInd: ptr cint; info: csrilu02Info_t;
                               pBufferSize: ptr csize): Status_t {.cdecl, cdecl,
      importc: "cusparseZcsrilu02_bufferSizeExt", dynlib: libName.}
  proc Scsrilu02_analysis*(handle: Handle_t; m: cint; nnz: cint; descrA: MatDescr_t;
                          csrSortedValA: ptr cfloat; csrSortedRowPtrA: ptr cint;
                          csrSortedColIndA: ptr cint; info: csrilu02Info_t;
                          policy: SolvePolicy_t; pBuffer: pointer): Status_t {.cdecl,
      cdecl, importc: "cusparseScsrilu02_analysis", dynlib: libName.}
  proc Dcsrilu02_analysis*(handle: Handle_t; m: cint; nnz: cint; descrA: MatDescr_t;
                          csrSortedValA: ptr cdouble; csrSortedRowPtrA: ptr cint;
                          csrSortedColIndA: ptr cint; info: csrilu02Info_t;
                          policy: SolvePolicy_t; pBuffer: pointer): Status_t {.cdecl,
      cdecl, importc: "cusparseDcsrilu02_analysis", dynlib: libName.}
  proc Ccsrilu02_analysis*(handle: Handle_t; m: cint; nnz: cint; descrA: MatDescr_t;
                          csrSortedValA: ptr cuComplex; csrSortedRowPtrA: ptr cint;
                          csrSortedColIndA: ptr cint; info: csrilu02Info_t;
                          policy: SolvePolicy_t; pBuffer: pointer): Status_t {.cdecl,
      cdecl, importc: "cusparseCcsrilu02_analysis", dynlib: libName.}
  proc Zcsrilu02_analysis*(handle: Handle_t; m: cint; nnz: cint; descrA: MatDescr_t;
                          csrSortedValA: ptr cuDoubleComplex;
                          csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                          info: csrilu02Info_t; policy: SolvePolicy_t;
                          pBuffer: pointer): Status_t {.cdecl, cdecl,
      importc: "cusparseZcsrilu02_analysis", dynlib: libName.}
  proc Scsrilu02*(handle: Handle_t; m: cint; nnz: cint; descrA: MatDescr_t;
                 csrSortedValA_valM: ptr cfloat; csrSortedRowPtrA: ptr cint;
                 csrSortedColIndA: ptr cint; info: csrilu02Info_t;
                 policy: SolvePolicy_t; pBuffer: pointer): Status_t {.cdecl, cdecl,
      importc: "cusparseScsrilu02", dynlib: libName.}
    ##  matrix A values are updated inplace 
    ##                                                   to be the preconditioner M values
  proc Dcsrilu02*(handle: Handle_t; m: cint; nnz: cint; descrA: MatDescr_t;
                 csrSortedValA_valM: ptr cdouble; csrSortedRowPtrA: ptr cint;
                 csrSortedColIndA: ptr cint; info: csrilu02Info_t;
                 policy: SolvePolicy_t; pBuffer: pointer): Status_t {.cdecl, cdecl,
      importc: "cusparseDcsrilu02", dynlib: libName.}
    ##  matrix A values are updated inplace 
    ##                                                   to be the preconditioner M values
  proc Ccsrilu02*(handle: Handle_t; m: cint; nnz: cint; descrA: MatDescr_t;
                 csrSortedValA_valM: ptr cuComplex; csrSortedRowPtrA: ptr cint;
                 csrSortedColIndA: ptr cint; info: csrilu02Info_t;
                 policy: SolvePolicy_t; pBuffer: pointer): Status_t {.cdecl, cdecl,
      importc: "cusparseCcsrilu02", dynlib: libName.}
    ##  matrix A values are updated inplace 
    ##                                                   to be the preconditioner M values
  proc Zcsrilu02*(handle: Handle_t; m: cint; nnz: cint; descrA: MatDescr_t;
                 csrSortedValA_valM: ptr cuDoubleComplex;
                 csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                 info: csrilu02Info_t; policy: SolvePolicy_t; pBuffer: pointer): Status_t {.
      cdecl, cdecl, importc: "cusparseZcsrilu02", dynlib: libName.}
    ##  matrix A values are updated inplace 
    ##                                                   to be the preconditioner M values
  ##  Description: Compute the incomplete-LU factorization with 0 fill-in (ILU0)
  ##    of the matrix A stored in block-CSR format based on the information in the opaque 
  ##    structure info that was obtained from the analysis phase (bsrsv2_analysis).
  ##    This routine implements algorithm 2 for this problem.
  proc Sbsrilu02_numericBoost*(handle: Handle_t; info: bsrilu02Info_t;
                              enable_boost: cint; tol: ptr cdouble;
                              boost_val: ptr cfloat): Status_t {.cdecl, cdecl,
      importc: "cusparseSbsrilu02_numericBoost", dynlib: libName.}
  proc Dbsrilu02_numericBoost*(handle: Handle_t; info: bsrilu02Info_t;
                              enable_boost: cint; tol: ptr cdouble;
                              boost_val: ptr cdouble): Status_t {.cdecl, cdecl,
      importc: "cusparseDbsrilu02_numericBoost", dynlib: libName.}
  proc Cbsrilu02_numericBoost*(handle: Handle_t; info: bsrilu02Info_t;
                              enable_boost: cint; tol: ptr cdouble;
                              boost_val: ptr cuComplex): Status_t {.cdecl, cdecl,
      importc: "cusparseCbsrilu02_numericBoost", dynlib: libName.}
  proc Zbsrilu02_numericBoost*(handle: Handle_t; info: bsrilu02Info_t;
                              enable_boost: cint; tol: ptr cdouble;
                              boost_val: ptr cuDoubleComplex): Status_t {.cdecl,
      cdecl, importc: "cusparseZbsrilu02_numericBoost", dynlib: libName.}
  proc Xbsrilu02_zeroPivot*(handle: Handle_t; info: bsrilu02Info_t;
                           position: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseXbsrilu02_zeroPivot", dynlib: libName.}
  proc Sbsrilu02_bufferSize*(handle: Handle_t; dirA: Direction_t; mb: cint; nnzb: cint;
                            descrA: MatDescr_t; bsrSortedVal: ptr cfloat;
                            bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint;
                            blockDim: cint; info: bsrilu02Info_t;
                            pBufferSizeInBytes: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseSbsrilu02_bufferSize", dynlib: libName.}
  proc Dbsrilu02_bufferSize*(handle: Handle_t; dirA: Direction_t; mb: cint; nnzb: cint;
                            descrA: MatDescr_t; bsrSortedVal: ptr cdouble;
                            bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint;
                            blockDim: cint; info: bsrilu02Info_t;
                            pBufferSizeInBytes: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseDbsrilu02_bufferSize", dynlib: libName.}
  proc Cbsrilu02_bufferSize*(handle: Handle_t; dirA: Direction_t; mb: cint; nnzb: cint;
                            descrA: MatDescr_t; bsrSortedVal: ptr cuComplex;
                            bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint;
                            blockDim: cint; info: bsrilu02Info_t;
                            pBufferSizeInBytes: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseCbsrilu02_bufferSize", dynlib: libName.}
  proc Zbsrilu02_bufferSize*(handle: Handle_t; dirA: Direction_t; mb: cint; nnzb: cint;
                            descrA: MatDescr_t; bsrSortedVal: ptr cuDoubleComplex;
                            bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint;
                            blockDim: cint; info: bsrilu02Info_t;
                            pBufferSizeInBytes: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseZbsrilu02_bufferSize", dynlib: libName.}
  proc Sbsrilu02_bufferSizeExt*(handle: Handle_t; dirA: Direction_t; mb: cint;
                               nnzb: cint; descrA: MatDescr_t;
                               bsrSortedVal: ptr cfloat; bsrSortedRowPtr: ptr cint;
                               bsrSortedColInd: ptr cint; blockSize: cint;
                               info: bsrilu02Info_t; pBufferSize: ptr csize): Status_t {.
      cdecl, cdecl, importc: "cusparseSbsrilu02_bufferSizeExt", dynlib: libName.}
  proc Dbsrilu02_bufferSizeExt*(handle: Handle_t; dirA: Direction_t; mb: cint;
                               nnzb: cint; descrA: MatDescr_t;
                               bsrSortedVal: ptr cdouble;
                               bsrSortedRowPtr: ptr cint;
                               bsrSortedColInd: ptr cint; blockSize: cint;
                               info: bsrilu02Info_t; pBufferSize: ptr csize): Status_t {.
      cdecl, cdecl, importc: "cusparseDbsrilu02_bufferSizeExt", dynlib: libName.}
  proc Cbsrilu02_bufferSizeExt*(handle: Handle_t; dirA: Direction_t; mb: cint;
                               nnzb: cint; descrA: MatDescr_t;
                               bsrSortedVal: ptr cuComplex;
                               bsrSortedRowPtr: ptr cint;
                               bsrSortedColInd: ptr cint; blockSize: cint;
                               info: bsrilu02Info_t; pBufferSize: ptr csize): Status_t {.
      cdecl, cdecl, importc: "cusparseCbsrilu02_bufferSizeExt", dynlib: libName.}
  proc Zbsrilu02_bufferSizeExt*(handle: Handle_t; dirA: Direction_t; mb: cint;
                               nnzb: cint; descrA: MatDescr_t;
                               bsrSortedVal: ptr cuDoubleComplex;
                               bsrSortedRowPtr: ptr cint;
                               bsrSortedColInd: ptr cint; blockSize: cint;
                               info: bsrilu02Info_t; pBufferSize: ptr csize): Status_t {.
      cdecl, cdecl, importc: "cusparseZbsrilu02_bufferSizeExt", dynlib: libName.}
  proc Sbsrilu02_analysis*(handle: Handle_t; dirA: Direction_t; mb: cint; nnzb: cint;
                          descrA: MatDescr_t; bsrSortedVal: ptr cfloat;
                          bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint;
                          blockDim: cint; info: bsrilu02Info_t;
                          policy: SolvePolicy_t; pBuffer: pointer): Status_t {.cdecl,
      cdecl, importc: "cusparseSbsrilu02_analysis", dynlib: libName.}
  proc Dbsrilu02_analysis*(handle: Handle_t; dirA: Direction_t; mb: cint; nnzb: cint;
                          descrA: MatDescr_t; bsrSortedVal: ptr cdouble;
                          bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint;
                          blockDim: cint; info: bsrilu02Info_t;
                          policy: SolvePolicy_t; pBuffer: pointer): Status_t {.cdecl,
      cdecl, importc: "cusparseDbsrilu02_analysis", dynlib: libName.}
  proc Cbsrilu02_analysis*(handle: Handle_t; dirA: Direction_t; mb: cint; nnzb: cint;
                          descrA: MatDescr_t; bsrSortedVal: ptr cuComplex;
                          bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint;
                          blockDim: cint; info: bsrilu02Info_t;
                          policy: SolvePolicy_t; pBuffer: pointer): Status_t {.cdecl,
      cdecl, importc: "cusparseCbsrilu02_analysis", dynlib: libName.}
  proc Zbsrilu02_analysis*(handle: Handle_t; dirA: Direction_t; mb: cint; nnzb: cint;
                          descrA: MatDescr_t; bsrSortedVal: ptr cuDoubleComplex;
                          bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint;
                          blockDim: cint; info: bsrilu02Info_t;
                          policy: SolvePolicy_t; pBuffer: pointer): Status_t {.cdecl,
      cdecl, importc: "cusparseZbsrilu02_analysis", dynlib: libName.}
  proc Sbsrilu02*(handle: Handle_t; dirA: Direction_t; mb: cint; nnzb: cint;
                 descra: MatDescr_t; bsrSortedVal: ptr cfloat;
                 bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint; blockDim: cint;
                 info: bsrilu02Info_t; policy: SolvePolicy_t; pBuffer: pointer): Status_t {.
      cdecl, cdecl, importc: "cusparseSbsrilu02", dynlib: libName.}
  proc Dbsrilu02*(handle: Handle_t; dirA: Direction_t; mb: cint; nnzb: cint;
                 descra: MatDescr_t; bsrSortedVal: ptr cdouble;
                 bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint; blockDim: cint;
                 info: bsrilu02Info_t; policy: SolvePolicy_t; pBuffer: pointer): Status_t {.
      cdecl, cdecl, importc: "cusparseDbsrilu02", dynlib: libName.}
  proc Cbsrilu02*(handle: Handle_t; dirA: Direction_t; mb: cint; nnzb: cint;
                 descra: MatDescr_t; bsrSortedVal: ptr cuComplex;
                 bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint; blockDim: cint;
                 info: bsrilu02Info_t; policy: SolvePolicy_t; pBuffer: pointer): Status_t {.
      cdecl, cdecl, importc: "cusparseCbsrilu02", dynlib: libName.}
  proc Zbsrilu02*(handle: Handle_t; dirA: Direction_t; mb: cint; nnzb: cint;
                 descra: MatDescr_t; bsrSortedVal: ptr cuDoubleComplex;
                 bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint; blockDim: cint;
                 info: bsrilu02Info_t; policy: SolvePolicy_t; pBuffer: pointer): Status_t {.
      cdecl, cdecl, importc: "cusparseZbsrilu02", dynlib: libName.}
  ##  Description: Compute the incomplete-Cholesky factorization with 0 fill-in (IC0)
  ##    of the matrix A stored in CSR format based on the information in the opaque 
  ##    structure info that was obtained from the analysis phase (csrsv_analysis). 
  ##    This routine implements algorithm 1 for this problem.
  proc Scsric0*(handle: Handle_t; trans: Operation_t; m: cint; descrA: MatDescr_t;
               csrSortedValA_ValM: ptr cfloat; csrSortedRowPtrA: ptr cint;
               csrSortedColIndA: ptr cint; info: SolveAnalysisInfo_t): Status_t {.
      cdecl, cdecl, importc: "cusparseScsric0", dynlib: libName.}
    ##  matrix A values are updated inplace 
    ##                                                  to be the preconditioner M values
  proc Dcsric0*(handle: Handle_t; trans: Operation_t; m: cint; descrA: MatDescr_t;
               csrSortedValA_ValM: ptr cdouble; csrSortedRowPtrA: ptr cint;
               csrSortedColIndA: ptr cint; info: SolveAnalysisInfo_t): Status_t {.
      cdecl, cdecl, importc: "cusparseDcsric0", dynlib: libName.}
    ##  matrix A values are updated inplace 
    ##                                                  to be the preconditioner M values
  proc Ccsric0*(handle: Handle_t; trans: Operation_t; m: cint; descrA: MatDescr_t;
               csrSortedValA_ValM: ptr cuComplex; csrSortedRowPtrA: ptr cint;
               csrSortedColIndA: ptr cint; info: SolveAnalysisInfo_t): Status_t {.
      cdecl, cdecl, importc: "cusparseCcsric0", dynlib: libName.}
    ##  matrix A values are updated inplace 
    ##                                                  to be the preconditioner M values
  proc Zcsric0*(handle: Handle_t; trans: Operation_t; m: cint; descrA: MatDescr_t;
               csrSortedValA_ValM: ptr cuDoubleComplex; csrSortedRowPtrA: ptr cint;
               csrSortedColIndA: ptr cint; info: SolveAnalysisInfo_t): Status_t {.
      cdecl, cdecl, importc: "cusparseZcsric0", dynlib: libName.}
    ##  matrix A values are updated inplace 
    ##                                                  to be the preconditioner M values
  ##  Description: Compute the incomplete-Cholesky factorization with 0 fill-in (IC0)
  ##    of the matrix A stored in CSR format based on the information in the opaque 
  ##    structure info that was obtained from the analysis phase (csrsv2_analysis). 
  ##    This routine implements algorithm 2 for this problem.
  proc Xcsric02_zeroPivot*(handle: Handle_t; info: csric02Info_t; position: ptr cint): Status_t {.
      cdecl, cdecl, importc: "cusparseXcsric02_zeroPivot", dynlib: libName.}
  proc Scsric02_bufferSize*(handle: Handle_t; m: cint; nnz: cint; descrA: MatDescr_t;
                           csrSortedValA: ptr cfloat; csrSortedRowPtrA: ptr cint;
                           csrSortedColIndA: ptr cint; info: csric02Info_t;
                           pBufferSizeInBytes: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseScsric02_bufferSize", dynlib: libName.}
  proc Dcsric02_bufferSize*(handle: Handle_t; m: cint; nnz: cint; descrA: MatDescr_t;
                           csrSortedValA: ptr cdouble; csrSortedRowPtrA: ptr cint;
                           csrSortedColIndA: ptr cint; info: csric02Info_t;
                           pBufferSizeInBytes: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseDcsric02_bufferSize", dynlib: libName.}
  proc Ccsric02_bufferSize*(handle: Handle_t; m: cint; nnz: cint; descrA: MatDescr_t;
                           csrSortedValA: ptr cuComplex;
                           csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                           info: csric02Info_t; pBufferSizeInBytes: ptr cint): Status_t {.
      cdecl, cdecl, importc: "cusparseCcsric02_bufferSize", dynlib: libName.}
  proc Zcsric02_bufferSize*(handle: Handle_t; m: cint; nnz: cint; descrA: MatDescr_t;
                           csrSortedValA: ptr cuDoubleComplex;
                           csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                           info: csric02Info_t; pBufferSizeInBytes: ptr cint): Status_t {.
      cdecl, cdecl, importc: "cusparseZcsric02_bufferSize", dynlib: libName.}
  proc Scsric02_bufferSizeExt*(handle: Handle_t; m: cint; nnz: cint;
                              descrA: MatDescr_t; csrSortedVal: ptr cfloat;
                              csrSortedRowPtr: ptr cint; csrSortedColInd: ptr cint;
                              info: csric02Info_t; pBufferSize: ptr csize): Status_t {.
      cdecl, cdecl, importc: "cusparseScsric02_bufferSizeExt", dynlib: libName.}
  proc Dcsric02_bufferSizeExt*(handle: Handle_t; m: cint; nnz: cint;
                              descrA: MatDescr_t; csrSortedVal: ptr cdouble;
                              csrSortedRowPtr: ptr cint; csrSortedColInd: ptr cint;
                              info: csric02Info_t; pBufferSize: ptr csize): Status_t {.
      cdecl, cdecl, importc: "cusparseDcsric02_bufferSizeExt", dynlib: libName.}
  proc Ccsric02_bufferSizeExt*(handle: Handle_t; m: cint; nnz: cint;
                              descrA: MatDescr_t; csrSortedVal: ptr cuComplex;
                              csrSortedRowPtr: ptr cint; csrSortedColInd: ptr cint;
                              info: csric02Info_t; pBufferSize: ptr csize): Status_t {.
      cdecl, cdecl, importc: "cusparseCcsric02_bufferSizeExt", dynlib: libName.}
  proc Zcsric02_bufferSizeExt*(handle: Handle_t; m: cint; nnz: cint;
                              descrA: MatDescr_t;
                              csrSortedVal: ptr cuDoubleComplex;
                              csrSortedRowPtr: ptr cint; csrSortedColInd: ptr cint;
                              info: csric02Info_t; pBufferSize: ptr csize): Status_t {.
      cdecl, cdecl, importc: "cusparseZcsric02_bufferSizeExt", dynlib: libName.}
  proc Scsric02_analysis*(handle: Handle_t; m: cint; nnz: cint; descrA: MatDescr_t;
                         csrSortedValA: ptr cfloat; csrSortedRowPtrA: ptr cint;
                         csrSortedColIndA: ptr cint; info: csric02Info_t;
                         policy: SolvePolicy_t; pBuffer: pointer): Status_t {.cdecl,
      cdecl, importc: "cusparseScsric02_analysis", dynlib: libName.}
  proc Dcsric02_analysis*(handle: Handle_t; m: cint; nnz: cint; descrA: MatDescr_t;
                         csrSortedValA: ptr cdouble; csrSortedRowPtrA: ptr cint;
                         csrSortedColIndA: ptr cint; info: csric02Info_t;
                         policy: SolvePolicy_t; pBuffer: pointer): Status_t {.cdecl,
      cdecl, importc: "cusparseDcsric02_analysis", dynlib: libName.}
  proc Ccsric02_analysis*(handle: Handle_t; m: cint; nnz: cint; descrA: MatDescr_t;
                         csrSortedValA: ptr cuComplex; csrSortedRowPtrA: ptr cint;
                         csrSortedColIndA: ptr cint; info: csric02Info_t;
                         policy: SolvePolicy_t; pBuffer: pointer): Status_t {.cdecl,
      cdecl, importc: "cusparseCcsric02_analysis", dynlib: libName.}
  proc Zcsric02_analysis*(handle: Handle_t; m: cint; nnz: cint; descrA: MatDescr_t;
                         csrSortedValA: ptr cuDoubleComplex;
                         csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                         info: csric02Info_t; policy: SolvePolicy_t;
                         pBuffer: pointer): Status_t {.cdecl, cdecl,
      importc: "cusparseZcsric02_analysis", dynlib: libName.}
  proc Scsric02*(handle: Handle_t; m: cint; nnz: cint; descrA: MatDescr_t;
                csrSortedValA_valM: ptr cfloat; csrSortedRowPtrA: ptr cint;
                csrSortedColIndA: ptr cint; info: csric02Info_t;
                policy: SolvePolicy_t; pBuffer: pointer): Status_t {.cdecl, cdecl,
      importc: "cusparseScsric02", dynlib: libName.}
    ##  matrix A values are updated inplace 
    ##                                                  to be the preconditioner M values
  proc Dcsric02*(handle: Handle_t; m: cint; nnz: cint; descrA: MatDescr_t;
                csrSortedValA_valM: ptr cdouble; csrSortedRowPtrA: ptr cint;
                csrSortedColIndA: ptr cint; info: csric02Info_t;
                policy: SolvePolicy_t; pBuffer: pointer): Status_t {.cdecl, cdecl,
      importc: "cusparseDcsric02", dynlib: libName.}
    ##  matrix A values are updated inplace 
    ##                                                  to be the preconditioner M values
  proc Ccsric02*(handle: Handle_t; m: cint; nnz: cint; descrA: MatDescr_t;
                csrSortedValA_valM: ptr cuComplex; csrSortedRowPtrA: ptr cint;
                csrSortedColIndA: ptr cint; info: csric02Info_t;
                policy: SolvePolicy_t; pBuffer: pointer): Status_t {.cdecl, cdecl,
      importc: "cusparseCcsric02", dynlib: libName.}
    ##  matrix A values are updated inplace 
    ##                                                  to be the preconditioner M values
  proc Zcsric02*(handle: Handle_t; m: cint; nnz: cint; descrA: MatDescr_t;
                csrSortedValA_valM: ptr cuDoubleComplex;
                csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                info: csric02Info_t; policy: SolvePolicy_t; pBuffer: pointer): Status_t {.
      cdecl, cdecl, importc: "cusparseZcsric02", dynlib: libName.}
    ##  matrix A values are updated inplace 
    ##                                                  to be the preconditioner M values
  ##  Description: Compute the incomplete-Cholesky factorization with 0 fill-in (IC0)
  ##    of the matrix A stored in block-CSR format based on the information in the opaque 
  ##    structure info that was obtained from the analysis phase (bsrsv2_analysis). 
  ##    This routine implements algorithm 1 for this problem.
  proc Xbsric02_zeroPivot*(handle: Handle_t; info: bsric02Info_t; position: ptr cint): Status_t {.
      cdecl, cdecl, importc: "cusparseXbsric02_zeroPivot", dynlib: libName.}
  proc Sbsric02_bufferSize*(handle: Handle_t; dirA: Direction_t; mb: cint; nnzb: cint;
                           descrA: MatDescr_t; bsrSortedVal: ptr cfloat;
                           bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint;
                           blockDim: cint; info: bsric02Info_t;
                           pBufferSizeInBytes: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseSbsric02_bufferSize", dynlib: libName.}
  proc Dbsric02_bufferSize*(handle: Handle_t; dirA: Direction_t; mb: cint; nnzb: cint;
                           descrA: MatDescr_t; bsrSortedVal: ptr cdouble;
                           bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint;
                           blockDim: cint; info: bsric02Info_t;
                           pBufferSizeInBytes: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseDbsric02_bufferSize", dynlib: libName.}
  proc Cbsric02_bufferSize*(handle: Handle_t; dirA: Direction_t; mb: cint; nnzb: cint;
                           descrA: MatDescr_t; bsrSortedVal: ptr cuComplex;
                           bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint;
                           blockDim: cint; info: bsric02Info_t;
                           pBufferSizeInBytes: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseCbsric02_bufferSize", dynlib: libName.}
  proc Zbsric02_bufferSize*(handle: Handle_t; dirA: Direction_t; mb: cint; nnzb: cint;
                           descrA: MatDescr_t; bsrSortedVal: ptr cuDoubleComplex;
                           bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint;
                           blockDim: cint; info: bsric02Info_t;
                           pBufferSizeInBytes: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseZbsric02_bufferSize", dynlib: libName.}
  proc Sbsric02_bufferSizeExt*(handle: Handle_t; dirA: Direction_t; mb: cint;
                              nnzb: cint; descrA: MatDescr_t;
                              bsrSortedVal: ptr cfloat; bsrSortedRowPtr: ptr cint;
                              bsrSortedColInd: ptr cint; blockSize: cint;
                              info: bsric02Info_t; pBufferSize: ptr csize): Status_t {.
      cdecl, cdecl, importc: "cusparseSbsric02_bufferSizeExt", dynlib: libName.}
  proc Dbsric02_bufferSizeExt*(handle: Handle_t; dirA: Direction_t; mb: cint;
                              nnzb: cint; descrA: MatDescr_t;
                              bsrSortedVal: ptr cdouble; bsrSortedRowPtr: ptr cint;
                              bsrSortedColInd: ptr cint; blockSize: cint;
                              info: bsric02Info_t; pBufferSize: ptr csize): Status_t {.
      cdecl, cdecl, importc: "cusparseDbsric02_bufferSizeExt", dynlib: libName.}
  proc Cbsric02_bufferSizeExt*(handle: Handle_t; dirA: Direction_t; mb: cint;
                              nnzb: cint; descrA: MatDescr_t;
                              bsrSortedVal: ptr cuComplex;
                              bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint;
                              blockSize: cint; info: bsric02Info_t;
                              pBufferSize: ptr csize): Status_t {.cdecl, cdecl,
      importc: "cusparseCbsric02_bufferSizeExt", dynlib: libName.}
  proc Zbsric02_bufferSizeExt*(handle: Handle_t; dirA: Direction_t; mb: cint;
                              nnzb: cint; descrA: MatDescr_t;
                              bsrSortedVal: ptr cuDoubleComplex;
                              bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint;
                              blockSize: cint; info: bsric02Info_t;
                              pBufferSize: ptr csize): Status_t {.cdecl, cdecl,
      importc: "cusparseZbsric02_bufferSizeExt", dynlib: libName.}
  proc Sbsric02_analysis*(handle: Handle_t; dirA: Direction_t; mb: cint; nnzb: cint;
                         descrA: MatDescr_t; bsrSortedVal: ptr cfloat;
                         bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint;
                         blockDim: cint; info: bsric02Info_t; policy: SolvePolicy_t;
                         pInputBuffer: pointer): Status_t {.cdecl, cdecl,
      importc: "cusparseSbsric02_analysis", dynlib: libName.}
  proc Dbsric02_analysis*(handle: Handle_t; dirA: Direction_t; mb: cint; nnzb: cint;
                         descrA: MatDescr_t; bsrSortedVal: ptr cdouble;
                         bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint;
                         blockDim: cint; info: bsric02Info_t; policy: SolvePolicy_t;
                         pInputBuffer: pointer): Status_t {.cdecl, cdecl,
      importc: "cusparseDbsric02_analysis", dynlib: libName.}
  proc Cbsric02_analysis*(handle: Handle_t; dirA: Direction_t; mb: cint; nnzb: cint;
                         descrA: MatDescr_t; bsrSortedVal: ptr cuComplex;
                         bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint;
                         blockDim: cint; info: bsric02Info_t; policy: SolvePolicy_t;
                         pInputBuffer: pointer): Status_t {.cdecl, cdecl,
      importc: "cusparseCbsric02_analysis", dynlib: libName.}
  proc Zbsric02_analysis*(handle: Handle_t; dirA: Direction_t; mb: cint; nnzb: cint;
                         descrA: MatDescr_t; bsrSortedVal: ptr cuDoubleComplex;
                         bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint;
                         blockDim: cint; info: bsric02Info_t; policy: SolvePolicy_t;
                         pInputBuffer: pointer): Status_t {.cdecl, cdecl,
      importc: "cusparseZbsric02_analysis", dynlib: libName.}
  proc Sbsric02*(handle: Handle_t; dirA: Direction_t; mb: cint; nnzb: cint;
                descrA: MatDescr_t; bsrSortedVal: ptr cfloat;
                bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint; blockDim: cint;
                info: bsric02Info_t; policy: SolvePolicy_t; pBuffer: pointer): Status_t {.
      cdecl, cdecl, importc: "cusparseSbsric02", dynlib: libName.}
  proc Dbsric02*(handle: Handle_t; dirA: Direction_t; mb: cint; nnzb: cint;
                descrA: MatDescr_t; bsrSortedVal: ptr cdouble;
                bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint; blockDim: cint;
                info: bsric02Info_t; policy: SolvePolicy_t; pBuffer: pointer): Status_t {.
      cdecl, cdecl, importc: "cusparseDbsric02", dynlib: libName.}
  proc Cbsric02*(handle: Handle_t; dirA: Direction_t; mb: cint; nnzb: cint;
                descrA: MatDescr_t; bsrSortedVal: ptr cuComplex;
                bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint; blockDim: cint;
                info: bsric02Info_t; policy: SolvePolicy_t; pBuffer: pointer): Status_t {.
      cdecl, cdecl, importc: "cusparseCbsric02", dynlib: libName.}
  proc Zbsric02*(handle: Handle_t; dirA: Direction_t; mb: cint; nnzb: cint;
                descrA: MatDescr_t; bsrSortedVal: ptr cuDoubleComplex;
                bsrSortedRowPtr: ptr cint; bsrSortedColInd: ptr cint; blockDim: cint;
                info: bsric02Info_t; policy: SolvePolicy_t; pBuffer: pointer): Status_t {.
      cdecl, cdecl, importc: "cusparseZbsric02", dynlib: libName.}
  ##  Description: Solution of tridiagonal linear system A * X = F, 
  ##    with multiple right-hand-sides. The coefficient matrix A is 
  ##    composed of lower (dl), main (d) and upper (du) diagonals, and 
  ##    the right-hand-sides F are overwritten with the solution X. 
  ##    These routine use pivoting.
  proc Sgtsv*(handle: Handle_t; m: cint; n: cint; dl: ptr cfloat; d: ptr cfloat;
             du: ptr cfloat; B: ptr cfloat; ldb: cint): Status_t {.cdecl, cdecl,
      importc: "cusparseSgtsv", dynlib: libName.}
  proc Dgtsv*(handle: Handle_t; m: cint; n: cint; dl: ptr cdouble; d: ptr cdouble;
             du: ptr cdouble; B: ptr cdouble; ldb: cint): Status_t {.cdecl, cdecl,
      importc: "cusparseDgtsv", dynlib: libName.}
  proc Cgtsv*(handle: Handle_t; m: cint; n: cint; dl: ptr cuComplex; d: ptr cuComplex;
             du: ptr cuComplex; B: ptr cuComplex; ldb: cint): Status_t {.cdecl, cdecl,
      importc: "cusparseCgtsv", dynlib: libName.}
  proc Zgtsv*(handle: Handle_t; m: cint; n: cint; dl: ptr cuDoubleComplex;
             d: ptr cuDoubleComplex; du: ptr cuDoubleComplex; B: ptr cuDoubleComplex;
             ldb: cint): Status_t {.cdecl, cdecl, importc: "cusparseZgtsv",
                                 dynlib: libName.}
  ##  Description: Solution of tridiagonal linear system A * X = F, 
  ##    with multiple right-hand-sides. The coefficient matrix A is 
  ##    composed of lower (dl), main (d) and upper (du) diagonals, and 
  ##    the right-hand-sides F are overwritten with the solution X. 
  ##    These routine does not use pivoting.
  proc Sgtsv_nopivot*(handle: Handle_t; m: cint; n: cint; dl: ptr cfloat; d: ptr cfloat;
                     du: ptr cfloat; B: ptr cfloat; ldb: cint): Status_t {.cdecl, cdecl,
      importc: "cusparseSgtsv_nopivot", dynlib: libName.}
  proc Dgtsv_nopivot*(handle: Handle_t; m: cint; n: cint; dl: ptr cdouble; d: ptr cdouble;
                     du: ptr cdouble; B: ptr cdouble; ldb: cint): Status_t {.cdecl, cdecl,
      importc: "cusparseDgtsv_nopivot", dynlib: libName.}
  proc Cgtsv_nopivot*(handle: Handle_t; m: cint; n: cint; dl: ptr cuComplex;
                     d: ptr cuComplex; du: ptr cuComplex; B: ptr cuComplex; ldb: cint): Status_t {.
      cdecl, cdecl, importc: "cusparseCgtsv_nopivot", dynlib: libName.}
  proc Zgtsv_nopivot*(handle: Handle_t; m: cint; n: cint; dl: ptr cuDoubleComplex;
                     d: ptr cuDoubleComplex; du: ptr cuDoubleComplex;
                     B: ptr cuDoubleComplex; ldb: cint): Status_t {.cdecl, cdecl,
      importc: "cusparseZgtsv_nopivot", dynlib: libName.}
  ##  Description: Solution of a set of tridiagonal linear systems 
  ##    A_{i} * x_{i} = f_{i} for i=1,...,batchCount. The coefficient 
  ##    matrices A_{i} are composed of lower (dl), main (d) and upper (du) 
  ##    diagonals and stored separated by a batchStride. Also, the 
  ##    right-hand-sides/solutions f_{i}/x_{i} are separated by a batchStride.
  proc SgtsvStridedBatch*(handle: Handle_t; m: cint; dl: ptr cfloat; d: ptr cfloat;
                         du: ptr cfloat; x: ptr cfloat; batchCount: cint;
                         batchStride: cint): Status_t {.cdecl, cdecl,
      importc: "cusparseSgtsvStridedBatch", dynlib: libName.}
  proc DgtsvStridedBatch*(handle: Handle_t; m: cint; dl: ptr cdouble; d: ptr cdouble;
                         du: ptr cdouble; x: ptr cdouble; batchCount: cint;
                         batchStride: cint): Status_t {.cdecl, cdecl,
      importc: "cusparseDgtsvStridedBatch", dynlib: libName.}
  proc CgtsvStridedBatch*(handle: Handle_t; m: cint; dl: ptr cuComplex;
                         d: ptr cuComplex; du: ptr cuComplex; x: ptr cuComplex;
                         batchCount: cint; batchStride: cint): Status_t {.cdecl,
      cdecl, importc: "cusparseCgtsvStridedBatch", dynlib: libName.}
  proc ZgtsvStridedBatch*(handle: Handle_t; m: cint; dl: ptr cuDoubleComplex;
                         d: ptr cuDoubleComplex; du: ptr cuDoubleComplex;
                         x: ptr cuDoubleComplex; batchCount: cint; batchStride: cint): Status_t {.
      cdecl, cdecl, importc: "cusparseZgtsvStridedBatch", dynlib: libName.}
  ##  --- Sparse Level 4 routines ---
  ##  Description: Compute sparse - sparse matrix multiplication for matrices 
  ##    stored in CSR format.
  proc XcsrgemmNnz*(handle: Handle_t; transA: Operation_t; transB: Operation_t;
                   m: cint; n: cint; k: cint; descrA: MatDescr_t; nnzA: cint;
                   csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                   descrB: MatDescr_t; nnzB: cint; csrSortedRowPtrB: ptr cint;
                   csrSortedColIndB: ptr cint; descrC: MatDescr_t;
                   csrSortedRowPtrC: ptr cint; nnzTotalDevHostPtr: ptr cint): Status_t {.
      cdecl, cdecl, importc: "cusparseXcsrgemmNnz", dynlib: libName.}
  proc Scsrgemm*(handle: Handle_t; transA: Operation_t; transB: Operation_t; m: cint;
                n: cint; k: cint; descrA: MatDescr_t; nnzA: cint;
                csrSortedValA: ptr cfloat; csrSortedRowPtrA: ptr cint;
                csrSortedColIndA: ptr cint; descrB: MatDescr_t; nnzB: cint;
                csrSortedValB: ptr cfloat; csrSortedRowPtrB: ptr cint;
                csrSortedColIndB: ptr cint; descrC: MatDescr_t;
                csrSortedValC: ptr cfloat; csrSortedRowPtrC: ptr cint;
                csrSortedColIndC: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseScsrgemm", dynlib: libName.}
  proc Dcsrgemm*(handle: Handle_t; transA: Operation_t; transB: Operation_t; m: cint;
                n: cint; k: cint; descrA: MatDescr_t; nnzA: cint;
                csrSortedValA: ptr cdouble; csrSortedRowPtrA: ptr cint;
                csrSortedColIndA: ptr cint; descrB: MatDescr_t; nnzB: cint;
                csrSortedValB: ptr cdouble; csrSortedRowPtrB: ptr cint;
                csrSortedColIndB: ptr cint; descrC: MatDescr_t;
                csrSortedValC: ptr cdouble; csrSortedRowPtrC: ptr cint;
                csrSortedColIndC: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseDcsrgemm", dynlib: libName.}
  proc Ccsrgemm*(handle: Handle_t; transA: Operation_t; transB: Operation_t; m: cint;
                n: cint; k: cint; descrA: MatDescr_t; nnzA: cint;
                csrSortedValA: ptr cuComplex; csrSortedRowPtrA: ptr cint;
                csrSortedColIndA: ptr cint; descrB: MatDescr_t; nnzB: cint;
                csrSortedValB: ptr cuComplex; csrSortedRowPtrB: ptr cint;
                csrSortedColIndB: ptr cint; descrC: MatDescr_t;
                csrSortedValC: ptr cuComplex; csrSortedRowPtrC: ptr cint;
                csrSortedColIndC: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseCcsrgemm", dynlib: libName.}
  proc Zcsrgemm*(handle: Handle_t; transA: Operation_t; transB: Operation_t; m: cint;
                n: cint; k: cint; descrA: MatDescr_t; nnzA: cint;
                csrSortedValA: ptr cuDoubleComplex; csrSortedRowPtrA: ptr cint;
                csrSortedColIndA: ptr cint; descrB: MatDescr_t; nnzB: cint;
                csrSortedValB: ptr cuDoubleComplex; csrSortedRowPtrB: ptr cint;
                csrSortedColIndB: ptr cint; descrC: MatDescr_t;
                csrSortedValC: ptr cuDoubleComplex; csrSortedRowPtrC: ptr cint;
                csrSortedColIndC: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseZcsrgemm", dynlib: libName.}
  ##  Description: Compute sparse - sparse matrix multiplication for matrices 
  ##    stored in CSR format.
  proc CreateCsrgemm2Info*(info: ptr csrgemm2Info_t): Status_t {.cdecl, cdecl,
      importc: "cusparseCreateCsrgemm2Info", dynlib: libName.}
  proc DestroyCsrgemm2Info*(info: csrgemm2Info_t): Status_t {.cdecl, cdecl,
      importc: "cusparseDestroyCsrgemm2Info", dynlib: libName.}
  proc Scsrgemm2_bufferSizeExt*(handle: Handle_t; m: cint; n: cint; k: cint;
                               alpha: ptr cfloat; descrA: MatDescr_t; nnzA: cint;
                               csrSortedRowPtrA: ptr cint;
                               csrSortedColIndA: ptr cint; descrB: MatDescr_t;
                               nnzB: cint; csrSortedRowPtrB: ptr cint;
                               csrSortedColIndB: ptr cint; beta: ptr cfloat;
                               descrD: MatDescr_t; nnzD: cint;
                               csrSortedRowPtrD: ptr cint;
                               csrSortedColIndD: ptr cint; info: csrgemm2Info_t;
                               pBufferSizeInBytes: ptr csize): Status_t {.cdecl,
      cdecl, importc: "cusparseScsrgemm2_bufferSizeExt", dynlib: libName.}
  proc Dcsrgemm2_bufferSizeExt*(handle: Handle_t; m: cint; n: cint; k: cint;
                               alpha: ptr cdouble; descrA: MatDescr_t; nnzA: cint;
                               csrSortedRowPtrA: ptr cint;
                               csrSortedColIndA: ptr cint; descrB: MatDescr_t;
                               nnzB: cint; csrSortedRowPtrB: ptr cint;
                               csrSortedColIndB: ptr cint; beta: ptr cdouble;
                               descrD: MatDescr_t; nnzD: cint;
                               csrSortedRowPtrD: ptr cint;
                               csrSortedColIndD: ptr cint; info: csrgemm2Info_t;
                               pBufferSizeInBytes: ptr csize): Status_t {.cdecl,
      cdecl, importc: "cusparseDcsrgemm2_bufferSizeExt", dynlib: libName.}
  proc Ccsrgemm2_bufferSizeExt*(handle: Handle_t; m: cint; n: cint; k: cint;
                               alpha: ptr cuComplex; descrA: MatDescr_t; nnzA: cint;
                               csrSortedRowPtrA: ptr cint;
                               csrSortedColIndA: ptr cint; descrB: MatDescr_t;
                               nnzB: cint; csrSortedRowPtrB: ptr cint;
                               csrSortedColIndB: ptr cint; beta: ptr cuComplex;
                               descrD: MatDescr_t; nnzD: cint;
                               csrSortedRowPtrD: ptr cint;
                               csrSortedColIndD: ptr cint; info: csrgemm2Info_t;
                               pBufferSizeInBytes: ptr csize): Status_t {.cdecl,
      cdecl, importc: "cusparseCcsrgemm2_bufferSizeExt", dynlib: libName.}
  proc Zcsrgemm2_bufferSizeExt*(handle: Handle_t; m: cint; n: cint; k: cint;
                               alpha: ptr cuDoubleComplex; descrA: MatDescr_t;
                               nnzA: cint; csrSortedRowPtrA: ptr cint;
                               csrSortedColIndA: ptr cint; descrB: MatDescr_t;
                               nnzB: cint; csrSortedRowPtrB: ptr cint;
                               csrSortedColIndB: ptr cint;
                               beta: ptr cuDoubleComplex; descrD: MatDescr_t;
                               nnzD: cint; csrSortedRowPtrD: ptr cint;
                               csrSortedColIndD: ptr cint; info: csrgemm2Info_t;
                               pBufferSizeInBytes: ptr csize): Status_t {.cdecl,
      cdecl, importc: "cusparseZcsrgemm2_bufferSizeExt", dynlib: libName.}
  proc Xcsrgemm2Nnz*(handle: Handle_t; m: cint; n: cint; k: cint; descrA: MatDescr_t;
                    nnzA: cint; csrSortedRowPtrA: ptr cint;
                    csrSortedColIndA: ptr cint; descrB: MatDescr_t; nnzB: cint;
                    csrSortedRowPtrB: ptr cint; csrSortedColIndB: ptr cint;
                    descrD: MatDescr_t; nnzD: cint; csrSortedRowPtrD: ptr cint;
                    csrSortedColIndD: ptr cint; descrC: MatDescr_t;
                    csrSortedRowPtrC: ptr cint; nnzTotalDevHostPtr: ptr cint;
                    info: csrgemm2Info_t; pBuffer: pointer): Status_t {.cdecl, cdecl,
      importc: "cusparseXcsrgemm2Nnz", dynlib: libName.}
  proc Scsrgemm2*(handle: Handle_t; m: cint; n: cint; k: cint; alpha: ptr cfloat;
                 descrA: MatDescr_t; nnzA: cint; csrSortedValA: ptr cfloat;
                 csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                 descrB: MatDescr_t; nnzB: cint; csrSortedValB: ptr cfloat;
                 csrSortedRowPtrB: ptr cint; csrSortedColIndB: ptr cint;
                 beta: ptr cfloat; descrD: MatDescr_t; nnzD: cint;
                 csrSortedValD: ptr cfloat; csrSortedRowPtrD: ptr cint;
                 csrSortedColIndD: ptr cint; descrC: MatDescr_t;
                 csrSortedValC: ptr cfloat; csrSortedRowPtrC: ptr cint;
                 csrSortedColIndC: ptr cint; info: csrgemm2Info_t; pBuffer: pointer): Status_t {.
      cdecl, cdecl, importc: "cusparseScsrgemm2", dynlib: libName.}
  proc Dcsrgemm2*(handle: Handle_t; m: cint; n: cint; k: cint; alpha: ptr cdouble;
                 descrA: MatDescr_t; nnzA: cint; csrSortedValA: ptr cdouble;
                 csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                 descrB: MatDescr_t; nnzB: cint; csrSortedValB: ptr cdouble;
                 csrSortedRowPtrB: ptr cint; csrSortedColIndB: ptr cint;
                 beta: ptr cdouble; descrD: MatDescr_t; nnzD: cint;
                 csrSortedValD: ptr cdouble; csrSortedRowPtrD: ptr cint;
                 csrSortedColIndD: ptr cint; descrC: MatDescr_t;
                 csrSortedValC: ptr cdouble; csrSortedRowPtrC: ptr cint;
                 csrSortedColIndC: ptr cint; info: csrgemm2Info_t; pBuffer: pointer): Status_t {.
      cdecl, cdecl, importc: "cusparseDcsrgemm2", dynlib: libName.}
  proc Ccsrgemm2*(handle: Handle_t; m: cint; n: cint; k: cint; alpha: ptr cuComplex;
                 descrA: MatDescr_t; nnzA: cint; csrSortedValA: ptr cuComplex;
                 csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                 descrB: MatDescr_t; nnzB: cint; csrSortedValB: ptr cuComplex;
                 csrSortedRowPtrB: ptr cint; csrSortedColIndB: ptr cint;
                 beta: ptr cuComplex; descrD: MatDescr_t; nnzD: cint;
                 csrSortedValD: ptr cuComplex; csrSortedRowPtrD: ptr cint;
                 csrSortedColIndD: ptr cint; descrC: MatDescr_t;
                 csrSortedValC: ptr cuComplex; csrSortedRowPtrC: ptr cint;
                 csrSortedColIndC: ptr cint; info: csrgemm2Info_t; pBuffer: pointer): Status_t {.
      cdecl, cdecl, importc: "cusparseCcsrgemm2", dynlib: libName.}
  proc Zcsrgemm2*(handle: Handle_t; m: cint; n: cint; k: cint;
                 alpha: ptr cuDoubleComplex; descrA: MatDescr_t; nnzA: cint;
                 csrSortedValA: ptr cuDoubleComplex; csrSortedRowPtrA: ptr cint;
                 csrSortedColIndA: ptr cint; descrB: MatDescr_t; nnzB: cint;
                 csrSortedValB: ptr cuDoubleComplex; csrSortedRowPtrB: ptr cint;
                 csrSortedColIndB: ptr cint; beta: ptr cuDoubleComplex;
                 descrD: MatDescr_t; nnzD: cint; csrSortedValD: ptr cuDoubleComplex;
                 csrSortedRowPtrD: ptr cint; csrSortedColIndD: ptr cint;
                 descrC: MatDescr_t; csrSortedValC: ptr cuDoubleComplex;
                 csrSortedRowPtrC: ptr cint; csrSortedColIndC: ptr cint;
                 info: csrgemm2Info_t; pBuffer: pointer): Status_t {.cdecl, cdecl,
      importc: "cusparseZcsrgemm2", dynlib: libName.}
  ##  Description: Compute sparse - sparse matrix addition of matrices 
  ##    stored in CSR format
  proc XcsrgeamNnz*(handle: Handle_t; m: cint; n: cint; descrA: MatDescr_t; nnzA: cint;
                   csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                   descrB: MatDescr_t; nnzB: cint; csrSortedRowPtrB: ptr cint;
                   csrSortedColIndB: ptr cint; descrC: MatDescr_t;
                   csrSortedRowPtrC: ptr cint; nnzTotalDevHostPtr: ptr cint): Status_t {.
      cdecl, cdecl, importc: "cusparseXcsrgeamNnz", dynlib: libName.}
  proc Scsrgeam*(handle: Handle_t; m: cint; n: cint; alpha: ptr cfloat;
                descrA: MatDescr_t; nnzA: cint; csrSortedValA: ptr cfloat;
                csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                beta: ptr cfloat; descrB: MatDescr_t; nnzB: cint;
                csrSortedValB: ptr cfloat; csrSortedRowPtrB: ptr cint;
                csrSortedColIndB: ptr cint; descrC: MatDescr_t;
                csrSortedValC: ptr cfloat; csrSortedRowPtrC: ptr cint;
                csrSortedColIndC: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseScsrgeam", dynlib: libName.}
  proc Dcsrgeam*(handle: Handle_t; m: cint; n: cint; alpha: ptr cdouble;
                descrA: MatDescr_t; nnzA: cint; csrSortedValA: ptr cdouble;
                csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                beta: ptr cdouble; descrB: MatDescr_t; nnzB: cint;
                csrSortedValB: ptr cdouble; csrSortedRowPtrB: ptr cint;
                csrSortedColIndB: ptr cint; descrC: MatDescr_t;
                csrSortedValC: ptr cdouble; csrSortedRowPtrC: ptr cint;
                csrSortedColIndC: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseDcsrgeam", dynlib: libName.}
  proc Ccsrgeam*(handle: Handle_t; m: cint; n: cint; alpha: ptr cuComplex;
                descrA: MatDescr_t; nnzA: cint; csrSortedValA: ptr cuComplex;
                csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                beta: ptr cuComplex; descrB: MatDescr_t; nnzB: cint;
                csrSortedValB: ptr cuComplex; csrSortedRowPtrB: ptr cint;
                csrSortedColIndB: ptr cint; descrC: MatDescr_t;
                csrSortedValC: ptr cuComplex; csrSortedRowPtrC: ptr cint;
                csrSortedColIndC: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseCcsrgeam", dynlib: libName.}
  proc Zcsrgeam*(handle: Handle_t; m: cint; n: cint; alpha: ptr cuDoubleComplex;
                descrA: MatDescr_t; nnzA: cint; csrSortedValA: ptr cuDoubleComplex;
                csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                beta: ptr cuDoubleComplex; descrB: MatDescr_t; nnzB: cint;
                csrSortedValB: ptr cuDoubleComplex; csrSortedRowPtrB: ptr cint;
                csrSortedColIndB: ptr cint; descrC: MatDescr_t;
                csrSortedValC: ptr cuDoubleComplex; csrSortedRowPtrC: ptr cint;
                csrSortedColIndC: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseZcsrgeam", dynlib: libName.}
  ##  --- Sparse Matrix Reorderings ---
  ##  Description: Find an approximate coloring of a matrix stored in CSR format.
  proc Scsrcolor*(handle: Handle_t; m: cint; nnz: cint; descrA: MatDescr_t;
                 csrSortedValA: ptr cfloat; csrSortedRowPtrA: ptr cint;
                 csrSortedColIndA: ptr cint; fractionToColor: ptr cfloat;
                 ncolors: ptr cint; coloring: ptr cint; reordering: ptr cint;
                 info: ColorInfo_t): Status_t {.cdecl, cdecl,
      importc: "cusparseScsrcolor", dynlib: libName.}
  proc Dcsrcolor*(handle: Handle_t; m: cint; nnz: cint; descrA: MatDescr_t;
                 csrSortedValA: ptr cdouble; csrSortedRowPtrA: ptr cint;
                 csrSortedColIndA: ptr cint; fractionToColor: ptr cdouble;
                 ncolors: ptr cint; coloring: ptr cint; reordering: ptr cint;
                 info: ColorInfo_t): Status_t {.cdecl, cdecl,
      importc: "cusparseDcsrcolor", dynlib: libName.}
  proc Ccsrcolor*(handle: Handle_t; m: cint; nnz: cint; descrA: MatDescr_t;
                 csrSortedValA: ptr cuComplex; csrSortedRowPtrA: ptr cint;
                 csrSortedColIndA: ptr cint; fractionToColor: ptr cfloat;
                 ncolors: ptr cint; coloring: ptr cint; reordering: ptr cint;
                 info: ColorInfo_t): Status_t {.cdecl, cdecl,
      importc: "cusparseCcsrcolor", dynlib: libName.}
  proc Zcsrcolor*(handle: Handle_t; m: cint; nnz: cint; descrA: MatDescr_t;
                 csrSortedValA: ptr cuDoubleComplex; csrSortedRowPtrA: ptr cint;
                 csrSortedColIndA: ptr cint; fractionToColor: ptr cdouble;
                 ncolors: ptr cint; coloring: ptr cint; reordering: ptr cint;
                 info: ColorInfo_t): Status_t {.cdecl, cdecl,
      importc: "cusparseZcsrcolor", dynlib: libName.}
  ##  --- Sparse Format Conversion ---
  ##  Description: This routine finds the total number of non-zero elements and 
  ##    the number of non-zero elements per row or column in the dense matrix A.
  proc Snnz*(handle: Handle_t; dirA: Direction_t; m: cint; n: cint; descrA: MatDescr_t;
            A: ptr cfloat; lda: cint; nnzPerRowCol: ptr cint;
            nnzTotalDevHostPtr: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseSnnz", dynlib: libName.}
  proc Dnnz*(handle: Handle_t; dirA: Direction_t; m: cint; n: cint; descrA: MatDescr_t;
            A: ptr cdouble; lda: cint; nnzPerRowCol: ptr cint;
            nnzTotalDevHostPtr: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseDnnz", dynlib: libName.}
  proc Cnnz*(handle: Handle_t; dirA: Direction_t; m: cint; n: cint; descrA: MatDescr_t;
            A: ptr cuComplex; lda: cint; nnzPerRowCol: ptr cint;
            nnzTotalDevHostPtr: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseCnnz", dynlib: libName.}
  proc Znnz*(handle: Handle_t; dirA: Direction_t; m: cint; n: cint; descrA: MatDescr_t;
            A: ptr cuDoubleComplex; lda: cint; nnzPerRowCol: ptr cint;
            nnzTotalDevHostPtr: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseZnnz", dynlib: libName.}
  ##  --- Sparse Format Conversion ---
  ##  Description: This routine finds the total number of non-zero elements and 
  ##    the number of non-zero elements per row in a noncompressed csr matrix A.
  proc Snnz_compress*(handle: Handle_t; m: cint; descr: MatDescr_t; values: ptr cfloat;
                     rowPtr: ptr cint; nnzPerRow: ptr cint; nnzTotal: ptr cint;
                     tol: cfloat): Status_t {.cdecl, cdecl,
      importc: "cusparseSnnz_compress", dynlib: libName.}
  proc Dnnz_compress*(handle: Handle_t; m: cint; descr: MatDescr_t;
                     values: ptr cdouble; rowPtr: ptr cint; nnzPerRow: ptr cint;
                     nnzTotal: ptr cint; tol: cdouble): Status_t {.cdecl, cdecl,
      importc: "cusparseDnnz_compress", dynlib: libName.}
  proc Cnnz_compress*(handle: Handle_t; m: cint; descr: MatDescr_t;
                     values: ptr cuComplex; rowPtr: ptr cint; nnzPerRow: ptr cint;
                     nnzTotal: ptr cint; tol: cuComplex): Status_t {.cdecl, cdecl,
      importc: "cusparseCnnz_compress", dynlib: libName.}
  proc Znnz_compress*(handle: Handle_t; m: cint; descr: MatDescr_t;
                     values: ptr cuDoubleComplex; rowPtr: ptr cint;
                     nnzPerRow: ptr cint; nnzTotal: ptr cint; tol: cuDoubleComplex): Status_t {.
      cdecl, cdecl, importc: "cusparseZnnz_compress", dynlib: libName.}
  ##  Description: This routine takes as input a csr form where the values may have 0 elements
  ##    and compresses it to return a csr form with no zeros.
  proc Scsr2csr_compress*(handle: Handle_t; m: cint; n: cint; descra: MatDescr_t;
                         inVal: ptr cfloat; inColInd: ptr cint; inRowPtr: ptr cint;
                         inNnz: cint; nnzPerRow: ptr cint; outVal: ptr cfloat;
                         outColInd: ptr cint; outRowPtr: ptr cint; tol: cfloat): Status_t {.
      cdecl, cdecl, importc: "cusparseScsr2csr_compress", dynlib: libName.}
  proc Dcsr2csr_compress*(handle: Handle_t; m: cint; n: cint; descra: MatDescr_t;
                         inVal: ptr cdouble; inColInd: ptr cint; inRowPtr: ptr cint;
                         inNnz: cint; nnzPerRow: ptr cint; outVal: ptr cdouble;
                         outColInd: ptr cint; outRowPtr: ptr cint; tol: cdouble): Status_t {.
      cdecl, cdecl, importc: "cusparseDcsr2csr_compress", dynlib: libName.}
    ## number of rows
    ## csr values array-the elements which are below a certain tolerance will be remvoed
    ## corresponding input noncompressed row pointer
    ## output: returns number of nonzeros per row
  proc Ccsr2csr_compress*(handle: Handle_t; m: cint; n: cint; descra: MatDescr_t;
                         inVal: ptr cuComplex; inColInd: ptr cint; inRowPtr: ptr cint;
                         inNnz: cint; nnzPerRow: ptr cint; outVal: ptr cuComplex;
                         outColInd: ptr cint; outRowPtr: ptr cint; tol: cuComplex): Status_t {.
      cdecl, cdecl, importc: "cusparseCcsr2csr_compress", dynlib: libName.}
    ## number of rows
    ## csr values array-the elements which are below a certain tolerance will be remvoed
    ## corresponding input noncompressed row pointer
    ## output: returns number of nonzeros per row
  proc Zcsr2csr_compress*(handle: Handle_t; m: cint; n: cint; descra: MatDescr_t;
                         inVal: ptr cuDoubleComplex; inColInd: ptr cint;
                         inRowPtr: ptr cint; inNnz: cint; nnzPerRow: ptr cint;
                         outVal: ptr cuDoubleComplex; outColInd: ptr cint;
                         outRowPtr: ptr cint; tol: cuDoubleComplex): Status_t {.cdecl,
      cdecl, importc: "cusparseZcsr2csr_compress", dynlib: libName.}
    ## number of rows
    ## csr values array-the elements which are below a certain tolerance will be remvoed
    ## corresponding input noncompressed row pointer
    ## output: returns number of nonzeros per row
  ##  Description: This routine converts a dense matrix to a sparse matrix 
  ##    in the CSR storage format, using the information computed by the 
  ##    nnz routine.
  proc Sdense2csr*(handle: Handle_t; m: cint; n: cint; descrA: MatDescr_t; A: ptr cfloat;
                  lda: cint; nnzPerRow: ptr cint; csrSortedValA: ptr cfloat;
                  csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint): Status_t {.
      cdecl, cdecl, importc: "cusparseSdense2csr", dynlib: libName.}
  proc Ddense2csr*(handle: Handle_t; m: cint; n: cint; descrA: MatDescr_t;
                  A: ptr cdouble; lda: cint; nnzPerRow: ptr cint;
                  csrSortedValA: ptr cdouble; csrSortedRowPtrA: ptr cint;
                  csrSortedColIndA: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseDdense2csr", dynlib: libName.}
  proc Cdense2csr*(handle: Handle_t; m: cint; n: cint; descrA: MatDescr_t;
                  A: ptr cuComplex; lda: cint; nnzPerRow: ptr cint;
                  csrSortedValA: ptr cuComplex; csrSortedRowPtrA: ptr cint;
                  csrSortedColIndA: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseCdense2csr", dynlib: libName.}
  proc Zdense2csr*(handle: Handle_t; m: cint; n: cint; descrA: MatDescr_t;
                  A: ptr cuDoubleComplex; lda: cint; nnzPerRow: ptr cint;
                  csrSortedValA: ptr cuDoubleComplex; csrSortedRowPtrA: ptr cint;
                  csrSortedColIndA: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseZdense2csr", dynlib: libName.}
  ##  Description: This routine converts a sparse matrix in CSR storage format
  ##    to a dense matrix.
  proc Scsr2dense*(handle: Handle_t; m: cint; n: cint; descrA: MatDescr_t;
                  csrSortedValA: ptr cfloat; csrSortedRowPtrA: ptr cint;
                  csrSortedColIndA: ptr cint; A: ptr cfloat; lda: cint): Status_t {.
      cdecl, cdecl, importc: "cusparseScsr2dense", dynlib: libName.}
  proc Dcsr2dense*(handle: Handle_t; m: cint; n: cint; descrA: MatDescr_t;
                  csrSortedValA: ptr cdouble; csrSortedRowPtrA: ptr cint;
                  csrSortedColIndA: ptr cint; A: ptr cdouble; lda: cint): Status_t {.
      cdecl, cdecl, importc: "cusparseDcsr2dense", dynlib: libName.}
  proc Ccsr2dense*(handle: Handle_t; m: cint; n: cint; descrA: MatDescr_t;
                  csrSortedValA: ptr cuComplex; csrSortedRowPtrA: ptr cint;
                  csrSortedColIndA: ptr cint; A: ptr cuComplex; lda: cint): Status_t {.
      cdecl, cdecl, importc: "cusparseCcsr2dense", dynlib: libName.}
  proc Zcsr2dense*(handle: Handle_t; m: cint; n: cint; descrA: MatDescr_t;
                  csrSortedValA: ptr cuDoubleComplex; csrSortedRowPtrA: ptr cint;
                  csrSortedColIndA: ptr cint; A: ptr cuDoubleComplex; lda: cint): Status_t {.
      cdecl, cdecl, importc: "cusparseZcsr2dense", dynlib: libName.}
  ##  Description: This routine converts a dense matrix to a sparse matrix 
  ##    in the CSC storage format, using the information computed by the 
  ##    nnz routine.
  proc Sdense2csc*(handle: Handle_t; m: cint; n: cint; descrA: MatDescr_t; A: ptr cfloat;
                  lda: cint; nnzPerCol: ptr cint; cscSortedValA: ptr cfloat;
                  cscSortedRowIndA: ptr cint; cscSortedColPtrA: ptr cint): Status_t {.
      cdecl, cdecl, importc: "cusparseSdense2csc", dynlib: libName.}
  proc Ddense2csc*(handle: Handle_t; m: cint; n: cint; descrA: MatDescr_t;
                  A: ptr cdouble; lda: cint; nnzPerCol: ptr cint;
                  cscSortedValA: ptr cdouble; cscSortedRowIndA: ptr cint;
                  cscSortedColPtrA: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseDdense2csc", dynlib: libName.}
  proc Cdense2csc*(handle: Handle_t; m: cint; n: cint; descrA: MatDescr_t;
                  A: ptr cuComplex; lda: cint; nnzPerCol: ptr cint;
                  cscSortedValA: ptr cuComplex; cscSortedRowIndA: ptr cint;
                  cscSortedColPtrA: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseCdense2csc", dynlib: libName.}
  proc Zdense2csc*(handle: Handle_t; m: cint; n: cint; descrA: MatDescr_t;
                  A: ptr cuDoubleComplex; lda: cint; nnzPerCol: ptr cint;
                  cscSortedValA: ptr cuDoubleComplex; cscSortedRowIndA: ptr cint;
                  cscSortedColPtrA: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseZdense2csc", dynlib: libName.}
  ##  Description: This routine converts a sparse matrix in CSC storage format
  ##    to a dense matrix.
  proc Scsc2dense*(handle: Handle_t; m: cint; n: cint; descrA: MatDescr_t;
                  cscSortedValA: ptr cfloat; cscSortedRowIndA: ptr cint;
                  cscSortedColPtrA: ptr cint; A: ptr cfloat; lda: cint): Status_t {.
      cdecl, cdecl, importc: "cusparseScsc2dense", dynlib: libName.}
  proc Dcsc2dense*(handle: Handle_t; m: cint; n: cint; descrA: MatDescr_t;
                  cscSortedValA: ptr cdouble; cscSortedRowIndA: ptr cint;
                  cscSortedColPtrA: ptr cint; A: ptr cdouble; lda: cint): Status_t {.
      cdecl, cdecl, importc: "cusparseDcsc2dense", dynlib: libName.}
  proc Ccsc2dense*(handle: Handle_t; m: cint; n: cint; descrA: MatDescr_t;
                  cscSortedValA: ptr cuComplex; cscSortedRowIndA: ptr cint;
                  cscSortedColPtrA: ptr cint; A: ptr cuComplex; lda: cint): Status_t {.
      cdecl, cdecl, importc: "cusparseCcsc2dense", dynlib: libName.}
  proc Zcsc2dense*(handle: Handle_t; m: cint; n: cint; descrA: MatDescr_t;
                  cscSortedValA: ptr cuDoubleComplex; cscSortedRowIndA: ptr cint;
                  cscSortedColPtrA: ptr cint; A: ptr cuDoubleComplex; lda: cint): Status_t {.
      cdecl, cdecl, importc: "cusparseZcsc2dense", dynlib: libName.}
  ##  Description: This routine compresses the indecis of rows or columns.
  ##    It can be interpreted as a conversion from COO to CSR sparse storage
  ##    format.
  proc Xcoo2csr*(handle: Handle_t; cooRowInd: ptr cint; nnz: cint; m: cint;
                csrSortedRowPtr: ptr cint; idxBase: IndexBase_t): Status_t {.cdecl,
      cdecl, importc: "cusparseXcoo2csr", dynlib: libName.}
  ##  Description: This routine uncompresses the indecis of rows or columns.
  ##    It can be interpreted as a conversion from CSR to COO sparse storage
  ##    format.
  proc Xcsr2coo*(handle: Handle_t; csrSortedRowPtr: ptr cint; nnz: cint; m: cint;
                cooRowInd: ptr cint; idxBase: IndexBase_t): Status_t {.cdecl, cdecl,
      importc: "cusparseXcsr2coo", dynlib: libName.}
  ##  Description: This routine converts a matrix from CSR to CSC sparse 
  ##    storage format. The resulting matrix can be re-interpreted as a 
  ##    transpose of the original matrix in CSR storage format.
  proc Csr2cscEx*(handle: Handle_t; m: cint; n: cint; nnz: cint; csrSortedVal: pointer;
                 csrSortedValtype: cudaDataType; csrSortedRowPtr: ptr cint;
                 csrSortedColInd: ptr cint; cscSortedVal: pointer;
                 cscSortedValtype: cudaDataType; cscSortedRowInd: ptr cint;
                 cscSortedColPtr: ptr cint; copyValues: Action_t;
                 idxBase: IndexBase_t; executiontype: cudaDataType): Status_t {.
      cdecl, cdecl, importc: "cusparseCsr2cscEx", dynlib: libName.}
  proc Scsr2csc*(handle: Handle_t; m: cint; n: cint; nnz: cint; csrSortedVal: ptr cfloat;
                csrSortedRowPtr: ptr cint; csrSortedColInd: ptr cint;
                cscSortedVal: ptr cfloat; cscSortedRowInd: ptr cint;
                cscSortedColPtr: ptr cint; copyValues: Action_t; idxBase: IndexBase_t): Status_t {.
      cdecl, cdecl, importc: "cusparseScsr2csc", dynlib: libName.}
  proc Dcsr2csc*(handle: Handle_t; m: cint; n: cint; nnz: cint;
                csrSortedVal: ptr cdouble; csrSortedRowPtr: ptr cint;
                csrSortedColInd: ptr cint; cscSortedVal: ptr cdouble;
                cscSortedRowInd: ptr cint; cscSortedColPtr: ptr cint;
                copyValues: Action_t; idxBase: IndexBase_t): Status_t {.cdecl, cdecl,
      importc: "cusparseDcsr2csc", dynlib: libName.}
  proc Ccsr2csc*(handle: Handle_t; m: cint; n: cint; nnz: cint;
                csrSortedVal: ptr cuComplex; csrSortedRowPtr: ptr cint;
                csrSortedColInd: ptr cint; cscSortedVal: ptr cuComplex;
                cscSortedRowInd: ptr cint; cscSortedColPtr: ptr cint;
                copyValues: Action_t; idxBase: IndexBase_t): Status_t {.cdecl, cdecl,
      importc: "cusparseCcsr2csc", dynlib: libName.}
  proc Zcsr2csc*(handle: Handle_t; m: cint; n: cint; nnz: cint;
                csrSortedVal: ptr cuDoubleComplex; csrSortedRowPtr: ptr cint;
                csrSortedColInd: ptr cint; cscSortedVal: ptr cuDoubleComplex;
                cscSortedRowInd: ptr cint; cscSortedColPtr: ptr cint;
                copyValues: Action_t; idxBase: IndexBase_t): Status_t {.cdecl, cdecl,
      importc: "cusparseZcsr2csc", dynlib: libName.}
  ##  Description: This routine converts a dense matrix to a sparse matrix 
  ##    in HYB storage format.
  proc Sdense2hyb*(handle: Handle_t; m: cint; n: cint; descrA: MatDescr_t; A: ptr cfloat;
                  lda: cint; nnzPerRow: ptr cint; hybA: HybMat_t; userEllWidth: cint;
                  partitionType: HybPartition_t): Status_t {.cdecl, cdecl,
      importc: "cusparseSdense2hyb", dynlib: libName.}
  proc Ddense2hyb*(handle: Handle_t; m: cint; n: cint; descrA: MatDescr_t;
                  A: ptr cdouble; lda: cint; nnzPerRow: ptr cint; hybA: HybMat_t;
                  userEllWidth: cint; partitionType: HybPartition_t): Status_t {.
      cdecl, cdecl, importc: "cusparseDdense2hyb", dynlib: libName.}
  proc Cdense2hyb*(handle: Handle_t; m: cint; n: cint; descrA: MatDescr_t;
                  A: ptr cuComplex; lda: cint; nnzPerRow: ptr cint; hybA: HybMat_t;
                  userEllWidth: cint; partitionType: HybPartition_t): Status_t {.
      cdecl, cdecl, importc: "cusparseCdense2hyb", dynlib: libName.}
  proc Zdense2hyb*(handle: Handle_t; m: cint; n: cint; descrA: MatDescr_t;
                  A: ptr cuDoubleComplex; lda: cint; nnzPerRow: ptr cint;
                  hybA: HybMat_t; userEllWidth: cint; partitionType: HybPartition_t): Status_t {.
      cdecl, cdecl, importc: "cusparseZdense2hyb", dynlib: libName.}
  ##  Description: This routine converts a sparse matrix in HYB storage format
  ##    to a dense matrix.
  proc Shyb2dense*(handle: Handle_t; descrA: MatDescr_t; hybA: HybMat_t; A: ptr cfloat;
                  lda: cint): Status_t {.cdecl, cdecl, importc: "cusparseShyb2dense",
                                      dynlib: libName.}
  proc Dhyb2dense*(handle: Handle_t; descrA: MatDescr_t; hybA: HybMat_t;
                  A: ptr cdouble; lda: cint): Status_t {.cdecl, cdecl,
      importc: "cusparseDhyb2dense", dynlib: libName.}
  proc Chyb2dense*(handle: Handle_t; descrA: MatDescr_t; hybA: HybMat_t;
                  A: ptr cuComplex; lda: cint): Status_t {.cdecl, cdecl,
      importc: "cusparseChyb2dense", dynlib: libName.}
  proc Zhyb2dense*(handle: Handle_t; descrA: MatDescr_t; hybA: HybMat_t;
                  A: ptr cuDoubleComplex; lda: cint): Status_t {.cdecl, cdecl,
      importc: "cusparseZhyb2dense", dynlib: libName.}
  ##  Description: This routine converts a sparse matrix in CSR storage format
  ##    to a sparse matrix in HYB storage format.
  proc Scsr2hyb*(handle: Handle_t; m: cint; n: cint; descrA: MatDescr_t;
                csrSortedValA: ptr cfloat; csrSortedRowPtrA: ptr cint;
                csrSortedColIndA: ptr cint; hybA: HybMat_t; userEllWidth: cint;
                partitionType: HybPartition_t): Status_t {.cdecl, cdecl,
      importc: "cusparseScsr2hyb", dynlib: libName.}
  proc Dcsr2hyb*(handle: Handle_t; m: cint; n: cint; descrA: MatDescr_t;
                csrSortedValA: ptr cdouble; csrSortedRowPtrA: ptr cint;
                csrSortedColIndA: ptr cint; hybA: HybMat_t; userEllWidth: cint;
                partitionType: HybPartition_t): Status_t {.cdecl, cdecl,
      importc: "cusparseDcsr2hyb", dynlib: libName.}
  proc Ccsr2hyb*(handle: Handle_t; m: cint; n: cint; descrA: MatDescr_t;
                csrSortedValA: ptr cuComplex; csrSortedRowPtrA: ptr cint;
                csrSortedColIndA: ptr cint; hybA: HybMat_t; userEllWidth: cint;
                partitionType: HybPartition_t): Status_t {.cdecl, cdecl,
      importc: "cusparseCcsr2hyb", dynlib: libName.}
  proc Zcsr2hyb*(handle: Handle_t; m: cint; n: cint; descrA: MatDescr_t;
                csrSortedValA: ptr cuDoubleComplex; csrSortedRowPtrA: ptr cint;
                csrSortedColIndA: ptr cint; hybA: HybMat_t; userEllWidth: cint;
                partitionType: HybPartition_t): Status_t {.cdecl, cdecl,
      importc: "cusparseZcsr2hyb", dynlib: libName.}
  ##  Description: This routine converts a sparse matrix in HYB storage format
  ##    to a sparse matrix in CSR storage format.
  proc Shyb2csr*(handle: Handle_t; descrA: MatDescr_t; hybA: HybMat_t;
                csrSortedValA: ptr cfloat; csrSortedRowPtrA: ptr cint;
                csrSortedColIndA: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseShyb2csr", dynlib: libName.}
  proc Dhyb2csr*(handle: Handle_t; descrA: MatDescr_t; hybA: HybMat_t;
                csrSortedValA: ptr cdouble; csrSortedRowPtrA: ptr cint;
                csrSortedColIndA: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseDhyb2csr", dynlib: libName.}
  proc Chyb2csr*(handle: Handle_t; descrA: MatDescr_t; hybA: HybMat_t;
                csrSortedValA: ptr cuComplex; csrSortedRowPtrA: ptr cint;
                csrSortedColIndA: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseChyb2csr", dynlib: libName.}
  proc Zhyb2csr*(handle: Handle_t; descrA: MatDescr_t; hybA: HybMat_t;
                csrSortedValA: ptr cuDoubleComplex; csrSortedRowPtrA: ptr cint;
                csrSortedColIndA: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseZhyb2csr", dynlib: libName.}
  ##  Description: This routine converts a sparse matrix in CSC storage format
  ##    to a sparse matrix in HYB storage format.
  proc Scsc2hyb*(handle: Handle_t; m: cint; n: cint; descrA: MatDescr_t;
                cscSortedValA: ptr cfloat; cscSortedRowIndA: ptr cint;
                cscSortedColPtrA: ptr cint; hybA: HybMat_t; userEllWidth: cint;
                partitionType: HybPartition_t): Status_t {.cdecl, cdecl,
      importc: "cusparseScsc2hyb", dynlib: libName.}
  proc Dcsc2hyb*(handle: Handle_t; m: cint; n: cint; descrA: MatDescr_t;
                cscSortedValA: ptr cdouble; cscSortedRowIndA: ptr cint;
                cscSortedColPtrA: ptr cint; hybA: HybMat_t; userEllWidth: cint;
                partitionType: HybPartition_t): Status_t {.cdecl, cdecl,
      importc: "cusparseDcsc2hyb", dynlib: libName.}
  proc Ccsc2hyb*(handle: Handle_t; m: cint; n: cint; descrA: MatDescr_t;
                cscSortedValA: ptr cuComplex; cscSortedRowIndA: ptr cint;
                cscSortedColPtrA: ptr cint; hybA: HybMat_t; userEllWidth: cint;
                partitionType: HybPartition_t): Status_t {.cdecl, cdecl,
      importc: "cusparseCcsc2hyb", dynlib: libName.}
  proc Zcsc2hyb*(handle: Handle_t; m: cint; n: cint; descrA: MatDescr_t;
                cscSortedValA: ptr cuDoubleComplex; cscSortedRowIndA: ptr cint;
                cscSortedColPtrA: ptr cint; hybA: HybMat_t; userEllWidth: cint;
                partitionType: HybPartition_t): Status_t {.cdecl, cdecl,
      importc: "cusparseZcsc2hyb", dynlib: libName.}
  ##  Description: This routine converts a sparse matrix in HYB storage format
  ##    to a sparse matrix in CSC storage format.
  proc Shyb2csc*(handle: Handle_t; descrA: MatDescr_t; hybA: HybMat_t;
                cscSortedVal: ptr cfloat; cscSortedRowInd: ptr cint;
                cscSortedColPtr: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseShyb2csc", dynlib: libName.}
  proc Dhyb2csc*(handle: Handle_t; descrA: MatDescr_t; hybA: HybMat_t;
                cscSortedVal: ptr cdouble; cscSortedRowInd: ptr cint;
                cscSortedColPtr: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseDhyb2csc", dynlib: libName.}
  proc Chyb2csc*(handle: Handle_t; descrA: MatDescr_t; hybA: HybMat_t;
                cscSortedVal: ptr cuComplex; cscSortedRowInd: ptr cint;
                cscSortedColPtr: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseChyb2csc", dynlib: libName.}
  proc Zhyb2csc*(handle: Handle_t; descrA: MatDescr_t; hybA: HybMat_t;
                cscSortedVal: ptr cuDoubleComplex; cscSortedRowInd: ptr cint;
                cscSortedColPtr: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseZhyb2csc", dynlib: libName.}
  ##  Description: This routine converts a sparse matrix in CSR storage format
  ##    to a sparse matrix in block-CSR storage format.
  proc Xcsr2bsrNnz*(handle: Handle_t; dirA: Direction_t; m: cint; n: cint;
                   descrA: MatDescr_t; csrSortedRowPtrA: ptr cint;
                   csrSortedColIndA: ptr cint; blockDim: cint; descrC: MatDescr_t;
                   bsrSortedRowPtrC: ptr cint; nnzTotalDevHostPtr: ptr cint): Status_t {.
      cdecl, cdecl, importc: "cusparseXcsr2bsrNnz", dynlib: libName.}
  proc Scsr2bsr*(handle: Handle_t; dirA: Direction_t; m: cint; n: cint;
                descrA: MatDescr_t; csrSortedValA: ptr cfloat;
                csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                blockDim: cint; descrC: MatDescr_t; bsrSortedValC: ptr cfloat;
                bsrSortedRowPtrC: ptr cint; bsrSortedColIndC: ptr cint): Status_t {.
      cdecl, cdecl, importc: "cusparseScsr2bsr", dynlib: libName.}
  proc Dcsr2bsr*(handle: Handle_t; dirA: Direction_t; m: cint; n: cint;
                descrA: MatDescr_t; csrSortedValA: ptr cdouble;
                csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                blockDim: cint; descrC: MatDescr_t; bsrSortedValC: ptr cdouble;
                bsrSortedRowPtrC: ptr cint; bsrSortedColIndC: ptr cint): Status_t {.
      cdecl, cdecl, importc: "cusparseDcsr2bsr", dynlib: libName.}
  proc Ccsr2bsr*(handle: Handle_t; dirA: Direction_t; m: cint; n: cint;
                descrA: MatDescr_t; csrSortedValA: ptr cuComplex;
                csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                blockDim: cint; descrC: MatDescr_t; bsrSortedValC: ptr cuComplex;
                bsrSortedRowPtrC: ptr cint; bsrSortedColIndC: ptr cint): Status_t {.
      cdecl, cdecl, importc: "cusparseCcsr2bsr", dynlib: libName.}
  proc Zcsr2bsr*(handle: Handle_t; dirA: Direction_t; m: cint; n: cint;
                descrA: MatDescr_t; csrSortedValA: ptr cuDoubleComplex;
                csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                blockDim: cint; descrC: MatDescr_t;
                bsrSortedValC: ptr cuDoubleComplex; bsrSortedRowPtrC: ptr cint;
                bsrSortedColIndC: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseZcsr2bsr", dynlib: libName.}
  ##  Description: This routine converts a sparse matrix in block-CSR storage format
  ##    to a sparse matrix in CSR storage format.
  proc Sbsr2csr*(handle: Handle_t; dirA: Direction_t; mb: cint; nb: cint;
                descrA: MatDescr_t; bsrSortedValA: ptr cfloat;
                bsrSortedRowPtrA: ptr cint; bsrSortedColIndA: ptr cint;
                blockDim: cint; descrC: MatDescr_t; csrSortedValC: ptr cfloat;
                csrSortedRowPtrC: ptr cint; csrSortedColIndC: ptr cint): Status_t {.
      cdecl, cdecl, importc: "cusparseSbsr2csr", dynlib: libName.}
  proc Dbsr2csr*(handle: Handle_t; dirA: Direction_t; mb: cint; nb: cint;
                descrA: MatDescr_t; bsrSortedValA: ptr cdouble;
                bsrSortedRowPtrA: ptr cint; bsrSortedColIndA: ptr cint;
                blockDim: cint; descrC: MatDescr_t; csrSortedValC: ptr cdouble;
                csrSortedRowPtrC: ptr cint; csrSortedColIndC: ptr cint): Status_t {.
      cdecl, cdecl, importc: "cusparseDbsr2csr", dynlib: libName.}
  proc Cbsr2csr*(handle: Handle_t; dirA: Direction_t; mb: cint; nb: cint;
                descrA: MatDescr_t; bsrSortedValA: ptr cuComplex;
                bsrSortedRowPtrA: ptr cint; bsrSortedColIndA: ptr cint;
                blockDim: cint; descrC: MatDescr_t; csrSortedValC: ptr cuComplex;
                csrSortedRowPtrC: ptr cint; csrSortedColIndC: ptr cint): Status_t {.
      cdecl, cdecl, importc: "cusparseCbsr2csr", dynlib: libName.}
  proc Zbsr2csr*(handle: Handle_t; dirA: Direction_t; mb: cint; nb: cint;
                descrA: MatDescr_t; bsrSortedValA: ptr cuDoubleComplex;
                bsrSortedRowPtrA: ptr cint; bsrSortedColIndA: ptr cint;
                blockDim: cint; descrC: MatDescr_t;
                csrSortedValC: ptr cuDoubleComplex; csrSortedRowPtrC: ptr cint;
                csrSortedColIndC: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseZbsr2csr", dynlib: libName.}
  ##  Description: This routine converts a sparse matrix in general block-CSR storage format
  ##    to a sparse matrix in general block-CSC storage format.
  proc Sgebsr2gebsc_bufferSize*(handle: Handle_t; mb: cint; nb: cint; nnzb: cint;
                               bsrSortedVal: ptr cfloat; bsrSortedRowPtr: ptr cint;
                               bsrSortedColInd: ptr cint; rowBlockDim: cint;
                               colBlockDim: cint; pBufferSizeInBytes: ptr cint): Status_t {.
      cdecl, cdecl, importc: "cusparseSgebsr2gebsc_bufferSize", dynlib: libName.}
  proc Dgebsr2gebsc_bufferSize*(handle: Handle_t; mb: cint; nb: cint; nnzb: cint;
                               bsrSortedVal: ptr cdouble;
                               bsrSortedRowPtr: ptr cint;
                               bsrSortedColInd: ptr cint; rowBlockDim: cint;
                               colBlockDim: cint; pBufferSizeInBytes: ptr cint): Status_t {.
      cdecl, cdecl, importc: "cusparseDgebsr2gebsc_bufferSize", dynlib: libName.}
  proc Cgebsr2gebsc_bufferSize*(handle: Handle_t; mb: cint; nb: cint; nnzb: cint;
                               bsrSortedVal: ptr cuComplex;
                               bsrSortedRowPtr: ptr cint;
                               bsrSortedColInd: ptr cint; rowBlockDim: cint;
                               colBlockDim: cint; pBufferSizeInBytes: ptr cint): Status_t {.
      cdecl, cdecl, importc: "cusparseCgebsr2gebsc_bufferSize", dynlib: libName.}
  proc Zgebsr2gebsc_bufferSize*(handle: Handle_t; mb: cint; nb: cint; nnzb: cint;
                               bsrSortedVal: ptr cuDoubleComplex;
                               bsrSortedRowPtr: ptr cint;
                               bsrSortedColInd: ptr cint; rowBlockDim: cint;
                               colBlockDim: cint; pBufferSizeInBytes: ptr cint): Status_t {.
      cdecl, cdecl, importc: "cusparseZgebsr2gebsc_bufferSize", dynlib: libName.}
  proc Sgebsr2gebsc_bufferSizeExt*(handle: Handle_t; mb: cint; nb: cint; nnzb: cint;
                                  bsrSortedVal: ptr cfloat;
                                  bsrSortedRowPtr: ptr cint;
                                  bsrSortedColInd: ptr cint; rowBlockDim: cint;
                                  colBlockDim: cint; pBufferSize: ptr csize): Status_t {.
      cdecl, cdecl, importc: "cusparseSgebsr2gebsc_bufferSizeExt", dynlib: libName.}
  proc Dgebsr2gebsc_bufferSizeExt*(handle: Handle_t; mb: cint; nb: cint; nnzb: cint;
                                  bsrSortedVal: ptr cdouble;
                                  bsrSortedRowPtr: ptr cint;
                                  bsrSortedColInd: ptr cint; rowBlockDim: cint;
                                  colBlockDim: cint; pBufferSize: ptr csize): Status_t {.
      cdecl, cdecl, importc: "cusparseDgebsr2gebsc_bufferSizeExt", dynlib: libName.}
  proc Cgebsr2gebsc_bufferSizeExt*(handle: Handle_t; mb: cint; nb: cint; nnzb: cint;
                                  bsrSortedVal: ptr cuComplex;
                                  bsrSortedRowPtr: ptr cint;
                                  bsrSortedColInd: ptr cint; rowBlockDim: cint;
                                  colBlockDim: cint; pBufferSize: ptr csize): Status_t {.
      cdecl, cdecl, importc: "cusparseCgebsr2gebsc_bufferSizeExt", dynlib: libName.}
  proc Zgebsr2gebsc_bufferSizeExt*(handle: Handle_t; mb: cint; nb: cint; nnzb: cint;
                                  bsrSortedVal: ptr cuDoubleComplex;
                                  bsrSortedRowPtr: ptr cint;
                                  bsrSortedColInd: ptr cint; rowBlockDim: cint;
                                  colBlockDim: cint; pBufferSize: ptr csize): Status_t {.
      cdecl, cdecl, importc: "cusparseZgebsr2gebsc_bufferSizeExt", dynlib: libName.}
  proc Sgebsr2gebsc*(handle: Handle_t; mb: cint; nb: cint; nnzb: cint;
                    bsrSortedVal: ptr cfloat; bsrSortedRowPtr: ptr cint;
                    bsrSortedColInd: ptr cint; rowBlockDim: cint; colBlockDim: cint;
                    bscVal: ptr cfloat; bscRowInd: ptr cint; bscColPtr: ptr cint;
                    copyValues: Action_t; baseIdx: IndexBase_t; pBuffer: pointer): Status_t {.
      cdecl, cdecl, importc: "cusparseSgebsr2gebsc", dynlib: libName.}
  proc Dgebsr2gebsc*(handle: Handle_t; mb: cint; nb: cint; nnzb: cint;
                    bsrSortedVal: ptr cdouble; bsrSortedRowPtr: ptr cint;
                    bsrSortedColInd: ptr cint; rowBlockDim: cint; colBlockDim: cint;
                    bscVal: ptr cdouble; bscRowInd: ptr cint; bscColPtr: ptr cint;
                    copyValues: Action_t; baseIdx: IndexBase_t; pBuffer: pointer): Status_t {.
      cdecl, cdecl, importc: "cusparseDgebsr2gebsc", dynlib: libName.}
  proc Cgebsr2gebsc*(handle: Handle_t; mb: cint; nb: cint; nnzb: cint;
                    bsrSortedVal: ptr cuComplex; bsrSortedRowPtr: ptr cint;
                    bsrSortedColInd: ptr cint; rowBlockDim: cint; colBlockDim: cint;
                    bscVal: ptr cuComplex; bscRowInd: ptr cint; bscColPtr: ptr cint;
                    copyValues: Action_t; baseIdx: IndexBase_t; pBuffer: pointer): Status_t {.
      cdecl, cdecl, importc: "cusparseCgebsr2gebsc", dynlib: libName.}
  proc Zgebsr2gebsc*(handle: Handle_t; mb: cint; nb: cint; nnzb: cint;
                    bsrSortedVal: ptr cuDoubleComplex; bsrSortedRowPtr: ptr cint;
                    bsrSortedColInd: ptr cint; rowBlockDim: cint; colBlockDim: cint;
                    bscVal: ptr cuDoubleComplex; bscRowInd: ptr cint;
                    bscColPtr: ptr cint; copyValues: Action_t; baseIdx: IndexBase_t;
                    pBuffer: pointer): Status_t {.cdecl, cdecl,
      importc: "cusparseZgebsr2gebsc", dynlib: libName.}
  ##  Description: This routine converts a sparse matrix in general block-CSR storage format
  ##    to a sparse matrix in CSR storage format.
  proc Xgebsr2csr*(handle: Handle_t; dirA: Direction_t; mb: cint; nb: cint;
                  descrA: MatDescr_t; bsrSortedRowPtrA: ptr cint;
                  bsrSortedColIndA: ptr cint; rowBlockDim: cint; colBlockDim: cint;
                  descrC: MatDescr_t; csrSortedRowPtrC: ptr cint;
                  csrSortedColIndC: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseXgebsr2csr", dynlib: libName.}
  proc Sgebsr2csr*(handle: Handle_t; dirA: Direction_t; mb: cint; nb: cint;
                  descrA: MatDescr_t; bsrSortedValA: ptr cfloat;
                  bsrSortedRowPtrA: ptr cint; bsrSortedColIndA: ptr cint;
                  rowBlockDim: cint; colBlockDim: cint; descrC: MatDescr_t;
                  csrSortedValC: ptr cfloat; csrSortedRowPtrC: ptr cint;
                  csrSortedColIndC: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseSgebsr2csr", dynlib: libName.}
  proc Dgebsr2csr*(handle: Handle_t; dirA: Direction_t; mb: cint; nb: cint;
                  descrA: MatDescr_t; bsrSortedValA: ptr cdouble;
                  bsrSortedRowPtrA: ptr cint; bsrSortedColIndA: ptr cint;
                  rowBlockDim: cint; colBlockDim: cint; descrC: MatDescr_t;
                  csrSortedValC: ptr cdouble; csrSortedRowPtrC: ptr cint;
                  csrSortedColIndC: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseDgebsr2csr", dynlib: libName.}
  proc Cgebsr2csr*(handle: Handle_t; dirA: Direction_t; mb: cint; nb: cint;
                  descrA: MatDescr_t; bsrSortedValA: ptr cuComplex;
                  bsrSortedRowPtrA: ptr cint; bsrSortedColIndA: ptr cint;
                  rowBlockDim: cint; colBlockDim: cint; descrC: MatDescr_t;
                  csrSortedValC: ptr cuComplex; csrSortedRowPtrC: ptr cint;
                  csrSortedColIndC: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseCgebsr2csr", dynlib: libName.}
  proc Zgebsr2csr*(handle: Handle_t; dirA: Direction_t; mb: cint; nb: cint;
                  descrA: MatDescr_t; bsrSortedValA: ptr cuDoubleComplex;
                  bsrSortedRowPtrA: ptr cint; bsrSortedColIndA: ptr cint;
                  rowBlockDim: cint; colBlockDim: cint; descrC: MatDescr_t;
                  csrSortedValC: ptr cuDoubleComplex; csrSortedRowPtrC: ptr cint;
                  csrSortedColIndC: ptr cint): Status_t {.cdecl, cdecl,
      importc: "cusparseZgebsr2csr", dynlib: libName.}
  ##  Description: This routine converts a sparse matrix in CSR storage format
  ##    to a sparse matrix in general block-CSR storage format.
  proc Scsr2gebsr_bufferSize*(handle: Handle_t; dirA: Direction_t; m: cint; n: cint;
                             descrA: MatDescr_t; csrSortedValA: ptr cfloat;
                             csrSortedRowPtrA: ptr cint;
                             csrSortedColIndA: ptr cint; rowBlockDim: cint;
                             colBlockDim: cint; pBufferSizeInBytes: ptr cint): Status_t {.
      cdecl, cdecl, importc: "cusparseScsr2gebsr_bufferSize", dynlib: libName.}
  proc Dcsr2gebsr_bufferSize*(handle: Handle_t; dirA: Direction_t; m: cint; n: cint;
                             descrA: MatDescr_t; csrSortedValA: ptr cdouble;
                             csrSortedRowPtrA: ptr cint;
                             csrSortedColIndA: ptr cint; rowBlockDim: cint;
                             colBlockDim: cint; pBufferSizeInBytes: ptr cint): Status_t {.
      cdecl, cdecl, importc: "cusparseDcsr2gebsr_bufferSize", dynlib: libName.}
  proc Ccsr2gebsr_bufferSize*(handle: Handle_t; dirA: Direction_t; m: cint; n: cint;
                             descrA: MatDescr_t; csrSortedValA: ptr cuComplex;
                             csrSortedRowPtrA: ptr cint;
                             csrSortedColIndA: ptr cint; rowBlockDim: cint;
                             colBlockDim: cint; pBufferSizeInBytes: ptr cint): Status_t {.
      cdecl, cdecl, importc: "cusparseCcsr2gebsr_bufferSize", dynlib: libName.}
  proc Zcsr2gebsr_bufferSize*(handle: Handle_t; dirA: Direction_t; m: cint; n: cint;
                             descrA: MatDescr_t;
                             csrSortedValA: ptr cuDoubleComplex;
                             csrSortedRowPtrA: ptr cint;
                             csrSortedColIndA: ptr cint; rowBlockDim: cint;
                             colBlockDim: cint; pBufferSizeInBytes: ptr cint): Status_t {.
      cdecl, cdecl, importc: "cusparseZcsr2gebsr_bufferSize", dynlib: libName.}
  proc Scsr2gebsr_bufferSizeExt*(handle: Handle_t; dirA: Direction_t; m: cint; n: cint;
                                descrA: MatDescr_t; csrSortedValA: ptr cfloat;
                                csrSortedRowPtrA: ptr cint;
                                csrSortedColIndA: ptr cint; rowBlockDim: cint;
                                colBlockDim: cint; pBufferSize: ptr csize): Status_t {.
      cdecl, cdecl, importc: "cusparseScsr2gebsr_bufferSizeExt", dynlib: libName.}
  proc Dcsr2gebsr_bufferSizeExt*(handle: Handle_t; dirA: Direction_t; m: cint; n: cint;
                                descrA: MatDescr_t; csrSortedValA: ptr cdouble;
                                csrSortedRowPtrA: ptr cint;
                                csrSortedColIndA: ptr cint; rowBlockDim: cint;
                                colBlockDim: cint; pBufferSize: ptr csize): Status_t {.
      cdecl, cdecl, importc: "cusparseDcsr2gebsr_bufferSizeExt", dynlib: libName.}
  proc Ccsr2gebsr_bufferSizeExt*(handle: Handle_t; dirA: Direction_t; m: cint; n: cint;
                                descrA: MatDescr_t; csrSortedValA: ptr cuComplex;
                                csrSortedRowPtrA: ptr cint;
                                csrSortedColIndA: ptr cint; rowBlockDim: cint;
                                colBlockDim: cint; pBufferSize: ptr csize): Status_t {.
      cdecl, cdecl, importc: "cusparseCcsr2gebsr_bufferSizeExt", dynlib: libName.}
  proc Zcsr2gebsr_bufferSizeExt*(handle: Handle_t; dirA: Direction_t; m: cint; n: cint;
                                descrA: MatDescr_t;
                                csrSortedValA: ptr cuDoubleComplex;
                                csrSortedRowPtrA: ptr cint;
                                csrSortedColIndA: ptr cint; rowBlockDim: cint;
                                colBlockDim: cint; pBufferSize: ptr csize): Status_t {.
      cdecl, cdecl, importc: "cusparseZcsr2gebsr_bufferSizeExt", dynlib: libName.}
  proc Xcsr2gebsrNnz*(handle: Handle_t; dirA: Direction_t; m: cint; n: cint;
                     descrA: MatDescr_t; csrSortedRowPtrA: ptr cint;
                     csrSortedColIndA: ptr cint; descrC: MatDescr_t;
                     bsrSortedRowPtrC: ptr cint; rowBlockDim: cint;
                     colBlockDim: cint; nnzTotalDevHostPtr: ptr cint;
                     pBuffer: pointer): Status_t {.cdecl, cdecl,
      importc: "cusparseXcsr2gebsrNnz", dynlib: libName.}
  proc Scsr2gebsr*(handle: Handle_t; dirA: Direction_t; m: cint; n: cint;
                  descrA: MatDescr_t; csrSortedValA: ptr cfloat;
                  csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                  descrC: MatDescr_t; bsrSortedValC: ptr cfloat;
                  bsrSortedRowPtrC: ptr cint; bsrSortedColIndC: ptr cint;
                  rowBlockDim: cint; colBlockDim: cint; pBuffer: pointer): Status_t {.
      cdecl, cdecl, importc: "cusparseScsr2gebsr", dynlib: libName.}
  proc Dcsr2gebsr*(handle: Handle_t; dirA: Direction_t; m: cint; n: cint;
                  descrA: MatDescr_t; csrSortedValA: ptr cdouble;
                  csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                  descrC: MatDescr_t; bsrSortedValC: ptr cdouble;
                  bsrSortedRowPtrC: ptr cint; bsrSortedColIndC: ptr cint;
                  rowBlockDim: cint; colBlockDim: cint; pBuffer: pointer): Status_t {.
      cdecl, cdecl, importc: "cusparseDcsr2gebsr", dynlib: libName.}
  proc Ccsr2gebsr*(handle: Handle_t; dirA: Direction_t; m: cint; n: cint;
                  descrA: MatDescr_t; csrSortedValA: ptr cuComplex;
                  csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                  descrC: MatDescr_t; bsrSortedValC: ptr cuComplex;
                  bsrSortedRowPtrC: ptr cint; bsrSortedColIndC: ptr cint;
                  rowBlockDim: cint; colBlockDim: cint; pBuffer: pointer): Status_t {.
      cdecl, cdecl, importc: "cusparseCcsr2gebsr", dynlib: libName.}
  proc Zcsr2gebsr*(handle: Handle_t; dirA: Direction_t; m: cint; n: cint;
                  descrA: MatDescr_t; csrSortedValA: ptr cuDoubleComplex;
                  csrSortedRowPtrA: ptr cint; csrSortedColIndA: ptr cint;
                  descrC: MatDescr_t; bsrSortedValC: ptr cuDoubleComplex;
                  bsrSortedRowPtrC: ptr cint; bsrSortedColIndC: ptr cint;
                  rowBlockDim: cint; colBlockDim: cint; pBuffer: pointer): Status_t {.
      cdecl, cdecl, importc: "cusparseZcsr2gebsr", dynlib: libName.}
  ##  Description: This routine converts a sparse matrix in general block-CSR storage format
  ##    to a sparse matrix in general block-CSR storage format with different block size.
  proc Sgebsr2gebsr_bufferSize*(handle: Handle_t; dirA: Direction_t; mb: cint;
                               nb: cint; nnzb: cint; descrA: MatDescr_t;
                               bsrSortedValA: ptr cfloat;
                               bsrSortedRowPtrA: ptr cint;
                               bsrSortedColIndA: ptr cint; rowBlockDimA: cint;
                               colBlockDimA: cint; rowBlockDimC: cint;
                               colBlockDimC: cint; pBufferSizeInBytes: ptr cint): Status_t {.
      cdecl, cdecl, importc: "cusparseSgebsr2gebsr_bufferSize", dynlib: libName.}
  proc Dgebsr2gebsr_bufferSize*(handle: Handle_t; dirA: Direction_t; mb: cint;
                               nb: cint; nnzb: cint; descrA: MatDescr_t;
                               bsrSortedValA: ptr cdouble;
                               bsrSortedRowPtrA: ptr cint;
                               bsrSortedColIndA: ptr cint; rowBlockDimA: cint;
                               colBlockDimA: cint; rowBlockDimC: cint;
                               colBlockDimC: cint; pBufferSizeInBytes: ptr cint): Status_t {.
      cdecl, cdecl, importc: "cusparseDgebsr2gebsr_bufferSize", dynlib: libName.}
  proc Cgebsr2gebsr_bufferSize*(handle: Handle_t; dirA: Direction_t; mb: cint;
                               nb: cint; nnzb: cint; descrA: MatDescr_t;
                               bsrSortedValA: ptr cuComplex;
                               bsrSortedRowPtrA: ptr cint;
                               bsrSortedColIndA: ptr cint; rowBlockDimA: cint;
                               colBlockDimA: cint; rowBlockDimC: cint;
                               colBlockDimC: cint; pBufferSizeInBytes: ptr cint): Status_t {.
      cdecl, cdecl, importc: "cusparseCgebsr2gebsr_bufferSize", dynlib: libName.}
  proc Zgebsr2gebsr_bufferSize*(handle: Handle_t; dirA: Direction_t; mb: cint;
                               nb: cint; nnzb: cint; descrA: MatDescr_t;
                               bsrSortedValA: ptr cuDoubleComplex;
                               bsrSortedRowPtrA: ptr cint;
                               bsrSortedColIndA: ptr cint; rowBlockDimA: cint;
                               colBlockDimA: cint; rowBlockDimC: cint;
                               colBlockDimC: cint; pBufferSizeInBytes: ptr cint): Status_t {.
      cdecl, cdecl, importc: "cusparseZgebsr2gebsr_bufferSize", dynlib: libName.}
  proc Sgebsr2gebsr_bufferSizeExt*(handle: Handle_t; dirA: Direction_t; mb: cint;
                                  nb: cint; nnzb: cint; descrA: MatDescr_t;
                                  bsrSortedValA: ptr cfloat;
                                  bsrSortedRowPtrA: ptr cint;
                                  bsrSortedColIndA: ptr cint; rowBlockDimA: cint;
                                  colBlockDimA: cint; rowBlockDimC: cint;
                                  colBlockDimC: cint; pBufferSize: ptr csize): Status_t {.
      cdecl, cdecl, importc: "cusparseSgebsr2gebsr_bufferSizeExt", dynlib: libName.}
  proc Dgebsr2gebsr_bufferSizeExt*(handle: Handle_t; dirA: Direction_t; mb: cint;
                                  nb: cint; nnzb: cint; descrA: MatDescr_t;
                                  bsrSortedValA: ptr cdouble;
                                  bsrSortedRowPtrA: ptr cint;
                                  bsrSortedColIndA: ptr cint; rowBlockDimA: cint;
                                  colBlockDimA: cint; rowBlockDimC: cint;
                                  colBlockDimC: cint; pBufferSize: ptr csize): Status_t {.
      cdecl, cdecl, importc: "cusparseDgebsr2gebsr_bufferSizeExt", dynlib: libName.}
  proc Cgebsr2gebsr_bufferSizeExt*(handle: Handle_t; dirA: Direction_t; mb: cint;
                                  nb: cint; nnzb: cint; descrA: MatDescr_t;
                                  bsrSortedValA: ptr cuComplex;
                                  bsrSortedRowPtrA: ptr cint;
                                  bsrSortedColIndA: ptr cint; rowBlockDimA: cint;
                                  colBlockDimA: cint; rowBlockDimC: cint;
                                  colBlockDimC: cint; pBufferSize: ptr csize): Status_t {.
      cdecl, cdecl, importc: "cusparseCgebsr2gebsr_bufferSizeExt", dynlib: libName.}
  proc Zgebsr2gebsr_bufferSizeExt*(handle: Handle_t; dirA: Direction_t; mb: cint;
                                  nb: cint; nnzb: cint; descrA: MatDescr_t;
                                  bsrSortedValA: ptr cuDoubleComplex;
                                  bsrSortedRowPtrA: ptr cint;
                                  bsrSortedColIndA: ptr cint; rowBlockDimA: cint;
                                  colBlockDimA: cint; rowBlockDimC: cint;
                                  colBlockDimC: cint; pBufferSize: ptr csize): Status_t {.
      cdecl, cdecl, importc: "cusparseZgebsr2gebsr_bufferSizeExt", dynlib: libName.}
  proc Xgebsr2gebsrNnz*(handle: Handle_t; dirA: Direction_t; mb: cint; nb: cint;
                       nnzb: cint; descrA: MatDescr_t; bsrSortedRowPtrA: ptr cint;
                       bsrSortedColIndA: ptr cint; rowBlockDimA: cint;
                       colBlockDimA: cint; descrC: MatDescr_t;
                       bsrSortedRowPtrC: ptr cint; rowBlockDimC: cint;
                       colBlockDimC: cint; nnzTotalDevHostPtr: ptr cint;
                       pBuffer: pointer): Status_t {.cdecl, cdecl,
      importc: "cusparseXgebsr2gebsrNnz", dynlib: libName.}
  proc Sgebsr2gebsr*(handle: Handle_t; dirA: Direction_t; mb: cint; nb: cint; nnzb: cint;
                    descrA: MatDescr_t; bsrSortedValA: ptr cfloat;
                    bsrSortedRowPtrA: ptr cint; bsrSortedColIndA: ptr cint;
                    rowBlockDimA: cint; colBlockDimA: cint; descrC: MatDescr_t;
                    bsrSortedValC: ptr cfloat; bsrSortedRowPtrC: ptr cint;
                    bsrSortedColIndC: ptr cint; rowBlockDimC: cint;
                    colBlockDimC: cint; pBuffer: pointer): Status_t {.cdecl, cdecl,
      importc: "cusparseSgebsr2gebsr", dynlib: libName.}
  proc Dgebsr2gebsr*(handle: Handle_t; dirA: Direction_t; mb: cint; nb: cint; nnzb: cint;
                    descrA: MatDescr_t; bsrSortedValA: ptr cdouble;
                    bsrSortedRowPtrA: ptr cint; bsrSortedColIndA: ptr cint;
                    rowBlockDimA: cint; colBlockDimA: cint; descrC: MatDescr_t;
                    bsrSortedValC: ptr cdouble; bsrSortedRowPtrC: ptr cint;
                    bsrSortedColIndC: ptr cint; rowBlockDimC: cint;
                    colBlockDimC: cint; pBuffer: pointer): Status_t {.cdecl, cdecl,
      importc: "cusparseDgebsr2gebsr", dynlib: libName.}
  proc Cgebsr2gebsr*(handle: Handle_t; dirA: Direction_t; mb: cint; nb: cint; nnzb: cint;
                    descrA: MatDescr_t; bsrSortedValA: ptr cuComplex;
                    bsrSortedRowPtrA: ptr cint; bsrSortedColIndA: ptr cint;
                    rowBlockDimA: cint; colBlockDimA: cint; descrC: MatDescr_t;
                    bsrSortedValC: ptr cuComplex; bsrSortedRowPtrC: ptr cint;
                    bsrSortedColIndC: ptr cint; rowBlockDimC: cint;
                    colBlockDimC: cint; pBuffer: pointer): Status_t {.cdecl, cdecl,
      importc: "cusparseCgebsr2gebsr", dynlib: libName.}
  proc Zgebsr2gebsr*(handle: Handle_t; dirA: Direction_t; mb: cint; nb: cint; nnzb: cint;
                    descrA: MatDescr_t; bsrSortedValA: ptr cuDoubleComplex;
                    bsrSortedRowPtrA: ptr cint; bsrSortedColIndA: ptr cint;
                    rowBlockDimA: cint; colBlockDimA: cint; descrC: MatDescr_t;
                    bsrSortedValC: ptr cuDoubleComplex; bsrSortedRowPtrC: ptr cint;
                    bsrSortedColIndC: ptr cint; rowBlockDimC: cint;
                    colBlockDimC: cint; pBuffer: pointer): Status_t {.cdecl, cdecl,
      importc: "cusparseZgebsr2gebsr", dynlib: libName.}
  ##  --- Sparse Matrix Sorting ---
  ##  Description: Create a identity sequence p=[0,1,...,n-1].
  proc CreateIdentityPermutation*(handle: Handle_t; n: cint; p: ptr cint): Status_t {.
      cdecl, cdecl, importc: "cusparseCreateIdentityPermutation", dynlib: libName.}
  ##  Description: Sort sparse matrix stored in COO format
  proc Xcoosort_bufferSizeExt*(handle: Handle_t; m: cint; n: cint; nnz: cint;
                              cooRowsA: ptr cint; cooColsA: ptr cint;
                              pBufferSizeInBytes: ptr csize): Status_t {.cdecl,
      cdecl, importc: "cusparseXcoosort_bufferSizeExt", dynlib: libName.}
  proc XcoosortByRow*(handle: Handle_t; m: cint; n: cint; nnz: cint; cooRowsA: ptr cint;
                     cooColsA: ptr cint; P: ptr cint; pBuffer: pointer): Status_t {.
      cdecl, cdecl, importc: "cusparseXcoosortByRow", dynlib: libName.}
  proc XcoosortByColumn*(handle: Handle_t; m: cint; n: cint; nnz: cint;
                        cooRowsA: ptr cint; cooColsA: ptr cint; P: ptr cint;
                        pBuffer: pointer): Status_t {.cdecl, cdecl,
      importc: "cusparseXcoosortByColumn", dynlib: libName.}
  ##  Description: Sort sparse matrix stored in CSR format
  proc Xcsrsort_bufferSizeExt*(handle: Handle_t; m: cint; n: cint; nnz: cint;
                              csrRowPtrA: ptr cint; csrColIndA: ptr cint;
                              pBufferSizeInBytes: ptr csize): Status_t {.cdecl,
      cdecl, importc: "cusparseXcsrsort_bufferSizeExt", dynlib: libName.}
  proc Xcsrsort*(handle: Handle_t; m: cint; n: cint; nnz: cint; descrA: MatDescr_t;
                csrRowPtrA: ptr cint; csrColIndA: ptr cint; P: ptr cint; pBuffer: pointer): Status_t {.
      cdecl, cdecl, importc: "cusparseXcsrsort", dynlib: libName.}
  ##  Description: Sort sparse matrix stored in CSC format
  proc Xcscsort_bufferSizeExt*(handle: Handle_t; m: cint; n: cint; nnz: cint;
                              cscColPtrA: ptr cint; cscRowIndA: ptr cint;
                              pBufferSizeInBytes: ptr csize): Status_t {.cdecl,
      cdecl, importc: "cusparseXcscsort_bufferSizeExt", dynlib: libName.}
  proc Xcscsort*(handle: Handle_t; m: cint; n: cint; nnz: cint; descrA: MatDescr_t;
                cscColPtrA: ptr cint; cscRowIndA: ptr cint; P: ptr cint; pBuffer: pointer): Status_t {.
      cdecl, cdecl, importc: "cusparseXcscsort", dynlib: libName.}
  ##  Description: Wrapper that sorts sparse matrix stored in CSR format 
  ##    (without exposing the permutation).
  proc Scsru2csr_bufferSizeExt*(handle: Handle_t; m: cint; n: cint; nnz: cint;
                               csrVal: ptr cfloat; csrRowPtr: ptr cint;
                               csrColInd: ptr cint; info: csru2csrInfo_t;
                               pBufferSizeInBytes: ptr csize): Status_t {.cdecl,
      cdecl, importc: "cusparseScsru2csr_bufferSizeExt", dynlib: libName.}
  proc Dcsru2csr_bufferSizeExt*(handle: Handle_t; m: cint; n: cint; nnz: cint;
                               csrVal: ptr cdouble; csrRowPtr: ptr cint;
                               csrColInd: ptr cint; info: csru2csrInfo_t;
                               pBufferSizeInBytes: ptr csize): Status_t {.cdecl,
      cdecl, importc: "cusparseDcsru2csr_bufferSizeExt", dynlib: libName.}
  proc Ccsru2csr_bufferSizeExt*(handle: Handle_t; m: cint; n: cint; nnz: cint;
                               csrVal: ptr cuComplex; csrRowPtr: ptr cint;
                               csrColInd: ptr cint; info: csru2csrInfo_t;
                               pBufferSizeInBytes: ptr csize): Status_t {.cdecl,
      cdecl, importc: "cusparseCcsru2csr_bufferSizeExt", dynlib: libName.}
  proc Zcsru2csr_bufferSizeExt*(handle: Handle_t; m: cint; n: cint; nnz: cint;
                               csrVal: ptr cuDoubleComplex; csrRowPtr: ptr cint;
                               csrColInd: ptr cint; info: csru2csrInfo_t;
                               pBufferSizeInBytes: ptr csize): Status_t {.cdecl,
      cdecl, importc: "cusparseZcsru2csr_bufferSizeExt", dynlib: libName.}
  proc Scsru2csr*(handle: Handle_t; m: cint; n: cint; nnz: cint; descrA: MatDescr_t;
                 csrVal: ptr cfloat; csrRowPtr: ptr cint; csrColInd: ptr cint;
                 info: csru2csrInfo_t; pBuffer: pointer): Status_t {.cdecl, cdecl,
      importc: "cusparseScsru2csr", dynlib: libName.}
  proc Dcsru2csr*(handle: Handle_t; m: cint; n: cint; nnz: cint; descrA: MatDescr_t;
                 csrVal: ptr cdouble; csrRowPtr: ptr cint; csrColInd: ptr cint;
                 info: csru2csrInfo_t; pBuffer: pointer): Status_t {.cdecl, cdecl,
      importc: "cusparseDcsru2csr", dynlib: libName.}
  proc Ccsru2csr*(handle: Handle_t; m: cint; n: cint; nnz: cint; descrA: MatDescr_t;
                 csrVal: ptr cuComplex; csrRowPtr: ptr cint; csrColInd: ptr cint;
                 info: csru2csrInfo_t; pBuffer: pointer): Status_t {.cdecl, cdecl,
      importc: "cusparseCcsru2csr", dynlib: libName.}
  proc Zcsru2csr*(handle: Handle_t; m: cint; n: cint; nnz: cint; descrA: MatDescr_t;
                 csrVal: ptr cuDoubleComplex; csrRowPtr: ptr cint;
                 csrColInd: ptr cint; info: csru2csrInfo_t; pBuffer: pointer): Status_t {.
      cdecl, cdecl, importc: "cusparseZcsru2csr", dynlib: libName.}
  ##  Description: Wrapper that un-sorts sparse matrix stored in CSR format 
  ##    (without exposing the permutation).
  proc Scsr2csru*(handle: Handle_t; m: cint; n: cint; nnz: cint; descrA: MatDescr_t;
                 csrVal: ptr cfloat; csrRowPtr: ptr cint; csrColInd: ptr cint;
                 info: csru2csrInfo_t; pBuffer: pointer): Status_t {.cdecl, cdecl,
      importc: "cusparseScsr2csru", dynlib: libName.}
  proc Dcsr2csru*(handle: Handle_t; m: cint; n: cint; nnz: cint; descrA: MatDescr_t;
                 csrVal: ptr cdouble; csrRowPtr: ptr cint; csrColInd: ptr cint;
                 info: csru2csrInfo_t; pBuffer: pointer): Status_t {.cdecl, cdecl,
      importc: "cusparseDcsr2csru", dynlib: libName.}
  proc Ccsr2csru*(handle: Handle_t; m: cint; n: cint; nnz: cint; descrA: MatDescr_t;
                 csrVal: ptr cuComplex; csrRowPtr: ptr cint; csrColInd: ptr cint;
                 info: csru2csrInfo_t; pBuffer: pointer): Status_t {.cdecl, cdecl,
      importc: "cusparseCcsr2csru", dynlib: libName.}
  proc Zcsr2csru*(handle: Handle_t; m: cint; n: cint; nnz: cint; descrA: MatDescr_t;
                 csrVal: ptr cuDoubleComplex; csrRowPtr: ptr cint;
                 csrColInd: ptr cint; info: csru2csrInfo_t; pBuffer: pointer): Status_t {.
      cdecl, cdecl, importc: "cusparseZcsr2csru", dynlib: libName.}