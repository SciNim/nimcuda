when defined(windows):
  const
    libName = "cusolver.dll"
elif defined(macosx):
  const
    libName = "libcusolver.dylib"
else:
  const
    libName = "libcusolver.so"
import
  cuComplex, cublas_api, cusolver_common, library_types, driver_types

##
##  Copyright 2014 NVIDIA Corporation.  All rights reserved.
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
##    cuSolverDN : Dense Linear Algebra Library
##
##

when not defined(CUSOLVERDN_H):
  type cusolverDnContext {.nodecl.} = object
  type
    cusolverDnHandle_t* = ptr cusolverDnContext
  type syevjInfo {.nodecl.} = object
  type
    syevjInfo_t* = ptr syevjInfo
  type gesvdjInfo {.nodecl.} = object
  type
    gesvdjInfo_t* = ptr gesvdjInfo
  ## ------------------------------------------------------
  ##  opaque cusolverDnIRS structure for IRS solver
  type cusolverDnIRSParams {.nodecl.} = object
  type
    cusolverDnIRSParams_t* = ptr cusolverDnIRSParams
  type cusolverDnIRSInfos {.nodecl.} = object
  type
    cusolverDnIRSInfos_t* = ptr cusolverDnIRSInfos
  ## ------------------------------------------------------
  type cusolverDnParams {.nodecl.} = object
  type
    cusolverDnParams_t* = ptr cusolverDnParams
    cusolverDnFunction_t* {.size: sizeof(cint).} = enum
      CUSOLVERDN_GETRF = 0, CUSOLVERDN_POTRF = 1
    cusolverDeterministicMode_t* {.size: sizeof(cint).} = enum
      CUSOLVER_DETERMINISTIC_RESULTS = 1,
      CUSOLVER_ALLOW_NON_DETERMINISTIC_RESULTS = 2
  ## ****************************************************************************
  proc cusolverDnCreateUnderScore*(handle: ptr cusolverDnHandle_t): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnCreate", dynlib: libName.}
  proc cusolverDnDestroyUnderScore*(handle: cusolverDnHandle_t): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnDestroy", dynlib: libName.}
  proc cusolverDnSetStreamUnderScore*(handle: cusolverDnHandle_t; streamId: cudaStream_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnSetStream", dynlib: libName.}
  proc cusolverDnGetStreamUnderScore*(handle: cusolverDnHandle_t; streamId: ptr cudaStream_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnGetStream", dynlib: libName.}
  ## ============================================================
  ##  Deterministic Mode
  ## ============================================================
  proc cusolverDnSetDeterministicModeUnderScore*(handle: cusolverDnHandle_t;
                                      mode: cusolverDeterministicMode_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnSetDeterministicMode", dynlib: libName.}
  proc cusolverDnGetDeterministicModeUnderScore*(handle: cusolverDnHandle_t;
                                      mode: ptr cusolverDeterministicMode_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnGetDeterministicMode", dynlib: libName.}
  ## ============================================================
  ##  IRS headers
  ## ============================================================
  ##  =============================================================================
  ##  IRS helper function API
  ##  =============================================================================
  proc cusolverDnIRSParamsCreateUnderScore*(params_ptr: ptr cusolverDnIRSParams_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnIRSParamsCreate", dynlib: libName.}
  proc cusolverDnIRSParamsDestroyUnderScore*(params: cusolverDnIRSParams_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnIRSParamsDestroy", dynlib: libName.}
  proc cusolverDnIRSParamsSetRefinementSolverUnderScore*(params: cusolverDnIRSParams_t;
      refinement_solver: cusolverIRSRefinement_t): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnIRSParamsSetRefinementSolver", dynlib: libName.}
  proc cusolverDnIRSParamsSetSolverMainPrecisionUnderScore*(params: cusolverDnIRSParams_t;
      solver_main_precision: cusolverPrecType_t): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnIRSParamsSetSolverMainPrecision", dynlib: libName.}
  proc cusolverDnIRSParamsSetSolverLowestPrecisionUnderScore*(
      params: cusolverDnIRSParams_t; solver_lowest_precision: cusolverPrecType_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnIRSParamsSetSolverLowestPrecision",
      dynlib: libName.}
  proc cusolverDnIRSParamsSetSolverPrecisionsUnderScore*(params: cusolverDnIRSParams_t;
      solver_main_precision: cusolverPrecType_t;
      solver_lowest_precision: cusolverPrecType_t): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnIRSParamsSetSolverPrecisions", dynlib: libName.}
  proc cusolverDnIRSParamsSetTolUnderScore*(params: cusolverDnIRSParams_t; val: cdouble): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnIRSParamsSetTol", dynlib: libName.}
  proc cusolverDnIRSParamsSetTolInnerUnderScore*(params: cusolverDnIRSParams_t; val: cdouble): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnIRSParamsSetTolInner", dynlib: libName.}
  proc cusolverDnIRSParamsSetMaxItersUnderScore*(params: cusolverDnIRSParams_t;
                                      maxiters: cusolver_int_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnIRSParamsSetMaxIters", dynlib: libName.}
  proc cusolverDnIRSParamsSetMaxItersInnerUnderScore*(params: cusolverDnIRSParams_t;
      maxiters_inner: cusolver_int_t): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnIRSParamsSetMaxItersInner", dynlib: libName.}
  proc cusolverDnIRSParamsGetMaxItersUnderScore*(params: cusolverDnIRSParams_t;
                                      maxiters: ptr cusolver_int_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnIRSParamsGetMaxIters", dynlib: libName.}
  proc cusolverDnIRSParamsEnableFallbackUnderScore*(params: cusolverDnIRSParams_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnIRSParamsEnableFallback", dynlib: libName.}
  proc cusolverDnIRSParamsDisableFallbackUnderScore*(params: cusolverDnIRSParams_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnIRSParamsDisableFallback", dynlib: libName.}
  ##  =============================================================================
  ##  cusolverDnIRSInfos prototypes
  ##  =============================================================================
  proc cusolverDnIRSInfosDestroyUnderScore*(infos: cusolverDnIRSInfos_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnIRSInfosDestroy", dynlib: libName.}
  proc cusolverDnIRSInfosCreateUnderScore*(infos_ptr: ptr cusolverDnIRSInfos_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnIRSInfosCreate", dynlib: libName.}
  proc cusolverDnIRSInfosGetNitersUnderScore*(infos: cusolverDnIRSInfos_t;
                                   niters: ptr cusolver_int_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnIRSInfosGetNiters", dynlib: libName.}
  proc cusolverDnIRSInfosGetOuterNitersUnderScore*(infos: cusolverDnIRSInfos_t;
                                        outer_niters: ptr cusolver_int_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnIRSInfosGetOuterNiters", dynlib: libName.}
  proc cusolverDnIRSInfosRequestResidualUnderScore*(infos: cusolverDnIRSInfos_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnIRSInfosRequestResidual", dynlib: libName.}
  proc cusolverDnIRSInfosGetResidualHistoryUnderScore*(infos: cusolverDnIRSInfos_t;
      residual_history: ptr pointer): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnIRSInfosGetResidualHistory", dynlib: libName.}
  proc cusolverDnIRSInfosGetMaxItersUnderScore*(infos: cusolverDnIRSInfos_t;
                                     maxiters: ptr cusolver_int_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnIRSInfosGetMaxIters", dynlib: libName.}
  ## ============================================================
  ##   IRS functions API
  ## ============================================================
  ## ****************************************************************************
  ##
  ##  [ZZ, ZC, ZK, ZE, ZY, CC, CK, CE, CY, DD, DS, DH, DB, DX, SS, SH, SB, SX]gesv
  ##  users API Prototypes
  ## ****************************************************************************
  proc cusolverDnZZgesvUnderScore*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                        nrhs: cusolver_int_t; dA: ptr cuDoubleComplex;
                        ldda: cusolver_int_t; dipiv: ptr cusolver_int_t;
                        dB: ptr cuDoubleComplex; lddb: cusolver_int_t;
                        dX: ptr cuDoubleComplex; lddx: cusolver_int_t;
                        dWorkspace: pointer; lwork_bytes: csize_t;
                        iter: ptr cusolver_int_t; d_info: ptr cusolver_int_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZZgesv", dynlib: libName.}
  proc cusolverDnZCgesvUnderScore*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                        nrhs: cusolver_int_t; dA: ptr cuDoubleComplex;
                        ldda: cusolver_int_t; dipiv: ptr cusolver_int_t;
                        dB: ptr cuDoubleComplex; lddb: cusolver_int_t;
                        dX: ptr cuDoubleComplex; lddx: cusolver_int_t;
                        dWorkspace: pointer; lwork_bytes: csize_t;
                        iter: ptr cusolver_int_t; d_info: ptr cusolver_int_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZCgesv", dynlib: libName.}
  proc cusolverDnZKgesvUnderScore*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                        nrhs: cusolver_int_t; dA: ptr cuDoubleComplex;
                        ldda: cusolver_int_t; dipiv: ptr cusolver_int_t;
                        dB: ptr cuDoubleComplex; lddb: cusolver_int_t;
                        dX: ptr cuDoubleComplex; lddx: cusolver_int_t;
                        dWorkspace: pointer; lwork_bytes: csize_t;
                        iter: ptr cusolver_int_t; d_info: ptr cusolver_int_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZKgesv", dynlib: libName.}
  proc cusolverDnZEgesvUnderScore*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                        nrhs: cusolver_int_t; dA: ptr cuDoubleComplex;
                        ldda: cusolver_int_t; dipiv: ptr cusolver_int_t;
                        dB: ptr cuDoubleComplex; lddb: cusolver_int_t;
                        dX: ptr cuDoubleComplex; lddx: cusolver_int_t;
                        dWorkspace: pointer; lwork_bytes: csize_t;
                        iter: ptr cusolver_int_t; d_info: ptr cusolver_int_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZEgesv", dynlib: libName.}
  proc cusolverDnZYgesvUnderScore*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                        nrhs: cusolver_int_t; dA: ptr cuDoubleComplex;
                        ldda: cusolver_int_t; dipiv: ptr cusolver_int_t;
                        dB: ptr cuDoubleComplex; lddb: cusolver_int_t;
                        dX: ptr cuDoubleComplex; lddx: cusolver_int_t;
                        dWorkspace: pointer; lwork_bytes: csize_t;
                        iter: ptr cusolver_int_t; d_info: ptr cusolver_int_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZYgesv", dynlib: libName.}
  proc cusolverDnCCgesvUnderScore*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                        nrhs: cusolver_int_t; dA: ptr cuComplex;
                        ldda: cusolver_int_t; dipiv: ptr cusolver_int_t;
                        dB: ptr cuComplex; lddb: cusolver_int_t; dX: ptr cuComplex;
                        lddx: cusolver_int_t; dWorkspace: pointer;
                        lwork_bytes: csize_t; iter: ptr cusolver_int_t;
                        d_info: ptr cusolver_int_t): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnCCgesv", dynlib: libName.}
  proc cusolverDnCEgesvUnderScore*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                        nrhs: cusolver_int_t; dA: ptr cuComplex;
                        ldda: cusolver_int_t; dipiv: ptr cusolver_int_t;
                        dB: ptr cuComplex; lddb: cusolver_int_t; dX: ptr cuComplex;
                        lddx: cusolver_int_t; dWorkspace: pointer;
                        lwork_bytes: csize_t; iter: ptr cusolver_int_t;
                        d_info: ptr cusolver_int_t): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnCEgesv", dynlib: libName.}
  proc cusolverDnCKgesvUnderScore*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                        nrhs: cusolver_int_t; dA: ptr cuComplex;
                        ldda: cusolver_int_t; dipiv: ptr cusolver_int_t;
                        dB: ptr cuComplex; lddb: cusolver_int_t; dX: ptr cuComplex;
                        lddx: cusolver_int_t; dWorkspace: pointer;
                        lwork_bytes: csize_t; iter: ptr cusolver_int_t;
                        d_info: ptr cusolver_int_t): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnCKgesv", dynlib: libName.}
  proc cusolverDnCYgesvUnderScore*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                        nrhs: cusolver_int_t; dA: ptr cuComplex;
                        ldda: cusolver_int_t; dipiv: ptr cusolver_int_t;
                        dB: ptr cuComplex; lddb: cusolver_int_t; dX: ptr cuComplex;
                        lddx: cusolver_int_t; dWorkspace: pointer;
                        lwork_bytes: csize_t; iter: ptr cusolver_int_t;
                        d_info: ptr cusolver_int_t): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnCYgesv", dynlib: libName.}
  proc cusolverDnDDgesvUnderScore*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                        nrhs: cusolver_int_t; dA: ptr cdouble; ldda: cusolver_int_t;
                        dipiv: ptr cusolver_int_t; dB: ptr cdouble;
                        lddb: cusolver_int_t; dX: ptr cdouble; lddx: cusolver_int_t;
                        dWorkspace: pointer; lwork_bytes: csize_t;
                        iter: ptr cusolver_int_t; d_info: ptr cusolver_int_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnDDgesv", dynlib: libName.}
  proc cusolverDnDSgesvUnderScore*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                        nrhs: cusolver_int_t; dA: ptr cdouble; ldda: cusolver_int_t;
                        dipiv: ptr cusolver_int_t; dB: ptr cdouble;
                        lddb: cusolver_int_t; dX: ptr cdouble; lddx: cusolver_int_t;
                        dWorkspace: pointer; lwork_bytes: csize_t;
                        iter: ptr cusolver_int_t; d_info: ptr cusolver_int_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnDSgesv", dynlib: libName.}
  proc cusolverDnDHgesvUnderScore*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                        nrhs: cusolver_int_t; dA: ptr cdouble; ldda: cusolver_int_t;
                        dipiv: ptr cusolver_int_t; dB: ptr cdouble;
                        lddb: cusolver_int_t; dX: ptr cdouble; lddx: cusolver_int_t;
                        dWorkspace: pointer; lwork_bytes: csize_t;
                        iter: ptr cusolver_int_t; d_info: ptr cusolver_int_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnDHgesv", dynlib: libName.}
  proc cusolverDnDBgesvUnderScore*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                        nrhs: cusolver_int_t; dA: ptr cdouble; ldda: cusolver_int_t;
                        dipiv: ptr cusolver_int_t; dB: ptr cdouble;
                        lddb: cusolver_int_t; dX: ptr cdouble; lddx: cusolver_int_t;
                        dWorkspace: pointer; lwork_bytes: csize_t;
                        iter: ptr cusolver_int_t; d_info: ptr cusolver_int_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnDBgesv", dynlib: libName.}
  proc cusolverDnDXgesvUnderScore*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                        nrhs: cusolver_int_t; dA: ptr cdouble; ldda: cusolver_int_t;
                        dipiv: ptr cusolver_int_t; dB: ptr cdouble;
                        lddb: cusolver_int_t; dX: ptr cdouble; lddx: cusolver_int_t;
                        dWorkspace: pointer; lwork_bytes: csize_t;
                        iter: ptr cusolver_int_t; d_info: ptr cusolver_int_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnDXgesv", dynlib: libName.}
  proc cusolverDnSSgesvUnderScore*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                        nrhs: cusolver_int_t; dA: ptr cfloat; ldda: cusolver_int_t;
                        dipiv: ptr cusolver_int_t; dB: ptr cfloat;
                        lddb: cusolver_int_t; dX: ptr cfloat; lddx: cusolver_int_t;
                        dWorkspace: pointer; lwork_bytes: csize_t;
                        iter: ptr cusolver_int_t; d_info: ptr cusolver_int_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnSSgesv", dynlib: libName.}
  proc cusolverDnSHgesvUnderScore*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                        nrhs: cusolver_int_t; dA: ptr cfloat; ldda: cusolver_int_t;
                        dipiv: ptr cusolver_int_t; dB: ptr cfloat;
                        lddb: cusolver_int_t; dX: ptr cfloat; lddx: cusolver_int_t;
                        dWorkspace: pointer; lwork_bytes: csize_t;
                        iter: ptr cusolver_int_t; d_info: ptr cusolver_int_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnSHgesv", dynlib: libName.}
  proc cusolverDnSBgesvUnderScore*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                        nrhs: cusolver_int_t; dA: ptr cfloat; ldda: cusolver_int_t;
                        dipiv: ptr cusolver_int_t; dB: ptr cfloat;
                        lddb: cusolver_int_t; dX: ptr cfloat; lddx: cusolver_int_t;
                        dWorkspace: pointer; lwork_bytes: csize_t;
                        iter: ptr cusolver_int_t; d_info: ptr cusolver_int_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnSBgesv", dynlib: libName.}
  proc cusolverDnSXgesvUnderScore*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                        nrhs: cusolver_int_t; dA: ptr cfloat; ldda: cusolver_int_t;
                        dipiv: ptr cusolver_int_t; dB: ptr cfloat;
                        lddb: cusolver_int_t; dX: ptr cfloat; lddx: cusolver_int_t;
                        dWorkspace: pointer; lwork_bytes: csize_t;
                        iter: ptr cusolver_int_t; d_info: ptr cusolver_int_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnSXgesv", dynlib: libName.}
  ## ****************************************************************************
  ## ****************************************************************************
  ##
  ##  [ZZ, ZC, ZK, ZE, ZY, CC, CK, CE, CY, DD, DS, DH, DB, DX, SS, SH, SB, SX]gesv_bufferSize
  ##  users API Prototypes
  ## ****************************************************************************
  proc cusolverDnZZgesv_bufferSizeUnderScore*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                                   nrhs: cusolver_int_t; dA: ptr cuDoubleComplex;
                                   ldda: cusolver_int_t;
                                   dipiv: ptr cusolver_int_t;
                                   dB: ptr cuDoubleComplex; lddb: cusolver_int_t;
                                   dX: ptr cuDoubleComplex; lddx: cusolver_int_t;
                                   dWorkspace: pointer; lwork_bytes: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZZgesv_bufferSize", dynlib: libName.}
  proc cusolverDnZCgesv_bufferSizeUnderScore*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                                   nrhs: cusolver_int_t; dA: ptr cuDoubleComplex;
                                   ldda: cusolver_int_t;
                                   dipiv: ptr cusolver_int_t;
                                   dB: ptr cuDoubleComplex; lddb: cusolver_int_t;
                                   dX: ptr cuDoubleComplex; lddx: cusolver_int_t;
                                   dWorkspace: pointer; lwork_bytes: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZCgesv_bufferSize", dynlib: libName.}
  proc cusolverDnZKgesv_bufferSizeUnderScore*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                                   nrhs: cusolver_int_t; dA: ptr cuDoubleComplex;
                                   ldda: cusolver_int_t;
                                   dipiv: ptr cusolver_int_t;
                                   dB: ptr cuDoubleComplex; lddb: cusolver_int_t;
                                   dX: ptr cuDoubleComplex; lddx: cusolver_int_t;
                                   dWorkspace: pointer; lwork_bytes: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZKgesv_bufferSize", dynlib: libName.}
  proc cusolverDnZEgesv_bufferSizeUnderScore*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                                   nrhs: cusolver_int_t; dA: ptr cuDoubleComplex;
                                   ldda: cusolver_int_t;
                                   dipiv: ptr cusolver_int_t;
                                   dB: ptr cuDoubleComplex; lddb: cusolver_int_t;
                                   dX: ptr cuDoubleComplex; lddx: cusolver_int_t;
                                   dWorkspace: pointer; lwork_bytes: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZEgesv_bufferSize", dynlib: libName.}
  proc cusolverDnZYgesv_bufferSizeUnderScore*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                                   nrhs: cusolver_int_t; dA: ptr cuDoubleComplex;
                                   ldda: cusolver_int_t;
                                   dipiv: ptr cusolver_int_t;
                                   dB: ptr cuDoubleComplex; lddb: cusolver_int_t;
                                   dX: ptr cuDoubleComplex; lddx: cusolver_int_t;
                                   dWorkspace: pointer; lwork_bytes: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZYgesv_bufferSize", dynlib: libName.}
  proc cusolverDnCCgesv_bufferSizeUnderScore*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                                   nrhs: cusolver_int_t; dA: ptr cuComplex;
                                   ldda: cusolver_int_t;
                                   dipiv: ptr cusolver_int_t; dB: ptr cuComplex;
                                   lddb: cusolver_int_t; dX: ptr cuComplex;
                                   lddx: cusolver_int_t; dWorkspace: pointer;
                                   lwork_bytes: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnCCgesv_bufferSize", dynlib: libName.}
  proc cusolverDnCKgesv_bufferSizeUnderScore*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                                   nrhs: cusolver_int_t; dA: ptr cuComplex;
                                   ldda: cusolver_int_t;
                                   dipiv: ptr cusolver_int_t; dB: ptr cuComplex;
                                   lddb: cusolver_int_t; dX: ptr cuComplex;
                                   lddx: cusolver_int_t; dWorkspace: pointer;
                                   lwork_bytes: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnCKgesv_bufferSize", dynlib: libName.}
  proc cusolverDnCEgesv_bufferSizeUnderScore*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                                   nrhs: cusolver_int_t; dA: ptr cuComplex;
                                   ldda: cusolver_int_t;
                                   dipiv: ptr cusolver_int_t; dB: ptr cuComplex;
                                   lddb: cusolver_int_t; dX: ptr cuComplex;
                                   lddx: cusolver_int_t; dWorkspace: pointer;
                                   lwork_bytes: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnCEgesv_bufferSize", dynlib: libName.}
  proc cusolverDnCYgesv_bufferSizeUnderScore*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                                   nrhs: cusolver_int_t; dA: ptr cuComplex;
                                   ldda: cusolver_int_t;
                                   dipiv: ptr cusolver_int_t; dB: ptr cuComplex;
                                   lddb: cusolver_int_t; dX: ptr cuComplex;
                                   lddx: cusolver_int_t; dWorkspace: pointer;
                                   lwork_bytes: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnCYgesv_bufferSize", dynlib: libName.}
  proc cusolverDnDDgesv_bufferSizeUnderScore*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                                   nrhs: cusolver_int_t; dA: ptr cdouble;
                                   ldda: cusolver_int_t;
                                   dipiv: ptr cusolver_int_t; dB: ptr cdouble;
                                   lddb: cusolver_int_t; dX: ptr cdouble;
                                   lddx: cusolver_int_t; dWorkspace: pointer;
                                   lwork_bytes: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnDDgesv_bufferSize", dynlib: libName.}
  proc cusolverDnDSgesv_bufferSizeUnderScore*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                                   nrhs: cusolver_int_t; dA: ptr cdouble;
                                   ldda: cusolver_int_t;
                                   dipiv: ptr cusolver_int_t; dB: ptr cdouble;
                                   lddb: cusolver_int_t; dX: ptr cdouble;
                                   lddx: cusolver_int_t; dWorkspace: pointer;
                                   lwork_bytes: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnDSgesv_bufferSize", dynlib: libName.}
  proc cusolverDnDHgesv_bufferSizeUnderScore*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                                   nrhs: cusolver_int_t; dA: ptr cdouble;
                                   ldda: cusolver_int_t;
                                   dipiv: ptr cusolver_int_t; dB: ptr cdouble;
                                   lddb: cusolver_int_t; dX: ptr cdouble;
                                   lddx: cusolver_int_t; dWorkspace: pointer;
                                   lwork_bytes: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnDHgesv_bufferSize", dynlib: libName.}
  proc cusolverDnDBgesv_bufferSizeUnderScore*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                                   nrhs: cusolver_int_t; dA: ptr cdouble;
                                   ldda: cusolver_int_t;
                                   dipiv: ptr cusolver_int_t; dB: ptr cdouble;
                                   lddb: cusolver_int_t; dX: ptr cdouble;
                                   lddx: cusolver_int_t; dWorkspace: pointer;
                                   lwork_bytes: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnDBgesv_bufferSize", dynlib: libName.}
  proc cusolverDnDXgesv_bufferSizeUnderScore*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                                   nrhs: cusolver_int_t; dA: ptr cdouble;
                                   ldda: cusolver_int_t;
                                   dipiv: ptr cusolver_int_t; dB: ptr cdouble;
                                   lddb: cusolver_int_t; dX: ptr cdouble;
                                   lddx: cusolver_int_t; dWorkspace: pointer;
                                   lwork_bytes: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnDXgesv_bufferSize", dynlib: libName.}
  proc cusolverDnSSgesv_bufferSizeUnderScore*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                                   nrhs: cusolver_int_t; dA: ptr cfloat;
                                   ldda: cusolver_int_t;
                                   dipiv: ptr cusolver_int_t; dB: ptr cfloat;
                                   lddb: cusolver_int_t; dX: ptr cfloat;
                                   lddx: cusolver_int_t; dWorkspace: pointer;
                                   lwork_bytes: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnSSgesv_bufferSize", dynlib: libName.}
  proc cusolverDnSHgesv_bufferSizeUnderScore*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                                   nrhs: cusolver_int_t; dA: ptr cfloat;
                                   ldda: cusolver_int_t;
                                   dipiv: ptr cusolver_int_t; dB: ptr cfloat;
                                   lddb: cusolver_int_t; dX: ptr cfloat;
                                   lddx: cusolver_int_t; dWorkspace: pointer;
                                   lwork_bytes: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnSHgesv_bufferSize", dynlib: libName.}
  proc cusolverDnSBgesv_bufferSizeUnderScore*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                                   nrhs: cusolver_int_t; dA: ptr cfloat;
                                   ldda: cusolver_int_t;
                                   dipiv: ptr cusolver_int_t; dB: ptr cfloat;
                                   lddb: cusolver_int_t; dX: ptr cfloat;
                                   lddx: cusolver_int_t; dWorkspace: pointer;
                                   lwork_bytes: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnSBgesv_bufferSize", dynlib: libName.}
  proc cusolverDnSXgesv_bufferSizeUnderScore*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                                   nrhs: cusolver_int_t; dA: ptr cfloat;
                                   ldda: cusolver_int_t;
                                   dipiv: ptr cusolver_int_t; dB: ptr cfloat;
                                   lddb: cusolver_int_t; dX: ptr cfloat;
                                   lddx: cusolver_int_t; dWorkspace: pointer;
                                   lwork_bytes: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnSXgesv_bufferSize", dynlib: libName.}
  ## ****************************************************************************
  ## ****************************************************************************
  ##
  ##  [ZZ, ZC, ZK, ZE, ZY, CC, CK, CE, CY, DD, DS, DH, DB, DX, SS, SH, SB, SX]gels
  ##  users API Prototypes
  ## ****************************************************************************
  proc cusolverDnZZgelsUnderScore*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                        n: cusolver_int_t; nrhs: cusolver_int_t;
                        dA: ptr cuDoubleComplex; ldda: cusolver_int_t;
                        dB: ptr cuDoubleComplex; lddb: cusolver_int_t;
                        dX: ptr cuDoubleComplex; lddx: cusolver_int_t;
                        dWorkspace: pointer; lwork_bytes: csize_t;
                        iter: ptr cusolver_int_t; d_info: ptr cusolver_int_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZZgels", dynlib: libName.}
  proc cusolverDnZCgelsUnderScore*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                        n: cusolver_int_t; nrhs: cusolver_int_t;
                        dA: ptr cuDoubleComplex; ldda: cusolver_int_t;
                        dB: ptr cuDoubleComplex; lddb: cusolver_int_t;
                        dX: ptr cuDoubleComplex; lddx: cusolver_int_t;
                        dWorkspace: pointer; lwork_bytes: csize_t;
                        iter: ptr cusolver_int_t; d_info: ptr cusolver_int_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZCgels", dynlib: libName.}
  proc cusolverDnZKgelsUnderScore*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                        n: cusolver_int_t; nrhs: cusolver_int_t;
                        dA: ptr cuDoubleComplex; ldda: cusolver_int_t;
                        dB: ptr cuDoubleComplex; lddb: cusolver_int_t;
                        dX: ptr cuDoubleComplex; lddx: cusolver_int_t;
                        dWorkspace: pointer; lwork_bytes: csize_t;
                        iter: ptr cusolver_int_t; d_info: ptr cusolver_int_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZKgels", dynlib: libName.}
  proc cusolverDnZEgelsUnderScore*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                        n: cusolver_int_t; nrhs: cusolver_int_t;
                        dA: ptr cuDoubleComplex; ldda: cusolver_int_t;
                        dB: ptr cuDoubleComplex; lddb: cusolver_int_t;
                        dX: ptr cuDoubleComplex; lddx: cusolver_int_t;
                        dWorkspace: pointer; lwork_bytes: csize_t;
                        iter: ptr cusolver_int_t; d_info: ptr cusolver_int_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZEgels", dynlib: libName.}
  proc cusolverDnZYgelsUnderScore*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                        n: cusolver_int_t; nrhs: cusolver_int_t;
                        dA: ptr cuDoubleComplex; ldda: cusolver_int_t;
                        dB: ptr cuDoubleComplex; lddb: cusolver_int_t;
                        dX: ptr cuDoubleComplex; lddx: cusolver_int_t;
                        dWorkspace: pointer; lwork_bytes: csize_t;
                        iter: ptr cusolver_int_t; d_info: ptr cusolver_int_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZYgels", dynlib: libName.}
  proc cusolverDnCCgelsUnderScore*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                        n: cusolver_int_t; nrhs: cusolver_int_t; dA: ptr cuComplex;
                        ldda: cusolver_int_t; dB: ptr cuComplex;
                        lddb: cusolver_int_t; dX: ptr cuComplex;
                        lddx: cusolver_int_t; dWorkspace: pointer;
                        lwork_bytes: csize_t; iter: ptr cusolver_int_t;
                        d_info: ptr cusolver_int_t): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnCCgels", dynlib: libName.}
  proc cusolverDnCKgelsUnderScore*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                        n: cusolver_int_t; nrhs: cusolver_int_t; dA: ptr cuComplex;
                        ldda: cusolver_int_t; dB: ptr cuComplex;
                        lddb: cusolver_int_t; dX: ptr cuComplex;
                        lddx: cusolver_int_t; dWorkspace: pointer;
                        lwork_bytes: csize_t; iter: ptr cusolver_int_t;
                        d_info: ptr cusolver_int_t): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnCKgels", dynlib: libName.}
  proc cusolverDnCEgelsUnderScore*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                        n: cusolver_int_t; nrhs: cusolver_int_t; dA: ptr cuComplex;
                        ldda: cusolver_int_t; dB: ptr cuComplex;
                        lddb: cusolver_int_t; dX: ptr cuComplex;
                        lddx: cusolver_int_t; dWorkspace: pointer;
                        lwork_bytes: csize_t; iter: ptr cusolver_int_t;
                        d_info: ptr cusolver_int_t): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnCEgels", dynlib: libName.}
  proc cusolverDnCYgelsUnderScore*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                        n: cusolver_int_t; nrhs: cusolver_int_t; dA: ptr cuComplex;
                        ldda: cusolver_int_t; dB: ptr cuComplex;
                        lddb: cusolver_int_t; dX: ptr cuComplex;
                        lddx: cusolver_int_t; dWorkspace: pointer;
                        lwork_bytes: csize_t; iter: ptr cusolver_int_t;
                        d_info: ptr cusolver_int_t): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnCYgels", dynlib: libName.}
  proc cusolverDnDDgelsUnderScore*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                        n: cusolver_int_t; nrhs: cusolver_int_t; dA: ptr cdouble;
                        ldda: cusolver_int_t; dB: ptr cdouble; lddb: cusolver_int_t;
                        dX: ptr cdouble; lddx: cusolver_int_t; dWorkspace: pointer;
                        lwork_bytes: csize_t; iter: ptr cusolver_int_t;
                        d_info: ptr cusolver_int_t): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnDDgels", dynlib: libName.}
  proc cusolverDnDSgelsUnderScore*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                        n: cusolver_int_t; nrhs: cusolver_int_t; dA: ptr cdouble;
                        ldda: cusolver_int_t; dB: ptr cdouble; lddb: cusolver_int_t;
                        dX: ptr cdouble; lddx: cusolver_int_t; dWorkspace: pointer;
                        lwork_bytes: csize_t; iter: ptr cusolver_int_t;
                        d_info: ptr cusolver_int_t): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnDSgels", dynlib: libName.}
  proc cusolverDnDHgelsUnderScore*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                        n: cusolver_int_t; nrhs: cusolver_int_t; dA: ptr cdouble;
                        ldda: cusolver_int_t; dB: ptr cdouble; lddb: cusolver_int_t;
                        dX: ptr cdouble; lddx: cusolver_int_t; dWorkspace: pointer;
                        lwork_bytes: csize_t; iter: ptr cusolver_int_t;
                        d_info: ptr cusolver_int_t): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnDHgels", dynlib: libName.}
  proc cusolverDnDBgelsUnderScore*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                        n: cusolver_int_t; nrhs: cusolver_int_t; dA: ptr cdouble;
                        ldda: cusolver_int_t; dB: ptr cdouble; lddb: cusolver_int_t;
                        dX: ptr cdouble; lddx: cusolver_int_t; dWorkspace: pointer;
                        lwork_bytes: csize_t; iter: ptr cusolver_int_t;
                        d_info: ptr cusolver_int_t): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnDBgels", dynlib: libName.}
  proc cusolverDnDXgelsUnderScore*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                        n: cusolver_int_t; nrhs: cusolver_int_t; dA: ptr cdouble;
                        ldda: cusolver_int_t; dB: ptr cdouble; lddb: cusolver_int_t;
                        dX: ptr cdouble; lddx: cusolver_int_t; dWorkspace: pointer;
                        lwork_bytes: csize_t; iter: ptr cusolver_int_t;
                        d_info: ptr cusolver_int_t): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnDXgels", dynlib: libName.}
  proc cusolverDnSSgelsUnderScore*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                        n: cusolver_int_t; nrhs: cusolver_int_t; dA: ptr cfloat;
                        ldda: cusolver_int_t; dB: ptr cfloat; lddb: cusolver_int_t;
                        dX: ptr cfloat; lddx: cusolver_int_t; dWorkspace: pointer;
                        lwork_bytes: csize_t; iter: ptr cusolver_int_t;
                        d_info: ptr cusolver_int_t): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnSSgels", dynlib: libName.}
  proc cusolverDnSHgelsUnderScore*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                        n: cusolver_int_t; nrhs: cusolver_int_t; dA: ptr cfloat;
                        ldda: cusolver_int_t; dB: ptr cfloat; lddb: cusolver_int_t;
                        dX: ptr cfloat; lddx: cusolver_int_t; dWorkspace: pointer;
                        lwork_bytes: csize_t; iter: ptr cusolver_int_t;
                        d_info: ptr cusolver_int_t): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnSHgels", dynlib: libName.}
  proc cusolverDnSBgelsUnderScore*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                        n: cusolver_int_t; nrhs: cusolver_int_t; dA: ptr cfloat;
                        ldda: cusolver_int_t; dB: ptr cfloat; lddb: cusolver_int_t;
                        dX: ptr cfloat; lddx: cusolver_int_t; dWorkspace: pointer;
                        lwork_bytes: csize_t; iter: ptr cusolver_int_t;
                        d_info: ptr cusolver_int_t): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnSBgels", dynlib: libName.}
  proc cusolverDnSXgelsUnderScore*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                        n: cusolver_int_t; nrhs: cusolver_int_t; dA: ptr cfloat;
                        ldda: cusolver_int_t; dB: ptr cfloat; lddb: cusolver_int_t;
                        dX: ptr cfloat; lddx: cusolver_int_t; dWorkspace: pointer;
                        lwork_bytes: csize_t; iter: ptr cusolver_int_t;
                        d_info: ptr cusolver_int_t): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnSXgels", dynlib: libName.}
  ## ****************************************************************************
  ## ****************************************************************************
  ##
  ##  [ZZ, ZC, ZK, ZE, ZY, CC, CK, CE, CY, DD, DS, DH, DB, DX, SS, SH, SB, SX]gels_bufferSize
  ##  API prototypes
  ## ****************************************************************************
  proc cusolverDnZZgels_bufferSizeUnderScore*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                                   n: cusolver_int_t; nrhs: cusolver_int_t;
                                   dA: ptr cuDoubleComplex; ldda: cusolver_int_t;
                                   dB: ptr cuDoubleComplex; lddb: cusolver_int_t;
                                   dX: ptr cuDoubleComplex; lddx: cusolver_int_t;
                                   dWorkspace: pointer; lwork_bytes: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZZgels_bufferSize", dynlib: libName.}
  proc cusolverDnZCgels_bufferSizeUnderScore*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                                   n: cusolver_int_t; nrhs: cusolver_int_t;
                                   dA: ptr cuDoubleComplex; ldda: cusolver_int_t;
                                   dB: ptr cuDoubleComplex; lddb: cusolver_int_t;
                                   dX: ptr cuDoubleComplex; lddx: cusolver_int_t;
                                   dWorkspace: pointer; lwork_bytes: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZCgels_bufferSize", dynlib: libName.}
  proc cusolverDnZKgels_bufferSizeUnderScore*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                                   n: cusolver_int_t; nrhs: cusolver_int_t;
                                   dA: ptr cuDoubleComplex; ldda: cusolver_int_t;
                                   dB: ptr cuDoubleComplex; lddb: cusolver_int_t;
                                   dX: ptr cuDoubleComplex; lddx: cusolver_int_t;
                                   dWorkspace: pointer; lwork_bytes: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZKgels_bufferSize", dynlib: libName.}
  proc cusolverDnZEgels_bufferSizeUnderScore*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                                   n: cusolver_int_t; nrhs: cusolver_int_t;
                                   dA: ptr cuDoubleComplex; ldda: cusolver_int_t;
                                   dB: ptr cuDoubleComplex; lddb: cusolver_int_t;
                                   dX: ptr cuDoubleComplex; lddx: cusolver_int_t;
                                   dWorkspace: pointer; lwork_bytes: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZEgels_bufferSize", dynlib: libName.}
  proc cusolverDnZYgels_bufferSizeUnderScore*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                                   n: cusolver_int_t; nrhs: cusolver_int_t;
                                   dA: ptr cuDoubleComplex; ldda: cusolver_int_t;
                                   dB: ptr cuDoubleComplex; lddb: cusolver_int_t;
                                   dX: ptr cuDoubleComplex; lddx: cusolver_int_t;
                                   dWorkspace: pointer; lwork_bytes: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZYgels_bufferSize", dynlib: libName.}
  proc cusolverDnCCgels_bufferSizeUnderScore*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                                   n: cusolver_int_t; nrhs: cusolver_int_t;
                                   dA: ptr cuComplex; ldda: cusolver_int_t;
                                   dB: ptr cuComplex; lddb: cusolver_int_t;
                                   dX: ptr cuComplex; lddx: cusolver_int_t;
                                   dWorkspace: pointer; lwork_bytes: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnCCgels_bufferSize", dynlib: libName.}
  proc cusolverDnCKgels_bufferSizeUnderScore*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                                   n: cusolver_int_t; nrhs: cusolver_int_t;
                                   dA: ptr cuComplex; ldda: cusolver_int_t;
                                   dB: ptr cuComplex; lddb: cusolver_int_t;
                                   dX: ptr cuComplex; lddx: cusolver_int_t;
                                   dWorkspace: pointer; lwork_bytes: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnCKgels_bufferSize", dynlib: libName.}
  proc cusolverDnCEgels_bufferSizeUnderScore*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                                   n: cusolver_int_t; nrhs: cusolver_int_t;
                                   dA: ptr cuComplex; ldda: cusolver_int_t;
                                   dB: ptr cuComplex; lddb: cusolver_int_t;
                                   dX: ptr cuComplex; lddx: cusolver_int_t;
                                   dWorkspace: pointer; lwork_bytes: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnCEgels_bufferSize", dynlib: libName.}
  proc cusolverDnCYgels_bufferSizeUnderScore*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                                   n: cusolver_int_t; nrhs: cusolver_int_t;
                                   dA: ptr cuComplex; ldda: cusolver_int_t;
                                   dB: ptr cuComplex; lddb: cusolver_int_t;
                                   dX: ptr cuComplex; lddx: cusolver_int_t;
                                   dWorkspace: pointer; lwork_bytes: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnCYgels_bufferSize", dynlib: libName.}
  proc cusolverDnDDgels_bufferSizeUnderScore*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                                   n: cusolver_int_t; nrhs: cusolver_int_t;
                                   dA: ptr cdouble; ldda: cusolver_int_t;
                                   dB: ptr cdouble; lddb: cusolver_int_t;
                                   dX: ptr cdouble; lddx: cusolver_int_t;
                                   dWorkspace: pointer; lwork_bytes: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnDDgels_bufferSize", dynlib: libName.}
  proc cusolverDnDSgels_bufferSizeUnderScore*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                                   n: cusolver_int_t; nrhs: cusolver_int_t;
                                   dA: ptr cdouble; ldda: cusolver_int_t;
                                   dB: ptr cdouble; lddb: cusolver_int_t;
                                   dX: ptr cdouble; lddx: cusolver_int_t;
                                   dWorkspace: pointer; lwork_bytes: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnDSgels_bufferSize", dynlib: libName.}
  proc cusolverDnDHgels_bufferSizeUnderScore*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                                   n: cusolver_int_t; nrhs: cusolver_int_t;
                                   dA: ptr cdouble; ldda: cusolver_int_t;
                                   dB: ptr cdouble; lddb: cusolver_int_t;
                                   dX: ptr cdouble; lddx: cusolver_int_t;
                                   dWorkspace: pointer; lwork_bytes: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnDHgels_bufferSize", dynlib: libName.}
  proc cusolverDnDBgels_bufferSizeUnderScore*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                                   n: cusolver_int_t; nrhs: cusolver_int_t;
                                   dA: ptr cdouble; ldda: cusolver_int_t;
                                   dB: ptr cdouble; lddb: cusolver_int_t;
                                   dX: ptr cdouble; lddx: cusolver_int_t;
                                   dWorkspace: pointer; lwork_bytes: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnDBgels_bufferSize", dynlib: libName.}
  proc cusolverDnDXgels_bufferSizeUnderScore*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                                   n: cusolver_int_t; nrhs: cusolver_int_t;
                                   dA: ptr cdouble; ldda: cusolver_int_t;
                                   dB: ptr cdouble; lddb: cusolver_int_t;
                                   dX: ptr cdouble; lddx: cusolver_int_t;
                                   dWorkspace: pointer; lwork_bytes: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnDXgels_bufferSize", dynlib: libName.}
  proc cusolverDnSSgels_bufferSizeUnderScore*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                                   n: cusolver_int_t; nrhs: cusolver_int_t;
                                   dA: ptr cfloat; ldda: cusolver_int_t;
                                   dB: ptr cfloat; lddb: cusolver_int_t;
                                   dX: ptr cfloat; lddx: cusolver_int_t;
                                   dWorkspace: pointer; lwork_bytes: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnSSgels_bufferSize", dynlib: libName.}
  proc cusolverDnSHgels_bufferSizeUnderScore*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                                   n: cusolver_int_t; nrhs: cusolver_int_t;
                                   dA: ptr cfloat; ldda: cusolver_int_t;
                                   dB: ptr cfloat; lddb: cusolver_int_t;
                                   dX: ptr cfloat; lddx: cusolver_int_t;
                                   dWorkspace: pointer; lwork_bytes: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnSHgels_bufferSize", dynlib: libName.}
  proc cusolverDnSBgels_bufferSizeUnderScore*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                                   n: cusolver_int_t; nrhs: cusolver_int_t;
                                   dA: ptr cfloat; ldda: cusolver_int_t;
                                   dB: ptr cfloat; lddb: cusolver_int_t;
                                   dX: ptr cfloat; lddx: cusolver_int_t;
                                   dWorkspace: pointer; lwork_bytes: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnSBgels_bufferSize", dynlib: libName.}
  proc cusolverDnSXgels_bufferSizeUnderScore*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                                   n: cusolver_int_t; nrhs: cusolver_int_t;
                                   dA: ptr cfloat; ldda: cusolver_int_t;
                                   dB: ptr cfloat; lddb: cusolver_int_t;
                                   dX: ptr cfloat; lddx: cusolver_int_t;
                                   dWorkspace: pointer; lwork_bytes: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnSXgels_bufferSize", dynlib: libName.}
  ## ****************************************************************************
  ## ****************************************************************************
  ##
  ##  expert users API for IRS Prototypes
  ##
  ## ****************************************************************************
  proc cusolverDnIRSXgesvUnderScore*(handle: cusolverDnHandle_t;
                          gesv_irs_params: cusolverDnIRSParams_t;
                          gesv_irs_infos: cusolverDnIRSInfos_t; n: cusolver_int_t;
                          nrhs: cusolver_int_t; dA: pointer; ldda: cusolver_int_t;
                          dB: pointer; lddb: cusolver_int_t; dX: pointer;
                          lddx: cusolver_int_t; dWorkspace: pointer;
                          lwork_bytes: csize_t; niters: ptr cusolver_int_t;
                          d_info: ptr cusolver_int_t): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnIRSXgesv", dynlib: libName.}
  proc cusolverDnIRSXgesv_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                     params: cusolverDnIRSParams_t;
                                     n: cusolver_int_t; nrhs: cusolver_int_t;
                                     lwork_bytes: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnIRSXgesv_bufferSize", dynlib: libName.}
  proc cusolverDnIRSXgelsUnderScore*(handle: cusolverDnHandle_t;
                          gels_irs_params: cusolverDnIRSParams_t;
                          gels_irs_infos: cusolverDnIRSInfos_t; m: cusolver_int_t;
                          n: cusolver_int_t; nrhs: cusolver_int_t; dA: pointer;
                          ldda: cusolver_int_t; dB: pointer; lddb: cusolver_int_t;
                          dX: pointer; lddx: cusolver_int_t; dWorkspace: pointer;
                          lwork_bytes: csize_t; niters: ptr cusolver_int_t;
                          d_info: ptr cusolver_int_t): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnIRSXgels", dynlib: libName.}
  proc cusolverDnIRSXgels_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                     params: cusolverDnIRSParams_t;
                                     m: cusolver_int_t; n: cusolver_int_t;
                                     nrhs: cusolver_int_t;
                                     lwork_bytes: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnIRSXgels_bufferSize", dynlib: libName.}
  ## ****************************************************************************
  ##  Cholesky factorization and its solver
  proc cusolverDnSpotrf_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cfloat;
                                   lda: cint; Lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnSpotrf_bufferSize", dynlib: libName.}
  proc cusolverDnDpotrf_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cdouble;
                                   lda: cint; Lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnDpotrf_bufferSize", dynlib: libName.}
  proc cusolverDnCpotrf_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuComplex; lda: cint; Lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnCpotrf_bufferSize", dynlib: libName.}
  proc cusolverDnZpotrf_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuDoubleComplex; lda: cint; Lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZpotrf_bufferSize", dynlib: libName.}
  proc cusolverDnSpotrfUnderScore*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cfloat; lda: cint; Workspace: ptr cfloat; Lwork: cint;
                        devInfo: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnSpotrf", dynlib: libName.}
  proc cusolverDnDpotrfUnderScore*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cdouble; lda: cint; Workspace: ptr cdouble; Lwork: cint;
                        devInfo: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnDpotrf", dynlib: libName.}
  proc cusolverDnCpotrfUnderScore*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cuComplex; lda: cint; Workspace: ptr cuComplex;
                        Lwork: cint; devInfo: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnCpotrf", dynlib: libName.}
  proc cusolverDnZpotrfUnderScore*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cuDoubleComplex; lda: cint;
                        Workspace: ptr cuDoubleComplex; Lwork: cint;
                        devInfo: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnZpotrf", dynlib: libName.}
  proc cusolverDnSpotrsUnderScore*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        nrhs: cint; A: ptr cfloat; lda: cint; B: ptr cfloat; ldb: cint;
                        devInfo: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnSpotrs", dynlib: libName.}
  proc cusolverDnDpotrsUnderScore*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        nrhs: cint; A: ptr cdouble; lda: cint; B: ptr cdouble; ldb: cint;
                        devInfo: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnDpotrs", dynlib: libName.}
  proc cusolverDnCpotrsUnderScore*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        nrhs: cint; A: ptr cuComplex; lda: cint; B: ptr cuComplex;
                        ldb: cint; devInfo: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnCpotrs", dynlib: libName.}
  proc cusolverDnZpotrsUnderScore*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        nrhs: cint; A: ptr cuDoubleComplex; lda: cint;
                        B: ptr cuDoubleComplex; ldb: cint; devInfo: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZpotrs", dynlib: libName.}
  ##  batched Cholesky factorization and its solver
  proc cusolverDnSpotrfBatched*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t;
                               n: cint; Aarray: ptr ptr cfloat; lda: cint;
                               infoArray: ptr cint; batchSize: cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSpotrfBatched", dynlib: libName.}
  proc cusolverDnDpotrfBatched*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t;
                               n: cint; Aarray: ptr ptr cdouble; lda: cint;
                               infoArray: ptr cint; batchSize: cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDpotrfBatched", dynlib: libName.}
  proc cusolverDnCpotrfBatched*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t;
                               n: cint; Aarray: ptr ptr cuComplex; lda: cint;
                               infoArray: ptr cint; batchSize: cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnCpotrfBatched", dynlib: libName.}
  proc cusolverDnZpotrfBatched*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t;
                               n: cint; Aarray: ptr ptr cuDoubleComplex; lda: cint;
                               infoArray: ptr cint; batchSize: cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZpotrfBatched", dynlib: libName.}
  proc cusolverDnSpotrsBatched*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t;
                               n: cint; nrhs: cint; A: ptr ptr cfloat; lda: cint;
                               B: ptr ptr cfloat; ldb: cint; d_info: ptr cint;
                               batchSize: cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnSpotrsBatched", dynlib: libName.}
    ##  only support rhs = 1
  proc cusolverDnDpotrsBatched*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t;
                               n: cint; nrhs: cint; A: ptr ptr cdouble; lda: cint;
                               B: ptr ptr cdouble; ldb: cint; d_info: ptr cint;
                               batchSize: cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDpotrsBatched", dynlib: libName.}
    ##  only support rhs = 1
  proc cusolverDnCpotrsBatched*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t;
                               n: cint; nrhs: cint; A: ptr ptr cuComplex; lda: cint;
                               B: ptr ptr cuComplex; ldb: cint; d_info: ptr cint;
                               batchSize: cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnCpotrsBatched", dynlib: libName.}
    ##  only support rhs = 1
  proc cusolverDnZpotrsBatched*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t;
                               n: cint; nrhs: cint; A: ptr ptr cuDoubleComplex;
                               lda: cint; B: ptr ptr cuDoubleComplex; ldb: cint;
                               d_info: ptr cint; batchSize: cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZpotrsBatched", dynlib: libName.}
    ##  only support rhs = 1
  ##  s.p.d. matrix inversion (POTRI) and auxiliary routines (TRTRI and LAUUM)
  proc cusolverDnSpotri_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cfloat;
                                   lda: cint; lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnSpotri_bufferSize", dynlib: libName.}
  proc cusolverDnDpotri_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cdouble;
                                   lda: cint; lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnDpotri_bufferSize", dynlib: libName.}
  proc cusolverDnCpotri_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuComplex; lda: cint; lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnCpotri_bufferSize", dynlib: libName.}
  proc cusolverDnZpotri_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuDoubleComplex; lda: cint; lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZpotri_bufferSize", dynlib: libName.}
  proc cusolverDnSpotriUnderScore*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cfloat; lda: cint; work: ptr cfloat; lwork: cint;
                        devInfo: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnSpotri", dynlib: libName.}
  proc cusolverDnDpotriUnderScore*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cdouble; lda: cint; work: ptr cdouble; lwork: cint;
                        devInfo: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnDpotri", dynlib: libName.}
  proc cusolverDnCpotriUnderScore*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cuComplex; lda: cint; work: ptr cuComplex; lwork: cint;
                        devInfo: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnCpotri", dynlib: libName.}
  proc cusolverDnZpotriUnderScore*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cuDoubleComplex; lda: cint; work: ptr cuDoubleComplex;
                        lwork: cint; devInfo: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnZpotri", dynlib: libName.}
  proc cusolverDnXtrtri_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; diag: cublasDiagType_t;
                                   n: clonglong; dataTypeA: cudaDataType;
                                   A: pointer; lda: clonglong;
                                   workspaceInBytesOnDevice: ptr csize_t;
                                   workspaceInBytesOnHost: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnXtrtri_bufferSize", dynlib: libName.}
  proc cusolverDnXtrtriUnderScore*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t;
                        diag: cublasDiagType_t; n: clonglong;
                        dataTypeA: cudaDataType; A: pointer; lda: clonglong;
                        bufferOnDevice: pointer;
                        workspaceInBytesOnDevice: csize_t; bufferOnHost: pointer;
                        workspaceInBytesOnHost: csize_t; devInfo: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnXtrtri", dynlib: libName.}
  ##  lauum, auxiliar routine for s.p.d matrix inversion
  proc cusolverDnSlauum_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cfloat;
                                   lda: cint; lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnSlauum_bufferSize", dynlib: libName.}
  proc cusolverDnDlauum_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cdouble;
                                   lda: cint; lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnDlauum_bufferSize", dynlib: libName.}
  proc cusolverDnClauum_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuComplex; lda: cint; lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnClauum_bufferSize", dynlib: libName.}
  proc cusolverDnZlauum_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuDoubleComplex; lda: cint; lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZlauum_bufferSize", dynlib: libName.}
  proc cusolverDnSlauumUnderScore*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cfloat; lda: cint; work: ptr cfloat; lwork: cint;
                        devInfo: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnSlauum", dynlib: libName.}
  proc cusolverDnDlauumUnderScore*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cdouble; lda: cint; work: ptr cdouble; lwork: cint;
                        devInfo: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnDlauum", dynlib: libName.}
  proc cusolverDnClauumUnderScore*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cuComplex; lda: cint; work: ptr cuComplex; lwork: cint;
                        devInfo: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnClauum", dynlib: libName.}
  proc cusolverDnZlauumUnderScore*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cuDoubleComplex; lda: cint; work: ptr cuDoubleComplex;
                        lwork: cint; devInfo: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnZlauum", dynlib: libName.}
  ##  LU Factorization
  proc cusolverDnSgetrf_bufferSizeUnderScore*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   A: ptr cfloat; lda: cint; Lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnSgetrf_bufferSize", dynlib: libName.}
  proc cusolverDnDgetrf_bufferSizeUnderScore*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   A: ptr cdouble; lda: cint; Lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnDgetrf_bufferSize", dynlib: libName.}
  proc cusolverDnCgetrf_bufferSizeUnderScore*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   A: ptr cuComplex; lda: cint; Lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnCgetrf_bufferSize", dynlib: libName.}
  proc cusolverDnZgetrf_bufferSizeUnderScore*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   A: ptr cuDoubleComplex; lda: cint; Lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZgetrf_bufferSize", dynlib: libName.}
  proc cusolverDnSgetrfUnderScore*(handle: cusolverDnHandle_t; m: cint; n: cint; A: ptr cfloat;
                        lda: cint; Workspace: ptr cfloat; devIpiv: ptr cint;
                        devInfo: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnSgetrf", dynlib: libName.}
  proc cusolverDnDgetrfUnderScore*(handle: cusolverDnHandle_t; m: cint; n: cint; A: ptr cdouble;
                        lda: cint; Workspace: ptr cdouble; devIpiv: ptr cint;
                        devInfo: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnDgetrf", dynlib: libName.}
  proc cusolverDnCgetrfUnderScore*(handle: cusolverDnHandle_t; m: cint; n: cint;
                        A: ptr cuComplex; lda: cint; Workspace: ptr cuComplex;
                        devIpiv: ptr cint; devInfo: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnCgetrf", dynlib: libName.}
  proc cusolverDnZgetrfUnderScore*(handle: cusolverDnHandle_t; m: cint; n: cint;
                        A: ptr cuDoubleComplex; lda: cint;
                        Workspace: ptr cuDoubleComplex; devIpiv: ptr cint;
                        devInfo: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnZgetrf", dynlib: libName.}
  ##  Row pivoting
  proc cusolverDnSlaswpUnderScore*(handle: cusolverDnHandle_t; n: cint; A: ptr cfloat; lda: cint;
                        k1: cint; k2: cint; devIpiv: ptr cint; incx: cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnSlaswp", dynlib: libName.}
  proc cusolverDnDlaswpUnderScore*(handle: cusolverDnHandle_t; n: cint; A: ptr cdouble; lda: cint;
                        k1: cint; k2: cint; devIpiv: ptr cint; incx: cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnDlaswp", dynlib: libName.}
  proc cusolverDnClaswpUnderScore*(handle: cusolverDnHandle_t; n: cint; A: ptr cuComplex;
                        lda: cint; k1: cint; k2: cint; devIpiv: ptr cint; incx: cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnClaswp", dynlib: libName.}
  proc cusolverDnZlaswpUnderScore*(handle: cusolverDnHandle_t; n: cint; A: ptr cuDoubleComplex;
                        lda: cint; k1: cint; k2: cint; devIpiv: ptr cint; incx: cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZlaswp", dynlib: libName.}
  ##  LU solve
  proc cusolverDnSgetrsUnderScore*(handle: cusolverDnHandle_t; trans: cublasOperation_t;
                        n: cint; nrhs: cint; A: ptr cfloat; lda: cint; devIpiv: ptr cint;
                        B: ptr cfloat; ldb: cint; devInfo: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnSgetrs", dynlib: libName.}
  proc cusolverDnDgetrsUnderScore*(handle: cusolverDnHandle_t; trans: cublasOperation_t;
                        n: cint; nrhs: cint; A: ptr cdouble; lda: cint;
                        devIpiv: ptr cint; B: ptr cdouble; ldb: cint; devInfo: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnDgetrs", dynlib: libName.}
  proc cusolverDnCgetrsUnderScore*(handle: cusolverDnHandle_t; trans: cublasOperation_t;
                        n: cint; nrhs: cint; A: ptr cuComplex; lda: cint;
                        devIpiv: ptr cint; B: ptr cuComplex; ldb: cint;
                        devInfo: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnCgetrs", dynlib: libName.}
  proc cusolverDnZgetrsUnderScore*(handle: cusolverDnHandle_t; trans: cublasOperation_t;
                        n: cint; nrhs: cint; A: ptr cuDoubleComplex; lda: cint;
                        devIpiv: ptr cint; B: ptr cuDoubleComplex; ldb: cint;
                        devInfo: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnZgetrs", dynlib: libName.}
  ##  QR factorization
  proc cusolverDnSgeqrf_bufferSizeUnderScore*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   A: ptr cfloat; lda: cint; lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnSgeqrf_bufferSize", dynlib: libName.}
  proc cusolverDnDgeqrf_bufferSizeUnderScore*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   A: ptr cdouble; lda: cint; lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnDgeqrf_bufferSize", dynlib: libName.}
  proc cusolverDnCgeqrf_bufferSizeUnderScore*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   A: ptr cuComplex; lda: cint; lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnCgeqrf_bufferSize", dynlib: libName.}
  proc cusolverDnZgeqrf_bufferSizeUnderScore*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   A: ptr cuDoubleComplex; lda: cint; lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZgeqrf_bufferSize", dynlib: libName.}
  proc cusolverDnSgeqrfUnderScore*(handle: cusolverDnHandle_t; m: cint; n: cint; A: ptr cfloat;
                        lda: cint; TAU: ptr cfloat; Workspace: ptr cfloat; Lwork: cint;
                        devInfo: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnSgeqrf", dynlib: libName.}
  proc cusolverDnDgeqrfUnderScore*(handle: cusolverDnHandle_t; m: cint; n: cint; A: ptr cdouble;
                        lda: cint; TAU: ptr cdouble; Workspace: ptr cdouble;
                        Lwork: cint; devInfo: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnDgeqrf", dynlib: libName.}
  proc cusolverDnCgeqrfUnderScore*(handle: cusolverDnHandle_t; m: cint; n: cint;
                        A: ptr cuComplex; lda: cint; TAU: ptr cuComplex;
                        Workspace: ptr cuComplex; Lwork: cint; devInfo: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnCgeqrf", dynlib: libName.}
  proc cusolverDnZgeqrfUnderScore*(handle: cusolverDnHandle_t; m: cint; n: cint;
                        A: ptr cuDoubleComplex; lda: cint; TAU: ptr cuDoubleComplex;
                        Workspace: ptr cuDoubleComplex; Lwork: cint;
                        devInfo: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnZgeqrf", dynlib: libName.}
  ##  generate unitary matrix Q from QR factorization
  proc cusolverDnSorgqr_bufferSizeUnderScore*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   k: cint; A: ptr cfloat; lda: cint; tau: ptr cfloat;
                                   lwork: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnSorgqr_bufferSize", dynlib: libName.}
  proc cusolverDnDorgqr_bufferSizeUnderScore*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   k: cint; A: ptr cdouble; lda: cint;
                                   tau: ptr cdouble; lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnDorgqr_bufferSize", dynlib: libName.}
  proc cusolverDnCungqr_bufferSizeUnderScore*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   k: cint; A: ptr cuComplex; lda: cint;
                                   tau: ptr cuComplex; lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnCungqr_bufferSize", dynlib: libName.}
  proc cusolverDnZungqr_bufferSizeUnderScore*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   k: cint; A: ptr cuDoubleComplex; lda: cint;
                                   tau: ptr cuDoubleComplex; lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZungqr_bufferSize", dynlib: libName.}
  proc cusolverDnSorgqrUnderScore*(handle: cusolverDnHandle_t; m: cint; n: cint; k: cint;
                        A: ptr cfloat; lda: cint; tau: ptr cfloat; work: ptr cfloat;
                        lwork: cint; info: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnSorgqr", dynlib: libName.}
  proc cusolverDnDorgqrUnderScore*(handle: cusolverDnHandle_t; m: cint; n: cint; k: cint;
                        A: ptr cdouble; lda: cint; tau: ptr cdouble; work: ptr cdouble;
                        lwork: cint; info: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnDorgqr", dynlib: libName.}
  proc cusolverDnCungqrUnderScore*(handle: cusolverDnHandle_t; m: cint; n: cint; k: cint;
                        A: ptr cuComplex; lda: cint; tau: ptr cuComplex;
                        work: ptr cuComplex; lwork: cint; info: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnCungqr", dynlib: libName.}
  proc cusolverDnZungqrUnderScore*(handle: cusolverDnHandle_t; m: cint; n: cint; k: cint;
                        A: ptr cuDoubleComplex; lda: cint; tau: ptr cuDoubleComplex;
                        work: ptr cuDoubleComplex; lwork: cint; info: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZungqr", dynlib: libName.}
  ##  compute Q**T*b in solve min||A*x = b||
  proc cusolverDnSormqr_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   side: cublasSideMode_t;
                                   trans: cublasOperation_t; m: cint; n: cint;
                                   k: cint; A: ptr cfloat; lda: cint; tau: ptr cfloat;
                                   C: ptr cfloat; ldc: cint; lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnSormqr_bufferSize", dynlib: libName.}
  proc cusolverDnDormqr_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   side: cublasSideMode_t;
                                   trans: cublasOperation_t; m: cint; n: cint;
                                   k: cint; A: ptr cdouble; lda: cint;
                                   tau: ptr cdouble; C: ptr cdouble; ldc: cint;
                                   lwork: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnDormqr_bufferSize", dynlib: libName.}
  proc cusolverDnCunmqr_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   side: cublasSideMode_t;
                                   trans: cublasOperation_t; m: cint; n: cint;
                                   k: cint; A: ptr cuComplex; lda: cint;
                                   tau: ptr cuComplex; C: ptr cuComplex; ldc: cint;
                                   lwork: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnCunmqr_bufferSize", dynlib: libName.}
  proc cusolverDnZunmqr_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   side: cublasSideMode_t;
                                   trans: cublasOperation_t; m: cint; n: cint;
                                   k: cint; A: ptr cuDoubleComplex; lda: cint;
                                   tau: ptr cuDoubleComplex;
                                   C: ptr cuDoubleComplex; ldc: cint; lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZunmqr_bufferSize", dynlib: libName.}
  proc cusolverDnSormqrUnderScore*(handle: cusolverDnHandle_t; side: cublasSideMode_t;
                        trans: cublasOperation_t; m: cint; n: cint; k: cint;
                        A: ptr cfloat; lda: cint; tau: ptr cfloat; C: ptr cfloat;
                        ldc: cint; work: ptr cfloat; lwork: cint; devInfo: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnSormqr", dynlib: libName.}
  proc cusolverDnDormqrUnderScore*(handle: cusolverDnHandle_t; side: cublasSideMode_t;
                        trans: cublasOperation_t; m: cint; n: cint; k: cint;
                        A: ptr cdouble; lda: cint; tau: ptr cdouble; C: ptr cdouble;
                        ldc: cint; work: ptr cdouble; lwork: cint; devInfo: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnDormqr", dynlib: libName.}
  proc cusolverDnCunmqrUnderScore*(handle: cusolverDnHandle_t; side: cublasSideMode_t;
                        trans: cublasOperation_t; m: cint; n: cint; k: cint;
                        A: ptr cuComplex; lda: cint; tau: ptr cuComplex;
                        C: ptr cuComplex; ldc: cint; work: ptr cuComplex; lwork: cint;
                        devInfo: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnCunmqr", dynlib: libName.}
  proc cusolverDnZunmqrUnderScore*(handle: cusolverDnHandle_t; side: cublasSideMode_t;
                        trans: cublasOperation_t; m: cint; n: cint; k: cint;
                        A: ptr cuDoubleComplex; lda: cint; tau: ptr cuDoubleComplex;
                        C: ptr cuDoubleComplex; ldc: cint; work: ptr cuDoubleComplex;
                        lwork: cint; devInfo: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnZunmqr", dynlib: libName.}
  ##  L*D*L**T,U*D*U**T factorization
  proc cusolverDnSsytrf_bufferSizeUnderScore*(handle: cusolverDnHandle_t; n: cint;
                                   A: ptr cfloat; lda: cint; lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnSsytrf_bufferSize", dynlib: libName.}
  proc cusolverDnDsytrf_bufferSizeUnderScore*(handle: cusolverDnHandle_t; n: cint;
                                   A: ptr cdouble; lda: cint; lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnDsytrf_bufferSize", dynlib: libName.}
  proc cusolverDnCsytrf_bufferSizeUnderScore*(handle: cusolverDnHandle_t; n: cint;
                                   A: ptr cuComplex; lda: cint; lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnCsytrf_bufferSize", dynlib: libName.}
  proc cusolverDnZsytrf_bufferSizeUnderScore*(handle: cusolverDnHandle_t; n: cint;
                                   A: ptr cuDoubleComplex; lda: cint; lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZsytrf_bufferSize", dynlib: libName.}
  proc cusolverDnSsytrfUnderScore*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cfloat; lda: cint; ipiv: ptr cint; work: ptr cfloat;
                        lwork: cint; info: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnSsytrf", dynlib: libName.}
  proc cusolverDnDsytrfUnderScore*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cdouble; lda: cint; ipiv: ptr cint; work: ptr cdouble;
                        lwork: cint; info: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnDsytrf", dynlib: libName.}
  proc cusolverDnCsytrfUnderScore*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cuComplex; lda: cint; ipiv: ptr cint;
                        work: ptr cuComplex; lwork: cint; info: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnCsytrf", dynlib: libName.}
  proc cusolverDnZsytrfUnderScore*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cuDoubleComplex; lda: cint; ipiv: ptr cint;
                        work: ptr cuDoubleComplex; lwork: cint; info: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZsytrf", dynlib: libName.}
  ##  Symmetric indefinite solve (SYTRS)
  proc cusolverDnXsytrs_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: clonglong;
                                   nrhs: clonglong; dataTypeA: cudaDataType;
                                   A: pointer; lda: clonglong; ipiv: ptr clonglong;
                                   dataTypeB: cudaDataType; B: pointer;
                                   ldb: clonglong;
                                   workspaceInBytesOnDevice: ptr csize_t;
                                   workspaceInBytesOnHost: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnXsytrs_bufferSize", dynlib: libName.}
  proc cusolverDnXsytrsUnderScore*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t;
                        n: clonglong; nrhs: clonglong; dataTypeA: cudaDataType;
                        A: pointer; lda: clonglong; ipiv: ptr clonglong;
                        dataTypeB: cudaDataType; B: pointer; ldb: clonglong;
                        bufferOnDevice: pointer;
                        workspaceInBytesOnDevice: csize_t; bufferOnHost: pointer;
                        workspaceInBytesOnHost: csize_t; info: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnXsytrs", dynlib: libName.}
  ##  Symmetric indefinite inversion (sytri)
  proc cusolverDnSsytri_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cfloat;
                                   lda: cint; ipiv: ptr cint; lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnSsytri_bufferSize", dynlib: libName.}
  proc cusolverDnDsytri_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cdouble;
                                   lda: cint; ipiv: ptr cint; lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnDsytri_bufferSize", dynlib: libName.}
  proc cusolverDnCsytri_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuComplex; lda: cint; ipiv: ptr cint;
                                   lwork: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnCsytri_bufferSize", dynlib: libName.}
  proc cusolverDnZsytri_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuDoubleComplex; lda: cint; ipiv: ptr cint;
                                   lwork: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnZsytri_bufferSize", dynlib: libName.}
  proc cusolverDnSsytriUnderScore*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cfloat; lda: cint; ipiv: ptr cint; work: ptr cfloat;
                        lwork: cint; info: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnSsytri", dynlib: libName.}
  proc cusolverDnDsytriUnderScore*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cdouble; lda: cint; ipiv: ptr cint; work: ptr cdouble;
                        lwork: cint; info: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnDsytri", dynlib: libName.}
  proc cusolverDnCsytriUnderScore*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cuComplex; lda: cint; ipiv: ptr cint;
                        work: ptr cuComplex; lwork: cint; info: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnCsytri", dynlib: libName.}
  proc cusolverDnZsytriUnderScore*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cuDoubleComplex; lda: cint; ipiv: ptr cint;
                        work: ptr cuDoubleComplex; lwork: cint; info: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZsytri", dynlib: libName.}
  ##  bidiagonal factorization
  proc cusolverDnSgebrd_bufferSizeUnderScore*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   Lwork: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnSgebrd_bufferSize", dynlib: libName.}
  proc cusolverDnDgebrd_bufferSizeUnderScore*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   Lwork: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnDgebrd_bufferSize", dynlib: libName.}
  proc cusolverDnCgebrd_bufferSizeUnderScore*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   Lwork: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnCgebrd_bufferSize", dynlib: libName.}
  proc cusolverDnZgebrd_bufferSizeUnderScore*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   Lwork: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnZgebrd_bufferSize", dynlib: libName.}
  proc cusolverDnSgebrdUnderScore*(handle: cusolverDnHandle_t; m: cint; n: cint; A: ptr cfloat;
                        lda: cint; D: ptr cfloat; E: ptr cfloat; TAUQ: ptr cfloat;
                        TAUP: ptr cfloat; Work: ptr cfloat; Lwork: cint;
                        devInfo: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnSgebrd", dynlib: libName.}
  proc cusolverDnDgebrdUnderScore*(handle: cusolverDnHandle_t; m: cint; n: cint; A: ptr cdouble;
                        lda: cint; D: ptr cdouble; E: ptr cdouble; TAUQ: ptr cdouble;
                        TAUP: ptr cdouble; Work: ptr cdouble; Lwork: cint;
                        devInfo: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnDgebrd", dynlib: libName.}
  proc cusolverDnCgebrdUnderScore*(handle: cusolverDnHandle_t; m: cint; n: cint;
                        A: ptr cuComplex; lda: cint; D: ptr cfloat; E: ptr cfloat;
                        TAUQ: ptr cuComplex; TAUP: ptr cuComplex; Work: ptr cuComplex;
                        Lwork: cint; devInfo: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnCgebrd", dynlib: libName.}
  proc cusolverDnZgebrdUnderScore*(handle: cusolverDnHandle_t; m: cint; n: cint;
                        A: ptr cuDoubleComplex; lda: cint; D: ptr cdouble;
                        E: ptr cdouble; TAUQ: ptr cuDoubleComplex;
                        TAUP: ptr cuDoubleComplex; Work: ptr cuDoubleComplex;
                        Lwork: cint; devInfo: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnZgebrd", dynlib: libName.}
  ##  generates one of the unitary matrices Q or P**T determined by GEBRD
  proc cusolverDnSorgbr_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   side: cublasSideMode_t; m: cint; n: cint; k: cint;
                                   A: ptr cfloat; lda: cint; tau: ptr cfloat;
                                   lwork: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnSorgbr_bufferSize", dynlib: libName.}
  proc cusolverDnDorgbr_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   side: cublasSideMode_t; m: cint; n: cint; k: cint;
                                   A: ptr cdouble; lda: cint; tau: ptr cdouble;
                                   lwork: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnDorgbr_bufferSize", dynlib: libName.}
  proc cusolverDnCungbr_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   side: cublasSideMode_t; m: cint; n: cint; k: cint;
                                   A: ptr cuComplex; lda: cint; tau: ptr cuComplex;
                                   lwork: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnCungbr_bufferSize", dynlib: libName.}
  proc cusolverDnZungbr_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   side: cublasSideMode_t; m: cint; n: cint; k: cint;
                                   A: ptr cuDoubleComplex; lda: cint;
                                   tau: ptr cuDoubleComplex; lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZungbr_bufferSize", dynlib: libName.}
  proc cusolverDnSorgbrUnderScore*(handle: cusolverDnHandle_t; side: cublasSideMode_t; m: cint;
                        n: cint; k: cint; A: ptr cfloat; lda: cint; tau: ptr cfloat;
                        work: ptr cfloat; lwork: cint; info: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnSorgbr", dynlib: libName.}
  proc cusolverDnDorgbrUnderScore*(handle: cusolverDnHandle_t; side: cublasSideMode_t; m: cint;
                        n: cint; k: cint; A: ptr cdouble; lda: cint; tau: ptr cdouble;
                        work: ptr cdouble; lwork: cint; info: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnDorgbr", dynlib: libName.}
  proc cusolverDnCungbrUnderScore*(handle: cusolverDnHandle_t; side: cublasSideMode_t; m: cint;
                        n: cint; k: cint; A: ptr cuComplex; lda: cint;
                        tau: ptr cuComplex; work: ptr cuComplex; lwork: cint;
                        info: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnCungbr", dynlib: libName.}
  proc cusolverDnZungbrUnderScore*(handle: cusolverDnHandle_t; side: cublasSideMode_t; m: cint;
                        n: cint; k: cint; A: ptr cuDoubleComplex; lda: cint;
                        tau: ptr cuDoubleComplex; work: ptr cuDoubleComplex;
                        lwork: cint; info: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnZungbr", dynlib: libName.}
  ##  tridiagonal factorization
  proc cusolverDnSsytrd_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cfloat;
                                   lda: cint; d: ptr cfloat; e: ptr cfloat;
                                   tau: ptr cfloat; lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnSsytrd_bufferSize", dynlib: libName.}
  proc cusolverDnDsytrd_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cdouble;
                                   lda: cint; d: ptr cdouble; e: ptr cdouble;
                                   tau: ptr cdouble; lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnDsytrd_bufferSize", dynlib: libName.}
  proc cusolverDnChetrd_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuComplex; lda: cint; d: ptr cfloat;
                                   e: ptr cfloat; tau: ptr cuComplex; lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnChetrd_bufferSize", dynlib: libName.}
  proc cusolverDnZhetrd_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuDoubleComplex; lda: cint; d: ptr cdouble;
                                   e: ptr cdouble; tau: ptr cuDoubleComplex;
                                   lwork: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnZhetrd_bufferSize", dynlib: libName.}
  proc cusolverDnSsytrdUnderScore*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cfloat; lda: cint; d: ptr cfloat; e: ptr cfloat;
                        tau: ptr cfloat; work: ptr cfloat; lwork: cint; info: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnSsytrd", dynlib: libName.}
  proc cusolverDnDsytrdUnderScore*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cdouble; lda: cint; d: ptr cdouble; e: ptr cdouble;
                        tau: ptr cdouble; work: ptr cdouble; lwork: cint; info: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnDsytrd", dynlib: libName.}
  proc cusolverDnChetrdUnderScore*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cuComplex; lda: cint; d: ptr cfloat; e: ptr cfloat;
                        tau: ptr cuComplex; work: ptr cuComplex; lwork: cint;
                        info: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnChetrd", dynlib: libName.}
  proc cusolverDnZhetrdUnderScore*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cuDoubleComplex; lda: cint; d: ptr cdouble;
                        e: ptr cdouble; tau: ptr cuDoubleComplex;
                        work: ptr cuDoubleComplex; lwork: cint; info: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZhetrd", dynlib: libName.}
  ##  generate unitary Q comes from sytrd
  proc cusolverDnSorgtr_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cfloat;
                                   lda: cint; tau: ptr cfloat; lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnSorgtr_bufferSize", dynlib: libName.}
  proc cusolverDnDorgtr_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cdouble;
                                   lda: cint; tau: ptr cdouble; lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnDorgtr_bufferSize", dynlib: libName.}
  proc cusolverDnCungtr_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuComplex; lda: cint; tau: ptr cuComplex;
                                   lwork: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnCungtr_bufferSize", dynlib: libName.}
  proc cusolverDnZungtr_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuDoubleComplex; lda: cint;
                                   tau: ptr cuDoubleComplex; lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZungtr_bufferSize", dynlib: libName.}
  proc cusolverDnSorgtrUnderScore*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cfloat; lda: cint; tau: ptr cfloat; work: ptr cfloat;
                        lwork: cint; info: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnSorgtr", dynlib: libName.}
  proc cusolverDnDorgtrUnderScore*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cdouble; lda: cint; tau: ptr cdouble; work: ptr cdouble;
                        lwork: cint; info: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnDorgtr", dynlib: libName.}
  proc cusolverDnCungtrUnderScore*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cuComplex; lda: cint; tau: ptr cuComplex;
                        work: ptr cuComplex; lwork: cint; info: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnCungtr", dynlib: libName.}
  proc cusolverDnZungtrUnderScore*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cuDoubleComplex; lda: cint; tau: ptr cuDoubleComplex;
                        work: ptr cuDoubleComplex; lwork: cint; info: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZungtr", dynlib: libName.}
  ##  compute op(Q)*C or C*op(Q) where Q comes from sytrd
  proc cusolverDnSormtr_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   side: cublasSideMode_t; uplo: cublasFillMode_t;
                                   trans: cublasOperation_t; m: cint; n: cint;
                                   A: ptr cfloat; lda: cint; tau: ptr cfloat;
                                   C: ptr cfloat; ldc: cint; lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnSormtr_bufferSize", dynlib: libName.}
  proc cusolverDnDormtr_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   side: cublasSideMode_t; uplo: cublasFillMode_t;
                                   trans: cublasOperation_t; m: cint; n: cint;
                                   A: ptr cdouble; lda: cint; tau: ptr cdouble;
                                   C: ptr cdouble; ldc: cint; lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnDormtr_bufferSize", dynlib: libName.}
  proc cusolverDnCunmtr_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   side: cublasSideMode_t; uplo: cublasFillMode_t;
                                   trans: cublasOperation_t; m: cint; n: cint;
                                   A: ptr cuComplex; lda: cint; tau: ptr cuComplex;
                                   C: ptr cuComplex; ldc: cint; lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnCunmtr_bufferSize", dynlib: libName.}
  proc cusolverDnZunmtr_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   side: cublasSideMode_t; uplo: cublasFillMode_t;
                                   trans: cublasOperation_t; m: cint; n: cint;
                                   A: ptr cuDoubleComplex; lda: cint;
                                   tau: ptr cuDoubleComplex;
                                   C: ptr cuDoubleComplex; ldc: cint; lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZunmtr_bufferSize", dynlib: libName.}
  proc cusolverDnSormtrUnderScore*(handle: cusolverDnHandle_t; side: cublasSideMode_t;
                        uplo: cublasFillMode_t; trans: cublasOperation_t; m: cint;
                        n: cint; A: ptr cfloat; lda: cint; tau: ptr cfloat; C: ptr cfloat;
                        ldc: cint; work: ptr cfloat; lwork: cint; info: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnSormtr", dynlib: libName.}
  proc cusolverDnDormtrUnderScore*(handle: cusolverDnHandle_t; side: cublasSideMode_t;
                        uplo: cublasFillMode_t; trans: cublasOperation_t; m: cint;
                        n: cint; A: ptr cdouble; lda: cint; tau: ptr cdouble;
                        C: ptr cdouble; ldc: cint; work: ptr cdouble; lwork: cint;
                        info: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnDormtr", dynlib: libName.}
  proc cusolverDnCunmtrUnderScore*(handle: cusolverDnHandle_t; side: cublasSideMode_t;
                        uplo: cublasFillMode_t; trans: cublasOperation_t; m: cint;
                        n: cint; A: ptr cuComplex; lda: cint; tau: ptr cuComplex;
                        C: ptr cuComplex; ldc: cint; work: ptr cuComplex; lwork: cint;
                        info: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnCunmtr", dynlib: libName.}
  proc cusolverDnZunmtrUnderScore*(handle: cusolverDnHandle_t; side: cublasSideMode_t;
                        uplo: cublasFillMode_t; trans: cublasOperation_t; m: cint;
                        n: cint; A: ptr cuDoubleComplex; lda: cint;
                        tau: ptr cuDoubleComplex; C: ptr cuDoubleComplex; ldc: cint;
                        work: ptr cuDoubleComplex; lwork: cint; info: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZunmtr", dynlib: libName.}
  ##  singular value decomposition, A = U * Sigma * V^H
  proc cusolverDnSgesvd_bufferSizeUnderScore*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   lwork: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnSgesvd_bufferSize", dynlib: libName.}
  proc cusolverDnDgesvd_bufferSizeUnderScore*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   lwork: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnDgesvd_bufferSize", dynlib: libName.}
  proc cusolverDnCgesvd_bufferSizeUnderScore*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   lwork: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnCgesvd_bufferSize", dynlib: libName.}
  proc cusolverDnZgesvd_bufferSizeUnderScore*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   lwork: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnZgesvd_bufferSize", dynlib: libName.}
  proc cusolverDnSgesvdUnderScore*(handle: cusolverDnHandle_t; jobu: cchar; jobvt: cchar;
                        m: cint; n: cint; A: ptr cfloat; lda: cint; S: ptr cfloat;
                        U: ptr cfloat; ldu: cint; VT: ptr cfloat; ldvt: cint;
                        work: ptr cfloat; lwork: cint; rwork: ptr cfloat; info: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnSgesvd", dynlib: libName.}
  proc cusolverDnDgesvdUnderScore*(handle: cusolverDnHandle_t; jobu: cchar; jobvt: cchar;
                        m: cint; n: cint; A: ptr cdouble; lda: cint; S: ptr cdouble;
                        U: ptr cdouble; ldu: cint; VT: ptr cdouble; ldvt: cint;
                        work: ptr cdouble; lwork: cint; rwork: ptr cdouble;
                        info: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnDgesvd", dynlib: libName.}
  proc cusolverDnCgesvdUnderScore*(handle: cusolverDnHandle_t; jobu: cchar; jobvt: cchar;
                        m: cint; n: cint; A: ptr cuComplex; lda: cint; S: ptr cfloat;
                        U: ptr cuComplex; ldu: cint; VT: ptr cuComplex; ldvt: cint;
                        work: ptr cuComplex; lwork: cint; rwork: ptr cfloat;
                        info: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnCgesvd", dynlib: libName.}
  proc cusolverDnZgesvdUnderScore*(handle: cusolverDnHandle_t; jobu: cchar; jobvt: cchar;
                        m: cint; n: cint; A: ptr cuDoubleComplex; lda: cint;
                        S: ptr cdouble; U: ptr cuDoubleComplex; ldu: cint;
                        VT: ptr cuDoubleComplex; ldvt: cint;
                        work: ptr cuDoubleComplex; lwork: cint; rwork: ptr cdouble;
                        info: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnZgesvd", dynlib: libName.}
  ##  standard symmetric eigenvalue solver, A*x = lambda*x, by divide-and-conquer
  ##
  proc cusolverDnSsyevd_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   jobz: cusolverEigMode_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cfloat;
                                   lda: cint; W: ptr cfloat; lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnSsyevd_bufferSize", dynlib: libName.}
  proc cusolverDnDsyevd_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   jobz: cusolverEigMode_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cdouble;
                                   lda: cint; W: ptr cdouble; lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnDsyevd_bufferSize", dynlib: libName.}
  proc cusolverDnCheevd_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   jobz: cusolverEigMode_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuComplex; lda: cint; W: ptr cfloat;
                                   lwork: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnCheevd_bufferSize", dynlib: libName.}
  proc cusolverDnZheevd_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   jobz: cusolverEigMode_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuDoubleComplex; lda: cint; W: ptr cdouble;
                                   lwork: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnZheevd_bufferSize", dynlib: libName.}
  proc cusolverDnSsyevdUnderScore*(handle: cusolverDnHandle_t; jobz: cusolverEigMode_t;
                        uplo: cublasFillMode_t; n: cint; A: ptr cfloat; lda: cint;
                        W: ptr cfloat; work: ptr cfloat; lwork: cint; info: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnSsyevd", dynlib: libName.}
  proc cusolverDnDsyevdUnderScore*(handle: cusolverDnHandle_t; jobz: cusolverEigMode_t;
                        uplo: cublasFillMode_t; n: cint; A: ptr cdouble; lda: cint;
                        W: ptr cdouble; work: ptr cdouble; lwork: cint; info: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnDsyevd", dynlib: libName.}
  proc cusolverDnCheevdUnderScore*(handle: cusolverDnHandle_t; jobz: cusolverEigMode_t;
                        uplo: cublasFillMode_t; n: cint; A: ptr cuComplex; lda: cint;
                        W: ptr cfloat; work: ptr cuComplex; lwork: cint; info: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnCheevd", dynlib: libName.}
  proc cusolverDnZheevdUnderScore*(handle: cusolverDnHandle_t; jobz: cusolverEigMode_t;
                        uplo: cublasFillMode_t; n: cint; A: ptr cuDoubleComplex;
                        lda: cint; W: ptr cdouble; work: ptr cuDoubleComplex;
                        lwork: cint; info: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnZheevd", dynlib: libName.}
  ##  standard selective symmetric eigenvalue solver, A*x = lambda*x, by
  ##  divide-and-conquer
  proc cusolverDnSsyevdx_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                    jobz: cusolverEigMode_t;
                                    range: cusolverEigRange_t;
                                    uplo: cublasFillMode_t; n: cint; A: ptr cfloat;
                                    lda: cint; vl: cfloat; vu: cfloat; il: cint;
                                    iu: cint; meig: ptr cint; W: ptr cfloat;
                                    lwork: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnSsyevdx_bufferSize", dynlib: libName.}
  proc cusolverDnDsyevdx_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                    jobz: cusolverEigMode_t;
                                    range: cusolverEigRange_t;
                                    uplo: cublasFillMode_t; n: cint; A: ptr cdouble;
                                    lda: cint; vl: cdouble; vu: cdouble; il: cint;
                                    iu: cint; meig: ptr cint; W: ptr cdouble;
                                    lwork: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnDsyevdx_bufferSize", dynlib: libName.}
  proc cusolverDnCheevdx_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                    jobz: cusolverEigMode_t;
                                    range: cusolverEigRange_t;
                                    uplo: cublasFillMode_t; n: cint;
                                    A: ptr cuComplex; lda: cint; vl: cfloat;
                                    vu: cfloat; il: cint; iu: cint; meig: ptr cint;
                                    W: ptr cfloat; lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnCheevdx_bufferSize", dynlib: libName.}
  proc cusolverDnZheevdx_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                    jobz: cusolverEigMode_t;
                                    range: cusolverEigRange_t;
                                    uplo: cublasFillMode_t; n: cint;
                                    A: ptr cuDoubleComplex; lda: cint; vl: cdouble;
                                    vu: cdouble; il: cint; iu: cint; meig: ptr cint;
                                    W: ptr cdouble; lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZheevdx_bufferSize", dynlib: libName.}
  proc cusolverDnSsyevdxUnderScore*(handle: cusolverDnHandle_t; jobz: cusolverEigMode_t;
                         range: cusolverEigRange_t; uplo: cublasFillMode_t; n: cint;
                         A: ptr cfloat; lda: cint; vl: cfloat; vu: cfloat; il: cint;
                         iu: cint; meig: ptr cint; W: ptr cfloat; work: ptr cfloat;
                         lwork: cint; info: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnSsyevdx", dynlib: libName.}
  proc cusolverDnDsyevdxUnderScore*(handle: cusolverDnHandle_t; jobz: cusolverEigMode_t;
                         range: cusolverEigRange_t; uplo: cublasFillMode_t; n: cint;
                         A: ptr cdouble; lda: cint; vl: cdouble; vu: cdouble; il: cint;
                         iu: cint; meig: ptr cint; W: ptr cdouble; work: ptr cdouble;
                         lwork: cint; info: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnDsyevdx", dynlib: libName.}
  proc cusolverDnCheevdxUnderScore*(handle: cusolverDnHandle_t; jobz: cusolverEigMode_t;
                         range: cusolverEigRange_t; uplo: cublasFillMode_t; n: cint;
                         A: ptr cuComplex; lda: cint; vl: cfloat; vu: cfloat; il: cint;
                         iu: cint; meig: ptr cint; W: ptr cfloat; work: ptr cuComplex;
                         lwork: cint; info: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnCheevdx", dynlib: libName.}
  proc cusolverDnZheevdxUnderScore*(handle: cusolverDnHandle_t; jobz: cusolverEigMode_t;
                         range: cusolverEigRange_t; uplo: cublasFillMode_t; n: cint;
                         A: ptr cuDoubleComplex; lda: cint; vl: cdouble; vu: cdouble;
                         il: cint; iu: cint; meig: ptr cint; W: ptr cdouble;
                         work: ptr cuDoubleComplex; lwork: cint; info: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZheevdx", dynlib: libName.}
  ##  selective generalized symmetric eigenvalue solver, A*x = lambda*B*x, by
  ##  divide-and-conquer
  proc cusolverDnSsygvdx_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                    itype: cusolverEigType_t;
                                    jobz: cusolverEigMode_t;
                                    range: cusolverEigRange_t;
                                    uplo: cublasFillMode_t; n: cint; A: ptr cfloat;
                                    lda: cint; B: ptr cfloat; ldb: cint; vl: cfloat;
                                    vu: cfloat; il: cint; iu: cint; meig: ptr cint;
                                    W: ptr cfloat; lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnSsygvdx_bufferSize", dynlib: libName.}
  proc cusolverDnDsygvdx_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                    itype: cusolverEigType_t;
                                    jobz: cusolverEigMode_t;
                                    range: cusolverEigRange_t;
                                    uplo: cublasFillMode_t; n: cint; A: ptr cdouble;
                                    lda: cint; B: ptr cdouble; ldb: cint; vl: cdouble;
                                    vu: cdouble; il: cint; iu: cint; meig: ptr cint;
                                    W: ptr cdouble; lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnDsygvdx_bufferSize", dynlib: libName.}
  proc cusolverDnChegvdx_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                    itype: cusolverEigType_t;
                                    jobz: cusolverEigMode_t;
                                    range: cusolverEigRange_t;
                                    uplo: cublasFillMode_t; n: cint;
                                    A: ptr cuComplex; lda: cint; B: ptr cuComplex;
                                    ldb: cint; vl: cfloat; vu: cfloat; il: cint;
                                    iu: cint; meig: ptr cint; W: ptr cfloat;
                                    lwork: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnChegvdx_bufferSize", dynlib: libName.}
  proc cusolverDnZhegvdx_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                    itype: cusolverEigType_t;
                                    jobz: cusolverEigMode_t;
                                    range: cusolverEigRange_t;
                                    uplo: cublasFillMode_t; n: cint;
                                    A: ptr cuDoubleComplex; lda: cint;
                                    B: ptr cuDoubleComplex; ldb: cint; vl: cdouble;
                                    vu: cdouble; il: cint; iu: cint; meig: ptr cint;
                                    W: ptr cdouble; lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZhegvdx_bufferSize", dynlib: libName.}
  proc cusolverDnSsygvdxUnderScore*(handle: cusolverDnHandle_t; itype: cusolverEigType_t;
                         jobz: cusolverEigMode_t; range: cusolverEigRange_t;
                         uplo: cublasFillMode_t; n: cint; A: ptr cfloat; lda: cint;
                         B: ptr cfloat; ldb: cint; vl: cfloat; vu: cfloat; il: cint;
                         iu: cint; meig: ptr cint; W: ptr cfloat; work: ptr cfloat;
                         lwork: cint; info: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnSsygvdx", dynlib: libName.}
  proc cusolverDnDsygvdxUnderScore*(handle: cusolverDnHandle_t; itype: cusolverEigType_t;
                         jobz: cusolverEigMode_t; range: cusolverEigRange_t;
                         uplo: cublasFillMode_t; n: cint; A: ptr cdouble; lda: cint;
                         B: ptr cdouble; ldb: cint; vl: cdouble; vu: cdouble; il: cint;
                         iu: cint; meig: ptr cint; W: ptr cdouble; work: ptr cdouble;
                         lwork: cint; info: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnDsygvdx", dynlib: libName.}
  proc cusolverDnChegvdxUnderScore*(handle: cusolverDnHandle_t; itype: cusolverEigType_t;
                         jobz: cusolverEigMode_t; range: cusolverEigRange_t;
                         uplo: cublasFillMode_t; n: cint; A: ptr cuComplex; lda: cint;
                         B: ptr cuComplex; ldb: cint; vl: cfloat; vu: cfloat; il: cint;
                         iu: cint; meig: ptr cint; W: ptr cfloat; work: ptr cuComplex;
                         lwork: cint; info: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnChegvdx", dynlib: libName.}
  proc cusolverDnZhegvdxUnderScore*(handle: cusolverDnHandle_t; itype: cusolverEigType_t;
                         jobz: cusolverEigMode_t; range: cusolverEigRange_t;
                         uplo: cublasFillMode_t; n: cint; A: ptr cuDoubleComplex;
                         lda: cint; B: ptr cuDoubleComplex; ldb: cint; vl: cdouble;
                         vu: cdouble; il: cint; iu: cint; meig: ptr cint; W: ptr cdouble;
                         work: ptr cuDoubleComplex; lwork: cint; info: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZhegvdx", dynlib: libName.}
  ##  generalized symmetric eigenvalue solver, A*x = lambda*B*x, by
  ##  divide-and-conquer
  proc cusolverDnSsygvd_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   itype: cusolverEigType_t;
                                   jobz: cusolverEigMode_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cfloat;
                                   lda: cint; B: ptr cfloat; ldb: cint; W: ptr cfloat;
                                   lwork: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnSsygvd_bufferSize", dynlib: libName.}
  proc cusolverDnDsygvd_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   itype: cusolverEigType_t;
                                   jobz: cusolverEigMode_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cdouble;
                                   lda: cint; B: ptr cdouble; ldb: cint;
                                   W: ptr cdouble; lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnDsygvd_bufferSize", dynlib: libName.}
  proc cusolverDnChegvd_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   itype: cusolverEigType_t;
                                   jobz: cusolverEigMode_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuComplex; lda: cint; B: ptr cuComplex;
                                   ldb: cint; W: ptr cfloat; lwork: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnChegvd_bufferSize", dynlib: libName.}
  proc cusolverDnZhegvd_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   itype: cusolverEigType_t;
                                   jobz: cusolverEigMode_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuDoubleComplex; lda: cint;
                                   B: ptr cuDoubleComplex; ldb: cint; W: ptr cdouble;
                                   lwork: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnZhegvd_bufferSize", dynlib: libName.}
  proc cusolverDnSsygvdUnderScore*(handle: cusolverDnHandle_t; itype: cusolverEigType_t;
                        jobz: cusolverEigMode_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cfloat; lda: cint; B: ptr cfloat; ldb: cint; W: ptr cfloat;
                        work: ptr cfloat; lwork: cint; info: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnSsygvd", dynlib: libName.}
  proc cusolverDnDsygvdUnderScore*(handle: cusolverDnHandle_t; itype: cusolverEigType_t;
                        jobz: cusolverEigMode_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cdouble; lda: cint; B: ptr cdouble; ldb: cint;
                        W: ptr cdouble; work: ptr cdouble; lwork: cint; info: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnDsygvd", dynlib: libName.}
  proc cusolverDnChegvdUnderScore*(handle: cusolverDnHandle_t; itype: cusolverEigType_t;
                        jobz: cusolverEigMode_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cuComplex; lda: cint; B: ptr cuComplex; ldb: cint;
                        W: ptr cfloat; work: ptr cuComplex; lwork: cint; info: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnChegvd", dynlib: libName.}
  proc cusolverDnZhegvdUnderScore*(handle: cusolverDnHandle_t; itype: cusolverEigType_t;
                        jobz: cusolverEigMode_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cuDoubleComplex; lda: cint; B: ptr cuDoubleComplex;
                        ldb: cint; W: ptr cdouble; work: ptr cuDoubleComplex;
                        lwork: cint; info: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnZhegvd", dynlib: libName.}
  proc cusolverDnCreateSyevjInfoUnderScore*(info: ptr syevjInfo_t): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnCreateSyevjInfo", dynlib: libName.}
  proc cusolverDnDestroySyevjInfoUnderScore*(info: syevjInfo_t): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnDestroySyevjInfo", dynlib: libName.}
  proc cusolverDnXsyevjSetToleranceUnderScore*(info: syevjInfo_t; tolerance: cdouble): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnXsyevjSetTolerance", dynlib: libName.}
  proc cusolverDnXsyevjSetMaxSweepsUnderScore*(info: syevjInfo_t; max_sweeps: cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnXsyevjSetMaxSweeps", dynlib: libName.}
  proc cusolverDnXsyevjSetSortEigUnderScore*(info: syevjInfo_t; sort_eig: cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnXsyevjSetSortEig", dynlib: libName.}
  proc cusolverDnXsyevjGetResidualUnderScore*(handle: cusolverDnHandle_t; info: syevjInfo_t;
                                   residual: ptr cdouble): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnXsyevjGetResidual", dynlib: libName.}
  proc cusolverDnXsyevjGetSweepsUnderScore*(handle: cusolverDnHandle_t; info: syevjInfo_t;
                                 executed_sweeps: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnXsyevjGetSweeps", dynlib: libName.}
  proc cusolverDnSsyevjBatched_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
      jobz: cusolverEigMode_t; uplo: cublasFillMode_t; n: cint; A: ptr cfloat; lda: cint;
      W: ptr cfloat; lwork: ptr cint; params: syevjInfo_t; batchSize: cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnSsyevjBatched_bufferSize", dynlib: libName.}
  proc cusolverDnDsyevjBatched_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
      jobz: cusolverEigMode_t; uplo: cublasFillMode_t; n: cint; A: ptr cdouble;
      lda: cint; W: ptr cdouble; lwork: ptr cint; params: syevjInfo_t; batchSize: cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnDsyevjBatched_bufferSize", dynlib: libName.}
  proc cusolverDnCheevjBatched_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
      jobz: cusolverEigMode_t; uplo: cublasFillMode_t; n: cint; A: ptr cuComplex;
      lda: cint; W: ptr cfloat; lwork: ptr cint; params: syevjInfo_t; batchSize: cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnCheevjBatched_bufferSize", dynlib: libName.}
  proc cusolverDnZheevjBatched_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
      jobz: cusolverEigMode_t; uplo: cublasFillMode_t; n: cint;
      A: ptr cuDoubleComplex; lda: cint; W: ptr cdouble; lwork: ptr cint;
      params: syevjInfo_t; batchSize: cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnZheevjBatched_bufferSize", dynlib: libName.}
  proc cusolverDnSsyevjBatchedUnderScore*(handle: cusolverDnHandle_t;
                               jobz: cusolverEigMode_t; uplo: cublasFillMode_t;
                               n: cint; A: ptr cfloat; lda: cint; W: ptr cfloat;
                               work: ptr cfloat; lwork: cint; info: ptr cint;
                               params: syevjInfo_t; batchSize: cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnSsyevjBatched", dynlib: libName.}
  proc cusolverDnDsyevjBatchedUnderScore*(handle: cusolverDnHandle_t;
                               jobz: cusolverEigMode_t; uplo: cublasFillMode_t;
                               n: cint; A: ptr cdouble; lda: cint; W: ptr cdouble;
                               work: ptr cdouble; lwork: cint; info: ptr cint;
                               params: syevjInfo_t; batchSize: cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnDsyevjBatched", dynlib: libName.}
  proc cusolverDnCheevjBatchedUnderScore*(handle: cusolverDnHandle_t;
                               jobz: cusolverEigMode_t; uplo: cublasFillMode_t;
                               n: cint; A: ptr cuComplex; lda: cint; W: ptr cfloat;
                               work: ptr cuComplex; lwork: cint; info: ptr cint;
                               params: syevjInfo_t; batchSize: cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnCheevjBatched", dynlib: libName.}
  proc cusolverDnZheevjBatchedUnderScore*(handle: cusolverDnHandle_t;
                               jobz: cusolverEigMode_t; uplo: cublasFillMode_t;
                               n: cint; A: ptr cuDoubleComplex; lda: cint;
                               W: ptr cdouble; work: ptr cuDoubleComplex; lwork: cint;
                               info: ptr cint; params: syevjInfo_t; batchSize: cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZheevjBatched", dynlib: libName.}
  proc cusolverDnSsyevj_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   jobz: cusolverEigMode_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cfloat;
                                   lda: cint; W: ptr cfloat; lwork: ptr cint;
                                   params: syevjInfo_t): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnSsyevj_bufferSize", dynlib: libName.}
  proc cusolverDnDsyevj_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   jobz: cusolverEigMode_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cdouble;
                                   lda: cint; W: ptr cdouble; lwork: ptr cint;
                                   params: syevjInfo_t): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnDsyevj_bufferSize", dynlib: libName.}
  proc cusolverDnCheevj_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   jobz: cusolverEigMode_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuComplex; lda: cint; W: ptr cfloat;
                                   lwork: ptr cint; params: syevjInfo_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnCheevj_bufferSize", dynlib: libName.}
  proc cusolverDnZheevj_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   jobz: cusolverEigMode_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuDoubleComplex; lda: cint; W: ptr cdouble;
                                   lwork: ptr cint; params: syevjInfo_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZheevj_bufferSize", dynlib: libName.}
  proc cusolverDnSsyevjUnderScore*(handle: cusolverDnHandle_t; jobz: cusolverEigMode_t;
                        uplo: cublasFillMode_t; n: cint; A: ptr cfloat; lda: cint;
                        W: ptr cfloat; work: ptr cfloat; lwork: cint; info: ptr cint;
                        params: syevjInfo_t): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnSsyevj", dynlib: libName.}
  proc cusolverDnDsyevjUnderScore*(handle: cusolverDnHandle_t; jobz: cusolverEigMode_t;
                        uplo: cublasFillMode_t; n: cint; A: ptr cdouble; lda: cint;
                        W: ptr cdouble; work: ptr cdouble; lwork: cint; info: ptr cint;
                        params: syevjInfo_t): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnDsyevj", dynlib: libName.}
  proc cusolverDnCheevjUnderScore*(handle: cusolverDnHandle_t; jobz: cusolverEigMode_t;
                        uplo: cublasFillMode_t; n: cint; A: ptr cuComplex; lda: cint;
                        W: ptr cfloat; work: ptr cuComplex; lwork: cint; info: ptr cint;
                        params: syevjInfo_t): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnCheevj", dynlib: libName.}
  proc cusolverDnZheevjUnderScore*(handle: cusolverDnHandle_t; jobz: cusolverEigMode_t;
                        uplo: cublasFillMode_t; n: cint; A: ptr cuDoubleComplex;
                        lda: cint; W: ptr cdouble; work: ptr cuDoubleComplex;
                        lwork: cint; info: ptr cint; params: syevjInfo_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZheevj", dynlib: libName.}
  proc cusolverDnSsygvj_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   itype: cusolverEigType_t;
                                   jobz: cusolverEigMode_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cfloat;
                                   lda: cint; B: ptr cfloat; ldb: cint; W: ptr cfloat;
                                   lwork: ptr cint; params: syevjInfo_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnSsygvj_bufferSize", dynlib: libName.}
  proc cusolverDnDsygvj_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   itype: cusolverEigType_t;
                                   jobz: cusolverEigMode_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cdouble;
                                   lda: cint; B: ptr cdouble; ldb: cint;
                                   W: ptr cdouble; lwork: ptr cint;
                                   params: syevjInfo_t): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnDsygvj_bufferSize", dynlib: libName.}
  proc cusolverDnChegvj_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   itype: cusolverEigType_t;
                                   jobz: cusolverEigMode_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuComplex; lda: cint; B: ptr cuComplex;
                                   ldb: cint; W: ptr cfloat; lwork: ptr cint;
                                   params: syevjInfo_t): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnChegvj_bufferSize", dynlib: libName.}
  proc cusolverDnZhegvj_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   itype: cusolverEigType_t;
                                   jobz: cusolverEigMode_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuDoubleComplex; lda: cint;
                                   B: ptr cuDoubleComplex; ldb: cint; W: ptr cdouble;
                                   lwork: ptr cint; params: syevjInfo_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZhegvj_bufferSize", dynlib: libName.}
  proc cusolverDnSsygvjUnderScore*(handle: cusolverDnHandle_t; itype: cusolverEigType_t;
                        jobz: cusolverEigMode_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cfloat; lda: cint; B: ptr cfloat; ldb: cint; W: ptr cfloat;
                        work: ptr cfloat; lwork: cint; info: ptr cint;
                        params: syevjInfo_t): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnSsygvj", dynlib: libName.}
  proc cusolverDnDsygvjUnderScore*(handle: cusolverDnHandle_t; itype: cusolverEigType_t;
                        jobz: cusolverEigMode_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cdouble; lda: cint; B: ptr cdouble; ldb: cint;
                        W: ptr cdouble; work: ptr cdouble; lwork: cint; info: ptr cint;
                        params: syevjInfo_t): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnDsygvj", dynlib: libName.}
  proc cusolverDnChegvjUnderScore*(handle: cusolverDnHandle_t; itype: cusolverEigType_t;
                        jobz: cusolverEigMode_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cuComplex; lda: cint; B: ptr cuComplex; ldb: cint;
                        W: ptr cfloat; work: ptr cuComplex; lwork: cint; info: ptr cint;
                        params: syevjInfo_t): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnChegvj", dynlib: libName.}
  proc cusolverDnZhegvjUnderScore*(handle: cusolverDnHandle_t; itype: cusolverEigType_t;
                        jobz: cusolverEigMode_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cuDoubleComplex; lda: cint; B: ptr cuDoubleComplex;
                        ldb: cint; W: ptr cdouble; work: ptr cuDoubleComplex;
                        lwork: cint; info: ptr cint; params: syevjInfo_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZhegvj", dynlib: libName.}
  proc cusolverDnCreateGesvdjInfoUnderScore*(info: ptr gesvdjInfo_t): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnCreateGesvdjInfo", dynlib: libName.}
  proc cusolverDnDestroyGesvdjInfoUnderScore*(info: gesvdjInfo_t): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnDestroyGesvdjInfo", dynlib: libName.}
  proc cusolverDnXgesvdjSetToleranceUnderScore*(info: gesvdjInfo_t; tolerance: cdouble): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnXgesvdjSetTolerance", dynlib: libName.}
  proc cusolverDnXgesvdjSetMaxSweepsUnderScore*(info: gesvdjInfo_t; max_sweeps: cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnXgesvdjSetMaxSweeps", dynlib: libName.}
  proc cusolverDnXgesvdjSetSortEigUnderScore*(info: gesvdjInfo_t; sort_svd: cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnXgesvdjSetSortEig", dynlib: libName.}
  proc cusolverDnXgesvdjGetResidualUnderScore*(handle: cusolverDnHandle_t;
                                    info: gesvdjInfo_t; residual: ptr cdouble): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnXgesvdjGetResidual", dynlib: libName.}
  proc cusolverDnXgesvdjGetSweepsUnderScore*(handle: cusolverDnHandle_t; info: gesvdjInfo_t;
                                  executed_sweeps: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnXgesvdjGetSweeps", dynlib: libName.}
  proc cusolverDnSgesvdjBatched_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
      jobz: cusolverEigMode_t; m: cint; n: cint; A: ptr cfloat; lda: cint; S: ptr cfloat;
      U: ptr cfloat; ldu: cint; V: ptr cfloat; ldv: cint; lwork: ptr cint;
      params: gesvdjInfo_t; batchSize: cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnSgesvdjBatched_bufferSize", dynlib: libName.}
  proc cusolverDnDgesvdjBatched_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
      jobz: cusolverEigMode_t; m: cint; n: cint; A: ptr cdouble; lda: cint; S: ptr cdouble;
      U: ptr cdouble; ldu: cint; V: ptr cdouble; ldv: cint; lwork: ptr cint;
      params: gesvdjInfo_t; batchSize: cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnDgesvdjBatched_bufferSize", dynlib: libName.}
  proc cusolverDnCgesvdjBatched_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
      jobz: cusolverEigMode_t; m: cint; n: cint; A: ptr cuComplex; lda: cint;
      S: ptr cfloat; U: ptr cuComplex; ldu: cint; V: ptr cuComplex; ldv: cint;
      lwork: ptr cint; params: gesvdjInfo_t; batchSize: cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnCgesvdjBatched_bufferSize", dynlib: libName.}
  proc cusolverDnZgesvdjBatched_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
      jobz: cusolverEigMode_t; m: cint; n: cint; A: ptr cuDoubleComplex; lda: cint;
      S: ptr cdouble; U: ptr cuDoubleComplex; ldu: cint; V: ptr cuDoubleComplex; ldv: cint;
      lwork: ptr cint; params: gesvdjInfo_t; batchSize: cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnZgesvdjBatched_bufferSize", dynlib: libName.}
  proc cusolverDnSgesvdjBatchedUnderScore*(handle: cusolverDnHandle_t;
                                jobz: cusolverEigMode_t; m: cint; n: cint;
                                A: ptr cfloat; lda: cint; S: ptr cfloat; U: ptr cfloat;
                                ldu: cint; V: ptr cfloat; ldv: cint; work: ptr cfloat;
                                lwork: cint; info: ptr cint; params: gesvdjInfo_t;
                                batchSize: cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnSgesvdjBatched", dynlib: libName.}
  proc cusolverDnDgesvdjBatchedUnderScore*(handle: cusolverDnHandle_t;
                                jobz: cusolverEigMode_t; m: cint; n: cint;
                                A: ptr cdouble; lda: cint; S: ptr cdouble;
                                U: ptr cdouble; ldu: cint; V: ptr cdouble; ldv: cint;
                                work: ptr cdouble; lwork: cint; info: ptr cint;
                                params: gesvdjInfo_t; batchSize: cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnDgesvdjBatched", dynlib: libName.}
  proc cusolverDnCgesvdjBatchedUnderScore*(handle: cusolverDnHandle_t;
                                jobz: cusolverEigMode_t; m: cint; n: cint;
                                A: ptr cuComplex; lda: cint; S: ptr cfloat;
                                U: ptr cuComplex; ldu: cint; V: ptr cuComplex;
                                ldv: cint; work: ptr cuComplex; lwork: cint;
                                info: ptr cint; params: gesvdjInfo_t; batchSize: cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnCgesvdjBatched", dynlib: libName.}
  proc cusolverDnZgesvdjBatchedUnderScore*(handle: cusolverDnHandle_t;
                                jobz: cusolverEigMode_t; m: cint; n: cint;
                                A: ptr cuDoubleComplex; lda: cint; S: ptr cdouble;
                                U: ptr cuDoubleComplex; ldu: cint;
                                V: ptr cuDoubleComplex; ldv: cint;
                                work: ptr cuDoubleComplex; lwork: cint;
                                info: ptr cint; params: gesvdjInfo_t; batchSize: cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZgesvdjBatched", dynlib: libName.}
  proc cusolverDnSgesvdj_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                    jobz: cusolverEigMode_t; econ: cint; m: cint;
                                    n: cint; A: ptr cfloat; lda: cint; S: ptr cfloat;
                                    U: ptr cfloat; ldu: cint; V: ptr cfloat; ldv: cint;
                                    lwork: ptr cint; params: gesvdjInfo_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnSgesvdj_bufferSize", dynlib: libName.}
  proc cusolverDnDgesvdj_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                    jobz: cusolverEigMode_t; econ: cint; m: cint;
                                    n: cint; A: ptr cdouble; lda: cint; S: ptr cdouble;
                                    U: ptr cdouble; ldu: cint; V: ptr cdouble;
                                    ldv: cint; lwork: ptr cint; params: gesvdjInfo_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnDgesvdj_bufferSize", dynlib: libName.}
  proc cusolverDnCgesvdj_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                    jobz: cusolverEigMode_t; econ: cint; m: cint;
                                    n: cint; A: ptr cuComplex; lda: cint;
                                    S: ptr cfloat; U: ptr cuComplex; ldu: cint;
                                    V: ptr cuComplex; ldv: cint; lwork: ptr cint;
                                    params: gesvdjInfo_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnCgesvdj_bufferSize", dynlib: libName.}
  proc cusolverDnZgesvdj_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                    jobz: cusolverEigMode_t; econ: cint; m: cint;
                                    n: cint; A: ptr cuDoubleComplex; lda: cint;
                                    S: ptr cdouble; U: ptr cuDoubleComplex; ldu: cint;
                                    V: ptr cuDoubleComplex; ldv: cint;
                                    lwork: ptr cint; params: gesvdjInfo_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnZgesvdj_bufferSize", dynlib: libName.}
  proc cusolverDnSgesvdjUnderScore*(handle: cusolverDnHandle_t; jobz: cusolverEigMode_t;
                         econ: cint; m: cint; n: cint; A: ptr cfloat; lda: cint;
                         S: ptr cfloat; U: ptr cfloat; ldu: cint; V: ptr cfloat; ldv: cint;
                         work: ptr cfloat; lwork: cint; info: ptr cint;
                         params: gesvdjInfo_t): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnSgesvdj", dynlib: libName.}
  proc cusolverDnDgesvdjUnderScore*(handle: cusolverDnHandle_t; jobz: cusolverEigMode_t;
                         econ: cint; m: cint; n: cint; A: ptr cdouble; lda: cint;
                         S: ptr cdouble; U: ptr cdouble; ldu: cint; V: ptr cdouble;
                         ldv: cint; work: ptr cdouble; lwork: cint; info: ptr cint;
                         params: gesvdjInfo_t): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnDgesvdj", dynlib: libName.}
  proc cusolverDnCgesvdjUnderScore*(handle: cusolverDnHandle_t; jobz: cusolverEigMode_t;
                         econ: cint; m: cint; n: cint; A: ptr cuComplex; lda: cint;
                         S: ptr cfloat; U: ptr cuComplex; ldu: cint; V: ptr cuComplex;
                         ldv: cint; work: ptr cuComplex; lwork: cint; info: ptr cint;
                         params: gesvdjInfo_t): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnCgesvdj", dynlib: libName.}
  proc cusolverDnZgesvdjUnderScore*(handle: cusolverDnHandle_t; jobz: cusolverEigMode_t;
                         econ: cint; m: cint; n: cint; A: ptr cuDoubleComplex; lda: cint;
                         S: ptr cdouble; U: ptr cuDoubleComplex; ldu: cint;
                         V: ptr cuDoubleComplex; ldv: cint;
                         work: ptr cuDoubleComplex; lwork: cint; info: ptr cint;
                         params: gesvdjInfo_t): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnZgesvdj", dynlib: libName.}
  ##  batched approximate SVD
  proc cusolverDnSgesvdaStridedBatched_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
      jobz: cusolverEigMode_t; rank: cint; m: cint; n: cint; d_A: ptr cfloat; lda: cint;
      strideA: clonglong; d_S: ptr cfloat; strideS: clonglong; d_U: ptr cfloat; ldu: cint;
      strideU: clonglong; d_V: ptr cfloat; ldv: cint; strideV: clonglong;
      lwork: ptr cint; batchSize: cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnSgesvdaStridedBatched_bufferSize", dynlib: libName.}
  proc cusolverDnDgesvdaStridedBatched_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
      jobz: cusolverEigMode_t; rank: cint; m: cint; n: cint; d_A: ptr cdouble; lda: cint;
      strideA: clonglong; d_S: ptr cdouble; strideS: clonglong; d_U: ptr cdouble;
      ldu: cint; strideU: clonglong; d_V: ptr cdouble; ldv: cint; strideV: clonglong;
      lwork: ptr cint; batchSize: cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnDgesvdaStridedBatched_bufferSize", dynlib: libName.}
  proc cusolverDnCgesvdaStridedBatched_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
      jobz: cusolverEigMode_t; rank: cint; m: cint; n: cint; d_A: ptr cuComplex; lda: cint;
      strideA: clonglong; d_S: ptr cfloat; strideS: clonglong; d_U: ptr cuComplex;
      ldu: cint; strideU: clonglong; d_V: ptr cuComplex; ldv: cint; strideV: clonglong;
      lwork: ptr cint; batchSize: cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnCgesvdaStridedBatched_bufferSize", dynlib: libName.}
  proc cusolverDnZgesvdaStridedBatched_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
      jobz: cusolverEigMode_t; rank: cint; m: cint; n: cint; d_A: ptr cuDoubleComplex;
      lda: cint; strideA: clonglong; d_S: ptr cdouble; strideS: clonglong;
      d_U: ptr cuDoubleComplex; ldu: cint; strideU: clonglong;
      d_V: ptr cuDoubleComplex; ldv: cint; strideV: clonglong; lwork: ptr cint;
      batchSize: cint): cusolverStatus_t {.discardable, cdecl, importc: "cusolverDnZgesvdaStridedBatched_bufferSize",
                                        dynlib: libName.}
  proc cusolverDnSgesvdaStridedBatchedUnderScore*(handle: cusolverDnHandle_t;
                                       jobz: cusolverEigMode_t; rank: cint; m: cint;
                                       n: cint; d_A: ptr cfloat; lda: cint;
                                       strideA: clonglong; d_S: ptr cfloat;
                                       strideS: clonglong; d_U: ptr cfloat;
                                       ldu: cint; strideU: clonglong;
                                       d_V: ptr cfloat; ldv: cint;
                                       strideV: clonglong; d_work: ptr cfloat;
                                       lwork: cint; d_info: ptr cint;
                                       h_R_nrmF: ptr cdouble; batchSize: cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnSgesvdaStridedBatched", dynlib: libName.}
  proc cusolverDnDgesvdaStridedBatchedUnderScore*(handle: cusolverDnHandle_t;
                                       jobz: cusolverEigMode_t; rank: cint; m: cint;
                                       n: cint; d_A: ptr cdouble; lda: cint;
                                       strideA: clonglong; d_S: ptr cdouble;
                                       strideS: clonglong; d_U: ptr cdouble;
                                       ldu: cint; strideU: clonglong;
                                       d_V: ptr cdouble; ldv: cint;
                                       strideV: clonglong; d_work: ptr cdouble;
                                       lwork: cint; d_info: ptr cint;
                                       h_R_nrmF: ptr cdouble; batchSize: cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnDgesvdaStridedBatched", dynlib: libName.}
  proc cusolverDnCgesvdaStridedBatchedUnderScore*(handle: cusolverDnHandle_t;
                                       jobz: cusolverEigMode_t; rank: cint; m: cint;
                                       n: cint; d_A: ptr cuComplex; lda: cint;
                                       strideA: clonglong; d_S: ptr cfloat;
                                       strideS: clonglong; d_U: ptr cuComplex;
                                       ldu: cint; strideU: clonglong;
                                       d_V: ptr cuComplex; ldv: cint;
                                       strideV: clonglong; d_work: ptr cuComplex;
                                       lwork: cint; d_info: ptr cint;
                                       h_R_nrmF: ptr cdouble; batchSize: cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnCgesvdaStridedBatched", dynlib: libName.}
  proc cusolverDnZgesvdaStridedBatchedUnderScore*(handle: cusolverDnHandle_t;
                                       jobz: cusolverEigMode_t; rank: cint; m: cint;
                                       n: cint; d_A: ptr cuDoubleComplex; lda: cint;
                                       strideA: clonglong; d_S: ptr cdouble;
                                       strideS: clonglong;
                                       d_U: ptr cuDoubleComplex; ldu: cint;
                                       strideU: clonglong;
                                       d_V: ptr cuDoubleComplex; ldv: cint;
                                       strideV: clonglong;
                                       d_work: ptr cuDoubleComplex; lwork: cint;
                                       d_info: ptr cint; h_R_nrmF: ptr cdouble;
                                       batchSize: cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnZgesvdaStridedBatched", dynlib: libName.}
  proc cusolverDnCreateParamsUnderScore*(params: ptr cusolverDnParams_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnCreateParams", dynlib: libName.}
  proc cusolverDnDestroyParamsUnderScore*(params: cusolverDnParams_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnDestroyParams", dynlib: libName.}
  proc cusolverDnSetAdvOptionsUnderScore*(params: cusolverDnParams_t;
                               function: cusolverDnFunction_t;
                               algo: cusolverAlgMode_t): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnSetAdvOptions", dynlib: libName.}
  ##  64-bit API for POTRF
  proc cusolverDnPotrf_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                  params: cusolverDnParams_t;
                                  uplo: cublasFillMode_t; n: clonglong;
                                  dataTypeA: cudaDataType; A: pointer;
                                  lda: clonglong; computeType: cudaDataType;
                                  workspaceInBytes: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnPotrf_bufferSize", dynlib: libName.}
  proc cusolverDnPotrfUnderScore*(handle: cusolverDnHandle_t; params: cusolverDnParams_t;
                       uplo: cublasFillMode_t; n: clonglong;
                       dataTypeA: cudaDataType; A: pointer; lda: clonglong;
                       computeType: cudaDataType; pBuffer: pointer;
                       workspaceInBytes: csize_t; info: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnPotrf", dynlib: libName.}
  ##  64-bit API for POTRS
  proc cusolverDnPotrsUnderScore*(handle: cusolverDnHandle_t; params: cusolverDnParams_t;
                       uplo: cublasFillMode_t; n: clonglong; nrhs: clonglong;
                       dataTypeA: cudaDataType; A: pointer; lda: clonglong;
                       dataTypeB: cudaDataType; B: pointer; ldb: clonglong;
                       info: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnPotrs", dynlib: libName.}
  ##  64-bit API for GEQRF
  proc cusolverDnGeqrf_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                  params: cusolverDnParams_t; m: clonglong;
                                  n: clonglong; dataTypeA: cudaDataType; A: pointer;
                                  lda: clonglong; dataTypeTau: cudaDataType;
                                  tau: pointer; computeType: cudaDataType;
                                  workspaceInBytes: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnGeqrf_bufferSize", dynlib: libName.}
  proc cusolverDnGeqrfUnderScore*(handle: cusolverDnHandle_t; params: cusolverDnParams_t;
                       m: clonglong; n: clonglong; dataTypeA: cudaDataType;
                       A: pointer; lda: clonglong; dataTypeTau: cudaDataType;
                       tau: pointer; computeType: cudaDataType; pBuffer: pointer;
                       workspaceInBytes: csize_t; info: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnGeqrf", dynlib: libName.}
  ##  64-bit API for GETRF
  proc cusolverDnGetrf_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                  params: cusolverDnParams_t; m: clonglong;
                                  n: clonglong; dataTypeA: cudaDataType; A: pointer;
                                  lda: clonglong; computeType: cudaDataType;
                                  workspaceInBytes: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnGetrf_bufferSize", dynlib: libName.}
  proc cusolverDnGetrfUnderScore*(handle: cusolverDnHandle_t; params: cusolverDnParams_t;
                       m: clonglong; n: clonglong; dataTypeA: cudaDataType;
                       A: pointer; lda: clonglong; ipiv: ptr clonglong;
                       computeType: cudaDataType; pBuffer: pointer;
                       workspaceInBytes: csize_t; info: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnGetrf", dynlib: libName.}
  ##  64-bit API for GETRS
  proc cusolverDnGetrsUnderScore*(handle: cusolverDnHandle_t; params: cusolverDnParams_t;
                       trans: cublasOperation_t; n: clonglong; nrhs: clonglong;
                       dataTypeA: cudaDataType; A: pointer; lda: clonglong;
                       ipiv: ptr clonglong; dataTypeB: cudaDataType; B: pointer;
                       ldb: clonglong; info: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnGetrs", dynlib: libName.}
  ##  64-bit API for SYEVD
  proc cusolverDnSyevd_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                  params: cusolverDnParams_t;
                                  jobz: cusolverEigMode_t; uplo: cublasFillMode_t;
                                  n: clonglong; dataTypeA: cudaDataType; A: pointer;
                                  lda: clonglong; dataTypeW: cudaDataType;
                                  W: pointer; computeType: cudaDataType;
                                  workspaceInBytes: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnSyevd_bufferSize", dynlib: libName.}
  proc cusolverDnSyevdUnderScore*(handle: cusolverDnHandle_t; params: cusolverDnParams_t;
                       jobz: cusolverEigMode_t; uplo: cublasFillMode_t;
                       n: clonglong; dataTypeA: cudaDataType; A: pointer;
                       lda: clonglong; dataTypeW: cudaDataType; W: pointer;
                       computeType: cudaDataType; pBuffer: pointer;
                       workspaceInBytes: csize_t; info: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnSyevd", dynlib: libName.}
  ##  64-bit API for SYEVDX
  proc cusolverDnSyevdx_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   params: cusolverDnParams_t;
                                   jobz: cusolverEigMode_t;
                                   range: cusolverEigRange_t;
                                   uplo: cublasFillMode_t; n: clonglong;
                                   dataTypeA: cudaDataType; A: pointer;
                                   lda: clonglong; vl: pointer; vu: pointer;
                                   il: clonglong; iu: clonglong;
                                   h_meig: ptr clonglong; dataTypeW: cudaDataType;
                                   W: pointer; computeType: cudaDataType;
                                   workspaceInBytes: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnSyevdx_bufferSize", dynlib: libName.}
  proc cusolverDnSyevdxUnderScore*(handle: cusolverDnHandle_t; params: cusolverDnParams_t;
                        jobz: cusolverEigMode_t; range: cusolverEigRange_t;
                        uplo: cublasFillMode_t; n: clonglong;
                        dataTypeA: cudaDataType; A: pointer; lda: clonglong;
                        vl: pointer; vu: pointer; il: clonglong; iu: clonglong;
                        meig64: ptr clonglong; dataTypeW: cudaDataType; W: pointer;
                        computeType: cudaDataType; pBuffer: pointer;
                        workspaceInBytes: csize_t; info: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnSyevdx", dynlib: libName.}
  ##  64-bit API for GESVD
  proc cusolverDnGesvd_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                  params: cusolverDnParams_t; jobu: cchar;
                                  jobvt: cchar; m: clonglong; n: clonglong;
                                  dataTypeA: cudaDataType; A: pointer;
                                  lda: clonglong; dataTypeS: cudaDataType;
                                  S: pointer; dataTypeU: cudaDataType; U: pointer;
                                  ldu: clonglong; dataTypeVT: cudaDataType;
                                  VT: pointer; ldvt: clonglong;
                                  computeType: cudaDataType;
                                  workspaceInBytes: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnGesvd_bufferSize", dynlib: libName.}
  proc cusolverDnGesvdUnderScore*(handle: cusolverDnHandle_t; params: cusolverDnParams_t;
                       jobu: cchar; jobvt: cchar; m: clonglong; n: clonglong;
                       dataTypeA: cudaDataType; A: pointer; lda: clonglong;
                       dataTypeS: cudaDataType; S: pointer; dataTypeU: cudaDataType;
                       U: pointer; ldu: clonglong; dataTypeVT: cudaDataType;
                       VT: pointer; ldvt: clonglong; computeType: cudaDataType;
                       pBuffer: pointer; workspaceInBytes: csize_t; info: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnGesvd", dynlib: libName.}
  ##
  ##  new 64-bit API
  ##
  ##  64-bit API for POTRF
  proc cusolverDnXpotrf_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   params: cusolverDnParams_t;
                                   uplo: cublasFillMode_t; n: clonglong;
                                   dataTypeA: cudaDataType; A: pointer;
                                   lda: clonglong; computeType: cudaDataType;
                                   workspaceInBytesOnDevice: ptr csize_t;
                                   workspaceInBytesOnHost: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnXpotrf_bufferSize", dynlib: libName.}
  proc cusolverDnXpotrfUnderScore*(handle: cusolverDnHandle_t; params: cusolverDnParams_t;
                        uplo: cublasFillMode_t; n: clonglong;
                        dataTypeA: cudaDataType; A: pointer; lda: clonglong;
                        computeType: cudaDataType; bufferOnDevice: pointer;
                        workspaceInBytesOnDevice: csize_t; bufferOnHost: pointer;
                        workspaceInBytesOnHost: csize_t; info: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnXpotrf", dynlib: libName.}
  ##  64-bit API for POTRS
  proc cusolverDnXpotrsUnderScore*(handle: cusolverDnHandle_t; params: cusolverDnParams_t;
                        uplo: cublasFillMode_t; n: clonglong; nrhs: clonglong;
                        dataTypeA: cudaDataType; A: pointer; lda: clonglong;
                        dataTypeB: cudaDataType; B: pointer; ldb: clonglong;
                        info: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnXpotrs", dynlib: libName.}
  ##  64-bit API for GEQRF
  proc cusolverDnXgeqrf_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   params: cusolverDnParams_t; m: clonglong;
                                   n: clonglong; dataTypeA: cudaDataType;
                                   A: pointer; lda: clonglong;
                                   dataTypeTau: cudaDataType; tau: pointer;
                                   computeType: cudaDataType;
                                   workspaceInBytesOnDevice: ptr csize_t;
                                   workspaceInBytesOnHost: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnXgeqrf_bufferSize", dynlib: libName.}
  proc cusolverDnXgeqrfUnderScore*(handle: cusolverDnHandle_t; params: cusolverDnParams_t;
                        m: clonglong; n: clonglong; dataTypeA: cudaDataType;
                        A: pointer; lda: clonglong; dataTypeTau: cudaDataType;
                        tau: pointer; computeType: cudaDataType;
                        bufferOnDevice: pointer;
                        workspaceInBytesOnDevice: csize_t; bufferOnHost: pointer;
                        workspaceInBytesOnHost: csize_t; info: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnXgeqrf", dynlib: libName.}
  ##  64-bit API for GETRF
  proc cusolverDnXgetrf_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   params: cusolverDnParams_t; m: clonglong;
                                   n: clonglong; dataTypeA: cudaDataType;
                                   A: pointer; lda: clonglong;
                                   computeType: cudaDataType;
                                   workspaceInBytesOnDevice: ptr csize_t;
                                   workspaceInBytesOnHost: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnXgetrf_bufferSize", dynlib: libName.}
  proc cusolverDnXgetrfUnderScore*(handle: cusolverDnHandle_t; params: cusolverDnParams_t;
                        m: clonglong; n: clonglong; dataTypeA: cudaDataType;
                        A: pointer; lda: clonglong; ipiv: ptr clonglong;
                        computeType: cudaDataType; bufferOnDevice: pointer;
                        workspaceInBytesOnDevice: csize_t; bufferOnHost: pointer;
                        workspaceInBytesOnHost: csize_t; info: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnXgetrf", dynlib: libName.}
  ##  64-bit API for GETRS
  proc cusolverDnXgetrsUnderScore*(handle: cusolverDnHandle_t; params: cusolverDnParams_t;
                        trans: cublasOperation_t; n: clonglong; nrhs: clonglong;
                        dataTypeA: cudaDataType; A: pointer; lda: clonglong;
                        ipiv: ptr clonglong; dataTypeB: cudaDataType; B: pointer;
                        ldb: clonglong; info: ptr cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnXgetrs", dynlib: libName.}
  ##  64-bit API for SYEVD
  proc cusolverDnXsyevd_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   params: cusolverDnParams_t;
                                   jobz: cusolverEigMode_t;
                                   uplo: cublasFillMode_t; n: clonglong;
                                   dataTypeA: cudaDataType; A: pointer;
                                   lda: clonglong; dataTypeW: cudaDataType;
                                   W: pointer; computeType: cudaDataType;
                                   workspaceInBytesOnDevice: ptr csize_t;
                                   workspaceInBytesOnHost: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnXsyevd_bufferSize", dynlib: libName.}
  proc cusolverDnXsyevdUnderScore*(handle: cusolverDnHandle_t; params: cusolverDnParams_t;
                        jobz: cusolverEigMode_t; uplo: cublasFillMode_t;
                        n: clonglong; dataTypeA: cudaDataType; A: pointer;
                        lda: clonglong; dataTypeW: cudaDataType; W: pointer;
                        computeType: cudaDataType; bufferOnDevice: pointer;
                        workspaceInBytesOnDevice: csize_t; bufferOnHost: pointer;
                        workspaceInBytesOnHost: csize_t; info: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnXsyevd", dynlib: libName.}
  ##  64-bit API for SYEVDX
  proc cusolverDnXsyevdx_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                    params: cusolverDnParams_t;
                                    jobz: cusolverEigMode_t;
                                    range: cusolverEigRange_t;
                                    uplo: cublasFillMode_t; n: clonglong;
                                    dataTypeA: cudaDataType; A: pointer;
                                    lda: clonglong; vl: pointer; vu: pointer;
                                    il: clonglong; iu: clonglong;
                                    h_meig: ptr clonglong; dataTypeW: cudaDataType;
                                    W: pointer; computeType: cudaDataType;
                                    workspaceInBytesOnDevice: ptr csize_t;
                                    workspaceInBytesOnHost: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnXsyevdx_bufferSize", dynlib: libName.}
  proc cusolverDnXsyevdxUnderScore*(handle: cusolverDnHandle_t; params: cusolverDnParams_t;
                         jobz: cusolverEigMode_t; range: cusolverEigRange_t;
                         uplo: cublasFillMode_t; n: clonglong;
                         dataTypeA: cudaDataType; A: pointer; lda: clonglong;
                         vl: pointer; vu: pointer; il: clonglong; iu: clonglong;
                         meig64: ptr clonglong; dataTypeW: cudaDataType; W: pointer;
                         computeType: cudaDataType; bufferOnDevice: pointer;
                         workspaceInBytesOnDevice: csize_t; bufferOnHost: pointer;
                         workspaceInBytesOnHost: csize_t; info: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnXsyevdx", dynlib: libName.}
  ##  64-bit API for GESVD
  proc cusolverDnXgesvd_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   params: cusolverDnParams_t; jobu: cchar;
                                   jobvt: cchar; m: clonglong; n: clonglong;
                                   dataTypeA: cudaDataType; A: pointer;
                                   lda: clonglong; dataTypeS: cudaDataType;
                                   S: pointer; dataTypeU: cudaDataType; U: pointer;
                                   ldu: clonglong; dataTypeVT: cudaDataType;
                                   VT: pointer; ldvt: clonglong;
                                   computeType: cudaDataType;
                                   workspaceInBytesOnDevice: ptr csize_t;
                                   workspaceInBytesOnHost: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnXgesvd_bufferSize", dynlib: libName.}
  proc cusolverDnXgesvdUnderScore*(handle: cusolverDnHandle_t; params: cusolverDnParams_t;
                        jobu: cchar; jobvt: cchar; m: clonglong; n: clonglong;
                        dataTypeA: cudaDataType; A: pointer; lda: clonglong;
                        dataTypeS: cudaDataType; S: pointer;
                        dataTypeU: cudaDataType; U: pointer; ldu: clonglong;
                        dataTypeVT: cudaDataType; VT: pointer; ldvt: clonglong;
                        computeType: cudaDataType; bufferOnDevice: pointer;
                        workspaceInBytesOnDevice: csize_t; bufferOnHost: pointer;
                        workspaceInBytesOnHost: csize_t; info: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnXgesvd", dynlib: libName.}
  ##  64-bit API for GESVDP
  proc cusolverDnXgesvdp_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                    params: cusolverDnParams_t;
                                    jobz: cusolverEigMode_t; econ: cint;
                                    m: clonglong; n: clonglong;
                                    dataTypeA: cudaDataType; A: pointer;
                                    lda: clonglong; dataTypeS: cudaDataType;
                                    S: pointer; dataTypeU: cudaDataType; U: pointer;
                                    ldu: clonglong; dataTypeV: cudaDataType;
                                    V: pointer; ldv: clonglong;
                                    computeType: cudaDataType;
                                    workspaceInBytesOnDevice: ptr csize_t;
                                    workspaceInBytesOnHost: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnXgesvdp_bufferSize", dynlib: libName.}
  proc cusolverDnXgesvdpUnderScore*(handle: cusolverDnHandle_t; params: cusolverDnParams_t;
                         jobz: cusolverEigMode_t; econ: cint; m: clonglong;
                         n: clonglong; dataTypeA: cudaDataType; A: pointer;
                         lda: clonglong; dataTypeS: cudaDataType; S: pointer;
                         dataTypeU: cudaDataType; U: pointer; ldu: clonglong;
                         dataTypeV: cudaDataType; V: pointer; ldv: clonglong;
                         computeType: cudaDataType; bufferOnDevice: pointer;
                         workspaceInBytesOnDevice: csize_t; bufferOnHost: pointer;
                         workspaceInBytesOnHost: csize_t; d_info: ptr cint;
                         h_err_sigma: ptr cdouble): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnXgesvdp", dynlib: libName.}
  proc cusolverDnXgesvdr_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                    params: cusolverDnParams_t; jobu: cchar;
                                    jobv: cchar; m: clonglong; n: clonglong;
                                    k: clonglong; p: clonglong; niters: clonglong;
                                    dataTypeA: cudaDataType; A: pointer;
                                    lda: clonglong; dataTypeSrand: cudaDataType;
                                    Srand: pointer; dataTypeUrand: cudaDataType;
                                    Urand: pointer; ldUrand: clonglong;
                                    dataTypeVrand: cudaDataType; Vrand: pointer;
                                    ldVrand: clonglong; computeType: cudaDataType;
                                    workspaceInBytesOnDevice: ptr csize_t;
                                    workspaceInBytesOnHost: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnXgesvdr_bufferSize", dynlib: libName.}
  proc cusolverDnXgesvdrUnderScore*(handle: cusolverDnHandle_t; params: cusolverDnParams_t;
                         jobu: cchar; jobv: cchar; m: clonglong; n: clonglong;
                         k: clonglong; p: clonglong; niters: clonglong;
                         dataTypeA: cudaDataType; A: pointer; lda: clonglong;
                         dataTypeSrand: cudaDataType; Srand: pointer;
                         dataTypeUrand: cudaDataType; Urand: pointer;
                         ldUrand: clonglong; dataTypeVrand: cudaDataType;
                         Vrand: pointer; ldVrand: clonglong;
                         computeType: cudaDataType; bufferOnDevice: pointer;
                         workspaceInBytesOnDevice: csize_t; bufferOnHost: pointer;
                         workspaceInBytesOnHost: csize_t; d_info: ptr cint): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnXgesvdr", dynlib: libName.}
  proc cusolverDnXlarft_bufferSizeUnderScore*(handle: cusolverDnHandle_t;
                                   params: cusolverDnParams_t;
                                   direct: cusolverDirectMode_t;
                                   storev: cusolverStorevMode_t; n: clonglong;
                                   k: clonglong; dataTypeV: cudaDataType;
                                   V: pointer; ldv: clonglong;
                                   dataTypeTau: cudaDataType; tau: pointer;
                                   dataTypeT: cudaDataType; T: pointer;
                                   ldt: clonglong; computeType: cudaDataType;
                                   workspaceInBytesOnDevice: ptr csize_t;
                                   workspaceInBytesOnHost: ptr csize_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnXlarft_bufferSize", dynlib: libName.}
  proc cusolverDnXlarftUnderScore*(handle: cusolverDnHandle_t; params: cusolverDnParams_t;
                        direct: cusolverDirectMode_t;
                        storev: cusolverStorevMode_t; n: clonglong; k: clonglong;
                        dataTypeV: cudaDataType; V: pointer; ldv: clonglong;
                        dataTypeTau: cudaDataType; tau: pointer;
                        dataTypeT: cudaDataType; T: pointer; ldt: clonglong;
                        computeType: cudaDataType; bufferOnDevice: pointer;
                        workspaceInBytesOnDevice: csize_t; bufferOnHost: pointer;
                        workspaceInBytesOnHost: csize_t): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnXlarft", dynlib: libName.}
  type
    cusolverDnLoggerCallback_t* = proc (logLevel: cint; functionName: cstring;
                                     message: cstring) {.cdecl.}
  proc cusolverDnLoggerSetCallbackUnderScore*(callback: cusolverDnLoggerCallback_t): cusolverStatus_t {.discardable, 
      cdecl, importc: "cusolverDnLoggerSetCallback", dynlib: libName.}
  proc cusolverDnLoggerSetFileUnderScore*(file: ptr FILE): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnLoggerSetFile", dynlib: libName.}
  proc cusolverDnLoggerOpenFileUnderScore*(logFile: cstring): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnLoggerOpenFile", dynlib: libName.}
  proc cusolverDnLoggerSetLevelUnderScore*(level: cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnLoggerSetLevel", dynlib: libName.}
  proc cusolverDnLoggerSetMaskUnderScore*(mask: cint): cusolverStatus_t {.discardable, cdecl,
      importc: "cusolverDnLoggerSetMask", dynlib: libName.}
  proc cusolverDnLoggerForceDisable*(): cusolverStatus_t {.cdecl,
      importc: "cusolverDnLoggerForceDisable", dynlib: libName.}