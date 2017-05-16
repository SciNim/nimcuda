 {.deadCodeElim: on.}
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
      importc: "cusolverDnCreate", dynlib: libName.}
  proc cusolverDnDestroy*(handle: cusolverDnHandle_t): cusolverStatus_t {.cdecl,
      importc: "cusolverDnDestroy", dynlib: libName.}
  proc cusolverDnSetStream*(handle: cusolverDnHandle_t; streamId: cudaStream_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnSetStream", dynlib: libName.}
  proc cusolverDnGetStream*(handle: cusolverDnHandle_t; streamId: ptr cudaStream_t): cusolverStatus_t {.
      cdecl, importc: "cusolverDnGetStream", dynlib: libName.}
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
  ##  generalized symmetric eigenvalue solver, A*x = lambda*B*x, by divide-and-conquer
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