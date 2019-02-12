 {.deadCodeElim: on.}
when defined(windows):
  import os
  {.passL: "\"" & os.getEnv("CUDA_PATH") / "lib/x64" / "cusolver.lib" & "\"".}
  {.pragma: dyn.}
elif defined(macosx):
  const
    libName = "libcusolver.dylib"
  {.pragma: dyn, dynlib: libName.}
else:
  const
    libName = "libcusolver.so"
  {.pragma: dyn, dynlib: libName.}
import
  cuComplex, cusolver_common

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

when not defined(CUSOLVERRF_H):
  const
    CUSOLVERRF_H* = true
  ##  CUSOLVERRF mode
  type
    cusolverRfResetValuesFastMode_t* {.size: sizeof(cint).} = enum
      CUSOLVERRF_RESET_VALUES_FAST_MODE_OFF = 0, ## default
      CUSOLVERRF_RESET_VALUES_FAST_MODE_ON = 1
  ##  CUSOLVERRF matrix format
  type
    cusolverRfMatrixFormat_t* {.size: sizeof(cint).} = enum
      CUSOLVERRF_MATRIX_FORMAT_CSR = 0, ## default
      CUSOLVERRF_MATRIX_FORMAT_CSC = 1
  ##  CUSOLVERRF unit diagonal
  type
    cusolverRfUnitDiagonal_t* {.size: sizeof(cint).} = enum
      CUSOLVERRF_UNIT_DIAGONAL_STORED_L = 0, ## default
      CUSOLVERRF_UNIT_DIAGONAL_STORED_U = 1,
      CUSOLVERRF_UNIT_DIAGONAL_ASSUMED_L = 2,
      CUSOLVERRF_UNIT_DIAGONAL_ASSUMED_U = 3
  ##  CUSOLVERRF factorization algorithm
  type
    cusolverRfFactorization_t* {.size: sizeof(cint).} = enum
      CUSOLVERRF_FACTORIZATION_ALG0 = 0, ##  default
      CUSOLVERRF_FACTORIZATION_ALG1 = 1, CUSOLVERRF_FACTORIZATION_ALG2 = 2
  ##  CUSOLVERRF triangular solve algorithm
  type
    cusolverRfTriangularSolve_t* {.size: sizeof(cint).} = enum
      CUSOLVERRF_TRIANGULAR_SOLVE_ALG0 = 0, CUSOLVERRF_TRIANGULAR_SOLVE_ALG1 = 1, ##  default
      CUSOLVERRF_TRIANGULAR_SOLVE_ALG2 = 2, CUSOLVERRF_TRIANGULAR_SOLVE_ALG3 = 3
  ##  CUSOLVERRF numeric boost report
  type
    cusolverRfNumericBoostReport_t* {.size: sizeof(cint).} = enum
      CUSOLVERRF_NUMERIC_BOOST_NOT_USED = 0, ## default
      CUSOLVERRF_NUMERIC_BOOST_USED = 1
  ##  Opaque structure holding CUSOLVERRF library common
  type
    cusolverRfCommon* = object
    
  type
    cusolverRfHandle_t* = ptr cusolverRfCommon
  ##  CUSOLVERRF create (allocate memory) and destroy (free memory) in the handle
  proc cusolverRfCreate*(handle: ptr cusolverRfHandle_t): cusolverStatus_t {.cdecl,
      importc: "cusolverRfCreate", dyn.}
  proc cusolverRfDestroy*(handle: cusolverRfHandle_t): cusolverStatus_t {.cdecl,
      importc: "cusolverRfDestroy", dyn.}
  ##  CUSOLVERRF set and get input format
  proc cusolverRfGetMatrixFormat*(handle: cusolverRfHandle_t;
                                 format: ptr cusolverRfMatrixFormat_t;
                                 diag: ptr cusolverRfUnitDiagonal_t): cusolverStatus_t {.
      cdecl, importc: "cusolverRfGetMatrixFormat", dyn.}
  proc cusolverRfSetMatrixFormat*(handle: cusolverRfHandle_t;
                                 format: cusolverRfMatrixFormat_t;
                                 diag: cusolverRfUnitDiagonal_t): cusolverStatus_t {.
      cdecl, importc: "cusolverRfSetMatrixFormat", dyn.}
  ##  CUSOLVERRF set and get numeric properties
  proc cusolverRfSetNumericProperties*(handle: cusolverRfHandle_t; zero: cdouble;
                                      boost: cdouble): cusolverStatus_t {.cdecl,
      importc: "cusolverRfSetNumericProperties", dyn.}
  proc cusolverRfGetNumericProperties*(handle: cusolverRfHandle_t;
                                      zero: ptr cdouble; boost: ptr cdouble): cusolverStatus_t {.
      cdecl, importc: "cusolverRfGetNumericProperties", dyn.}
  proc cusolverRfGetNumericBoostReport*(handle: cusolverRfHandle_t; report: ptr cusolverRfNumericBoostReport_t): cusolverStatus_t {.
      cdecl, importc: "cusolverRfGetNumericBoostReport", dyn.}
  ##  CUSOLVERRF choose the triangular solve algorithm
  proc cusolverRfSetAlgs*(handle: cusolverRfHandle_t;
                         factAlg: cusolverRfFactorization_t;
                         solveAlg: cusolverRfTriangularSolve_t): cusolverStatus_t {.
      cdecl, importc: "cusolverRfSetAlgs", dyn.}
  proc cusolverRfGetAlgs*(handle: cusolverRfHandle_t;
                         factAlg: ptr cusolverRfFactorization_t;
                         solveAlg: ptr cusolverRfTriangularSolve_t): cusolverStatus_t {.
      cdecl, importc: "cusolverRfGetAlgs", dyn.}
  ##  CUSOLVERRF set and get fast mode
  proc cusolverRfGetResetValuesFastMode*(handle: cusolverRfHandle_t; fastMode: ptr cusolverRfResetValuesFastMode_t): cusolverStatus_t {.
      cdecl, importc: "cusolverRfGetResetValuesFastMode", dyn.}
  proc cusolverRfSetResetValuesFastMode*(handle: cusolverRfHandle_t; fastMode: cusolverRfResetValuesFastMode_t): cusolverStatus_t {.
      cdecl, importc: "cusolverRfSetResetValuesFastMode", dyn.}
  ## ** Non-Batched Routines **
  ##  CUSOLVERRF setup of internal structures from host or device memory
  proc cusolverRfSetupHost*(n: cint; nnzA: cint; h_csrRowPtrA: ptr cint;
                           h_csrColIndA: ptr cint; h_csrValA: ptr cdouble; nnzL: cint;
                           h_csrRowPtrL: ptr cint; h_csrColIndL: ptr cint;
                           h_csrValL: ptr cdouble; nnzU: cint;
                           h_csrRowPtrU: ptr cint; h_csrColIndU: ptr cint;
                           h_csrValU: ptr cdouble; h_P: ptr cint; h_Q: ptr cint;
                           handle: cusolverRfHandle_t): cusolverStatus_t {.cdecl,
      importc: "cusolverRfSetupHost", dyn.}
    ##  Input (in the host memory)
    ##  Output
  proc cusolverRfSetupDevice*(n: cint; nnzA: cint; csrRowPtrA: ptr cint;
                             csrColIndA: ptr cint; csrValA: ptr cdouble; nnzL: cint;
                             csrRowPtrL: ptr cint; csrColIndL: ptr cint;
                             csrValL: ptr cdouble; nnzU: cint; csrRowPtrU: ptr cint;
                             csrColIndU: ptr cint; csrValU: ptr cdouble; P: ptr cint;
                             Q: ptr cint; handle: cusolverRfHandle_t): cusolverStatus_t {.
      cdecl, importc: "cusolverRfSetupDevice", dyn.}
    ##  Input (in the device memory)
    ##  Output
  ##  CUSOLVERRF update the matrix values (assuming the reordering, pivoting 
  ##    and consequently the sparsity pattern of L and U did not change),
  ##    and zero out the remaining values.
  proc cusolverRfResetValues*(n: cint; nnzA: cint; csrRowPtrA: ptr cint;
                             csrColIndA: ptr cint; csrValA: ptr cdouble; P: ptr cint;
                             Q: ptr cint; handle: cusolverRfHandle_t): cusolverStatus_t {.
      cdecl, importc: "cusolverRfResetValues", dyn.}
    ##  Input (in the device memory)
    ##  Output
  ##  CUSOLVERRF analysis (for parallelism)
  proc cusolverRfAnalyze*(handle: cusolverRfHandle_t): cusolverStatus_t {.cdecl,
      importc: "cusolverRfAnalyze", dyn.}
  ##  CUSOLVERRF re-factorization (for parallelism)
  proc cusolverRfRefactor*(handle: cusolverRfHandle_t): cusolverStatus_t {.cdecl,
      importc: "cusolverRfRefactor", dyn.}
  ##  CUSOLVERRF extraction: Get L & U packed into a single matrix M
  proc cusolverRfAccessBundledFactorsDevice*(handle: cusolverRfHandle_t;
      nnzM: ptr cint; Mp: ptr ptr cint; Mi: ptr ptr cint; Mx: ptr ptr cdouble): cusolverStatus_t {.
      cdecl, importc: "cusolverRfAccessBundledFactorsDevice", dyn.}
    ##  Input
    ##  Output (in the host memory)
    ##  Output (in the device memory)
  proc cusolverRfExtractBundledFactorsHost*(handle: cusolverRfHandle_t;
      h_nnzM: ptr cint; h_Mp: ptr ptr cint; h_Mi: ptr ptr cint; h_Mx: ptr ptr cdouble): cusolverStatus_t {.
      cdecl, importc: "cusolverRfExtractBundledFactorsHost", dyn.}
    ##  Input
    ##  Output (in the host memory)
  ##  CUSOLVERRF extraction: Get L & U individually
  proc cusolverRfExtractSplitFactorsHost*(handle: cusolverRfHandle_t;
      h_nnzL: ptr cint; h_csrRowPtrL: ptr ptr cint; h_csrColIndL: ptr ptr cint;
      h_csrValL: ptr ptr cdouble; h_nnzU: ptr cint; h_csrRowPtrU: ptr ptr cint;
      h_csrColIndU: ptr ptr cint; h_csrValU: ptr ptr cdouble): cusolverStatus_t {.cdecl,
      importc: "cusolverRfExtractSplitFactorsHost", dyn.}
    ##  Input
    ##  Output (in the host memory)
  ##  CUSOLVERRF (forward and backward triangular) solves
  proc cusolverRfSolve*(handle: cusolverRfHandle_t; P: ptr cint; Q: ptr cint; nrhs: cint;
                       Temp: ptr cdouble; ldt: cint; XF: ptr cdouble; ldxf: cint): cusolverStatus_t {.
      cdecl, importc: "cusolverRfSolve", dyn.}
    ##  Input (in the device memory)
    ## only nrhs=1 is supported
    ## of size ldt*nrhs (ldt>=n)
    ##  Input/Output (in the device memory)
    ##  Input
  ## ** Batched Routines **
  ##  CUSOLVERRF-batch setup of internal structures from host
  proc cusolverRfBatchSetupHost*(batchSize: cint; n: cint; nnzA: cint;
                                h_csrRowPtrA: ptr cint; h_csrColIndA: ptr cint;
                                h_csrValA_array: ptr ptr cdouble; nnzL: cint;
                                h_csrRowPtrL: ptr cint; h_csrColIndL: ptr cint;
                                h_csrValL: ptr cdouble; nnzU: cint;
                                h_csrRowPtrU: ptr cint; h_csrColIndU: ptr cint;
                                h_csrValU: ptr cdouble; h_P: ptr cint; h_Q: ptr cint;
                                handle: cusolverRfHandle_t): cusolverStatus_t {.
      cdecl, importc: "cusolverRfBatchSetupHost", dyn.}
    ##  Input (in the host memory)
    ##  Output (in the device memory)
  ##  CUSOLVERRF-batch update the matrix values (assuming the reordering, pivoting 
  ##    and consequently the sparsity pattern of L and U did not change),
  ##    and zero out the remaining values.
  proc cusolverRfBatchResetValues*(batchSize: cint; n: cint; nnzA: cint;
                                  csrRowPtrA: ptr cint; csrColIndA: ptr cint;
                                  csrValA_array: ptr ptr cdouble; P: ptr cint;
                                  Q: ptr cint; handle: cusolverRfHandle_t): cusolverStatus_t {.
      cdecl, importc: "cusolverRfBatchResetValues", dyn.}
    ##  Input (in the device memory)
    ##  Output
  ##  CUSOLVERRF-batch analysis (for parallelism)
  proc cusolverRfBatchAnalyze*(handle: cusolverRfHandle_t): cusolverStatus_t {.
      cdecl, importc: "cusolverRfBatchAnalyze", dyn.}
  ##  CUSOLVERRF-batch re-factorization (for parallelism)
  proc cusolverRfBatchRefactor*(handle: cusolverRfHandle_t): cusolverStatus_t {.
      cdecl, importc: "cusolverRfBatchRefactor", dyn.}
  ##  CUSOLVERRF-batch (forward and backward triangular) solves
  proc cusolverRfBatchSolve*(handle: cusolverRfHandle_t; P: ptr cint; Q: ptr cint;
                            nrhs: cint; Temp: ptr cdouble; ldt: cint;
                            XF_array: ptr ptr cdouble; ldxf: cint): cusolverStatus_t {.
      cdecl, importc: "cusolverRfBatchSolve", dyn.}
    ##  Input (in the device memory)
    ## only nrhs=1 is supported
    ## of size 2*batchSize*(n*nrhs)
    ## only ldt=n is supported
    ##  Input/Output (in the device memory)
    ##  Input
  ##  CUSOLVERRF-batch obtain the position of zero pivot
  proc cusolverRfBatchZeroPivot*(handle: cusolverRfHandle_t; position: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverRfBatchZeroPivot", dyn.}
    ##  Input
    ##  Output (in the host memory)