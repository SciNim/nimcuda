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
  cuComplex, cublas_api, cusolver_common

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
  const
    CUSOLVERDN_H* = true
  type
    cusolverDnContext* = object
    
  type
    cusolverDnHandle_t* = ptr cusolverDnContext
  proc cusolverDnCreate*(handle: ptr cusolverDnHandle_t): cusolverStatus_t {.cdecl,
      importc: "cusolverDnCreate", dyn.}
  proc cusolverDnDestroy*(handle: cusolverDnHandle_t): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDestroy", dyn.}
  proc cusolverDnSetStream*(handle: cusolverDnHandle_t; streamId: cudaStream_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSetStream", dyn.}
  proc cusolverDnGetStream*(handle: cusolverDnHandle_t; streamId: ptr cudaStream_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnGetStream", dyn.}
  ##  Cholesky factorization and its solver
  proc cusolverDnSpotrf_bufferSize*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cfloat;
                                   lda: cint; Lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSpotrf_bufferSize", dyn.}
  proc cusolverDnDpotrf_bufferSize*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cdouble;
                                   lda: cint; Lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDpotrf_bufferSize", dyn.}
  proc cusolverDnCpotrf_bufferSize*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuComplex; lda: cint; Lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnCpotrf_bufferSize", dyn.}
  proc cusolverDnZpotrf_bufferSize*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuDoubleComplex; lda: cint; Lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZpotrf_bufferSize", dyn.}
  proc cusolverDnSpotrf*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cfloat; lda: cint; Workspace: ptr cfloat; Lwork: cint;
                        devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnSpotrf", dyn.}
  proc cusolverDnDpotrf*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cdouble; lda: cint; Workspace: ptr cdouble; Lwork: cint;
                        devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDpotrf", dyn.}
  proc cusolverDnCpotrf*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cuComplex; lda: cint; Workspace: ptr cuComplex;
                        Lwork: cint; devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnCpotrf", dyn.}
  proc cusolverDnZpotrf*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cuDoubleComplex; lda: cint;
                        Workspace: ptr cuDoubleComplex; Lwork: cint;
                        devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnZpotrf", dyn.}
  proc cusolverDnSpotrs*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        nrhs: cint; A: ptr cfloat; lda: cint; B: ptr cfloat; ldb: cint;
                        devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnSpotrs", dyn.}
  proc cusolverDnDpotrs*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        nrhs: cint; A: ptr cdouble; lda: cint; B: ptr cdouble; ldb: cint;
                        devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDpotrs", dyn.}
  proc cusolverDnCpotrs*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        nrhs: cint; A: ptr cuComplex; lda: cint; B: ptr cuComplex;
                        ldb: cint; devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnCpotrs", dyn.}
  proc cusolverDnZpotrs*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        nrhs: cint; A: ptr cuDoubleComplex; lda: cint;
                        B: ptr cuDoubleComplex; ldb: cint; devInfo: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZpotrs", dyn.}
  ##  LU Factorization
  proc cusolverDnSgetrf_bufferSize*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   A: ptr cfloat; lda: cint; Lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSgetrf_bufferSize", dyn.}
  proc cusolverDnDgetrf_bufferSize*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   A: ptr cdouble; lda: cint; Lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDgetrf_bufferSize", dyn.}
  proc cusolverDnCgetrf_bufferSize*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   A: ptr cuComplex; lda: cint; Lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnCgetrf_bufferSize", dyn.}
  proc cusolverDnZgetrf_bufferSize*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   A: ptr cuDoubleComplex; lda: cint; Lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZgetrf_bufferSize", dyn.}
  proc cusolverDnSgetrf*(handle: cusolverDnHandle_t; m: cint; n: cint; A: ptr cfloat;
                        lda: cint; Workspace: ptr cfloat; devIpiv: ptr cint;
                        devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnSgetrf", dyn.}
  proc cusolverDnDgetrf*(handle: cusolverDnHandle_t; m: cint; n: cint; A: ptr cdouble;
                        lda: cint; Workspace: ptr cdouble; devIpiv: ptr cint;
                        devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDgetrf", dyn.}
  proc cusolverDnCgetrf*(handle: cusolverDnHandle_t; m: cint; n: cint;
                        A: ptr cuComplex; lda: cint; Workspace: ptr cuComplex;
                        devIpiv: ptr cint; devInfo: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnCgetrf", dyn.}
  proc cusolverDnZgetrf*(handle: cusolverDnHandle_t; m: cint; n: cint;
                        A: ptr cuDoubleComplex; lda: cint;
                        Workspace: ptr cuDoubleComplex; devIpiv: ptr cint;
                        devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnZgetrf", dyn.}
  ##  Row pivoting
  proc cusolverDnSlaswp*(handle: cusolverDnHandle_t; n: cint; A: ptr cfloat; lda: cint;
                        k1: cint; k2: cint; devIpiv: ptr cint; incx: cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSlaswp", dyn.}
  proc cusolverDnDlaswp*(handle: cusolverDnHandle_t; n: cint; A: ptr cdouble; lda: cint;
                        k1: cint; k2: cint; devIpiv: ptr cint; incx: cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDlaswp", dyn.}
  proc cusolverDnClaswp*(handle: cusolverDnHandle_t; n: cint; A: ptr cuComplex;
                        lda: cint; k1: cint; k2: cint; devIpiv: ptr cint; incx: cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnClaswp", dyn.}
  proc cusolverDnZlaswp*(handle: cusolverDnHandle_t; n: cint; A: ptr cuDoubleComplex;
                        lda: cint; k1: cint; k2: cint; devIpiv: ptr cint; incx: cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZlaswp", dyn.}
  ##  LU solve
  proc cusolverDnSgetrs*(handle: cusolverDnHandle_t; trans: cublasOperation_t;
                        n: cint; nrhs: cint; A: ptr cfloat; lda: cint; devIpiv: ptr cint;
                        B: ptr cfloat; ldb: cint; devInfo: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSgetrs", dyn.}
  proc cusolverDnDgetrs*(handle: cusolverDnHandle_t; trans: cublasOperation_t;
                        n: cint; nrhs: cint; A: ptr cdouble; lda: cint;
                        devIpiv: ptr cint; B: ptr cdouble; ldb: cint; devInfo: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDgetrs", dyn.}
  proc cusolverDnCgetrs*(handle: cusolverDnHandle_t; trans: cublasOperation_t;
                        n: cint; nrhs: cint; A: ptr cuComplex; lda: cint;
                        devIpiv: ptr cint; B: ptr cuComplex; ldb: cint;
                        devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnCgetrs", dyn.}
  proc cusolverDnZgetrs*(handle: cusolverDnHandle_t; trans: cublasOperation_t;
                        n: cint; nrhs: cint; A: ptr cuDoubleComplex; lda: cint;
                        devIpiv: ptr cint; B: ptr cuDoubleComplex; ldb: cint;
                        devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnZgetrs", dyn.}
  ##  QR factorization
  proc cusolverDnSgeqrf_bufferSize*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   A: ptr cfloat; lda: cint; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSgeqrf_bufferSize", dyn.}
  proc cusolverDnDgeqrf_bufferSize*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   A: ptr cdouble; lda: cint; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDgeqrf_bufferSize", dyn.}
  proc cusolverDnCgeqrf_bufferSize*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   A: ptr cuComplex; lda: cint; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnCgeqrf_bufferSize", dyn.}
  proc cusolverDnZgeqrf_bufferSize*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   A: ptr cuDoubleComplex; lda: cint; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZgeqrf_bufferSize", dyn.}
  proc cusolverDnSgeqrf*(handle: cusolverDnHandle_t; m: cint; n: cint; A: ptr cfloat;
                        lda: cint; TAU: ptr cfloat; Workspace: ptr cfloat; Lwork: cint;
                        devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnSgeqrf", dyn.}
  proc cusolverDnDgeqrf*(handle: cusolverDnHandle_t; m: cint; n: cint; A: ptr cdouble;
                        lda: cint; TAU: ptr cdouble; Workspace: ptr cdouble;
                        Lwork: cint; devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDgeqrf", dyn.}
  proc cusolverDnCgeqrf*(handle: cusolverDnHandle_t; m: cint; n: cint;
                        A: ptr cuComplex; lda: cint; TAU: ptr cuComplex;
                        Workspace: ptr cuComplex; Lwork: cint; devInfo: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnCgeqrf", dyn.}
  proc cusolverDnZgeqrf*(handle: cusolverDnHandle_t; m: cint; n: cint;
                        A: ptr cuDoubleComplex; lda: cint; TAU: ptr cuDoubleComplex;
                        Workspace: ptr cuDoubleComplex; Lwork: cint;
                        devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnZgeqrf", dyn.}
  ##  generate unitary matrix Q from QR factorization
  proc cusolverDnSorgqr_bufferSize*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   k: cint; A: ptr cfloat; lda: cint; tau: ptr cfloat;
                                   lwork: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnSorgqr_bufferSize", dyn.}
  proc cusolverDnDorgqr_bufferSize*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   k: cint; A: ptr cdouble; lda: cint;
                                   tau: ptr cdouble; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDorgqr_bufferSize", dyn.}
  proc cusolverDnCungqr_bufferSize*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   k: cint; A: ptr cuComplex; lda: cint;
                                   tau: ptr cuComplex; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnCungqr_bufferSize", dyn.}
  proc cusolverDnZungqr_bufferSize*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   k: cint; A: ptr cuDoubleComplex; lda: cint;
                                   tau: ptr cuDoubleComplex; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZungqr_bufferSize", dyn.}
  proc cusolverDnSorgqr*(handle: cusolverDnHandle_t; m: cint; n: cint; k: cint;
                        A: ptr cfloat; lda: cint; tau: ptr cfloat; work: ptr cfloat;
                        lwork: cint; info: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnSorgqr", dyn.}
  proc cusolverDnDorgqr*(handle: cusolverDnHandle_t; m: cint; n: cint; k: cint;
                        A: ptr cdouble; lda: cint; tau: ptr cdouble; work: ptr cdouble;
                        lwork: cint; info: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDorgqr", dyn.}
  proc cusolverDnCungqr*(handle: cusolverDnHandle_t; m: cint; n: cint; k: cint;
                        A: ptr cuComplex; lda: cint; tau: ptr cuComplex;
                        work: ptr cuComplex; lwork: cint; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnCungqr", dyn.}
  proc cusolverDnZungqr*(handle: cusolverDnHandle_t; m: cint; n: cint; k: cint;
                        A: ptr cuDoubleComplex; lda: cint; tau: ptr cuDoubleComplex;
                        work: ptr cuDoubleComplex; lwork: cint; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZungqr", dyn.}
  ##  compute Q**T*b in solve min||A*x = b||
  proc cusolverDnSormqr_bufferSize*(handle: cusolverDnHandle_t;
                                   side: cublasSideMode_t;
                                   trans: cublasOperation_t; m: cint; n: cint;
                                   k: cint; A: ptr cfloat; lda: cint; tau: ptr cfloat;
                                   C: ptr cfloat; ldc: cint; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSormqr_bufferSize", dyn.}
  proc cusolverDnDormqr_bufferSize*(handle: cusolverDnHandle_t;
                                   side: cublasSideMode_t;
                                   trans: cublasOperation_t; m: cint; n: cint;
                                   k: cint; A: ptr cdouble; lda: cint;
                                   tau: ptr cdouble; C: ptr cdouble; ldc: cint;
                                   lwork: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDormqr_bufferSize", dyn.}
  proc cusolverDnCunmqr_bufferSize*(handle: cusolverDnHandle_t;
                                   side: cublasSideMode_t;
                                   trans: cublasOperation_t; m: cint; n: cint;
                                   k: cint; A: ptr cuComplex; lda: cint;
                                   tau: ptr cuComplex; C: ptr cuComplex; ldc: cint;
                                   lwork: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnCunmqr_bufferSize", dyn.}
  proc cusolverDnZunmqr_bufferSize*(handle: cusolverDnHandle_t;
                                   side: cublasSideMode_t;
                                   trans: cublasOperation_t; m: cint; n: cint;
                                   k: cint; A: ptr cuDoubleComplex; lda: cint;
                                   tau: ptr cuDoubleComplex;
                                   C: ptr cuDoubleComplex; ldc: cint; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZunmqr_bufferSize", dyn.}
  proc cusolverDnSormqr*(handle: cusolverDnHandle_t; side: cublasSideMode_t;
                        trans: cublasOperation_t; m: cint; n: cint; k: cint;
                        A: ptr cfloat; lda: cint; tau: ptr cfloat; C: ptr cfloat;
                        ldc: cint; work: ptr cfloat; lwork: cint; devInfo: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSormqr", dyn.}
  proc cusolverDnDormqr*(handle: cusolverDnHandle_t; side: cublasSideMode_t;
                        trans: cublasOperation_t; m: cint; n: cint; k: cint;
                        A: ptr cdouble; lda: cint; tau: ptr cdouble; C: ptr cdouble;
                        ldc: cint; work: ptr cdouble; lwork: cint; devInfo: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDormqr", dyn.}
  proc cusolverDnCunmqr*(handle: cusolverDnHandle_t; side: cublasSideMode_t;
                        trans: cublasOperation_t; m: cint; n: cint; k: cint;
                        A: ptr cuComplex; lda: cint; tau: ptr cuComplex;
                        C: ptr cuComplex; ldc: cint; work: ptr cuComplex; lwork: cint;
                        devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnCunmqr", dyn.}
  proc cusolverDnZunmqr*(handle: cusolverDnHandle_t; side: cublasSideMode_t;
                        trans: cublasOperation_t; m: cint; n: cint; k: cint;
                        A: ptr cuDoubleComplex; lda: cint; tau: ptr cuDoubleComplex;
                        C: ptr cuDoubleComplex; ldc: cint; work: ptr cuDoubleComplex;
                        lwork: cint; devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnZunmqr", dyn.}
  ##  L*D*L**T,U*D*U**T factorization
  proc cusolverDnSsytrf_bufferSize*(handle: cusolverDnHandle_t; n: cint;
                                   A: ptr cfloat; lda: cint; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSsytrf_bufferSize", dyn.}
  proc cusolverDnDsytrf_bufferSize*(handle: cusolverDnHandle_t; n: cint;
                                   A: ptr cdouble; lda: cint; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDsytrf_bufferSize", dyn.}
  proc cusolverDnCsytrf_bufferSize*(handle: cusolverDnHandle_t; n: cint;
                                   A: ptr cuComplex; lda: cint; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnCsytrf_bufferSize", dyn.}
  proc cusolverDnZsytrf_bufferSize*(handle: cusolverDnHandle_t; n: cint;
                                   A: ptr cuDoubleComplex; lda: cint; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZsytrf_bufferSize", dyn.}
  proc cusolverDnSsytrf*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cfloat; lda: cint; ipiv: ptr cint; work: ptr cfloat;
                        lwork: cint; info: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnSsytrf", dyn.}
  proc cusolverDnDsytrf*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cdouble; lda: cint; ipiv: ptr cint; work: ptr cdouble;
                        lwork: cint; info: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDsytrf", dyn.}
  proc cusolverDnCsytrf*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cuComplex; lda: cint; ipiv: ptr cint;
                        work: ptr cuComplex; lwork: cint; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnCsytrf", dyn.}
  proc cusolverDnZsytrf*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cuDoubleComplex; lda: cint; ipiv: ptr cint;
                        work: ptr cuDoubleComplex; lwork: cint; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZsytrf", dyn.}
  ##  bidiagonal factorization
  proc cusolverDnSgebrd_bufferSize*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   Lwork: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnSgebrd_bufferSize", dyn.}
  proc cusolverDnDgebrd_bufferSize*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   Lwork: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDgebrd_bufferSize", dyn.}
  proc cusolverDnCgebrd_bufferSize*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   Lwork: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnCgebrd_bufferSize", dyn.}
  proc cusolverDnZgebrd_bufferSize*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   Lwork: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnZgebrd_bufferSize", dyn.}
  proc cusolverDnSgebrd*(handle: cusolverDnHandle_t; m: cint; n: cint; A: ptr cfloat;
                        lda: cint; D: ptr cfloat; E: ptr cfloat; TAUQ: ptr cfloat;
                        TAUP: ptr cfloat; Work: ptr cfloat; Lwork: cint;
                        devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnSgebrd", dyn.}
  proc cusolverDnDgebrd*(handle: cusolverDnHandle_t; m: cint; n: cint; A: ptr cdouble;
                        lda: cint; D: ptr cdouble; E: ptr cdouble; TAUQ: ptr cdouble;
                        TAUP: ptr cdouble; Work: ptr cdouble; Lwork: cint;
                        devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDgebrd", dyn.}
  proc cusolverDnCgebrd*(handle: cusolverDnHandle_t; m: cint; n: cint;
                        A: ptr cuComplex; lda: cint; D: ptr cfloat; E: ptr cfloat;
                        TAUQ: ptr cuComplex; TAUP: ptr cuComplex; Work: ptr cuComplex;
                        Lwork: cint; devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnCgebrd", dyn.}
  proc cusolverDnZgebrd*(handle: cusolverDnHandle_t; m: cint; n: cint;
                        A: ptr cuDoubleComplex; lda: cint; D: ptr cdouble;
                        E: ptr cdouble; TAUQ: ptr cuDoubleComplex;
                        TAUP: ptr cuDoubleComplex; Work: ptr cuDoubleComplex;
                        Lwork: cint; devInfo: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnZgebrd", dyn.}
  ##  generates one of the unitary matrices Q or P**T determined by GEBRD
  proc cusolverDnSorgbr_bufferSize*(handle: cusolverDnHandle_t;
                                   side: cublasSideMode_t; m: cint; n: cint; k: cint;
                                   A: ptr cfloat; lda: cint; tau: ptr cfloat;
                                   lwork: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnSorgbr_bufferSize", dyn.}
  proc cusolverDnDorgbr_bufferSize*(handle: cusolverDnHandle_t;
                                   side: cublasSideMode_t; m: cint; n: cint; k: cint;
                                   A: ptr cdouble; lda: cint; tau: ptr cdouble;
                                   lwork: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDorgbr_bufferSize", dyn.}
  proc cusolverDnCungbr_bufferSize*(handle: cusolverDnHandle_t;
                                   side: cublasSideMode_t; m: cint; n: cint; k: cint;
                                   A: ptr cuComplex; lda: cint; tau: ptr cuComplex;
                                   lwork: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnCungbr_bufferSize", dyn.}
  proc cusolverDnZungbr_bufferSize*(handle: cusolverDnHandle_t;
                                   side: cublasSideMode_t; m: cint; n: cint; k: cint;
                                   A: ptr cuDoubleComplex; lda: cint;
                                   tau: ptr cuDoubleComplex; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZungbr_bufferSize", dyn.}
  proc cusolverDnSorgbr*(handle: cusolverDnHandle_t; side: cublasSideMode_t; m: cint;
                        n: cint; k: cint; A: ptr cfloat; lda: cint; tau: ptr cfloat;
                        work: ptr cfloat; lwork: cint; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSorgbr", dyn.}
  proc cusolverDnDorgbr*(handle: cusolverDnHandle_t; side: cublasSideMode_t; m: cint;
                        n: cint; k: cint; A: ptr cdouble; lda: cint; tau: ptr cdouble;
                        work: ptr cdouble; lwork: cint; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDorgbr", dyn.}
  proc cusolverDnCungbr*(handle: cusolverDnHandle_t; side: cublasSideMode_t; m: cint;
                        n: cint; k: cint; A: ptr cuComplex; lda: cint;
                        tau: ptr cuComplex; work: ptr cuComplex; lwork: cint;
                        info: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnCungbr", dyn.}
  proc cusolverDnZungbr*(handle: cusolverDnHandle_t; side: cublasSideMode_t; m: cint;
                        n: cint; k: cint; A: ptr cuDoubleComplex; lda: cint;
                        tau: ptr cuDoubleComplex; work: ptr cuDoubleComplex;
                        lwork: cint; info: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnZungbr", dyn.}
  ##  tridiagonal factorization
  proc cusolverDnSsytrd_bufferSize*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cfloat;
                                   lda: cint; d: ptr cfloat; e: ptr cfloat;
                                   tau: ptr cfloat; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSsytrd_bufferSize", dyn.}
  proc cusolverDnDsytrd_bufferSize*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cdouble;
                                   lda: cint; d: ptr cdouble; e: ptr cdouble;
                                   tau: ptr cdouble; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDsytrd_bufferSize", dyn.}
  proc cusolverDnChetrd_bufferSize*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuComplex; lda: cint; d: ptr cfloat;
                                   e: ptr cfloat; tau: ptr cuComplex; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnChetrd_bufferSize", dyn.}
  proc cusolverDnZhetrd_bufferSize*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuDoubleComplex; lda: cint; d: ptr cdouble;
                                   e: ptr cdouble; tau: ptr cuDoubleComplex;
                                   lwork: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnZhetrd_bufferSize", dyn.}
  proc cusolverDnSsytrd*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cfloat; lda: cint; d: ptr cfloat; e: ptr cfloat;
                        tau: ptr cfloat; work: ptr cfloat; lwork: cint; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSsytrd", dyn.}
  proc cusolverDnDsytrd*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cdouble; lda: cint; d: ptr cdouble; e: ptr cdouble;
                        tau: ptr cdouble; work: ptr cdouble; lwork: cint; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDsytrd", dyn.}
  proc cusolverDnChetrd*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cuComplex; lda: cint; d: ptr cfloat; e: ptr cfloat;
                        tau: ptr cuComplex; work: ptr cuComplex; lwork: cint;
                        info: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnChetrd", dyn.}
  proc cusolverDnZhetrd*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cuDoubleComplex; lda: cint; d: ptr cdouble;
                        e: ptr cdouble; tau: ptr cuDoubleComplex;
                        work: ptr cuDoubleComplex; lwork: cint; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZhetrd", dyn.}
  ##  generate unitary Q comes from sytrd
  proc cusolverDnSorgtr_bufferSize*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cfloat;
                                   lda: cint; tau: ptr cfloat; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSorgtr_bufferSize", dyn.}
  proc cusolverDnDorgtr_bufferSize*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cdouble;
                                   lda: cint; tau: ptr cdouble; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDorgtr_bufferSize", dyn.}
  proc cusolverDnCungtr_bufferSize*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuComplex; lda: cint; tau: ptr cuComplex;
                                   lwork: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnCungtr_bufferSize", dyn.}
  proc cusolverDnZungtr_bufferSize*(handle: cusolverDnHandle_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuDoubleComplex; lda: cint;
                                   tau: ptr cuDoubleComplex; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZungtr_bufferSize", dyn.}
  proc cusolverDnSorgtr*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cfloat; lda: cint; tau: ptr cfloat; work: ptr cfloat;
                        lwork: cint; info: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnSorgtr", dyn.}
  proc cusolverDnDorgtr*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cdouble; lda: cint; tau: ptr cdouble; work: ptr cdouble;
                        lwork: cint; info: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDorgtr", dyn.}
  proc cusolverDnCungtr*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cuComplex; lda: cint; tau: ptr cuComplex;
                        work: ptr cuComplex; lwork: cint; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnCungtr", dyn.}
  proc cusolverDnZungtr*(handle: cusolverDnHandle_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cuDoubleComplex; lda: cint; tau: ptr cuDoubleComplex;
                        work: ptr cuDoubleComplex; lwork: cint; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZungtr", dyn.}
  ##  compute op(Q)*C or C*op(Q) where Q comes from sytrd
  proc cusolverDnSormtr_bufferSize*(handle: cusolverDnHandle_t;
                                   side: cublasSideMode_t; uplo: cublasFillMode_t;
                                   trans: cublasOperation_t; m: cint; n: cint;
                                   A: ptr cfloat; lda: cint; tau: ptr cfloat;
                                   C: ptr cfloat; ldc: cint; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSormtr_bufferSize", dyn.}
  proc cusolverDnDormtr_bufferSize*(handle: cusolverDnHandle_t;
                                   side: cublasSideMode_t; uplo: cublasFillMode_t;
                                   trans: cublasOperation_t; m: cint; n: cint;
                                   A: ptr cdouble; lda: cint; tau: ptr cdouble;
                                   C: ptr cdouble; ldc: cint; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDormtr_bufferSize", dyn.}
  proc cusolverDnCunmtr_bufferSize*(handle: cusolverDnHandle_t;
                                   side: cublasSideMode_t; uplo: cublasFillMode_t;
                                   trans: cublasOperation_t; m: cint; n: cint;
                                   A: ptr cuComplex; lda: cint; tau: ptr cuComplex;
                                   C: ptr cuComplex; ldc: cint; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnCunmtr_bufferSize", dyn.}
  proc cusolverDnZunmtr_bufferSize*(handle: cusolverDnHandle_t;
                                   side: cublasSideMode_t; uplo: cublasFillMode_t;
                                   trans: cublasOperation_t; m: cint; n: cint;
                                   A: ptr cuDoubleComplex; lda: cint;
                                   tau: ptr cuDoubleComplex;
                                   C: ptr cuDoubleComplex; ldc: cint; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZunmtr_bufferSize", dyn.}
  proc cusolverDnSormtr*(handle: cusolverDnHandle_t; side: cublasSideMode_t;
                        uplo: cublasFillMode_t; trans: cublasOperation_t; m: cint;
                        n: cint; A: ptr cfloat; lda: cint; tau: ptr cfloat; C: ptr cfloat;
                        ldc: cint; work: ptr cfloat; lwork: cint; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSormtr", dyn.}
  proc cusolverDnDormtr*(handle: cusolverDnHandle_t; side: cublasSideMode_t;
                        uplo: cublasFillMode_t; trans: cublasOperation_t; m: cint;
                        n: cint; A: ptr cdouble; lda: cint; tau: ptr cdouble;
                        C: ptr cdouble; ldc: cint; work: ptr cdouble; lwork: cint;
                        info: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDormtr", dyn.}
  proc cusolverDnCunmtr*(handle: cusolverDnHandle_t; side: cublasSideMode_t;
                        uplo: cublasFillMode_t; trans: cublasOperation_t; m: cint;
                        n: cint; A: ptr cuComplex; lda: cint; tau: ptr cuComplex;
                        C: ptr cuComplex; ldc: cint; work: ptr cuComplex; lwork: cint;
                        info: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnCunmtr", dyn.}
  proc cusolverDnZunmtr*(handle: cusolverDnHandle_t; side: cublasSideMode_t;
                        uplo: cublasFillMode_t; trans: cublasOperation_t; m: cint;
                        n: cint; A: ptr cuDoubleComplex; lda: cint;
                        tau: ptr cuDoubleComplex; C: ptr cuDoubleComplex; ldc: cint;
                        work: ptr cuDoubleComplex; lwork: cint; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnZunmtr", dyn.}
  ##  singular value decomposition, A = U * Sigma * V^H
  proc cusolverDnSgesvd_bufferSize*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   lwork: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnSgesvd_bufferSize", dyn.}
  proc cusolverDnDgesvd_bufferSize*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   lwork: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDgesvd_bufferSize", dyn.}
  proc cusolverDnCgesvd_bufferSize*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   lwork: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnCgesvd_bufferSize", dyn.}
  proc cusolverDnZgesvd_bufferSize*(handle: cusolverDnHandle_t; m: cint; n: cint;
                                   lwork: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnZgesvd_bufferSize", dyn.}
  proc cusolverDnSgesvd*(handle: cusolverDnHandle_t; jobu: cchar; jobvt: cchar;
                        m: cint; n: cint; A: ptr cfloat; lda: cint; S: ptr cfloat;
                        U: ptr cfloat; ldu: cint; VT: ptr cfloat; ldvt: cint;
                        work: ptr cfloat; lwork: cint; rwork: ptr cfloat; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSgesvd", dyn.}
  proc cusolverDnDgesvd*(handle: cusolverDnHandle_t; jobu: cchar; jobvt: cchar;
                        m: cint; n: cint; A: ptr cdouble; lda: cint; S: ptr cdouble;
                        U: ptr cdouble; ldu: cint; VT: ptr cdouble; ldvt: cint;
                        work: ptr cdouble; lwork: cint; rwork: ptr cdouble;
                        info: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDgesvd", dyn.}
  proc cusolverDnCgesvd*(handle: cusolverDnHandle_t; jobu: cchar; jobvt: cchar;
                        m: cint; n: cint; A: ptr cuComplex; lda: cint; S: ptr cfloat;
                        U: ptr cuComplex; ldu: cint; VT: ptr cuComplex; ldvt: cint;
                        work: ptr cuComplex; lwork: cint; rwork: ptr cfloat;
                        info: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnCgesvd", dyn.}
  proc cusolverDnZgesvd*(handle: cusolverDnHandle_t; jobu: cchar; jobvt: cchar;
                        m: cint; n: cint; A: ptr cuDoubleComplex; lda: cint;
                        S: ptr cdouble; U: ptr cuDoubleComplex; ldu: cint;
                        VT: ptr cuDoubleComplex; ldvt: cint;
                        work: ptr cuDoubleComplex; lwork: cint; rwork: ptr cdouble;
                        info: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnZgesvd", dyn.}
  ##  standard symmetric eigenvalue solver, A*x = lambda*x, by divide-and-conquer
  proc cusolverDnSsyevd_bufferSize*(handle: cusolverDnHandle_t;
                                   jobz: cusolverEigMode_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cfloat;
                                   lda: cint; W: ptr cfloat; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSsyevd_bufferSize", dyn.}
  proc cusolverDnDsyevd_bufferSize*(handle: cusolverDnHandle_t;
                                   jobz: cusolverEigMode_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cdouble;
                                   lda: cint; W: ptr cdouble; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDsyevd_bufferSize", dyn.}
  proc cusolverDnCheevd_bufferSize*(handle: cusolverDnHandle_t;
                                   jobz: cusolverEigMode_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuComplex; lda: cint; W: ptr cfloat;
                                   lwork: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnCheevd_bufferSize", dyn.}
  proc cusolverDnZheevd_bufferSize*(handle: cusolverDnHandle_t;
                                   jobz: cusolverEigMode_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuDoubleComplex; lda: cint; W: ptr cdouble;
                                   lwork: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnZheevd_bufferSize", dyn.}
  proc cusolverDnSsyevd*(handle: cusolverDnHandle_t; jobz: cusolverEigMode_t;
                        uplo: cublasFillMode_t; n: cint; A: ptr cfloat; lda: cint;
                        W: ptr cfloat; work: ptr cfloat; lwork: cint; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSsyevd", dyn.}
  proc cusolverDnDsyevd*(handle: cusolverDnHandle_t; jobz: cusolverEigMode_t;
                        uplo: cublasFillMode_t; n: cint; A: ptr cdouble; lda: cint;
                        W: ptr cdouble; work: ptr cdouble; lwork: cint; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDsyevd", dyn.}
  proc cusolverDnCheevd*(handle: cusolverDnHandle_t; jobz: cusolverEigMode_t;
                        uplo: cublasFillMode_t; n: cint; A: ptr cuComplex; lda: cint;
                        W: ptr cfloat; work: ptr cuComplex; lwork: cint; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnCheevd", dyn.}
  proc cusolverDnZheevd*(handle: cusolverDnHandle_t; jobz: cusolverEigMode_t;
                        uplo: cublasFillMode_t; n: cint; A: ptr cuDoubleComplex;
                        lda: cint; W: ptr cdouble; work: ptr cuDoubleComplex;
                        lwork: cint; info: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnZheevd", dyn.}
  ##  generalized symmetric eigenvalue solver, A*x = lambda*B*x, by divide-and-conquer
  proc cusolverDnSsygvd_bufferSize*(handle: cusolverDnHandle_t;
                                   itype: cusolverEigType_t;
                                   jobz: cusolverEigMode_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cfloat;
                                   lda: cint; B: ptr cfloat; ldb: cint; W: ptr cfloat;
                                   lwork: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnSsygvd_bufferSize", dyn.}
  proc cusolverDnDsygvd_bufferSize*(handle: cusolverDnHandle_t;
                                   itype: cusolverEigType_t;
                                   jobz: cusolverEigMode_t;
                                   uplo: cublasFillMode_t; n: cint; A: ptr cdouble;
                                   lda: cint; B: ptr cdouble; ldb: cint;
                                   W: ptr cdouble; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDsygvd_bufferSize", dyn.}
  proc cusolverDnChegvd_bufferSize*(handle: cusolverDnHandle_t;
                                   itype: cusolverEigType_t;
                                   jobz: cusolverEigMode_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuComplex; lda: cint; B: ptr cuComplex;
                                   ldb: cint; W: ptr cfloat; lwork: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnChegvd_bufferSize", dyn.}
  proc cusolverDnZhegvd_bufferSize*(handle: cusolverDnHandle_t;
                                   itype: cusolverEigType_t;
                                   jobz: cusolverEigMode_t;
                                   uplo: cublasFillMode_t; n: cint;
                                   A: ptr cuDoubleComplex; lda: cint;
                                   B: ptr cuDoubleComplex; ldb: cint; W: ptr cdouble;
                                   lwork: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnZhegvd_bufferSize", dyn.}
  proc cusolverDnSsygvd*(handle: cusolverDnHandle_t; itype: cusolverEigType_t;
                        jobz: cusolverEigMode_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cfloat; lda: cint; B: ptr cfloat; ldb: cint; W: ptr cfloat;
                        work: ptr cfloat; lwork: cint; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSsygvd", dyn.}
  proc cusolverDnDsygvd*(handle: cusolverDnHandle_t; itype: cusolverEigType_t;
                        jobz: cusolverEigMode_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cdouble; lda: cint; B: ptr cdouble; ldb: cint;
                        W: ptr cdouble; work: ptr cdouble; lwork: cint; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnDsygvd", dyn.}
  proc cusolverDnChegvd*(handle: cusolverDnHandle_t; itype: cusolverEigType_t;
                        jobz: cusolverEigMode_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cuComplex; lda: cint; B: ptr cuComplex; ldb: cint;
                        W: ptr cfloat; work: ptr cuComplex; lwork: cint; info: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverDnChegvd", dyn.}
  proc cusolverDnZhegvd*(handle: cusolverDnHandle_t; itype: cusolverEigType_t;
                        jobz: cusolverEigMode_t; uplo: cublasFillMode_t; n: cint;
                        A: ptr cuDoubleComplex; lda: cint; B: ptr cuDoubleComplex;
                        ldb: cint; W: ptr cdouble; work: ptr cuDoubleComplex;
                        lwork: cint; info: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverDnZhegvd", dyn.}