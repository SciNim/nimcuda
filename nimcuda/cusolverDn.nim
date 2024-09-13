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
  type cusolverDnContext {.importc, nodecl.} = object
  type
    cusolverDnHandle_t* = ptr cusolverDnContext
  type syevjInfo {.importc, nodecl.} = object
  type
    syevjInfo_t* = ptr syevjInfo
  type gesvdjInfo {.importc, nodecl.} = object
  type
    gesvdjInfo_t* = ptr gesvdjInfo
  ## ------------------------------------------------------
  ##  opaque cusolverDnIRS structure for IRS solver
  type cusolverDnIRSParams {.importc, nodecl.} = object
  type
    cusolverDnIRSParams_t* = ptr cusolverDnIRSParams
  type cusolverDnIRSInfos {.importc, nodecl.} = object
  type
    cusolverDnIRSInfos_t* = ptr cusolverDnIRSInfos
  ## ------------------------------------------------------
  type cusolverDnParams {.importc, nodecl.} = object
  type
    cusolverDnParams_t* = ptr cusolverDnParams
    cusolverDnFunction_t* {.size: sizeof(cint).} = enum
      CUSOLVERDN_GETRF = 0, CUSOLVERDN_POTRF = 1
    cusolverDeterministicMode_t* {.size: sizeof(cint).} = enum
      CUSOLVER_DETERMINISTIC_RESULTS = 1,
      CUSOLVER_ALLOW_NON_DETERMINISTIC_RESULTS = 2
  ## ****************************************************************************
  proc cusolverDnCreate*(handle: ptr cusolverDnHandle_t): cusolverStatus_t {.cdecl,
      importc: "cusolverDnCreate", dynlib: libName.}
  proc cusolverDnDestroy*(handle: cusolverDnHandle_t): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDestroy", dynlib: libName.}
  proc cusolverDnSetStream*(handle: cusolverDnHandle_t; streamId: cudaStream_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSetStream", dynlib: libName.}
  proc cusolverDnGetStream*(handle: cusolverDnHandle_t; streamId: ptr cudaStream_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnGetStream", dynlib: libName.}
  ## ============================================================
  ##  Deterministic Mode
  ## ============================================================
  proc cusolverDnSetDeterministicMode*(handle: cusolverDnHandle_t;
                                      mode: cusolverDeterministicMode_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSetDeterministicMode", dynlib: libName.}
  proc cusolverDnGetDeterministicMode*(handle: cusolverDnHandle_t;
                                      mode: ptr cusolverDeterministicMode_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnGetDeterministicMode", dynlib: libName.}
  ## ============================================================
  ##  IRS headers
  ## ============================================================
  ##  =============================================================================
  ##  IRS helper function API
  ##  =============================================================================
  proc cusolverDnIRSParamsCreate*(params_ptr: ptr cusolverDnIRSParams_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnIRSParamsCreate", dynlib: libName.}
  proc cusolverDnIRSParamsDestroy*(params: cusolverDnIRSParams_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnIRSParamsDestroy", dynlib: libName.}
  proc cusolverDnIRSParamsSetRefinementSolver*(params: cusolverDnIRSParams_t;
      refinement_solver: cusolverIRSRefinement_t): cusolverStatus_t {.cdecl,
      importc: "cusolverDnIRSParamsSetRefinementSolver", dynlib: libName.}
  proc cusolverDnIRSParamsSetSolverMainPrecision*(params: cusolverDnIRSParams_t;
      solver_main_precision: cusolverPrecType_t): cusolverStatus_t {.cdecl,
      importc: "cusolverDnIRSParamsSetSolverMainPrecision", dynlib: libName.}
  proc cusolverDnIRSParamsSetSolverLowestPrecision*(
      params: cusolverDnIRSParams_t; solver_lowest_precision: cusolverPrecType_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnIRSParamsSetSolverLowestPrecision",
      dynlib: libName.}
  proc cusolverDnIRSParamsSetSolverPrecisions*(params: cusolverDnIRSParams_t;
      solver_main_precision: cusolverPrecType_t;
      solver_lowest_precision: cusolverPrecType_t): cusolverStatus_t {.cdecl,
      importc: "cusolverDnIRSParamsSetSolverPrecisions", dynlib: libName.}
  proc cusolverDnIRSParamsSetTol*(params: cusolverDnIRSParams_t; val: cdouble): cusolverStatus_t {.
      cdecl, importc: "cusolverDnIRSParamsSetTol", dynlib: libName.}
  proc cusolverDnIRSParamsSetTolInner*(params: cusolverDnIRSParams_t; val: cdouble): cusolverStatus_t {.
      cdecl, importc: "cusolverDnIRSParamsSetTolInner", dynlib: libName.}
  proc cusolverDnIRSParamsSetMaxIters*(params: cusolverDnIRSParams_t;
                                      maxiters: cusolver_int_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnIRSParamsSetMaxIters", dynlib: libName.}
  proc cusolverDnIRSParamsSetMaxItersInner*(params: cusolverDnIRSParams_t;
      maxiters_inner: cusolver_int_t): cusolverStatus_t {.cdecl,
      importc: "cusolverDnIRSParamsSetMaxItersInner", dynlib: libName.}
  proc cusolverDnIRSParamsGetMaxIters*(params: cusolverDnIRSParams_t;
                                      maxiters: ptr cusolver_int_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnIRSParamsGetMaxIters", dynlib: libName.}
  proc cusolverDnIRSParamsEnableFallback*(params: cusolverDnIRSParams_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnIRSParamsEnableFallback", dynlib: libName.}
  proc cusolverDnIRSParamsDisableFallback*(params: cusolverDnIRSParams_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnIRSParamsDisableFallback", dynlib: libName.}
  ##  =============================================================================
  ##  cusolverDnIRSInfos prototypes
  ##  =============================================================================
  proc cusolverDnIRSInfosDestroy*(infos: cusolverDnIRSInfos_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnIRSInfosDestroy", dynlib: libName.}
  proc cusolverDnIRSInfosCreate*(infos_ptr: ptr cusolverDnIRSInfos_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnIRSInfosCreate", dynlib: libName.}
  proc cusolverDnIRSInfosGetNiters*(infos: cusolverDnIRSInfos_t;
                                   niters: ptr cusolver_int_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnIRSInfosGetNiters", dynlib: libName.}
  proc cusolverDnIRSInfosGetOuterNiters*(infos: cusolverDnIRSInfos_t;
                                        outer_niters: ptr cusolver_int_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnIRSInfosGetOuterNiters", dynlib: libName.}
  proc cusolverDnIRSInfosRequestResidual*(infos: cusolverDnIRSInfos_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnIRSInfosRequestResidual", dynlib: libName.}
  proc cusolverDnIRSInfosGetResidualHistory*(infos: cusolverDnIRSInfos_t;
      residual_history: ptr pointer): cusolverStatus_t {.cdecl,
      importc: "cusolverDnIRSInfosGetResidualHistory", dynlib: libName.}
  proc cusolverDnIRSInfosGetMaxIters*(infos: cusolverDnIRSInfos_t;
                                     maxiters: ptr cusolver_int_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnIRSInfosGetMaxIters", dynlib: libName.}
  ## ============================================================
  ##   IRS functions API
  ## ============================================================
  ## ****************************************************************************
  ##
  ##  [ZZ, ZC, ZK, ZE, ZY, CC, CK, CE, CY, DD, DS, DH, DB, DX, SS, SH, SB, SX]gesv
  ##  users API Prototypes
  ## ****************************************************************************
  proc cusolverDnZZgesv*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                        nrhs: cusolver_int_t; dA: ptr cuDoubleComplex;
                        ldda: cusolver_int_t; dipiv: ptr cusolver_int_t;
                        dB: ptr cuDoubleComplex; lddb: cusolver_int_t;
                        dX: ptr cuDoubleComplex; lddx: cusolver_int_t;
                        dWorkspace: pointer; lwork_bytes: csize_t;
                        iter: ptr cusolver_int_t; d_info: ptr cusolver_int_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZZgesv", dynlib: libName.}
  proc cusolverDnZCgesv*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                        nrhs: cusolver_int_t; dA: ptr cuDoubleComplex;
                        ldda: cusolver_int_t; dipiv: ptr cusolver_int_t;
                        dB: ptr cuDoubleComplex; lddb: cusolver_int_t;
                        dX: ptr cuDoubleComplex; lddx: cusolver_int_t;
                        dWorkspace: pointer; lwork_bytes: csize_t;
                        iter: ptr cusolver_int_t; d_info: ptr cusolver_int_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZCgesv", dynlib: libName.}
  proc cusolverDnZKgesv*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                        nrhs: cusolver_int_t; dA: ptr cuDoubleComplex;
                        ldda: cusolver_int_t; dipiv: ptr cusolver_int_t;
                        dB: ptr cuDoubleComplex; lddb: cusolver_int_t;
                        dX: ptr cuDoubleComplex; lddx: cusolver_int_t;
                        dWorkspace: pointer; lwork_bytes: csize_t;
                        iter: ptr cusolver_int_t; d_info: ptr cusolver_int_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZKgesv", dynlib: libName.}
  proc cusolverDnZEgesv*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                        nrhs: cusolver_int_t; dA: ptr cuDoubleComplex;
                        ldda: cusolver_int_t; dipiv: ptr cusolver_int_t;
                        dB: ptr cuDoubleComplex; lddb: cusolver_int_t;
                        dX: ptr cuDoubleComplex; lddx: cusolver_int_t;
                        dWorkspace: pointer; lwork_bytes: csize_t;
                        iter: ptr cusolver_int_t; d_info: ptr cusolver_int_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZEgesv", dynlib: libName.}
  proc cusolverDnZYgesv*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                        nrhs: cusolver_int_t; dA: ptr cuDoubleComplex;
                        ldda: cusolver_int_t; dipiv: ptr cusolver_int_t;
                        dB: ptr cuDoubleComplex; lddb: cusolver_int_t;
                        dX: ptr cuDoubleComplex; lddx: cusolver_int_t;
                        dWorkspace: pointer; lwork_bytes: csize_t;
                        iter: ptr cusolver_int_t; d_info: ptr cusolver_int_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZYgesv", dynlib: libName.}
  proc cusolverDnCCgesv*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                        nrhs: cusolver_int_t; dA: ptr cuComplex;
                        ldda: cusolver_int_t; dipiv: ptr cusolver_int_t;
                        dB: ptr cuComplex; lddb: cusolver_int_t; dX: ptr cuComplex;
                        lddx: cusolver_int_t; dWorkspace: pointer;
                        lwork_bytes: csize_t; iter: ptr cusolver_int_t;
                        d_info: ptr cusolver_int_t): cusolverStatus_t {.cdecl,
      importc: "cusolverDnCCgesv", dynlib: libName.}
  proc cusolverDnCEgesv*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                        nrhs: cusolver_int_t; dA: ptr cuComplex;
                        ldda: cusolver_int_t; dipiv: ptr cusolver_int_t;
                        dB: ptr cuComplex; lddb: cusolver_int_t; dX: ptr cuComplex;
                        lddx: cusolver_int_t; dWorkspace: pointer;
                        lwork_bytes: csize_t; iter: ptr cusolver_int_t;
                        d_info: ptr cusolver_int_t): cusolverStatus_t {.cdecl,
      importc: "cusolverDnCEgesv", dynlib: libName.}
  proc cusolverDnCKgesv*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                        nrhs: cusolver_int_t; dA: ptr cuComplex;
                        ldda: cusolver_int_t; dipiv: ptr cusolver_int_t;
                        dB: ptr cuComplex; lddb: cusolver_int_t; dX: ptr cuComplex;
                        lddx: cusolver_int_t; dWorkspace: pointer;
                        lwork_bytes: csize_t; iter: ptr cusolver_int_t;
                        d_info: ptr cusolver_int_t): cusolverStatus_t {.cdecl,
      importc: "cusolverDnCKgesv", dynlib: libName.}
  proc cusolverDnCYgesv*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                        nrhs: cusolver_int_t; dA: ptr cuComplex;
                        ldda: cusolver_int_t; dipiv: ptr cusolver_int_t;
                        dB: ptr cuComplex; lddb: cusolver_int_t; dX: ptr cuComplex;
                        lddx: cusolver_int_t; dWorkspace: pointer;
                        lwork_bytes: csize_t; iter: ptr cusolver_int_t;
                        d_info: ptr cusolver_int_t): cusolverStatus_t {.cdecl,
      importc: "cusolverDnCYgesv", dynlib: libName.}
  proc cusolverDnDDgesv*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                        nrhs: cusolver_int_t; dA: ptr cdouble; ldda: cusolver_int_t;
                        dipiv: ptr cusolver_int_t; dB: ptr cdouble;
                        lddb: cusolver_int_t; dX: ptr cdouble; lddx: cusolver_int_t;
                        dWorkspace: pointer; lwork_bytes: csize_t;
                        iter: ptr cusolver_int_t; d_info: ptr cusolver_int_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDDgesv", dynlib: libName.}
  proc cusolverDnDSgesv*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                        nrhs: cusolver_int_t; dA: ptr cdouble; ldda: cusolver_int_t;
                        dipiv: ptr cusolver_int_t; dB: ptr cdouble;
                        lddb: cusolver_int_t; dX: ptr cdouble; lddx: cusolver_int_t;
                        dWorkspace: pointer; lwork_bytes: csize_t;
                        iter: ptr cusolver_int_t; d_info: ptr cusolver_int_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDSgesv", dynlib: libName.}
  proc cusolverDnDHgesv*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                        nrhs: cusolver_int_t; dA: ptr cdouble; ldda: cusolver_int_t;
                        dipiv: ptr cusolver_int_t; dB: ptr cdouble;
                        lddb: cusolver_int_t; dX: ptr cdouble; lddx: cusolver_int_t;
                        dWorkspace: pointer; lwork_bytes: csize_t;
                        iter: ptr cusolver_int_t; d_info: ptr cusolver_int_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDHgesv", dynlib: libName.}
  proc cusolverDnDBgesv*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                        nrhs: cusolver_int_t; dA: ptr cdouble; ldda: cusolver_int_t;
                        dipiv: ptr cusolver_int_t; dB: ptr cdouble;
                        lddb: cusolver_int_t; dX: ptr cdouble; lddx: cusolver_int_t;
                        dWorkspace: pointer; lwork_bytes: csize_t;
                        iter: ptr cusolver_int_t; d_info: ptr cusolver_int_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDBgesv", dynlib: libName.}
  proc cusolverDnDXgesv*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                        nrhs: cusolver_int_t; dA: ptr cdouble; ldda: cusolver_int_t;
                        dipiv: ptr cusolver_int_t; dB: ptr cdouble;
                        lddb: cusolver_int_t; dX: ptr cdouble; lddx: cusolver_int_t;
                        dWorkspace: pointer; lwork_bytes: csize_t;
                        iter: ptr cusolver_int_t; d_info: ptr cusolver_int_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDXgesv", dynlib: libName.}
  proc cusolverDnSSgesv*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                        nrhs: cusolver_int_t; dA: ptr cfloat; ldda: cusolver_int_t;
                        dipiv: ptr cusolver_int_t; dB: ptr cfloat;
                        lddb: cusolver_int_t; dX: ptr cfloat; lddx: cusolver_int_t;
                        dWorkspace: pointer; lwork_bytes: csize_t;
                        iter: ptr cusolver_int_t; d_info: ptr cusolver_int_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSSgesv", dynlib: libName.}
  proc cusolverDnSHgesv*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                        nrhs: cusolver_int_t; dA: ptr cfloat; ldda: cusolver_int_t;
                        dipiv: ptr cusolver_int_t; dB: ptr cfloat;
                        lddb: cusolver_int_t; dX: ptr cfloat; lddx: cusolver_int_t;
                        dWorkspace: pointer; lwork_bytes: csize_t;
                        iter: ptr cusolver_int_t; d_info: ptr cusolver_int_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSHgesv", dynlib: libName.}
  proc cusolverDnSBgesv*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                        nrhs: cusolver_int_t; dA: ptr cfloat; ldda: cusolver_int_t;
                        dipiv: ptr cusolver_int_t; dB: ptr cfloat;
                        lddb: cusolver_int_t; dX: ptr cfloat; lddx: cusolver_int_t;
                        dWorkspace: pointer; lwork_bytes: csize_t;
                        iter: ptr cusolver_int_t; d_info: ptr cusolver_int_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSBgesv", dynlib: libName.}
  proc cusolverDnSXgesv*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                        nrhs: cusolver_int_t; dA: ptr cfloat; ldda: cusolver_int_t;
                        dipiv: ptr cusolver_int_t; dB: ptr cfloat;
                        lddb: cusolver_int_t; dX: ptr cfloat; lddx: cusolver_int_t;
                        dWorkspace: pointer; lwork_bytes: csize_t;
                        iter: ptr cusolver_int_t; d_info: ptr cusolver_int_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSXgesv", dynlib: libName.}
  ## ****************************************************************************
  ## ****************************************************************************
  ##
  ##  [ZZ, ZC, ZK, ZE, ZY, CC, CK, CE, CY, DD, DS, DH, DB, DX, SS, SH, SB, SX]gesv_bufferSize
  ##  users API Prototypes
  ## ****************************************************************************
  proc cusolverDnZZgesv_bufferSize*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                                   nrhs: cusolver_int_t; dA: ptr cuDoubleComplex;
                                   ldda: cusolver_int_t;
                                   dipiv: ptr cusolver_int_t;
                                   dB: ptr cuDoubleComplex; lddb: cusolver_int_t;
                                   dX: ptr cuDoubleComplex; lddx: cusolver_int_t;
                                   dWorkspace: pointer; lwork_bytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZZgesv_bufferSize", dynlib: libName.}
  proc cusolverDnZCgesv_bufferSize*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                                   nrhs: cusolver_int_t; dA: ptr cuDoubleComplex;
                                   ldda: cusolver_int_t;
                                   dipiv: ptr cusolver_int_t;
                                   dB: ptr cuDoubleComplex; lddb: cusolver_int_t;
                                   dX: ptr cuDoubleComplex; lddx: cusolver_int_t;
                                   dWorkspace: pointer; lwork_bytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZCgesv_bufferSize", dynlib: libName.}
  proc cusolverDnZKgesv_bufferSize*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                                   nrhs: cusolver_int_t; dA: ptr cuDoubleComplex;
                                   ldda: cusolver_int_t;
                                   dipiv: ptr cusolver_int_t;
                                   dB: ptr cuDoubleComplex; lddb: cusolver_int_t;
                                   dX: ptr cuDoubleComplex; lddx: cusolver_int_t;
                                   dWorkspace: pointer; lwork_bytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZKgesv_bufferSize", dynlib: libName.}
  proc cusolverDnZEgesv_bufferSize*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                                   nrhs: cusolver_int_t; dA: ptr cuDoubleComplex;
                                   ldda: cusolver_int_t;
                                   dipiv: ptr cusolver_int_t;
                                   dB: ptr cuDoubleComplex; lddb: cusolver_int_t;
                                   dX: ptr cuDoubleComplex; lddx: cusolver_int_t;
                                   dWorkspace: pointer; lwork_bytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZEgesv_bufferSize", dynlib: libName.}
  proc cusolverDnZYgesv_bufferSize*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                                   nrhs: cusolver_int_t; dA: ptr cuDoubleComplex;
                                   ldda: cusolver_int_t;
                                   dipiv: ptr cusolver_int_t;
                                   dB: ptr cuDoubleComplex; lddb: cusolver_int_t;
                                   dX: ptr cuDoubleComplex; lddx: cusolver_int_t;
                                   dWorkspace: pointer; lwork_bytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZYgesv_bufferSize", dynlib: libName.}
  proc cusolverDnCCgesv_bufferSize*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                                   nrhs: cusolver_int_t; dA: ptr cuComplex;
                                   ldda: cusolver_int_t;
                                   dipiv: ptr cusolver_int_t; dB: ptr cuComplex;
                                   lddb: cusolver_int_t; dX: ptr cuComplex;
                                   lddx: cusolver_int_t; dWorkspace: pointer;
                                   lwork_bytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnCCgesv_bufferSize", dynlib: libName.}
  proc cusolverDnCKgesv_bufferSize*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                                   nrhs: cusolver_int_t; dA: ptr cuComplex;
                                   ldda: cusolver_int_t;
                                   dipiv: ptr cusolver_int_t; dB: ptr cuComplex;
                                   lddb: cusolver_int_t; dX: ptr cuComplex;
                                   lddx: cusolver_int_t; dWorkspace: pointer;
                                   lwork_bytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnCKgesv_bufferSize", dynlib: libName.}
  proc cusolverDnCEgesv_bufferSize*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                                   nrhs: cusolver_int_t; dA: ptr cuComplex;
                                   ldda: cusolver_int_t;
                                   dipiv: ptr cusolver_int_t; dB: ptr cuComplex;
                                   lddb: cusolver_int_t; dX: ptr cuComplex;
                                   lddx: cusolver_int_t; dWorkspace: pointer;
                                   lwork_bytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnCEgesv_bufferSize", dynlib: libName.}
  proc cusolverDnCYgesv_bufferSize*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                                   nrhs: cusolver_int_t; dA: ptr cuComplex;
                                   ldda: cusolver_int_t;
                                   dipiv: ptr cusolver_int_t; dB: ptr cuComplex;
                                   lddb: cusolver_int_t; dX: ptr cuComplex;
                                   lddx: cusolver_int_t; dWorkspace: pointer;
                                   lwork_bytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnCYgesv_bufferSize", dynlib: libName.}
  proc cusolverDnDDgesv_bufferSize*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                                   nrhs: cusolver_int_t; dA: ptr cdouble;
                                   ldda: cusolver_int_t;
                                   dipiv: ptr cusolver_int_t; dB: ptr cdouble;
                                   lddb: cusolver_int_t; dX: ptr cdouble;
                                   lddx: cusolver_int_t; dWorkspace: pointer;
                                   lwork_bytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDDgesv_bufferSize", dynlib: libName.}
  proc cusolverDnDSgesv_bufferSize*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                                   nrhs: cusolver_int_t; dA: ptr cdouble;
                                   ldda: cusolver_int_t;
                                   dipiv: ptr cusolver_int_t; dB: ptr cdouble;
                                   lddb: cusolver_int_t; dX: ptr cdouble;
                                   lddx: cusolver_int_t; dWorkspace: pointer;
                                   lwork_bytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDSgesv_bufferSize", dynlib: libName.}
  proc cusolverDnDHgesv_bufferSize*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                                   nrhs: cusolver_int_t; dA: ptr cdouble;
                                   ldda: cusolver_int_t;
                                   dipiv: ptr cusolver_int_t; dB: ptr cdouble;
                                   lddb: cusolver_int_t; dX: ptr cdouble;
                                   lddx: cusolver_int_t; dWorkspace: pointer;
                                   lwork_bytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDHgesv_bufferSize", dynlib: libName.}
  proc cusolverDnDBgesv_bufferSize*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                                   nrhs: cusolver_int_t; dA: ptr cdouble;
                                   ldda: cusolver_int_t;
                                   dipiv: ptr cusolver_int_t; dB: ptr cdouble;
                                   lddb: cusolver_int_t; dX: ptr cdouble;
                                   lddx: cusolver_int_t; dWorkspace: pointer;
                                   lwork_bytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDBgesv_bufferSize", dynlib: libName.}
  proc cusolverDnDXgesv_bufferSize*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                                   nrhs: cusolver_int_t; dA: ptr cdouble;
                                   ldda: cusolver_int_t;
                                   dipiv: ptr cusolver_int_t; dB: ptr cdouble;
                                   lddb: cusolver_int_t; dX: ptr cdouble;
                                   lddx: cusolver_int_t; dWorkspace: pointer;
                                   lwork_bytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDXgesv_bufferSize", dynlib: libName.}
  proc cusolverDnSSgesv_bufferSize*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                                   nrhs: cusolver_int_t; dA: ptr cfloat;
                                   ldda: cusolver_int_t;
                                   dipiv: ptr cusolver_int_t; dB: ptr cfloat;
                                   lddb: cusolver_int_t; dX: ptr cfloat;
                                   lddx: cusolver_int_t; dWorkspace: pointer;
                                   lwork_bytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSSgesv_bufferSize", dynlib: libName.}
  proc cusolverDnSHgesv_bufferSize*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                                   nrhs: cusolver_int_t; dA: ptr cfloat;
                                   ldda: cusolver_int_t;
                                   dipiv: ptr cusolver_int_t; dB: ptr cfloat;
                                   lddb: cusolver_int_t; dX: ptr cfloat;
                                   lddx: cusolver_int_t; dWorkspace: pointer;
                                   lwork_bytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSHgesv_bufferSize", dynlib: libName.}
  proc cusolverDnSBgesv_bufferSize*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                                   nrhs: cusolver_int_t; dA: ptr cfloat;
                                   ldda: cusolver_int_t;
                                   dipiv: ptr cusolver_int_t; dB: ptr cfloat;
                                   lddb: cusolver_int_t; dX: ptr cfloat;
                                   lddx: cusolver_int_t; dWorkspace: pointer;
                                   lwork_bytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSBgesv_bufferSize", dynlib: libName.}
  proc cusolverDnSXgesv_bufferSize*(handle: cusolverDnHandle_t; n: cusolver_int_t;
                                   nrhs: cusolver_int_t; dA: ptr cfloat;
                                   ldda: cusolver_int_t;
                                   dipiv: ptr cusolver_int_t; dB: ptr cfloat;
                                   lddb: cusolver_int_t; dX: ptr cfloat;
                                   lddx: cusolver_int_t; dWorkspace: pointer;
                                   lwork_bytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSXgesv_bufferSize", dynlib: libName.}
  ## ****************************************************************************
  ## ****************************************************************************
  ##
  ##  [ZZ, ZC, ZK, ZE, ZY, CC, CK, CE, CY, DD, DS, DH, DB, DX, SS, SH, SB, SX]gels
  ##  users API Prototypes
  ## ****************************************************************************
  proc cusolverDnZZgels*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                        n: cusolver_int_t; nrhs: cusolver_int_t;
                        dA: ptr cuDoubleComplex; ldda: cusolver_int_t;
                        dB: ptr cuDoubleComplex; lddb: cusolver_int_t;
                        dX: ptr cuDoubleComplex; lddx: cusolver_int_t;
                        dWorkspace: pointer; lwork_bytes: csize_t;
                        iter: ptr cusolver_int_t; d_info: ptr cusolver_int_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZZgels", dynlib: libName.}
  proc cusolverDnZCgels*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                        n: cusolver_int_t; nrhs: cusolver_int_t;
                        dA: ptr cuDoubleComplex; ldda: cusolver_int_t;
                        dB: ptr cuDoubleComplex; lddb: cusolver_int_t;
                        dX: ptr cuDoubleComplex; lddx: cusolver_int_t;
                        dWorkspace: pointer; lwork_bytes: csize_t;
                        iter: ptr cusolver_int_t; d_info: ptr cusolver_int_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZCgels", dynlib: libName.}
  proc cusolverDnZKgels*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                        n: cusolver_int_t; nrhs: cusolver_int_t;
                        dA: ptr cuDoubleComplex; ldda: cusolver_int_t;
                        dB: ptr cuDoubleComplex; lddb: cusolver_int_t;
                        dX: ptr cuDoubleComplex; lddx: cusolver_int_t;
                        dWorkspace: pointer; lwork_bytes: csize_t;
                        iter: ptr cusolver_int_t; d_info: ptr cusolver_int_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZKgels", dynlib: libName.}
  proc cusolverDnZEgels*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                        n: cusolver_int_t; nrhs: cusolver_int_t;
                        dA: ptr cuDoubleComplex; ldda: cusolver_int_t;
                        dB: ptr cuDoubleComplex; lddb: cusolver_int_t;
                        dX: ptr cuDoubleComplex; lddx: cusolver_int_t;
                        dWorkspace: pointer; lwork_bytes: csize_t;
                        iter: ptr cusolver_int_t; d_info: ptr cusolver_int_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZEgels", dynlib: libName.}
  proc cusolverDnZYgels*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                        n: cusolver_int_t; nrhs: cusolver_int_t;
                        dA: ptr cuDoubleComplex; ldda: cusolver_int_t;
                        dB: ptr cuDoubleComplex; lddb: cusolver_int_t;
                        dX: ptr cuDoubleComplex; lddx: cusolver_int_t;
                        dWorkspace: pointer; lwork_bytes: csize_t;
                        iter: ptr cusolver_int_t; d_info: ptr cusolver_int_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZYgels", dynlib: libName.}
  proc cusolverDnCCgels*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                        n: cusolver_int_t; nrhs: cusolver_int_t; dA: ptr cuComplex;
                        ldda: cusolver_int_t; dB: ptr cuComplex;
                        lddb: cusolver_int_t; dX: ptr cuComplex;
                        lddx: cusolver_int_t; dWorkspace: pointer;
                        lwork_bytes: csize_t; iter: ptr cusolver_int_t;
                        d_info: ptr cusolver_int_t): cusolverStatus_t {.cdecl,
      importc: "cusolverDnCCgels", dynlib: libName.}
  proc cusolverDnCKgels*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                        n: cusolver_int_t; nrhs: cusolver_int_t; dA: ptr cuComplex;
                        ldda: cusolver_int_t; dB: ptr cuComplex;
                        lddb: cusolver_int_t; dX: ptr cuComplex;
                        lddx: cusolver_int_t; dWorkspace: pointer;
                        lwork_bytes: csize_t; iter: ptr cusolver_int_t;
                        d_info: ptr cusolver_int_t): cusolverStatus_t {.cdecl,
      importc: "cusolverDnCKgels", dynlib: libName.}
  proc cusolverDnCEgels*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                        n: cusolver_int_t; nrhs: cusolver_int_t; dA: ptr cuComplex;
                        ldda: cusolver_int_t; dB: ptr cuComplex;
                        lddb: cusolver_int_t; dX: ptr cuComplex;
                        lddx: cusolver_int_t; dWorkspace: pointer;
                        lwork_bytes: csize_t; iter: ptr cusolver_int_t;
                        d_info: ptr cusolver_int_t): cusolverStatus_t {.cdecl,
      importc: "cusolverDnCEgels", dynlib: libName.}
  proc cusolverDnCYgels*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                        n: cusolver_int_t; nrhs: cusolver_int_t; dA: ptr cuComplex;
                        ldda: cusolver_int_t; dB: ptr cuComplex;
                        lddb: cusolver_int_t; dX: ptr cuComplex;
                        lddx: cusolver_int_t; dWorkspace: pointer;
                        lwork_bytes: csize_t; iter: ptr cusolver_int_t;
                        d_info: ptr cusolver_int_t): cusolverStatus_t {.cdecl,
      importc: "cusolverDnCYgels", dynlib: libName.}
  proc cusolverDnDDgels*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                        n: cusolver_int_t; nrhs: cusolver_int_t; dA: ptr cdouble;
                        ldda: cusolver_int_t; dB: ptr cdouble; lddb: cusolver_int_t;
                        dX: ptr cdouble; lddx: cusolver_int_t; dWorkspace: pointer;
                        lwork_bytes: csize_t; iter: ptr cusolver_int_t;
                        d_info: ptr cusolver_int_t): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDDgels", dynlib: libName.}
  proc cusolverDnDSgels*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                        n: cusolver_int_t; nrhs: cusolver_int_t; dA: ptr cdouble;
                        ldda: cusolver_int_t; dB: ptr cdouble; lddb: cusolver_int_t;
                        dX: ptr cdouble; lddx: cusolver_int_t; dWorkspace: pointer;
                        lwork_bytes: csize_t; iter: ptr cusolver_int_t;
                        d_info: ptr cusolver_int_t): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDSgels", dynlib: libName.}
  proc cusolverDnDHgels*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                        n: cusolver_int_t; nrhs: cusolver_int_t; dA: ptr cdouble;
                        ldda: cusolver_int_t; dB: ptr cdouble; lddb: cusolver_int_t;
                        dX: ptr cdouble; lddx: cusolver_int_t; dWorkspace: pointer;
                        lwork_bytes: csize_t; iter: ptr cusolver_int_t;
                        d_info: ptr cusolver_int_t): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDHgels", dynlib: libName.}
  proc cusolverDnDBgels*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                        n: cusolver_int_t; nrhs: cusolver_int_t; dA: ptr cdouble;
                        ldda: cusolver_int_t; dB: ptr cdouble; lddb: cusolver_int_t;
                        dX: ptr cdouble; lddx: cusolver_int_t; dWorkspace: pointer;
                        lwork_bytes: csize_t; iter: ptr cusolver_int_t;
                        d_info: ptr cusolver_int_t): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDBgels", dynlib: libName.}
  proc cusolverDnDXgels*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                        n: cusolver_int_t; nrhs: cusolver_int_t; dA: ptr cdouble;
                        ldda: cusolver_int_t; dB: ptr cdouble; lddb: cusolver_int_t;
                        dX: ptr cdouble; lddx: cusolver_int_t; dWorkspace: pointer;
                        lwork_bytes: csize_t; iter: ptr cusolver_int_t;
                        d_info: ptr cusolver_int_t): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDXgels", dynlib: libName.}
  proc cusolverDnSSgels*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                        n: cusolver_int_t; nrhs: cusolver_int_t; dA: ptr cfloat;
                        ldda: cusolver_int_t; dB: ptr cfloat; lddb: cusolver_int_t;
                        dX: ptr cfloat; lddx: cusolver_int_t; dWorkspace: pointer;
                        lwork_bytes: csize_t; iter: ptr cusolver_int_t;
                        d_info: ptr cusolver_int_t): cusolverStatus_t {.cdecl,
      importc: "cusolverDnSSgels", dynlib: libName.}
  proc cusolverDnSHgels*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                        n: cusolver_int_t; nrhs: cusolver_int_t; dA: ptr cfloat;
                        ldda: cusolver_int_t; dB: ptr cfloat; lddb: cusolver_int_t;
                        dX: ptr cfloat; lddx: cusolver_int_t; dWorkspace: pointer;
                        lwork_bytes: csize_t; iter: ptr cusolver_int_t;
                        d_info: ptr cusolver_int_t): cusolverStatus_t {.cdecl,
      importc: "cusolverDnSHgels", dynlib: libName.}
  proc cusolverDnSBgels*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                        n: cusolver_int_t; nrhs: cusolver_int_t; dA: ptr cfloat;
                        ldda: cusolver_int_t; dB: ptr cfloat; lddb: cusolver_int_t;
                        dX: ptr cfloat; lddx: cusolver_int_t; dWorkspace: pointer;
                        lwork_bytes: csize_t; iter: ptr cusolver_int_t;
                        d_info: ptr cusolver_int_t): cusolverStatus_t {.cdecl,
      importc: "cusolverDnSBgels", dynlib: libName.}
  proc cusolverDnSXgels*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                        n: cusolver_int_t; nrhs: cusolver_int_t; dA: ptr cfloat;
                        ldda: cusolver_int_t; dB: ptr cfloat; lddb: cusolver_int_t;
                        dX: ptr cfloat; lddx: cusolver_int_t; dWorkspace: pointer;
                        lwork_bytes: csize_t; iter: ptr cusolver_int_t;
                        d_info: ptr cusolver_int_t): cusolverStatus_t {.cdecl,
      importc: "cusolverDnSXgels", dynlib: libName.}
  ## ****************************************************************************
  ## ****************************************************************************
  ##
  ##  [ZZ, ZC, ZK, ZE, ZY, CC, CK, CE, CY, DD, DS, DH, DB, DX, SS, SH, SB, SX]gels_bufferSize
  ##  API prototypes
  ## ****************************************************************************
  proc cusolverDnZZgels_bufferSize*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                                   n: cusolver_int_t; nrhs: cusolver_int_t;
                                   dA: ptr cuDoubleComplex; ldda: cusolver_int_t;
                                   dB: ptr cuDoubleComplex; lddb: cusolver_int_t;
                                   dX: ptr cuDoubleComplex; lddx: cusolver_int_t;
                                   dWorkspace: pointer; lwork_bytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZZgels_bufferSize", dynlib: libName.}
  proc cusolverDnZCgels_bufferSize*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                                   n: cusolver_int_t; nrhs: cusolver_int_t;
                                   dA: ptr cuDoubleComplex; ldda: cusolver_int_t;
                                   dB: ptr cuDoubleComplex; lddb: cusolver_int_t;
                                   dX: ptr cuDoubleComplex; lddx: cusolver_int_t;
                                   dWorkspace: pointer; lwork_bytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZCgels_bufferSize", dynlib: libName.}
  proc cusolverDnZKgels_bufferSize*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                                   n: cusolver_int_t; nrhs: cusolver_int_t;
                                   dA: ptr cuDoubleComplex; ldda: cusolver_int_t;
                                   dB: ptr cuDoubleComplex; lddb: cusolver_int_t;
                                   dX: ptr cuDoubleComplex; lddx: cusolver_int_t;
                                   dWorkspace: pointer; lwork_bytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZKgels_bufferSize", dynlib: libName.}
  proc cusolverDnZEgels_bufferSize*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                                   n: cusolver_int_t; nrhs: cusolver_int_t;
                                   dA: ptr cuDoubleComplex; ldda: cusolver_int_t;
                                   dB: ptr cuDoubleComplex; lddb: cusolver_int_t;
                                   dX: ptr cuDoubleComplex; lddx: cusolver_int_t;
                                   dWorkspace: pointer; lwork_bytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZEgels_bufferSize", dynlib: libName.}
  proc cusolverDnZYgels_bufferSize*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                                   n: cusolver_int_t; nrhs: cusolver_int_t;
                                   dA: ptr cuDoubleComplex; ldda: cusolver_int_t;
                                   dB: ptr cuDoubleComplex; lddb: cusolver_int_t;
                                   dX: ptr cuDoubleComplex; lddx: cusolver_int_t;
                                   dWorkspace: pointer; lwork_bytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZYgels_bufferSize", dynlib: libName.}
  proc cusolverDnCCgels_bufferSize*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                                   n: cusolver_int_t; nrhs: cusolver_int_t;
                                   dA: ptr cuComplex; ldda: cusolver_int_t;
                                   dB: ptr cuComplex; lddb: cusolver_int_t;
                                   dX: ptr cuComplex; lddx: cusolver_int_t;
                                   dWorkspace: pointer; lwork_bytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnCCgels_bufferSize", dynlib: libName.}
  proc cusolverDnCKgels_bufferSize*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                                   n: cusolver_int_t; nrhs: cusolver_int_t;
                                   dA: ptr cuComplex; ldda: cusolver_int_t;
                                   dB: ptr cuComplex; lddb: cusolver_int_t;
                                   dX: ptr cuComplex; lddx: cusolver_int_t;
                                   dWorkspace: pointer; lwork_bytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnCKgels_bufferSize", dynlib: libName.}
  proc cusolverDnCEgels_bufferSize*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                                   n: cusolver_int_t; nrhs: cusolver_int_t;
                                   dA: ptr cuComplex; ldda: cusolver_int_t;
                                   dB: ptr cuComplex; lddb: cusolver_int_t;
                                   dX: ptr cuComplex; lddx: cusolver_int_t;
                                   dWorkspace: pointer; lwork_bytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnCEgels_bufferSize", dynlib: libName.}
  proc cusolverDnCYgels_bufferSize*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                                   n: cusolver_int_t; nrhs: cusolver_int_t;
                                   dA: ptr cuComplex; ldda: cusolver_int_t;
                                   dB: ptr cuComplex; lddb: cusolver_int_t;
                                   dX: ptr cuComplex; lddx: cusolver_int_t;
                                   dWorkspace: pointer; lwork_bytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnCYgels_bufferSize", dynlib: libName.}
  proc cusolverDnDDgels_bufferSize*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                                   n: cusolver_int_t; nrhs: cusolver_int_t;
                                   dA: ptr cdouble; ldda: cusolver_int_t;
                                   dB: ptr cdouble; lddb: cusolver_int_t;
                                   dX: ptr cdouble; lddx: cusolver_int_t;
                                   dWorkspace: pointer; lwork_bytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDDgels_bufferSize", dynlib: libName.}
  proc cusolverDnDSgels_bufferSize*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                                   n: cusolver_int_t; nrhs: cusolver_int_t;
                                   dA: ptr cdouble; ldda: cusolver_int_t;
                                   dB: ptr cdouble; lddb: cusolver_int_t;
                                   dX: ptr cdouble; lddx: cusolver_int_t;
                                   dWorkspace: pointer; lwork_bytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDSgels_bufferSize", dynlib: libName.}
  proc cusolverDnDHgels_bufferSize*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                                   n: cusolver_int_t; nrhs: cusolver_int_t;
                                   dA: ptr cdouble; ldda: cusolver_int_t;
                                   dB: ptr cdouble; lddb: cusolver_int_t;
                                   dX: ptr cdouble; lddx: cusolver_int_t;
                                   dWorkspace: pointer; lwork_bytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDHgels_bufferSize", dynlib: libName.}
  proc cusolverDnDBgels_bufferSize*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                                   n: cusolver_int_t; nrhs: cusolver_int_t;
                                   dA: ptr cdouble; ldda: cusolver_int_t;
                                   dB: ptr cdouble; lddb: cusolver_int_t;
                                   dX: ptr cdouble; lddx: cusolver_int_t;
                                   dWorkspace: pointer; lwork_bytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDBgels_bufferSize", dynlib: libName.}
  proc cusolverDnDXgels_bufferSize*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                                   n: cusolver_int_t; nrhs: cusolver_int_t;
                                   dA: ptr cdouble; ldda: cusolver_int_t;
                                   dB: ptr cdouble; lddb: cusolver_int_t;
                                   dX: ptr cdouble; lddx: cusolver_int_t;
                                   dWorkspace: pointer; lwork_bytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDXgels_bufferSize", dynlib: libName.}
  proc cusolverDnSSgels_bufferSize*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                                   n: cusolver_int_t; nrhs: cusolver_int_t;
                                   dA: ptr cfloat; ldda: cusolver_int_t;
                                   dB: ptr cfloat; lddb: cusolver_int_t;
                                   dX: ptr cfloat; lddx: cusolver_int_t;
                                   dWorkspace: pointer; lwork_bytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSSgels_bufferSize", dynlib: libName.}
  proc cusolverDnSHgels_bufferSize*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                                   n: cusolver_int_t; nrhs: cusolver_int_t;
                                   dA: ptr cfloat; ldda: cusolver_int_t;
                                   dB: ptr cfloat; lddb: cusolver_int_t;
                                   dX: ptr cfloat; lddx: cusolver_int_t;
                                   dWorkspace: pointer; lwork_bytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSHgels_bufferSize", dynlib: libName.}
  proc cusolverDnSBgels_bufferSize*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                                   n: cusolver_int_t; nrhs: cusolver_int_t;
                                   dA: ptr cfloat; ldda: cusolver_int_t;
                                   dB: ptr cfloat; lddb: cusolver_int_t;
                                   dX: ptr cfloat; lddx: cusolver_int_t;
                                   dWorkspace: pointer; lwork_bytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSBgels_bufferSize", dynlib: libName.}
  proc cusolverDnSXgels_bufferSize*(handle: cusolverDnHandle_t; m: cusolver_int_t;
                                   n: cusolver_int_t; nrhs: cusolver_int_t;
                                   dA: ptr cfloat; ldda: cusolver_int_t;
                                   dB: ptr cfloat; lddb: cusolver_int_t;
                                   dX: ptr cfloat; lddx: cusolver_int_t;
                                   dWorkspace: pointer; lwork_bytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSXgels_bufferSize", dynlib: libName.}
  ## ****************************************************************************
  ## ****************************************************************************
  ##
  ##  expert users API for IRS Prototypes
  ##
  ## ****************************************************************************
  proc cusolverDnIRSXgesv*(handle: cusolverDnHandle_t;
                          gesv_irs_params: cusolverDnIRSParams_t;
                          gesv_irs_infos: cusolverDnIRSInfos_t; n: cusolver_int_t;
                          nrhs: cusolver_int_t; dA: pointer; ldda: cusolver_int_t;
                          dB: pointer; lddb: cusolver_int_t; dX: pointer;
                          lddx: cusolver_int_t; dWorkspace: pointer;
                          lwork_bytes: csize_t; niters: ptr cusolver_int_t;
                          d_info: ptr cusolver_int_t): cusolverStatus_t {.cdecl,
      importc: "cusolverDnIRSXgesv", dynlib: libName.}
  proc cusolverDnIRSXgesv_bufferSize*(handle: cusolverDnHandle_t;
                                     params: cusolverDnIRSParams_t;
                                     n: cusolver_int_t; nrhs: cusolver_int_t;
                                     lwork_bytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnIRSXgesv_bufferSize", dynlib: libName.}
  proc cusolverDnIRSXgels*(handle: cusolverDnHandle_t;
                          gels_irs_params: cusolverDnIRSParams_t;
                          gels_irs_infos: cusolverDnIRSInfos_t; m: cusolver_int_t;
                          n: cusolver_int_t; nrhs: cusolver_int_t; dA: pointer;
                          ldda: cusolver_int_t; dB: pointer; lddb: cusolver_int_t;
                          dX: pointer; lddx: cusolver_int_t; dWorkspace: pointer;
                          lwork_bytes: csize_t; niters: ptr cusolver_int_t;
                          d_info: ptr cusolver_int_t): cusolverStatus_t {.cdecl,
      importc: "cusolverDnIRSXgels", dynlib: libName.}
  proc cusolverDnIRSXgels_bufferSize*(handle: cusolverDnHandle_t;
                                     params: cusolverDnIRSParams_t;
                                     m: cusolver_int_t; n: cusolver_int_t;
                                     nrhs: cusolver_int_t;
                                     lwork_bytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnIRSXgels_bufferSize", dynlib: libName.}
  ## ****************************************************************************
  ##  Cholesky factorization and its solver
  proc cusolverDnSpotrf_bufferSize*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cfloat;
                                   lda: cint; Lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSpotrf_bufferSize", dynlib: libName.}
  proc cusolverDnDpotrf_bufferSize*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cdouble;
                                   lda: cint; Lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDpotrf_bufferSize", dynlib: libName.}
  proc cusolverDnCpotrf_bufferSize*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuComplex; lda: cint; Lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnCpotrf_bufferSize", dynlib: libName.}
  proc cusolverDnZpotrf_bufferSize*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuDoubleComplex; lda: cint; Lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZpotrf_bufferSize", dynlib: libName.}
  proc cusolverDnSpotrf*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cfloat; lda: cint; Workspace: ptr cfloat; Lwork: cint;
                        devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnSpotrf", dynlib: libName.}
  proc cusolverDnDpotrf*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cdouble; lda: cint; Workspace: ptr cdouble; Lwork: cint;
                        devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDpotrf", dynlib: libName.}
  proc cusolverDnCpotrf*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cuComplex; lda: cint; Workspace: ptr cuComplex;
                        Lwork: cint; devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnCpotrf", dynlib: libName.}
  proc cusolverDnZpotrf*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cuDoubleComplex; lda: cint;
                        Workspace: ptr cuDoubleComplex; Lwork: cint;
                        devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnZpotrf", dynlib: libName.}
  proc cusolverDnSpotrs*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        nrhs: cint; A: ptr cfloat; lda: cint; B: ptr cfloat; ldb: cint;
                        devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnSpotrs", dynlib: libName.}
  proc cusolverDnDpotrs*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        nrhs: cint; A: ptr cdouble; lda: cint; B: ptr cdouble; ldb: cint;
                        devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDpotrs", dynlib: libName.}
  proc cusolverDnCpotrs*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        nrhs: cint; A: ptr cuComplex; lda: cint; B: ptr cuComplex;
                        ldb: cint; devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnCpotrs", dynlib: libName.}
  proc cusolverDnZpotrs*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        nrhs: cint; A: ptr cuDoubleComplex; lda: cint;
                        B: ptr cuDoubleComplex; ldb: cint; devInfo: ptr cint): cusolverStatus_t {.
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
  proc cusolverDnSpotri_bufferSize*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cfloat;
                                   lda: cint; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSpotri_bufferSize", dynlib: libName.}
  proc cusolverDnDpotri_bufferSize*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cdouble;
                                   lda: cint; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDpotri_bufferSize", dynlib: libName.}
  proc cusolverDnCpotri_bufferSize*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuComplex; lda: cint; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnCpotri_bufferSize", dynlib: libName.}
  proc cusolverDnZpotri_bufferSize*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuDoubleComplex; lda: cint; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZpotri_bufferSize", dynlib: libName.}
  proc cusolverDnSpotri*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cfloat; lda: cint; work: ptr cfloat; lwork: cint;
                        devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnSpotri", dynlib: libName.}
  proc cusolverDnDpotri*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cdouble; lda: cint; work: ptr cdouble; lwork: cint;
                        devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDpotri", dynlib: libName.}
  proc cusolverDnCpotri*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cuComplex; lda: cint; work: ptr cuComplex; lwork: cint;
                        devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnCpotri", dynlib: libName.}
  proc cusolverDnZpotri*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cuDoubleComplex; lda: cint; work: ptr cuDoubleComplex;
                        lwork: cint; devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnZpotri", dynlib: libName.}
  proc cusolverDnXtrtri_bufferSize*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; diag: cublasDiagType_t;
                                   n: clonglong; dataTypeA: cudaDataType;
                                   A: pointer; lda: clonglong;
                                   workspaceInBytesOnDevice: ptr csize_t;
                                   workspaceInBytesOnHost: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnXtrtri_bufferSize", dynlib: libName.}
  proc cusolverDnXtrtri*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t;
                        diag: cublasDiagType_t; n: clonglong;
                        dataTypeA: cudaDataType; A: pointer; lda: clonglong;
                        bufferOnDevice: pointer;
                        workspaceInBytesOnDevice: csize_t; bufferOnHost: pointer;
                        workspaceInBytesOnHost: csize_t; devInfo: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnXtrtri", dynlib: libName.}
  ##  lauum, auxiliar routine for s.p.d matrix inversion
  proc cusolverDnSlauum_bufferSize*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cfloat;
                                   lda: cint; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSlauum_bufferSize", dynlib: libName.}
  proc cusolverDnDlauum_bufferSize*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cdouble;
                                   lda: cint; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDlauum_bufferSize", dynlib: libName.}
  proc cusolverDnClauum_bufferSize*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuComplex; lda: cint; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnClauum_bufferSize", dynlib: libName.}
  proc cusolverDnZlauum_bufferSize*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuDoubleComplex; lda: cint; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZlauum_bufferSize", dynlib: libName.}
  proc cusolverDnSlauum*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cfloat; lda: cint; work: ptr cfloat; lwork: cint;
                        devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnSlauum", dynlib: libName.}
  proc cusolverDnDlauum*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cdouble; lda: cint; work: ptr cdouble; lwork: cint;
                        devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDlauum", dynlib: libName.}
  proc cusolverDnClauum*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cuComplex; lda: cint; work: ptr cuComplex; lwork: cint;
                        devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnClauum", dynlib: libName.}
  proc cusolverDnZlauum*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cuDoubleComplex; lda: cint; work: ptr cuDoubleComplex;
                        lwork: cint; devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnZlauum", dynlib: libName.}
  ##  LU Factorization
  proc cusolverDnSgetrf_bufferSize*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   A: ptr cfloat; lda: cint; Lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSgetrf_bufferSize", dynlib: libName.}
  proc cusolverDnDgetrf_bufferSize*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   A: ptr cdouble; lda: cint; Lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDgetrf_bufferSize", dynlib: libName.}
  proc cusolverDnCgetrf_bufferSize*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   A: ptr cuComplex; lda: cint; Lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnCgetrf_bufferSize", dynlib: libName.}
  proc cusolverDnZgetrf_bufferSize*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   A: ptr cuDoubleComplex; lda: cint; Lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZgetrf_bufferSize", dynlib: libName.}
  proc cusolverDnSgetrf*(handle: cusolverDnHandle_t; m: cint; n: cint; A: ptr cfloat;
                        lda: cint; Workspace: ptr cfloat; devIpiv: ptr cint;
                        devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnSgetrf", dynlib: libName.}
  proc cusolverDnDgetrf*(handle: cusolverDnHandle_t; m: cint; n: cint; A: ptr cdouble;
                        lda: cint; Workspace: ptr cdouble; devIpiv: ptr cint;
                        devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDgetrf", dynlib: libName.}
  proc cusolverDnCgetrf*(handle: cusolverDnHandle_t; m: cint; n: cint;
                        A: ptr cuComplex; lda: cint; Workspace: ptr cuComplex;
                        devIpiv: ptr cint; devInfo: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnCgetrf", dynlib: libName.}
  proc cusolverDnZgetrf*(handle: cusolverDnHandle_t; m: cint; n: cint;
                        A: ptr cuDoubleComplex; lda: cint;
                        Workspace: ptr cuDoubleComplex; devIpiv: ptr cint;
                        devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnZgetrf", dynlib: libName.}
  ##  Row pivoting
  proc cusolverDnSlaswp*(handle: cusolverDnHandle_t; n: cint; A: ptr cfloat; lda: cint;
                        k1: cint; k2: cint; devIpiv: ptr cint; incx: cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSlaswp", dynlib: libName.}
  proc cusolverDnDlaswp*(handle: cusolverDnHandle_t; n: cint; A: ptr cdouble; lda: cint;
                        k1: cint; k2: cint; devIpiv: ptr cint; incx: cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDlaswp", dynlib: libName.}
  proc cusolverDnClaswp*(handle: cusolverDnHandle_t; n: cint; A: ptr cuComplex;
                        lda: cint; k1: cint; k2: cint; devIpiv: ptr cint; incx: cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnClaswp", dynlib: libName.}
  proc cusolverDnZlaswp*(handle: cusolverDnHandle_t; n: cint; A: ptr cuDoubleComplex;
                        lda: cint; k1: cint; k2: cint; devIpiv: ptr cint; incx: cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZlaswp", dynlib: libName.}
  ##  LU solve
  proc cusolverDnSgetrs*(handle: cusolverDnHandle_t; trans: cublasOperation_t;
                        n: cint; nrhs: cint; A: ptr cfloat; lda: cint; devIpiv: ptr cint;
                        B: ptr cfloat; ldb: cint; devInfo: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSgetrs", dynlib: libName.}
  proc cusolverDnDgetrs*(handle: cusolverDnHandle_t; trans: cublasOperation_t;
                        n: cint; nrhs: cint; A: ptr cdouble; lda: cint;
                        devIpiv: ptr cint; B: ptr cdouble; ldb: cint; devInfo: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDgetrs", dynlib: libName.}
  proc cusolverDnCgetrs*(handle: cusolverDnHandle_t; trans: cublasOperation_t;
                        n: cint; nrhs: cint; A: ptr cuComplex; lda: cint;
                        devIpiv: ptr cint; B: ptr cuComplex; ldb: cint;
                        devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnCgetrs", dynlib: libName.}
  proc cusolverDnZgetrs*(handle: cusolverDnHandle_t; trans: cublasOperation_t;
                        n: cint; nrhs: cint; A: ptr cuDoubleComplex; lda: cint;
                        devIpiv: ptr cint; B: ptr cuDoubleComplex; ldb: cint;
                        devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnZgetrs", dynlib: libName.}
  ##  QR factorization
  proc cusolverDnSgeqrf_bufferSize*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   A: ptr cfloat; lda: cint; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSgeqrf_bufferSize", dynlib: libName.}
  proc cusolverDnDgeqrf_bufferSize*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   A: ptr cdouble; lda: cint; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDgeqrf_bufferSize", dynlib: libName.}
  proc cusolverDnCgeqrf_bufferSize*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   A: ptr cuComplex; lda: cint; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnCgeqrf_bufferSize", dynlib: libName.}
  proc cusolverDnZgeqrf_bufferSize*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   A: ptr cuDoubleComplex; lda: cint; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZgeqrf_bufferSize", dynlib: libName.}
  proc cusolverDnSgeqrf*(handle: cusolverDnHandle_t; m: cint; n: cint; A: ptr cfloat;
                        lda: cint; TAU: ptr cfloat; Workspace: ptr cfloat; Lwork: cint;
                        devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnSgeqrf", dynlib: libName.}
  proc cusolverDnDgeqrf*(handle: cusolverDnHandle_t; m: cint; n: cint; A: ptr cdouble;
                        lda: cint; TAU: ptr cdouble; Workspace: ptr cdouble;
                        Lwork: cint; devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDgeqrf", dynlib: libName.}
  proc cusolverDnCgeqrf*(handle: cusolverDnHandle_t; m: cint; n: cint;
                        A: ptr cuComplex; lda: cint; TAU: ptr cuComplex;
                        Workspace: ptr cuComplex; Lwork: cint; devInfo: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnCgeqrf", dynlib: libName.}
  proc cusolverDnZgeqrf*(handle: cusolverDnHandle_t; m: cint; n: cint;
                        A: ptr cuDoubleComplex; lda: cint; TAU: ptr cuDoubleComplex;
                        Workspace: ptr cuDoubleComplex; Lwork: cint;
                        devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnZgeqrf", dynlib: libName.}
  ##  generate unitary matrix Q from QR factorization
  proc cusolverDnSorgqr_bufferSize*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   k: cint; A: ptr cfloat; lda: cint; tau: ptr cfloat;
                                   lwork: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnSorgqr_bufferSize", dynlib: libName.}
  proc cusolverDnDorgqr_bufferSize*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   k: cint; A: ptr cdouble; lda: cint;
                                   tau: ptr cdouble; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDorgqr_bufferSize", dynlib: libName.}
  proc cusolverDnCungqr_bufferSize*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   k: cint; A: ptr cuComplex; lda: cint;
                                   tau: ptr cuComplex; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnCungqr_bufferSize", dynlib: libName.}
  proc cusolverDnZungqr_bufferSize*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   k: cint; A: ptr cuDoubleComplex; lda: cint;
                                   tau: ptr cuDoubleComplex; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZungqr_bufferSize", dynlib: libName.}
  proc cusolverDnSorgqr*(handle: cusolverDnHandle_t; m: cint; n: cint; k: cint;
                        A: ptr cfloat; lda: cint; tau: ptr cfloat; work: ptr cfloat;
                        lwork: cint; info: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnSorgqr", dynlib: libName.}
  proc cusolverDnDorgqr*(handle: cusolverDnHandle_t; m: cint; n: cint; k: cint;
                        A: ptr cdouble; lda: cint; tau: ptr cdouble; work: ptr cdouble;
                        lwork: cint; info: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDorgqr", dynlib: libName.}
  proc cusolverDnCungqr*(handle: cusolverDnHandle_t; m: cint; n: cint; k: cint;
                        A: ptr cuComplex; lda: cint; tau: ptr cuComplex;
                        work: ptr cuComplex; lwork: cint; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnCungqr", dynlib: libName.}
  proc cusolverDnZungqr*(handle: cusolverDnHandle_t; m: cint; n: cint; k: cint;
                        A: ptr cuDoubleComplex; lda: cint; tau: ptr cuDoubleComplex;
                        work: ptr cuDoubleComplex; lwork: cint; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZungqr", dynlib: libName.}
  ##  compute Q**T*b in solve min||A*x = b||
  proc cusolverDnSormqr_bufferSize*(handle: cusolverDnHandle_t;
                                   side: cublasSideMode_t;
                                   trans: cublasOperation_t; m: cint; n: cint;
                                   k: cint; A: ptr cfloat; lda: cint; tau: ptr cfloat;
                                   C: ptr cfloat; ldc: cint; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSormqr_bufferSize", dynlib: libName.}
  proc cusolverDnDormqr_bufferSize*(handle: cusolverDnHandle_t;
                                   side: cublasSideMode_t;
                                   trans: cublasOperation_t; m: cint; n: cint;
                                   k: cint; A: ptr cdouble; lda: cint;
                                   tau: ptr cdouble; C: ptr cdouble; ldc: cint;
                                   lwork: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDormqr_bufferSize", dynlib: libName.}
  proc cusolverDnCunmqr_bufferSize*(handle: cusolverDnHandle_t;
                                   side: cublasSideMode_t;
                                   trans: cublasOperation_t; m: cint; n: cint;
                                   k: cint; A: ptr cuComplex; lda: cint;
                                   tau: ptr cuComplex; C: ptr cuComplex; ldc: cint;
                                   lwork: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnCunmqr_bufferSize", dynlib: libName.}
  proc cusolverDnZunmqr_bufferSize*(handle: cusolverDnHandle_t;
                                   side: cublasSideMode_t;
                                   trans: cublasOperation_t; m: cint; n: cint;
                                   k: cint; A: ptr cuDoubleComplex; lda: cint;
                                   tau: ptr cuDoubleComplex;
                                   C: ptr cuDoubleComplex; ldc: cint; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZunmqr_bufferSize", dynlib: libName.}
  proc cusolverDnSormqr*(handle: cusolverDnHandle_t; side: cublasSideMode_t;
                        trans: cublasOperation_t; m: cint; n: cint; k: cint;
                        A: ptr cfloat; lda: cint; tau: ptr cfloat; C: ptr cfloat;
                        ldc: cint; work: ptr cfloat; lwork: cint; devInfo: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSormqr", dynlib: libName.}
  proc cusolverDnDormqr*(handle: cusolverDnHandle_t; side: cublasSideMode_t;
                        trans: cublasOperation_t; m: cint; n: cint; k: cint;
                        A: ptr cdouble; lda: cint; tau: ptr cdouble; C: ptr cdouble;
                        ldc: cint; work: ptr cdouble; lwork: cint; devInfo: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDormqr", dynlib: libName.}
  proc cusolverDnCunmqr*(handle: cusolverDnHandle_t; side: cublasSideMode_t;
                        trans: cublasOperation_t; m: cint; n: cint; k: cint;
                        A: ptr cuComplex; lda: cint; tau: ptr cuComplex;
                        C: ptr cuComplex; ldc: cint; work: ptr cuComplex; lwork: cint;
                        devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnCunmqr", dynlib: libName.}
  proc cusolverDnZunmqr*(handle: cusolverDnHandle_t; side: cublasSideMode_t;
                        trans: cublasOperation_t; m: cint; n: cint; k: cint;
                        A: ptr cuDoubleComplex; lda: cint; tau: ptr cuDoubleComplex;
                        C: ptr cuDoubleComplex; ldc: cint; work: ptr cuDoubleComplex;
                        lwork: cint; devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnZunmqr", dynlib: libName.}
  ##  L*D*L**T,U*D*U**T factorization
  proc cusolverDnSsytrf_bufferSize*(handle: cusolverDnHandle_t; n: cint;
                                   A: ptr cfloat; lda: cint; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSsytrf_bufferSize", dynlib: libName.}
  proc cusolverDnDsytrf_bufferSize*(handle: cusolverDnHandle_t; n: cint;
                                   A: ptr cdouble; lda: cint; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDsytrf_bufferSize", dynlib: libName.}
  proc cusolverDnCsytrf_bufferSize*(handle: cusolverDnHandle_t; n: cint;
                                   A: ptr cuComplex; lda: cint; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnCsytrf_bufferSize", dynlib: libName.}
  proc cusolverDnZsytrf_bufferSize*(handle: cusolverDnHandle_t; n: cint;
                                   A: ptr cuDoubleComplex; lda: cint; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZsytrf_bufferSize", dynlib: libName.}
  proc cusolverDnSsytrf*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cfloat; lda: cint; ipiv: ptr cint; work: ptr cfloat;
                        lwork: cint; info: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnSsytrf", dynlib: libName.}
  proc cusolverDnDsytrf*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cdouble; lda: cint; ipiv: ptr cint; work: ptr cdouble;
                        lwork: cint; info: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDsytrf", dynlib: libName.}
  proc cusolverDnCsytrf*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cuComplex; lda: cint; ipiv: ptr cint;
                        work: ptr cuComplex; lwork: cint; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnCsytrf", dynlib: libName.}
  proc cusolverDnZsytrf*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cuDoubleComplex; lda: cint; ipiv: ptr cint;
                        work: ptr cuDoubleComplex; lwork: cint; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZsytrf", dynlib: libName.}
  ##  Symmetric indefinite solve (SYTRS)
  proc cusolverDnXsytrs_bufferSize*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: clonglong;
                                   nrhs: clonglong; dataTypeA: cudaDataType;
                                   A: pointer; lda: clonglong; ipiv: ptr clonglong;
                                   dataTypeB: cudaDataType; B: pointer;
                                   ldb: clonglong;
                                   workspaceInBytesOnDevice: ptr csize_t;
                                   workspaceInBytesOnHost: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnXsytrs_bufferSize", dynlib: libName.}
  proc cusolverDnXsytrs*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t;
                        n: clonglong; nrhs: clonglong; dataTypeA: cudaDataType;
                        A: pointer; lda: clonglong; ipiv: ptr clonglong;
                        dataTypeB: cudaDataType; B: pointer; ldb: clonglong;
                        bufferOnDevice: pointer;
                        workspaceInBytesOnDevice: csize_t; bufferOnHost: pointer;
                        workspaceInBytesOnHost: csize_t; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnXsytrs", dynlib: libName.}
  ##  Symmetric indefinite inversion (sytri)
  proc cusolverDnSsytri_bufferSize*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cfloat;
                                   lda: cint; ipiv: ptr cint; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSsytri_bufferSize", dynlib: libName.}
  proc cusolverDnDsytri_bufferSize*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cdouble;
                                   lda: cint; ipiv: ptr cint; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDsytri_bufferSize", dynlib: libName.}
  proc cusolverDnCsytri_bufferSize*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuComplex; lda: cint; ipiv: ptr cint;
                                   lwork: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnCsytri_bufferSize", dynlib: libName.}
  proc cusolverDnZsytri_bufferSize*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuDoubleComplex; lda: cint; ipiv: ptr cint;
                                   lwork: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnZsytri_bufferSize", dynlib: libName.}
  proc cusolverDnSsytri*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cfloat; lda: cint; ipiv: ptr cint; work: ptr cfloat;
                        lwork: cint; info: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnSsytri", dynlib: libName.}
  proc cusolverDnDsytri*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cdouble; lda: cint; ipiv: ptr cint; work: ptr cdouble;
                        lwork: cint; info: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDsytri", dynlib: libName.}
  proc cusolverDnCsytri*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cuComplex; lda: cint; ipiv: ptr cint;
                        work: ptr cuComplex; lwork: cint; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnCsytri", dynlib: libName.}
  proc cusolverDnZsytri*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cuDoubleComplex; lda: cint; ipiv: ptr cint;
                        work: ptr cuDoubleComplex; lwork: cint; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZsytri", dynlib: libName.}
  ##  bidiagonal factorization
  proc cusolverDnSgebrd_bufferSize*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   Lwork: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnSgebrd_bufferSize", dynlib: libName.}
  proc cusolverDnDgebrd_bufferSize*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   Lwork: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDgebrd_bufferSize", dynlib: libName.}
  proc cusolverDnCgebrd_bufferSize*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   Lwork: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnCgebrd_bufferSize", dynlib: libName.}
  proc cusolverDnZgebrd_bufferSize*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   Lwork: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnZgebrd_bufferSize", dynlib: libName.}
  proc cusolverDnSgebrd*(handle: cusolverDnHandle_t; m: cint; n: cint; A: ptr cfloat;
                        lda: cint; D: ptr cfloat; E: ptr cfloat; TAUQ: ptr cfloat;
                        TAUP: ptr cfloat; Work: ptr cfloat; Lwork: cint;
                        devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnSgebrd", dynlib: libName.}
  proc cusolverDnDgebrd*(handle: cusolverDnHandle_t; m: cint; n: cint; A: ptr cdouble;
                        lda: cint; D: ptr cdouble; E: ptr cdouble; TAUQ: ptr cdouble;
                        TAUP: ptr cdouble; Work: ptr cdouble; Lwork: cint;
                        devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDgebrd", dynlib: libName.}
  proc cusolverDnCgebrd*(handle: cusolverDnHandle_t; m: cint; n: cint;
                        A: ptr cuComplex; lda: cint; D: ptr cfloat; E: ptr cfloat;
                        TAUQ: ptr cuComplex; TAUP: ptr cuComplex; Work: ptr cuComplex;
                        Lwork: cint; devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnCgebrd", dynlib: libName.}
  proc cusolverDnZgebrd*(handle: cusolverDnHandle_t; m: cint; n: cint;
                        A: ptr cuDoubleComplex; lda: cint; D: ptr cdouble;
                        E: ptr cdouble; TAUQ: ptr cuDoubleComplex;
                        TAUP: ptr cuDoubleComplex; Work: ptr cuDoubleComplex;
                        Lwork: cint; devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnZgebrd", dynlib: libName.}
  ##  generates one of the unitary matrices Q or P**T determined by GEBRD
  proc cusolverDnSorgbr_bufferSize*(handle: cusolverDnHandle_t;
                                   side: cublasSideMode_t; m: cint; n: cint; k: cint;
                                   A: ptr cfloat; lda: cint; tau: ptr cfloat;
                                   lwork: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnSorgbr_bufferSize", dynlib: libName.}
  proc cusolverDnDorgbr_bufferSize*(handle: cusolverDnHandle_t;
                                   side: cublasSideMode_t; m: cint; n: cint; k: cint;
                                   A: ptr cdouble; lda: cint; tau: ptr cdouble;
                                   lwork: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDorgbr_bufferSize", dynlib: libName.}
  proc cusolverDnCungbr_bufferSize*(handle: cusolverDnHandle_t;
                                   side: cublasSideMode_t; m: cint; n: cint; k: cint;
                                   A: ptr cuComplex; lda: cint; tau: ptr cuComplex;
                                   lwork: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnCungbr_bufferSize", dynlib: libName.}
  proc cusolverDnZungbr_bufferSize*(handle: cusolverDnHandle_t;
                                   side: cublasSideMode_t; m: cint; n: cint; k: cint;
                                   A: ptr cuDoubleComplex; lda: cint;
                                   tau: ptr cuDoubleComplex; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZungbr_bufferSize", dynlib: libName.}
  proc cusolverDnSorgbr*(handle: cusolverDnHandle_t; side: cublasSideMode_t; m: cint;
                        n: cint; k: cint; A: ptr cfloat; lda: cint; tau: ptr cfloat;
                        work: ptr cfloat; lwork: cint; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSorgbr", dynlib: libName.}
  proc cusolverDnDorgbr*(handle: cusolverDnHandle_t; side: cublasSideMode_t; m: cint;
                        n: cint; k: cint; A: ptr cdouble; lda: cint; tau: ptr cdouble;
                        work: ptr cdouble; lwork: cint; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDorgbr", dynlib: libName.}
  proc cusolverDnCungbr*(handle: cusolverDnHandle_t; side: cublasSideMode_t; m: cint;
                        n: cint; k: cint; A: ptr cuComplex; lda: cint;
                        tau: ptr cuComplex; work: ptr cuComplex; lwork: cint;
                        info: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnCungbr", dynlib: libName.}
  proc cusolverDnZungbr*(handle: cusolverDnHandle_t; side: cublasSideMode_t; m: cint;
                        n: cint; k: cint; A: ptr cuDoubleComplex; lda: cint;
                        tau: ptr cuDoubleComplex; work: ptr cuDoubleComplex;
                        lwork: cint; info: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnZungbr", dynlib: libName.}
  ##  tridiagonal factorization
  proc cusolverDnSsytrd_bufferSize*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cfloat;
                                   lda: cint; d: ptr cfloat; e: ptr cfloat;
                                   tau: ptr cfloat; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSsytrd_bufferSize", dynlib: libName.}
  proc cusolverDnDsytrd_bufferSize*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cdouble;
                                   lda: cint; d: ptr cdouble; e: ptr cdouble;
                                   tau: ptr cdouble; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDsytrd_bufferSize", dynlib: libName.}
  proc cusolverDnChetrd_bufferSize*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuComplex; lda: cint; d: ptr cfloat;
                                   e: ptr cfloat; tau: ptr cuComplex; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnChetrd_bufferSize", dynlib: libName.}
  proc cusolverDnZhetrd_bufferSize*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuDoubleComplex; lda: cint; d: ptr cdouble;
                                   e: ptr cdouble; tau: ptr cuDoubleComplex;
                                   lwork: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnZhetrd_bufferSize", dynlib: libName.}
  proc cusolverDnSsytrd*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cfloat; lda: cint; d: ptr cfloat; e: ptr cfloat;
                        tau: ptr cfloat; work: ptr cfloat; lwork: cint; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSsytrd", dynlib: libName.}
  proc cusolverDnDsytrd*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cdouble; lda: cint; d: ptr cdouble; e: ptr cdouble;
                        tau: ptr cdouble; work: ptr cdouble; lwork: cint; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDsytrd", dynlib: libName.}
  proc cusolverDnChetrd*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cuComplex; lda: cint; d: ptr cfloat; e: ptr cfloat;
                        tau: ptr cuComplex; work: ptr cuComplex; lwork: cint;
                        info: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnChetrd", dynlib: libName.}
  proc cusolverDnZhetrd*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cuDoubleComplex; lda: cint; d: ptr cdouble;
                        e: ptr cdouble; tau: ptr cuDoubleComplex;
                        work: ptr cuDoubleComplex; lwork: cint; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZhetrd", dynlib: libName.}
  ##  generate unitary Q comes from sytrd
  proc cusolverDnSorgtr_bufferSize*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cfloat;
                                   lda: cint; tau: ptr cfloat; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSorgtr_bufferSize", dynlib: libName.}
  proc cusolverDnDorgtr_bufferSize*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cdouble;
                                   lda: cint; tau: ptr cdouble; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDorgtr_bufferSize", dynlib: libName.}
  proc cusolverDnCungtr_bufferSize*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuComplex; lda: cint; tau: ptr cuComplex;
                                   lwork: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnCungtr_bufferSize", dynlib: libName.}
  proc cusolverDnZungtr_bufferSize*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuDoubleComplex; lda: cint;
                                   tau: ptr cuDoubleComplex; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZungtr_bufferSize", dynlib: libName.}
  proc cusolverDnSorgtr*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cfloat; lda: cint; tau: ptr cfloat; work: ptr cfloat;
                        lwork: cint; info: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnSorgtr", dynlib: libName.}
  proc cusolverDnDorgtr*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cdouble; lda: cint; tau: ptr cdouble; work: ptr cdouble;
                        lwork: cint; info: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDorgtr", dynlib: libName.}
  proc cusolverDnCungtr*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cuComplex; lda: cint; tau: ptr cuComplex;
                        work: ptr cuComplex; lwork: cint; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnCungtr", dynlib: libName.}
  proc cusolverDnZungtr*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cuDoubleComplex; lda: cint; tau: ptr cuDoubleComplex;
                        work: ptr cuDoubleComplex; lwork: cint; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZungtr", dynlib: libName.}
  ##  compute op(Q)*C or C*op(Q) where Q comes from sytrd
  proc cusolverDnSormtr_bufferSize*(handle: cusolverDnHandle_t;
                                   side: cublasSideMode_t; uplo: cublasFillMode_t;
                                   trans: cublasOperation_t; m: cint; n: cint;
                                   A: ptr cfloat; lda: cint; tau: ptr cfloat;
                                   C: ptr cfloat; ldc: cint; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSormtr_bufferSize", dynlib: libName.}
  proc cusolverDnDormtr_bufferSize*(handle: cusolverDnHandle_t;
                                   side: cublasSideMode_t; uplo: cublasFillMode_t;
                                   trans: cublasOperation_t; m: cint; n: cint;
                                   A: ptr cdouble; lda: cint; tau: ptr cdouble;
                                   C: ptr cdouble; ldc: cint; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDormtr_bufferSize", dynlib: libName.}
  proc cusolverDnCunmtr_bufferSize*(handle: cusolverDnHandle_t;
                                   side: cublasSideMode_t; uplo: cublasFillMode_t;
                                   trans: cublasOperation_t; m: cint; n: cint;
                                   A: ptr cuComplex; lda: cint; tau: ptr cuComplex;
                                   C: ptr cuComplex; ldc: cint; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnCunmtr_bufferSize", dynlib: libName.}
  proc cusolverDnZunmtr_bufferSize*(handle: cusolverDnHandle_t;
                                   side: cublasSideMode_t; uplo: cublasFillMode_t;
                                   trans: cublasOperation_t; m: cint; n: cint;
                                   A: ptr cuDoubleComplex; lda: cint;
                                   tau: ptr cuDoubleComplex;
                                   C: ptr cuDoubleComplex; ldc: cint; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZunmtr_bufferSize", dynlib: libName.}
  proc cusolverDnSormtr*(handle: cusolverDnHandle_t; side: cublasSideMode_t;
                        uplo: cublasFillMode_t; trans: cublasOperation_t; m: cint;
                        n: cint; A: ptr cfloat; lda: cint; tau: ptr cfloat; C: ptr cfloat;
                        ldc: cint; work: ptr cfloat; lwork: cint; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSormtr", dynlib: libName.}
  proc cusolverDnDormtr*(handle: cusolverDnHandle_t; side: cublasSideMode_t;
                        uplo: cublasFillMode_t; trans: cublasOperation_t; m: cint;
                        n: cint; A: ptr cdouble; lda: cint; tau: ptr cdouble;
                        C: ptr cdouble; ldc: cint; work: ptr cdouble; lwork: cint;
                        info: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDormtr", dynlib: libName.}
  proc cusolverDnCunmtr*(handle: cusolverDnHandle_t; side: cublasSideMode_t;
                        uplo: cublasFillMode_t; trans: cublasOperation_t; m: cint;
                        n: cint; A: ptr cuComplex; lda: cint; tau: ptr cuComplex;
                        C: ptr cuComplex; ldc: cint; work: ptr cuComplex; lwork: cint;
                        info: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnCunmtr", dynlib: libName.}
  proc cusolverDnZunmtr*(handle: cusolverDnHandle_t; side: cublasSideMode_t;
                        uplo: cublasFillMode_t; trans: cublasOperation_t; m: cint;
                        n: cint; A: ptr cuDoubleComplex; lda: cint;
                        tau: ptr cuDoubleComplex; C: ptr cuDoubleComplex; ldc: cint;
                        work: ptr cuDoubleComplex; lwork: cint; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZunmtr", dynlib: libName.}
  ##  singular value decomposition, A = U * Sigma * V^H
  proc cusolverDnSgesvd_bufferSize*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   lwork: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnSgesvd_bufferSize", dynlib: libName.}
  proc cusolverDnDgesvd_bufferSize*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   lwork: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDgesvd_bufferSize", dynlib: libName.}
  proc cusolverDnCgesvd_bufferSize*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   lwork: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnCgesvd_bufferSize", dynlib: libName.}
  proc cusolverDnZgesvd_bufferSize*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   lwork: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnZgesvd_bufferSize", dynlib: libName.}
  proc cusolverDnSgesvd*(handle: cusolverDnHandle_t; jobu: cchar; jobvt: cchar;
                        m: cint; n: cint; A: ptr cfloat; lda: cint; S: ptr cfloat;
                        U: ptr cfloat; ldu: cint; VT: ptr cfloat; ldvt: cint;
                        work: ptr cfloat; lwork: cint; rwork: ptr cfloat; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSgesvd", dynlib: libName.}
  proc cusolverDnDgesvd*(handle: cusolverDnHandle_t; jobu: cchar; jobvt: cchar;
                        m: cint; n: cint; A: ptr cdouble; lda: cint; S: ptr cdouble;
                        U: ptr cdouble; ldu: cint; VT: ptr cdouble; ldvt: cint;
                        work: ptr cdouble; lwork: cint; rwork: ptr cdouble;
                        info: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDgesvd", dynlib: libName.}
  proc cusolverDnCgesvd*(handle: cusolverDnHandle_t; jobu: cchar; jobvt: cchar;
                        m: cint; n: cint; A: ptr cuComplex; lda: cint; S: ptr cfloat;
                        U: ptr cuComplex; ldu: cint; VT: ptr cuComplex; ldvt: cint;
                        work: ptr cuComplex; lwork: cint; rwork: ptr cfloat;
                        info: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnCgesvd", dynlib: libName.}
  proc cusolverDnZgesvd*(handle: cusolverDnHandle_t; jobu: cchar; jobvt: cchar;
                        m: cint; n: cint; A: ptr cuDoubleComplex; lda: cint;
                        S: ptr cdouble; U: ptr cuDoubleComplex; ldu: cint;
                        VT: ptr cuDoubleComplex; ldvt: cint;
                        work: ptr cuDoubleComplex; lwork: cint; rwork: ptr cdouble;
                        info: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnZgesvd", dynlib: libName.}
  ##  standard symmetric eigenvalue solver, A*x = lambda*x, by divide-and-conquer
  ##
  proc cusolverDnSsyevd_bufferSize*(handle: cusolverDnHandle_t;
                                   jobz: cusolverEigMode_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cfloat;
                                   lda: cint; W: ptr cfloat; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSsyevd_bufferSize", dynlib: libName.}
  proc cusolverDnDsyevd_bufferSize*(handle: cusolverDnHandle_t;
                                   jobz: cusolverEigMode_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cdouble;
                                   lda: cint; W: ptr cdouble; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDsyevd_bufferSize", dynlib: libName.}
  proc cusolverDnCheevd_bufferSize*(handle: cusolverDnHandle_t;
                                   jobz: cusolverEigMode_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuComplex; lda: cint; W: ptr cfloat;
                                   lwork: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnCheevd_bufferSize", dynlib: libName.}
  proc cusolverDnZheevd_bufferSize*(handle: cusolverDnHandle_t;
                                   jobz: cusolverEigMode_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuDoubleComplex; lda: cint; W: ptr cdouble;
                                   lwork: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnZheevd_bufferSize", dynlib: libName.}
  proc cusolverDnSsyevd*(handle: cusolverDnHandle_t; jobz: cusolverEigMode_t;
                        uplo: cublasFillMode_t; n: cint; A: ptr cfloat; lda: cint;
                        W: ptr cfloat; work: ptr cfloat; lwork: cint; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSsyevd", dynlib: libName.}
  proc cusolverDnDsyevd*(handle: cusolverDnHandle_t; jobz: cusolverEigMode_t;
                        uplo: cublasFillMode_t; n: cint; A: ptr cdouble; lda: cint;
                        W: ptr cdouble; work: ptr cdouble; lwork: cint; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDsyevd", dynlib: libName.}
  proc cusolverDnCheevd*(handle: cusolverDnHandle_t; jobz: cusolverEigMode_t;
                        uplo: cublasFillMode_t; n: cint; A: ptr cuComplex; lda: cint;
                        W: ptr cfloat; work: ptr cuComplex; lwork: cint; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnCheevd", dynlib: libName.}
  proc cusolverDnZheevd*(handle: cusolverDnHandle_t; jobz: cusolverEigMode_t;
                        uplo: cublasFillMode_t; n: cint; A: ptr cuDoubleComplex;
                        lda: cint; W: ptr cdouble; work: ptr cuDoubleComplex;
                        lwork: cint; info: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnZheevd", dynlib: libName.}
  ##  standard selective symmetric eigenvalue solver, A*x = lambda*x, by
  ##  divide-and-conquer
  proc cusolverDnSsyevdx_bufferSize*(handle: cusolverDnHandle_t;
                                    jobz: cusolverEigMode_t;
                                    range: cusolverEigRange_t;
                                    uplo: cublasFillMode_t; n: cint; A: ptr cfloat;
                                    lda: cint; vl: cfloat; vu: cfloat; il: cint;
                                    iu: cint; meig: ptr cint; W: ptr cfloat;
                                    lwork: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnSsyevdx_bufferSize", dynlib: libName.}
  proc cusolverDnDsyevdx_bufferSize*(handle: cusolverDnHandle_t;
                                    jobz: cusolverEigMode_t;
                                    range: cusolverEigRange_t;
                                    uplo: cublasFillMode_t; n: cint; A: ptr cdouble;
                                    lda: cint; vl: cdouble; vu: cdouble; il: cint;
                                    iu: cint; meig: ptr cint; W: ptr cdouble;
                                    lwork: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDsyevdx_bufferSize", dynlib: libName.}
  proc cusolverDnCheevdx_bufferSize*(handle: cusolverDnHandle_t;
                                    jobz: cusolverEigMode_t;
                                    range: cusolverEigRange_t;
                                    uplo: cublasFillMode_t; n: cint;
                                    A: ptr cuComplex; lda: cint; vl: cfloat;
                                    vu: cfloat; il: cint; iu: cint; meig: ptr cint;
                                    W: ptr cfloat; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnCheevdx_bufferSize", dynlib: libName.}
  proc cusolverDnZheevdx_bufferSize*(handle: cusolverDnHandle_t;
                                    jobz: cusolverEigMode_t;
                                    range: cusolverEigRange_t;
                                    uplo: cublasFillMode_t; n: cint;
                                    A: ptr cuDoubleComplex; lda: cint; vl: cdouble;
                                    vu: cdouble; il: cint; iu: cint; meig: ptr cint;
                                    W: ptr cdouble; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZheevdx_bufferSize", dynlib: libName.}
  proc cusolverDnSsyevdx*(handle: cusolverDnHandle_t; jobz: cusolverEigMode_t;
                         range: cusolverEigRange_t; uplo: cublasFillMode_t; n: cint;
                         A: ptr cfloat; lda: cint; vl: cfloat; vu: cfloat; il: cint;
                         iu: cint; meig: ptr cint; W: ptr cfloat; work: ptr cfloat;
                         lwork: cint; info: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnSsyevdx", dynlib: libName.}
  proc cusolverDnDsyevdx*(handle: cusolverDnHandle_t; jobz: cusolverEigMode_t;
                         range: cusolverEigRange_t; uplo: cublasFillMode_t; n: cint;
                         A: ptr cdouble; lda: cint; vl: cdouble; vu: cdouble; il: cint;
                         iu: cint; meig: ptr cint; W: ptr cdouble; work: ptr cdouble;
                         lwork: cint; info: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDsyevdx", dynlib: libName.}
  proc cusolverDnCheevdx*(handle: cusolverDnHandle_t; jobz: cusolverEigMode_t;
                         range: cusolverEigRange_t; uplo: cublasFillMode_t; n: cint;
                         A: ptr cuComplex; lda: cint; vl: cfloat; vu: cfloat; il: cint;
                         iu: cint; meig: ptr cint; W: ptr cfloat; work: ptr cuComplex;
                         lwork: cint; info: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnCheevdx", dynlib: libName.}
  proc cusolverDnZheevdx*(handle: cusolverDnHandle_t; jobz: cusolverEigMode_t;
                         range: cusolverEigRange_t; uplo: cublasFillMode_t; n: cint;
                         A: ptr cuDoubleComplex; lda: cint; vl: cdouble; vu: cdouble;
                         il: cint; iu: cint; meig: ptr cint; W: ptr cdouble;
                         work: ptr cuDoubleComplex; lwork: cint; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZheevdx", dynlib: libName.}
  ##  selective generalized symmetric eigenvalue solver, A*x = lambda*B*x, by
  ##  divide-and-conquer
  proc cusolverDnSsygvdx_bufferSize*(handle: cusolverDnHandle_t;
                                    itype: cusolverEigType_t;
                                    jobz: cusolverEigMode_t;
                                    range: cusolverEigRange_t;
                                    uplo: cublasFillMode_t; n: cint; A: ptr cfloat;
                                    lda: cint; B: ptr cfloat; ldb: cint; vl: cfloat;
                                    vu: cfloat; il: cint; iu: cint; meig: ptr cint;
                                    W: ptr cfloat; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSsygvdx_bufferSize", dynlib: libName.}
  proc cusolverDnDsygvdx_bufferSize*(handle: cusolverDnHandle_t;
                                    itype: cusolverEigType_t;
                                    jobz: cusolverEigMode_t;
                                    range: cusolverEigRange_t;
                                    uplo: cublasFillMode_t; n: cint; A: ptr cdouble;
                                    lda: cint; B: ptr cdouble; ldb: cint; vl: cdouble;
                                    vu: cdouble; il: cint; iu: cint; meig: ptr cint;
                                    W: ptr cdouble; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDsygvdx_bufferSize", dynlib: libName.}
  proc cusolverDnChegvdx_bufferSize*(handle: cusolverDnHandle_t;
                                    itype: cusolverEigType_t;
                                    jobz: cusolverEigMode_t;
                                    range: cusolverEigRange_t;
                                    uplo: cublasFillMode_t; n: cint;
                                    A: ptr cuComplex; lda: cint; B: ptr cuComplex;
                                    ldb: cint; vl: cfloat; vu: cfloat; il: cint;
                                    iu: cint; meig: ptr cint; W: ptr cfloat;
                                    lwork: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnChegvdx_bufferSize", dynlib: libName.}
  proc cusolverDnZhegvdx_bufferSize*(handle: cusolverDnHandle_t;
                                    itype: cusolverEigType_t;
                                    jobz: cusolverEigMode_t;
                                    range: cusolverEigRange_t;
                                    uplo: cublasFillMode_t; n: cint;
                                    A: ptr cuDoubleComplex; lda: cint;
                                    B: ptr cuDoubleComplex; ldb: cint; vl: cdouble;
                                    vu: cdouble; il: cint; iu: cint; meig: ptr cint;
                                    W: ptr cdouble; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZhegvdx_bufferSize", dynlib: libName.}
  proc cusolverDnSsygvdx*(handle: cusolverDnHandle_t; itype: cusolverEigType_t;
                         jobz: cusolverEigMode_t; range: cusolverEigRange_t;
                         uplo: cublasFillMode_t; n: cint; A: ptr cfloat; lda: cint;
                         B: ptr cfloat; ldb: cint; vl: cfloat; vu: cfloat; il: cint;
                         iu: cint; meig: ptr cint; W: ptr cfloat; work: ptr cfloat;
                         lwork: cint; info: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnSsygvdx", dynlib: libName.}
  proc cusolverDnDsygvdx*(handle: cusolverDnHandle_t; itype: cusolverEigType_t;
                         jobz: cusolverEigMode_t; range: cusolverEigRange_t;
                         uplo: cublasFillMode_t; n: cint; A: ptr cdouble; lda: cint;
                         B: ptr cdouble; ldb: cint; vl: cdouble; vu: cdouble; il: cint;
                         iu: cint; meig: ptr cint; W: ptr cdouble; work: ptr cdouble;
                         lwork: cint; info: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDsygvdx", dynlib: libName.}
  proc cusolverDnChegvdx*(handle: cusolverDnHandle_t; itype: cusolverEigType_t;
                         jobz: cusolverEigMode_t; range: cusolverEigRange_t;
                         uplo: cublasFillMode_t; n: cint; A: ptr cuComplex; lda: cint;
                         B: ptr cuComplex; ldb: cint; vl: cfloat; vu: cfloat; il: cint;
                         iu: cint; meig: ptr cint; W: ptr cfloat; work: ptr cuComplex;
                         lwork: cint; info: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnChegvdx", dynlib: libName.}
  proc cusolverDnZhegvdx*(handle: cusolverDnHandle_t; itype: cusolverEigType_t;
                         jobz: cusolverEigMode_t; range: cusolverEigRange_t;
                         uplo: cublasFillMode_t; n: cint; A: ptr cuDoubleComplex;
                         lda: cint; B: ptr cuDoubleComplex; ldb: cint; vl: cdouble;
                         vu: cdouble; il: cint; iu: cint; meig: ptr cint; W: ptr cdouble;
                         work: ptr cuDoubleComplex; lwork: cint; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZhegvdx", dynlib: libName.}
  ##  generalized symmetric eigenvalue solver, A*x = lambda*B*x, by
  ##  divide-and-conquer
  proc cusolverDnSsygvd_bufferSize*(handle: cusolverDnHandle_t;
                                   itype: cusolverEigType_t;
                                   jobz: cusolverEigMode_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cfloat;
                                   lda: cint; B: ptr cfloat; ldb: cint; W: ptr cfloat;
                                   lwork: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnSsygvd_bufferSize", dynlib: libName.}
  proc cusolverDnDsygvd_bufferSize*(handle: cusolverDnHandle_t;
                                   itype: cusolverEigType_t;
                                   jobz: cusolverEigMode_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cdouble;
                                   lda: cint; B: ptr cdouble; ldb: cint;
                                   W: ptr cdouble; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDsygvd_bufferSize", dynlib: libName.}
  proc cusolverDnChegvd_bufferSize*(handle: cusolverDnHandle_t;
                                   itype: cusolverEigType_t;
                                   jobz: cusolverEigMode_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuComplex; lda: cint; B: ptr cuComplex;
                                   ldb: cint; W: ptr cfloat; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnChegvd_bufferSize", dynlib: libName.}
  proc cusolverDnZhegvd_bufferSize*(handle: cusolverDnHandle_t;
                                   itype: cusolverEigType_t;
                                   jobz: cusolverEigMode_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuDoubleComplex; lda: cint;
                                   B: ptr cuDoubleComplex; ldb: cint; W: ptr cdouble;
                                   lwork: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnZhegvd_bufferSize", dynlib: libName.}
  proc cusolverDnSsygvd*(handle: cusolverDnHandle_t; itype: cusolverEigType_t;
                        jobz: cusolverEigMode_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cfloat; lda: cint; B: ptr cfloat; ldb: cint; W: ptr cfloat;
                        work: ptr cfloat; lwork: cint; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSsygvd", dynlib: libName.}
  proc cusolverDnDsygvd*(handle: cusolverDnHandle_t; itype: cusolverEigType_t;
                        jobz: cusolverEigMode_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cdouble; lda: cint; B: ptr cdouble; ldb: cint;
                        W: ptr cdouble; work: ptr cdouble; lwork: cint; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDsygvd", dynlib: libName.}
  proc cusolverDnChegvd*(handle: cusolverDnHandle_t; itype: cusolverEigType_t;
                        jobz: cusolverEigMode_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cuComplex; lda: cint; B: ptr cuComplex; ldb: cint;
                        W: ptr cfloat; work: ptr cuComplex; lwork: cint; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnChegvd", dynlib: libName.}
  proc cusolverDnZhegvd*(handle: cusolverDnHandle_t; itype: cusolverEigType_t;
                        jobz: cusolverEigMode_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cuDoubleComplex; lda: cint; B: ptr cuDoubleComplex;
                        ldb: cint; W: ptr cdouble; work: ptr cuDoubleComplex;
                        lwork: cint; info: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnZhegvd", dynlib: libName.}
  proc cusolverDnCreateSyevjInfo*(info: ptr syevjInfo_t): cusolverStatus_t {.cdecl,
      importc: "cusolverDnCreateSyevjInfo", dynlib: libName.}
  proc cusolverDnDestroySyevjInfo*(info: syevjInfo_t): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDestroySyevjInfo", dynlib: libName.}
  proc cusolverDnXsyevjSetTolerance*(info: syevjInfo_t; tolerance: cdouble): cusolverStatus_t {.
      cdecl, importc: "cusolverDnXsyevjSetTolerance", dynlib: libName.}
  proc cusolverDnXsyevjSetMaxSweeps*(info: syevjInfo_t; max_sweeps: cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnXsyevjSetMaxSweeps", dynlib: libName.}
  proc cusolverDnXsyevjSetSortEig*(info: syevjInfo_t; sort_eig: cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnXsyevjSetSortEig", dynlib: libName.}
  proc cusolverDnXsyevjGetResidual*(handle: cusolverDnHandle_t; info: syevjInfo_t;
                                   residual: ptr cdouble): cusolverStatus_t {.cdecl,
      importc: "cusolverDnXsyevjGetResidual", dynlib: libName.}
  proc cusolverDnXsyevjGetSweeps*(handle: cusolverDnHandle_t; info: syevjInfo_t;
                                 executed_sweeps: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnXsyevjGetSweeps", dynlib: libName.}
  proc cusolverDnSsyevjBatched_bufferSize*(handle: cusolverDnHandle_t;
      jobz: cusolverEigMode_t; uplo: cublasFillMode_t; n: cint; A: ptr cfloat; lda: cint;
      W: ptr cfloat; lwork: ptr cint; params: syevjInfo_t; batchSize: cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSsyevjBatched_bufferSize", dynlib: libName.}
  proc cusolverDnDsyevjBatched_bufferSize*(handle: cusolverDnHandle_t;
      jobz: cusolverEigMode_t; uplo: cublasFillMode_t; n: cint; A: ptr cdouble;
      lda: cint; W: ptr cdouble; lwork: ptr cint; params: syevjInfo_t; batchSize: cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDsyevjBatched_bufferSize", dynlib: libName.}
  proc cusolverDnCheevjBatched_bufferSize*(handle: cusolverDnHandle_t;
      jobz: cusolverEigMode_t; uplo: cublasFillMode_t; n: cint; A: ptr cuComplex;
      lda: cint; W: ptr cfloat; lwork: ptr cint; params: syevjInfo_t; batchSize: cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnCheevjBatched_bufferSize", dynlib: libName.}
  proc cusolverDnZheevjBatched_bufferSize*(handle: cusolverDnHandle_t;
      jobz: cusolverEigMode_t; uplo: cublasFillMode_t; n: cint;
      A: ptr cuDoubleComplex; lda: cint; W: ptr cdouble; lwork: ptr cint;
      params: syevjInfo_t; batchSize: cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnZheevjBatched_bufferSize", dynlib: libName.}
  proc cusolverDnSsyevjBatched*(handle: cusolverDnHandle_t;
                               jobz: cusolverEigMode_t; uplo: cublasFillMode_t;
                               n: cint; A: ptr cfloat; lda: cint; W: ptr cfloat;
                               work: ptr cfloat; lwork: cint; info: ptr cint;
                               params: syevjInfo_t; batchSize: cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSsyevjBatched", dynlib: libName.}
  proc cusolverDnDsyevjBatched*(handle: cusolverDnHandle_t;
                               jobz: cusolverEigMode_t; uplo: cublasFillMode_t;
                               n: cint; A: ptr cdouble; lda: cint; W: ptr cdouble;
                               work: ptr cdouble; lwork: cint; info: ptr cint;
                               params: syevjInfo_t; batchSize: cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDsyevjBatched", dynlib: libName.}
  proc cusolverDnCheevjBatched*(handle: cusolverDnHandle_t;
                               jobz: cusolverEigMode_t; uplo: cublasFillMode_t;
                               n: cint; A: ptr cuComplex; lda: cint; W: ptr cfloat;
                               work: ptr cuComplex; lwork: cint; info: ptr cint;
                               params: syevjInfo_t; batchSize: cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnCheevjBatched", dynlib: libName.}
  proc cusolverDnZheevjBatched*(handle: cusolverDnHandle_t;
                               jobz: cusolverEigMode_t; uplo: cublasFillMode_t;
                               n: cint; A: ptr cuDoubleComplex; lda: cint;
                               W: ptr cdouble; work: ptr cuDoubleComplex; lwork: cint;
                               info: ptr cint; params: syevjInfo_t; batchSize: cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZheevjBatched", dynlib: libName.}
  proc cusolverDnSsyevj_bufferSize*(handle: cusolverDnHandle_t;
                                   jobz: cusolverEigMode_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cfloat;
                                   lda: cint; W: ptr cfloat; lwork: ptr cint;
                                   params: syevjInfo_t): cusolverStatus_t {.cdecl,
      importc: "cusolverDnSsyevj_bufferSize", dynlib: libName.}
  proc cusolverDnDsyevj_bufferSize*(handle: cusolverDnHandle_t;
                                   jobz: cusolverEigMode_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cdouble;
                                   lda: cint; W: ptr cdouble; lwork: ptr cint;
                                   params: syevjInfo_t): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDsyevj_bufferSize", dynlib: libName.}
  proc cusolverDnCheevj_bufferSize*(handle: cusolverDnHandle_t;
                                   jobz: cusolverEigMode_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuComplex; lda: cint; W: ptr cfloat;
                                   lwork: ptr cint; params: syevjInfo_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnCheevj_bufferSize", dynlib: libName.}
  proc cusolverDnZheevj_bufferSize*(handle: cusolverDnHandle_t;
                                   jobz: cusolverEigMode_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuDoubleComplex; lda: cint; W: ptr cdouble;
                                   lwork: ptr cint; params: syevjInfo_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZheevj_bufferSize", dynlib: libName.}
  proc cusolverDnSsyevj*(handle: cusolverDnHandle_t; jobz: cusolverEigMode_t;
                        uplo: cublasFillMode_t; n: cint; A: ptr cfloat; lda: cint;
                        W: ptr cfloat; work: ptr cfloat; lwork: cint; info: ptr cint;
                        params: syevjInfo_t): cusolverStatus_t {.cdecl,
      importc: "cusolverDnSsyevj", dynlib: libName.}
  proc cusolverDnDsyevj*(handle: cusolverDnHandle_t; jobz: cusolverEigMode_t;
                        uplo: cublasFillMode_t; n: cint; A: ptr cdouble; lda: cint;
                        W: ptr cdouble; work: ptr cdouble; lwork: cint; info: ptr cint;
                        params: syevjInfo_t): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDsyevj", dynlib: libName.}
  proc cusolverDnCheevj*(handle: cusolverDnHandle_t; jobz: cusolverEigMode_t;
                        uplo: cublasFillMode_t; n: cint; A: ptr cuComplex; lda: cint;
                        W: ptr cfloat; work: ptr cuComplex; lwork: cint; info: ptr cint;
                        params: syevjInfo_t): cusolverStatus_t {.cdecl,
      importc: "cusolverDnCheevj", dynlib: libName.}
  proc cusolverDnZheevj*(handle: cusolverDnHandle_t; jobz: cusolverEigMode_t;
                        uplo: cublasFillMode_t; n: cint; A: ptr cuDoubleComplex;
                        lda: cint; W: ptr cdouble; work: ptr cuDoubleComplex;
                        lwork: cint; info: ptr cint; params: syevjInfo_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZheevj", dynlib: libName.}
  proc cusolverDnSsygvj_bufferSize*(handle: cusolverDnHandle_t;
                                   itype: cusolverEigType_t;
                                   jobz: cusolverEigMode_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cfloat;
                                   lda: cint; B: ptr cfloat; ldb: cint; W: ptr cfloat;
                                   lwork: ptr cint; params: syevjInfo_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSsygvj_bufferSize", dynlib: libName.}
  proc cusolverDnDsygvj_bufferSize*(handle: cusolverDnHandle_t;
                                   itype: cusolverEigType_t;
                                   jobz: cusolverEigMode_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cdouble;
                                   lda: cint; B: ptr cdouble; ldb: cint;
                                   W: ptr cdouble; lwork: ptr cint;
                                   params: syevjInfo_t): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDsygvj_bufferSize", dynlib: libName.}
  proc cusolverDnChegvj_bufferSize*(handle: cusolverDnHandle_t;
                                   itype: cusolverEigType_t;
                                   jobz: cusolverEigMode_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuComplex; lda: cint; B: ptr cuComplex;
                                   ldb: cint; W: ptr cfloat; lwork: ptr cint;
                                   params: syevjInfo_t): cusolverStatus_t {.cdecl,
      importc: "cusolverDnChegvj_bufferSize", dynlib: libName.}
  proc cusolverDnZhegvj_bufferSize*(handle: cusolverDnHandle_t;
                                   itype: cusolverEigType_t;
                                   jobz: cusolverEigMode_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuDoubleComplex; lda: cint;
                                   B: ptr cuDoubleComplex; ldb: cint; W: ptr cdouble;
                                   lwork: ptr cint; params: syevjInfo_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZhegvj_bufferSize", dynlib: libName.}
  proc cusolverDnSsygvj*(handle: cusolverDnHandle_t; itype: cusolverEigType_t;
                        jobz: cusolverEigMode_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cfloat; lda: cint; B: ptr cfloat; ldb: cint; W: ptr cfloat;
                        work: ptr cfloat; lwork: cint; info: ptr cint;
                        params: syevjInfo_t): cusolverStatus_t {.cdecl,
      importc: "cusolverDnSsygvj", dynlib: libName.}
  proc cusolverDnDsygvj*(handle: cusolverDnHandle_t; itype: cusolverEigType_t;
                        jobz: cusolverEigMode_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cdouble; lda: cint; B: ptr cdouble; ldb: cint;
                        W: ptr cdouble; work: ptr cdouble; lwork: cint; info: ptr cint;
                        params: syevjInfo_t): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDsygvj", dynlib: libName.}
  proc cusolverDnChegvj*(handle: cusolverDnHandle_t; itype: cusolverEigType_t;
                        jobz: cusolverEigMode_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cuComplex; lda: cint; B: ptr cuComplex; ldb: cint;
                        W: ptr cfloat; work: ptr cuComplex; lwork: cint; info: ptr cint;
                        params: syevjInfo_t): cusolverStatus_t {.cdecl,
      importc: "cusolverDnChegvj", dynlib: libName.}
  proc cusolverDnZhegvj*(handle: cusolverDnHandle_t; itype: cusolverEigType_t;
                        jobz: cusolverEigMode_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cuDoubleComplex; lda: cint; B: ptr cuDoubleComplex;
                        ldb: cint; W: ptr cdouble; work: ptr cuDoubleComplex;
                        lwork: cint; info: ptr cint; params: syevjInfo_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZhegvj", dynlib: libName.}
  proc cusolverDnCreateGesvdjInfo*(info: ptr gesvdjInfo_t): cusolverStatus_t {.cdecl,
      importc: "cusolverDnCreateGesvdjInfo", dynlib: libName.}
  proc cusolverDnDestroyGesvdjInfo*(info: gesvdjInfo_t): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDestroyGesvdjInfo", dynlib: libName.}
  proc cusolverDnXgesvdjSetTolerance*(info: gesvdjInfo_t; tolerance: cdouble): cusolverStatus_t {.
      cdecl, importc: "cusolverDnXgesvdjSetTolerance", dynlib: libName.}
  proc cusolverDnXgesvdjSetMaxSweeps*(info: gesvdjInfo_t; max_sweeps: cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnXgesvdjSetMaxSweeps", dynlib: libName.}
  proc cusolverDnXgesvdjSetSortEig*(info: gesvdjInfo_t; sort_svd: cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnXgesvdjSetSortEig", dynlib: libName.}
  proc cusolverDnXgesvdjGetResidual*(handle: cusolverDnHandle_t;
                                    info: gesvdjInfo_t; residual: ptr cdouble): cusolverStatus_t {.
      cdecl, importc: "cusolverDnXgesvdjGetResidual", dynlib: libName.}
  proc cusolverDnXgesvdjGetSweeps*(handle: cusolverDnHandle_t; info: gesvdjInfo_t;
                                  executed_sweeps: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnXgesvdjGetSweeps", dynlib: libName.}
  proc cusolverDnSgesvdjBatched_bufferSize*(handle: cusolverDnHandle_t;
      jobz: cusolverEigMode_t; m: cint; n: cint; A: ptr cfloat; lda: cint; S: ptr cfloat;
      U: ptr cfloat; ldu: cint; V: ptr cfloat; ldv: cint; lwork: ptr cint;
      params: gesvdjInfo_t; batchSize: cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnSgesvdjBatched_bufferSize", dynlib: libName.}
  proc cusolverDnDgesvdjBatched_bufferSize*(handle: cusolverDnHandle_t;
      jobz: cusolverEigMode_t; m: cint; n: cint; A: ptr cdouble; lda: cint; S: ptr cdouble;
      U: ptr cdouble; ldu: cint; V: ptr cdouble; ldv: cint; lwork: ptr cint;
      params: gesvdjInfo_t; batchSize: cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDgesvdjBatched_bufferSize", dynlib: libName.}
  proc cusolverDnCgesvdjBatched_bufferSize*(handle: cusolverDnHandle_t;
      jobz: cusolverEigMode_t; m: cint; n: cint; A: ptr cuComplex; lda: cint;
      S: ptr cfloat; U: ptr cuComplex; ldu: cint; V: ptr cuComplex; ldv: cint;
      lwork: ptr cint; params: gesvdjInfo_t; batchSize: cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnCgesvdjBatched_bufferSize", dynlib: libName.}
  proc cusolverDnZgesvdjBatched_bufferSize*(handle: cusolverDnHandle_t;
      jobz: cusolverEigMode_t; m: cint; n: cint; A: ptr cuDoubleComplex; lda: cint;
      S: ptr cdouble; U: ptr cuDoubleComplex; ldu: cint; V: ptr cuDoubleComplex; ldv: cint;
      lwork: ptr cint; params: gesvdjInfo_t; batchSize: cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnZgesvdjBatched_bufferSize", dynlib: libName.}
  proc cusolverDnSgesvdjBatched*(handle: cusolverDnHandle_t;
                                jobz: cusolverEigMode_t; m: cint; n: cint;
                                A: ptr cfloat; lda: cint; S: ptr cfloat; U: ptr cfloat;
                                ldu: cint; V: ptr cfloat; ldv: cint; work: ptr cfloat;
                                lwork: cint; info: ptr cint; params: gesvdjInfo_t;
                                batchSize: cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnSgesvdjBatched", dynlib: libName.}
  proc cusolverDnDgesvdjBatched*(handle: cusolverDnHandle_t;
                                jobz: cusolverEigMode_t; m: cint; n: cint;
                                A: ptr cdouble; lda: cint; S: ptr cdouble;
                                U: ptr cdouble; ldu: cint; V: ptr cdouble; ldv: cint;
                                work: ptr cdouble; lwork: cint; info: ptr cint;
                                params: gesvdjInfo_t; batchSize: cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDgesvdjBatched", dynlib: libName.}
  proc cusolverDnCgesvdjBatched*(handle: cusolverDnHandle_t;
                                jobz: cusolverEigMode_t; m: cint; n: cint;
                                A: ptr cuComplex; lda: cint; S: ptr cfloat;
                                U: ptr cuComplex; ldu: cint; V: ptr cuComplex;
                                ldv: cint; work: ptr cuComplex; lwork: cint;
                                info: ptr cint; params: gesvdjInfo_t; batchSize: cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnCgesvdjBatched", dynlib: libName.}
  proc cusolverDnZgesvdjBatched*(handle: cusolverDnHandle_t;
                                jobz: cusolverEigMode_t; m: cint; n: cint;
                                A: ptr cuDoubleComplex; lda: cint; S: ptr cdouble;
                                U: ptr cuDoubleComplex; ldu: cint;
                                V: ptr cuDoubleComplex; ldv: cint;
                                work: ptr cuDoubleComplex; lwork: cint;
                                info: ptr cint; params: gesvdjInfo_t; batchSize: cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZgesvdjBatched", dynlib: libName.}
  proc cusolverDnSgesvdj_bufferSize*(handle: cusolverDnHandle_t;
                                    jobz: cusolverEigMode_t; econ: cint; m: cint;
                                    n: cint; A: ptr cfloat; lda: cint; S: ptr cfloat;
                                    U: ptr cfloat; ldu: cint; V: ptr cfloat; ldv: cint;
                                    lwork: ptr cint; params: gesvdjInfo_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSgesvdj_bufferSize", dynlib: libName.}
  proc cusolverDnDgesvdj_bufferSize*(handle: cusolverDnHandle_t;
                                    jobz: cusolverEigMode_t; econ: cint; m: cint;
                                    n: cint; A: ptr cdouble; lda: cint; S: ptr cdouble;
                                    U: ptr cdouble; ldu: cint; V: ptr cdouble;
                                    ldv: cint; lwork: ptr cint; params: gesvdjInfo_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDgesvdj_bufferSize", dynlib: libName.}
  proc cusolverDnCgesvdj_bufferSize*(handle: cusolverDnHandle_t;
                                    jobz: cusolverEigMode_t; econ: cint; m: cint;
                                    n: cint; A: ptr cuComplex; lda: cint;
                                    S: ptr cfloat; U: ptr cuComplex; ldu: cint;
                                    V: ptr cuComplex; ldv: cint; lwork: ptr cint;
                                    params: gesvdjInfo_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnCgesvdj_bufferSize", dynlib: libName.}
  proc cusolverDnZgesvdj_bufferSize*(handle: cusolverDnHandle_t;
                                    jobz: cusolverEigMode_t; econ: cint; m: cint;
                                    n: cint; A: ptr cuDoubleComplex; lda: cint;
                                    S: ptr cdouble; U: ptr cuDoubleComplex; ldu: cint;
                                    V: ptr cuDoubleComplex; ldv: cint;
                                    lwork: ptr cint; params: gesvdjInfo_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZgesvdj_bufferSize", dynlib: libName.}
  proc cusolverDnSgesvdj*(handle: cusolverDnHandle_t; jobz: cusolverEigMode_t;
                         econ: cint; m: cint; n: cint; A: ptr cfloat; lda: cint;
                         S: ptr cfloat; U: ptr cfloat; ldu: cint; V: ptr cfloat; ldv: cint;
                         work: ptr cfloat; lwork: cint; info: ptr cint;
                         params: gesvdjInfo_t): cusolverStatus_t {.cdecl,
      importc: "cusolverDnSgesvdj", dynlib: libName.}
  proc cusolverDnDgesvdj*(handle: cusolverDnHandle_t; jobz: cusolverEigMode_t;
                         econ: cint; m: cint; n: cint; A: ptr cdouble; lda: cint;
                         S: ptr cdouble; U: ptr cdouble; ldu: cint; V: ptr cdouble;
                         ldv: cint; work: ptr cdouble; lwork: cint; info: ptr cint;
                         params: gesvdjInfo_t): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDgesvdj", dynlib: libName.}
  proc cusolverDnCgesvdj*(handle: cusolverDnHandle_t; jobz: cusolverEigMode_t;
                         econ: cint; m: cint; n: cint; A: ptr cuComplex; lda: cint;
                         S: ptr cfloat; U: ptr cuComplex; ldu: cint; V: ptr cuComplex;
                         ldv: cint; work: ptr cuComplex; lwork: cint; info: ptr cint;
                         params: gesvdjInfo_t): cusolverStatus_t {.cdecl,
      importc: "cusolverDnCgesvdj", dynlib: libName.}
  proc cusolverDnZgesvdj*(handle: cusolverDnHandle_t; jobz: cusolverEigMode_t;
                         econ: cint; m: cint; n: cint; A: ptr cuDoubleComplex; lda: cint;
                         S: ptr cdouble; U: ptr cuDoubleComplex; ldu: cint;
                         V: ptr cuDoubleComplex; ldv: cint;
                         work: ptr cuDoubleComplex; lwork: cint; info: ptr cint;
                         params: gesvdjInfo_t): cusolverStatus_t {.cdecl,
      importc: "cusolverDnZgesvdj", dynlib: libName.}
  ##  batched approximate SVD
  proc cusolverDnSgesvdaStridedBatched_bufferSize*(handle: cusolverDnHandle_t;
      jobz: cusolverEigMode_t; rank: cint; m: cint; n: cint; d_A: ptr cfloat; lda: cint;
      strideA: clonglong; d_S: ptr cfloat; strideS: clonglong; d_U: ptr cfloat; ldu: cint;
      strideU: clonglong; d_V: ptr cfloat; ldv: cint; strideV: clonglong;
      lwork: ptr cint; batchSize: cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnSgesvdaStridedBatched_bufferSize", dynlib: libName.}
  proc cusolverDnDgesvdaStridedBatched_bufferSize*(handle: cusolverDnHandle_t;
      jobz: cusolverEigMode_t; rank: cint; m: cint; n: cint; d_A: ptr cdouble; lda: cint;
      strideA: clonglong; d_S: ptr cdouble; strideS: clonglong; d_U: ptr cdouble;
      ldu: cint; strideU: clonglong; d_V: ptr cdouble; ldv: cint; strideV: clonglong;
      lwork: ptr cint; batchSize: cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDgesvdaStridedBatched_bufferSize", dynlib: libName.}
  proc cusolverDnCgesvdaStridedBatched_bufferSize*(handle: cusolverDnHandle_t;
      jobz: cusolverEigMode_t; rank: cint; m: cint; n: cint; d_A: ptr cuComplex; lda: cint;
      strideA: clonglong; d_S: ptr cfloat; strideS: clonglong; d_U: ptr cuComplex;
      ldu: cint; strideU: clonglong; d_V: ptr cuComplex; ldv: cint; strideV: clonglong;
      lwork: ptr cint; batchSize: cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnCgesvdaStridedBatched_bufferSize", dynlib: libName.}
  proc cusolverDnZgesvdaStridedBatched_bufferSize*(handle: cusolverDnHandle_t;
      jobz: cusolverEigMode_t; rank: cint; m: cint; n: cint; d_A: ptr cuDoubleComplex;
      lda: cint; strideA: clonglong; d_S: ptr cdouble; strideS: clonglong;
      d_U: ptr cuDoubleComplex; ldu: cint; strideU: clonglong;
      d_V: ptr cuDoubleComplex; ldv: cint; strideV: clonglong; lwork: ptr cint;
      batchSize: cint): cusolverStatus_t {.cdecl, importc: "cusolverDnZgesvdaStridedBatched_bufferSize",
                                        dynlib: libName.}
  proc cusolverDnSgesvdaStridedBatched*(handle: cusolverDnHandle_t;
                                       jobz: cusolverEigMode_t; rank: cint; m: cint;
                                       n: cint; d_A: ptr cfloat; lda: cint;
                                       strideA: clonglong; d_S: ptr cfloat;
                                       strideS: clonglong; d_U: ptr cfloat;
                                       ldu: cint; strideU: clonglong;
                                       d_V: ptr cfloat; ldv: cint;
                                       strideV: clonglong; d_work: ptr cfloat;
                                       lwork: cint; d_info: ptr cint;
                                       h_R_nrmF: ptr cdouble; batchSize: cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSgesvdaStridedBatched", dynlib: libName.}
  proc cusolverDnDgesvdaStridedBatched*(handle: cusolverDnHandle_t;
                                       jobz: cusolverEigMode_t; rank: cint; m: cint;
                                       n: cint; d_A: ptr cdouble; lda: cint;
                                       strideA: clonglong; d_S: ptr cdouble;
                                       strideS: clonglong; d_U: ptr cdouble;
                                       ldu: cint; strideU: clonglong;
                                       d_V: ptr cdouble; ldv: cint;
                                       strideV: clonglong; d_work: ptr cdouble;
                                       lwork: cint; d_info: ptr cint;
                                       h_R_nrmF: ptr cdouble; batchSize: cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDgesvdaStridedBatched", dynlib: libName.}
  proc cusolverDnCgesvdaStridedBatched*(handle: cusolverDnHandle_t;
                                       jobz: cusolverEigMode_t; rank: cint; m: cint;
                                       n: cint; d_A: ptr cuComplex; lda: cint;
                                       strideA: clonglong; d_S: ptr cfloat;
                                       strideS: clonglong; d_U: ptr cuComplex;
                                       ldu: cint; strideU: clonglong;
                                       d_V: ptr cuComplex; ldv: cint;
                                       strideV: clonglong; d_work: ptr cuComplex;
                                       lwork: cint; d_info: ptr cint;
                                       h_R_nrmF: ptr cdouble; batchSize: cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnCgesvdaStridedBatched", dynlib: libName.}
  proc cusolverDnZgesvdaStridedBatched*(handle: cusolverDnHandle_t;
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
                                       batchSize: cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnZgesvdaStridedBatched", dynlib: libName.}
  proc cusolverDnCreateParams*(params: ptr cusolverDnParams_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnCreateParams", dynlib: libName.}
  proc cusolverDnDestroyParams*(params: cusolverDnParams_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDestroyParams", dynlib: libName.}
  proc cusolverDnSetAdvOptions*(params: cusolverDnParams_t;
                               function: cusolverDnFunction_t;
                               algo: cusolverAlgMode_t): cusolverStatus_t {.cdecl,
      importc: "cusolverDnSetAdvOptions", dynlib: libName.}
  ##  64-bit API for POTRF
  proc cusolverDnPotrf_bufferSize*(handle: cusolverDnHandle_t;
                                  params: cusolverDnParams_t;
                                  uplo: cublasFillMode_t; n: clonglong;
                                  dataTypeA: cudaDataType; A: pointer;
                                  lda: clonglong; computeType: cudaDataType;
                                  workspaceInBytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnPotrf_bufferSize", dynlib: libName.}
  proc cusolverDnPotrf*(handle: cusolverDnHandle_t; params: cusolverDnParams_t;
                       uplo: cublasFillMode_t; n: clonglong;
                       dataTypeA: cudaDataType; A: pointer; lda: clonglong;
                       computeType: cudaDataType; pBuffer: pointer;
                       workspaceInBytes: csize_t; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnPotrf", dynlib: libName.}
  ##  64-bit API for POTRS
  proc cusolverDnPotrs*(handle: cusolverDnHandle_t; params: cusolverDnParams_t;
                       uplo: cublasFillMode_t; n: clonglong; nrhs: clonglong;
                       dataTypeA: cudaDataType; A: pointer; lda: clonglong;
                       dataTypeB: cudaDataType; B: pointer; ldb: clonglong;
                       info: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnPotrs", dynlib: libName.}
  ##  64-bit API for GEQRF
  proc cusolverDnGeqrf_bufferSize*(handle: cusolverDnHandle_t;
                                  params: cusolverDnParams_t; m: clonglong;
                                  n: clonglong; dataTypeA: cudaDataType; A: pointer;
                                  lda: clonglong; dataTypeTau: cudaDataType;
                                  tau: pointer; computeType: cudaDataType;
                                  workspaceInBytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnGeqrf_bufferSize", dynlib: libName.}
  proc cusolverDnGeqrf*(handle: cusolverDnHandle_t; params: cusolverDnParams_t;
                       m: clonglong; n: clonglong; dataTypeA: cudaDataType;
                       A: pointer; lda: clonglong; dataTypeTau: cudaDataType;
                       tau: pointer; computeType: cudaDataType; pBuffer: pointer;
                       workspaceInBytes: csize_t; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnGeqrf", dynlib: libName.}
  ##  64-bit API for GETRF
  proc cusolverDnGetrf_bufferSize*(handle: cusolverDnHandle_t;
                                  params: cusolverDnParams_t; m: clonglong;
                                  n: clonglong; dataTypeA: cudaDataType; A: pointer;
                                  lda: clonglong; computeType: cudaDataType;
                                  workspaceInBytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnGetrf_bufferSize", dynlib: libName.}
  proc cusolverDnGetrf*(handle: cusolverDnHandle_t; params: cusolverDnParams_t;
                       m: clonglong; n: clonglong; dataTypeA: cudaDataType;
                       A: pointer; lda: clonglong; ipiv: ptr clonglong;
                       computeType: cudaDataType; pBuffer: pointer;
                       workspaceInBytes: csize_t; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnGetrf", dynlib: libName.}
  ##  64-bit API for GETRS
  proc cusolverDnGetrs*(handle: cusolverDnHandle_t; params: cusolverDnParams_t;
                       trans: cublasOperation_t; n: clonglong; nrhs: clonglong;
                       dataTypeA: cudaDataType; A: pointer; lda: clonglong;
                       ipiv: ptr clonglong; dataTypeB: cudaDataType; B: pointer;
                       ldb: clonglong; info: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnGetrs", dynlib: libName.}
  ##  64-bit API for SYEVD
  proc cusolverDnSyevd_bufferSize*(handle: cusolverDnHandle_t;
                                  params: cusolverDnParams_t;
                                  jobz: cusolverEigMode_t; uplo: cublasFillMode_t;
                                  n: clonglong; dataTypeA: cudaDataType; A: pointer;
                                  lda: clonglong; dataTypeW: cudaDataType;
                                  W: pointer; computeType: cudaDataType;
                                  workspaceInBytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSyevd_bufferSize", dynlib: libName.}
  proc cusolverDnSyevd*(handle: cusolverDnHandle_t; params: cusolverDnParams_t;
                       jobz: cusolverEigMode_t; uplo: cublasFillMode_t;
                       n: clonglong; dataTypeA: cudaDataType; A: pointer;
                       lda: clonglong; dataTypeW: cudaDataType; W: pointer;
                       computeType: cudaDataType; pBuffer: pointer;
                       workspaceInBytes: csize_t; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSyevd", dynlib: libName.}
  ##  64-bit API for SYEVDX
  proc cusolverDnSyevdx_bufferSize*(handle: cusolverDnHandle_t;
                                   params: cusolverDnParams_t;
                                   jobz: cusolverEigMode_t;
                                   range: cusolverEigRange_t;
                                   uplo: cublasFillMode_t; n: clonglong;
                                   dataTypeA: cudaDataType; A: pointer;
                                   lda: clonglong; vl: pointer; vu: pointer;
                                   il: clonglong; iu: clonglong;
                                   h_meig: ptr clonglong; dataTypeW: cudaDataType;
                                   W: pointer; computeType: cudaDataType;
                                   workspaceInBytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSyevdx_bufferSize", dynlib: libName.}
  proc cusolverDnSyevdx*(handle: cusolverDnHandle_t; params: cusolverDnParams_t;
                        jobz: cusolverEigMode_t; range: cusolverEigRange_t;
                        uplo: cublasFillMode_t; n: clonglong;
                        dataTypeA: cudaDataType; A: pointer; lda: clonglong;
                        vl: pointer; vu: pointer; il: clonglong; iu: clonglong;
                        meig64: ptr clonglong; dataTypeW: cudaDataType; W: pointer;
                        computeType: cudaDataType; pBuffer: pointer;
                        workspaceInBytes: csize_t; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSyevdx", dynlib: libName.}
  ##  64-bit API for GESVD
  proc cusolverDnGesvd_bufferSize*(handle: cusolverDnHandle_t;
                                  params: cusolverDnParams_t; jobu: cchar;
                                  jobvt: cchar; m: clonglong; n: clonglong;
                                  dataTypeA: cudaDataType; A: pointer;
                                  lda: clonglong; dataTypeS: cudaDataType;
                                  S: pointer; dataTypeU: cudaDataType; U: pointer;
                                  ldu: clonglong; dataTypeVT: cudaDataType;
                                  VT: pointer; ldvt: clonglong;
                                  computeType: cudaDataType;
                                  workspaceInBytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnGesvd_bufferSize", dynlib: libName.}
  proc cusolverDnGesvd*(handle: cusolverDnHandle_t; params: cusolverDnParams_t;
                       jobu: cchar; jobvt: cchar; m: clonglong; n: clonglong;
                       dataTypeA: cudaDataType; A: pointer; lda: clonglong;
                       dataTypeS: cudaDataType; S: pointer; dataTypeU: cudaDataType;
                       U: pointer; ldu: clonglong; dataTypeVT: cudaDataType;
                       VT: pointer; ldvt: clonglong; computeType: cudaDataType;
                       pBuffer: pointer; workspaceInBytes: csize_t; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnGesvd", dynlib: libName.}
  ##
  ##  new 64-bit API
  ##
  ##  64-bit API for POTRF
  proc cusolverDnXpotrf_bufferSize*(handle: cusolverDnHandle_t;
                                   params: cusolverDnParams_t;
                                   uplo: cublasFillMode_t; n: clonglong;
                                   dataTypeA: cudaDataType; A: pointer;
                                   lda: clonglong; computeType: cudaDataType;
                                   workspaceInBytesOnDevice: ptr csize_t;
                                   workspaceInBytesOnHost: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnXpotrf_bufferSize", dynlib: libName.}
  proc cusolverDnXpotrf*(handle: cusolverDnHandle_t; params: cusolverDnParams_t;
                        uplo: cublasFillMode_t; n: clonglong;
                        dataTypeA: cudaDataType; A: pointer; lda: clonglong;
                        computeType: cudaDataType; bufferOnDevice: pointer;
                        workspaceInBytesOnDevice: csize_t; bufferOnHost: pointer;
                        workspaceInBytesOnHost: csize_t; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnXpotrf", dynlib: libName.}
  ##  64-bit API for POTRS
  proc cusolverDnXpotrs*(handle: cusolverDnHandle_t; params: cusolverDnParams_t;
                        uplo: cublasFillMode_t; n: clonglong; nrhs: clonglong;
                        dataTypeA: cudaDataType; A: pointer; lda: clonglong;
                        dataTypeB: cudaDataType; B: pointer; ldb: clonglong;
                        info: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnXpotrs", dynlib: libName.}
  ##  64-bit API for GEQRF
  proc cusolverDnXgeqrf_bufferSize*(handle: cusolverDnHandle_t;
                                   params: cusolverDnParams_t; m: clonglong;
                                   n: clonglong; dataTypeA: cudaDataType;
                                   A: pointer; lda: clonglong;
                                   dataTypeTau: cudaDataType; tau: pointer;
                                   computeType: cudaDataType;
                                   workspaceInBytesOnDevice: ptr csize_t;
                                   workspaceInBytesOnHost: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnXgeqrf_bufferSize", dynlib: libName.}
  proc cusolverDnXgeqrf*(handle: cusolverDnHandle_t; params: cusolverDnParams_t;
                        m: clonglong; n: clonglong; dataTypeA: cudaDataType;
                        A: pointer; lda: clonglong; dataTypeTau: cudaDataType;
                        tau: pointer; computeType: cudaDataType;
                        bufferOnDevice: pointer;
                        workspaceInBytesOnDevice: csize_t; bufferOnHost: pointer;
                        workspaceInBytesOnHost: csize_t; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnXgeqrf", dynlib: libName.}
  ##  64-bit API for GETRF
  proc cusolverDnXgetrf_bufferSize*(handle: cusolverDnHandle_t;
                                   params: cusolverDnParams_t; m: clonglong;
                                   n: clonglong; dataTypeA: cudaDataType;
                                   A: pointer; lda: clonglong;
                                   computeType: cudaDataType;
                                   workspaceInBytesOnDevice: ptr csize_t;
                                   workspaceInBytesOnHost: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnXgetrf_bufferSize", dynlib: libName.}
  proc cusolverDnXgetrf*(handle: cusolverDnHandle_t; params: cusolverDnParams_t;
                        m: clonglong; n: clonglong; dataTypeA: cudaDataType;
                        A: pointer; lda: clonglong; ipiv: ptr clonglong;
                        computeType: cudaDataType; bufferOnDevice: pointer;
                        workspaceInBytesOnDevice: csize_t; bufferOnHost: pointer;
                        workspaceInBytesOnHost: csize_t; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnXgetrf", dynlib: libName.}
  ##  64-bit API for GETRS
  proc cusolverDnXgetrs*(handle: cusolverDnHandle_t; params: cusolverDnParams_t;
                        trans: cublasOperation_t; n: clonglong; nrhs: clonglong;
                        dataTypeA: cudaDataType; A: pointer; lda: clonglong;
                        ipiv: ptr clonglong; dataTypeB: cudaDataType; B: pointer;
                        ldb: clonglong; info: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnXgetrs", dynlib: libName.}
  ##  64-bit API for SYEVD
  proc cusolverDnXsyevd_bufferSize*(handle: cusolverDnHandle_t;
                                   params: cusolverDnParams_t;
                                   jobz: cusolverEigMode_t;
                                   uplo: cublasFillMode_t; n: clonglong;
                                   dataTypeA: cudaDataType; A: pointer;
                                   lda: clonglong; dataTypeW: cudaDataType;
                                   W: pointer; computeType: cudaDataType;
                                   workspaceInBytesOnDevice: ptr csize_t;
                                   workspaceInBytesOnHost: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnXsyevd_bufferSize", dynlib: libName.}
  proc cusolverDnXsyevd*(handle: cusolverDnHandle_t; params: cusolverDnParams_t;
                        jobz: cusolverEigMode_t; uplo: cublasFillMode_t;
                        n: clonglong; dataTypeA: cudaDataType; A: pointer;
                        lda: clonglong; dataTypeW: cudaDataType; W: pointer;
                        computeType: cudaDataType; bufferOnDevice: pointer;
                        workspaceInBytesOnDevice: csize_t; bufferOnHost: pointer;
                        workspaceInBytesOnHost: csize_t; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnXsyevd", dynlib: libName.}
  ##  64-bit API for SYEVDX
  proc cusolverDnXsyevdx_bufferSize*(handle: cusolverDnHandle_t;
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
                                    workspaceInBytesOnHost: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnXsyevdx_bufferSize", dynlib: libName.}
  proc cusolverDnXsyevdx*(handle: cusolverDnHandle_t; params: cusolverDnParams_t;
                         jobz: cusolverEigMode_t; range: cusolverEigRange_t;
                         uplo: cublasFillMode_t; n: clonglong;
                         dataTypeA: cudaDataType; A: pointer; lda: clonglong;
                         vl: pointer; vu: pointer; il: clonglong; iu: clonglong;
                         meig64: ptr clonglong; dataTypeW: cudaDataType; W: pointer;
                         computeType: cudaDataType; bufferOnDevice: pointer;
                         workspaceInBytesOnDevice: csize_t; bufferOnHost: pointer;
                         workspaceInBytesOnHost: csize_t; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnXsyevdx", dynlib: libName.}
  ##  64-bit API for GESVD
  proc cusolverDnXgesvd_bufferSize*(handle: cusolverDnHandle_t;
                                   params: cusolverDnParams_t; jobu: cchar;
                                   jobvt: cchar; m: clonglong; n: clonglong;
                                   dataTypeA: cudaDataType; A: pointer;
                                   lda: clonglong; dataTypeS: cudaDataType;
                                   S: pointer; dataTypeU: cudaDataType; U: pointer;
                                   ldu: clonglong; dataTypeVT: cudaDataType;
                                   VT: pointer; ldvt: clonglong;
                                   computeType: cudaDataType;
                                   workspaceInBytesOnDevice: ptr csize_t;
                                   workspaceInBytesOnHost: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnXgesvd_bufferSize", dynlib: libName.}
  proc cusolverDnXgesvd*(handle: cusolverDnHandle_t; params: cusolverDnParams_t;
                        jobu: cchar; jobvt: cchar; m: clonglong; n: clonglong;
                        dataTypeA: cudaDataType; A: pointer; lda: clonglong;
                        dataTypeS: cudaDataType; S: pointer;
                        dataTypeU: cudaDataType; U: pointer; ldu: clonglong;
                        dataTypeVT: cudaDataType; VT: pointer; ldvt: clonglong;
                        computeType: cudaDataType; bufferOnDevice: pointer;
                        workspaceInBytesOnDevice: csize_t; bufferOnHost: pointer;
                        workspaceInBytesOnHost: csize_t; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnXgesvd", dynlib: libName.}
  ##  64-bit API for GESVDP
  proc cusolverDnXgesvdp_bufferSize*(handle: cusolverDnHandle_t;
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
                                    workspaceInBytesOnHost: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnXgesvdp_bufferSize", dynlib: libName.}
  proc cusolverDnXgesvdp*(handle: cusolverDnHandle_t; params: cusolverDnParams_t;
                         jobz: cusolverEigMode_t; econ: cint; m: clonglong;
                         n: clonglong; dataTypeA: cudaDataType; A: pointer;
                         lda: clonglong; dataTypeS: cudaDataType; S: pointer;
                         dataTypeU: cudaDataType; U: pointer; ldu: clonglong;
                         dataTypeV: cudaDataType; V: pointer; ldv: clonglong;
                         computeType: cudaDataType; bufferOnDevice: pointer;
                         workspaceInBytesOnDevice: csize_t; bufferOnHost: pointer;
                         workspaceInBytesOnHost: csize_t; d_info: ptr cint;
                         h_err_sigma: ptr cdouble): cusolverStatus_t {.cdecl,
      importc: "cusolverDnXgesvdp", dynlib: libName.}
  proc cusolverDnXgesvdr_bufferSize*(handle: cusolverDnHandle_t;
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
                                    workspaceInBytesOnHost: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnXgesvdr_bufferSize", dynlib: libName.}
  proc cusolverDnXgesvdr*(handle: cusolverDnHandle_t; params: cusolverDnParams_t;
                         jobu: cchar; jobv: cchar; m: clonglong; n: clonglong;
                         k: clonglong; p: clonglong; niters: clonglong;
                         dataTypeA: cudaDataType; A: pointer; lda: clonglong;
                         dataTypeSrand: cudaDataType; Srand: pointer;
                         dataTypeUrand: cudaDataType; Urand: pointer;
                         ldUrand: clonglong; dataTypeVrand: cudaDataType;
                         Vrand: pointer; ldVrand: clonglong;
                         computeType: cudaDataType; bufferOnDevice: pointer;
                         workspaceInBytesOnDevice: csize_t; bufferOnHost: pointer;
                         workspaceInBytesOnHost: csize_t; d_info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnXgesvdr", dynlib: libName.}
  proc cusolverDnXlarft_bufferSize*(handle: cusolverDnHandle_t;
                                   params: cusolverDnParams_t;
                                   direct: cusolverDirectMode_t;
                                   storev: cusolverStorevMode_t; n: clonglong;
                                   k: clonglong; dataTypeV: cudaDataType;
                                   V: pointer; ldv: clonglong;
                                   dataTypeTau: cudaDataType; tau: pointer;
                                   dataTypeT: cudaDataType; T: pointer;
                                   ldt: clonglong; computeType: cudaDataType;
                                   workspaceInBytesOnDevice: ptr csize_t;
                                   workspaceInBytesOnHost: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnXlarft_bufferSize", dynlib: libName.}
  proc cusolverDnXlarft*(handle: cusolverDnHandle_t; params: cusolverDnParams_t;
                        direct: cusolverDirectMode_t;
                        storev: cusolverStorevMode_t; n: clonglong; k: clonglong;
                        dataTypeV: cudaDataType; V: pointer; ldv: clonglong;
                        dataTypeTau: cudaDataType; tau: pointer;
                        dataTypeT: cudaDataType; T: pointer; ldt: clonglong;
                        computeType: cudaDataType; bufferOnDevice: pointer;
                        workspaceInBytesOnDevice: csize_t; bufferOnHost: pointer;
                        workspaceInBytesOnHost: csize_t): cusolverStatus_t {.cdecl,
      importc: "cusolverDnXlarft", dynlib: libName.}
  type
    cusolverDnLoggerCallback_t* = proc (logLevel: cint; functionName: cstring;
                                     message: cstring) {.cdecl.}
  proc cusolverDnLoggerSetCallback*(callback: cusolverDnLoggerCallback_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnLoggerSetCallback", dynlib: libName.}
  proc cusolverDnLoggerSetFile*(file: ptr FILE): cusolverStatus_t {.cdecl,
      importc: "cusolverDnLoggerSetFile", dynlib: libName.}
  proc cusolverDnLoggerOpenFile*(logFile: cstring): cusolverStatus_t {.cdecl,
      importc: "cusolverDnLoggerOpenFile", dynlib: libName.}
  proc cusolverDnLoggerSetLevel*(level: cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnLoggerSetLevel", dynlib: libName.}
  proc cusolverDnLoggerSetMask*(mask: cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnLoggerSetMask", dynlib: libName.}
  proc cusolverDnLoggerForceDisable*(): cusolverStatus_t {.cdecl,
      importc: "cusolverDnLoggerForceDisable", dynlib: libName.}