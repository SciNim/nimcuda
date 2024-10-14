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
  cuComplex

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

when not defined(CUSOLVERSP_H):
  const
    CUSOLVERSP_H* = true
  import
    cusparse, cusolver_common

  type
    cusolverSpContext* = object

  type
    cusolverSpHandle_t* = ptr cusolverSpContext
  type
    csrqrInfo* = object

  type
    csrqrInfo_t* = ptr csrqrInfo
  proc cusolverSpCreate*(handle: ptr cusolverSpHandle_t): cusolverStatus_t {.cdecl,
      importc: "cusolverSpCreate", dyn.}
  proc cusolverSpDestroy*(handle: cusolverSpHandle_t): cusolverStatus_t {.cdecl,
      importc: "cusolverSpDestroy", dyn.}
  proc cusolverSpSetStream*(handle: cusolverSpHandle_t; streamId: cudaStream_t): cusolverStatus_t {.
      cdecl, importc: "cusolverSpSetStream", dyn.}
  proc cusolverSpGetStream*(handle: cusolverSpHandle_t; streamId: ptr cudaStream_t): cusolverStatus_t {.
      cdecl, importc: "cusolverSpGetStream", dyn.}
  proc cusolverSpXcsrissymHost*(handle: cusolverSpHandle_t; m: cint; nnzA: cint;
                               descrA: cusparseMatDescr_t; csrRowPtrA: ptr cint;
                               csrEndPtrA: ptr cint; csrColIndA: ptr cint;
                               issym: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverSpXcsrissymHost", dyn.}
  ##  GPU linear solver based on LU factorization
  ##  `      solve A*x = b, A can be singular `
  ##  [ls] stands for linear solve
  ##  [v] stands for vector
  ##  [lu] stands for LU factorization

  proc cusolverSpScsrlsvluHost*(handle: cusolverSpHandle_t; n: cint; nnzA: cint;
                               descrA: cusparseMatDescr_t; csrValA: ptr cfloat;
                               csrRowPtrA: ptr cint; csrColIndA: ptr cint;
                               b: ptr cfloat; tol: cfloat; reorder: cint;
                               x: ptr cfloat; singularity: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverSpScsrlsvluHost", dyn.}
  proc cusolverSpDcsrlsvluHost*(handle: cusolverSpHandle_t; n: cint; nnzA: cint;
                               descrA: cusparseMatDescr_t; csrValA: ptr cdouble;
                               csrRowPtrA: ptr cint; csrColIndA: ptr cint;
                               b: ptr cdouble; tol: cdouble; reorder: cint;
                               x: ptr cdouble; singularity: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverSpDcsrlsvluHost", dyn.}
  proc cusolverSpCcsrlsvluHost*(handle: cusolverSpHandle_t; n: cint; nnzA: cint;
                               descrA: cusparseMatDescr_t; csrValA: ptr cuComplex;
                               csrRowPtrA: ptr cint; csrColIndA: ptr cint;
                               b: ptr cuComplex; tol: cfloat; reorder: cint;
                               x: ptr cuComplex; singularity: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverSpCcsrlsvluHost", dyn.}
  proc cusolverSpZcsrlsvluHost*(handle: cusolverSpHandle_t; n: cint; nnzA: cint;
                               descrA: cusparseMatDescr_t;
                               csrValA: ptr cuDoubleComplex; csrRowPtrA: ptr cint;
                               csrColIndA: ptr cint; b: ptr cuDoubleComplex;
                               tol: cdouble; reorder: cint; x: ptr cuDoubleComplex;
                               singularity: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverSpZcsrlsvluHost", dyn.}
  ##  GPU linear solver based on QR factorization
  ##        solve A*x = b, A can be singular
  ##  [ls] stands for linear solve
  ##  [v] stands for vector
  ##  [qr] stands for QR factorization
  ##
  proc cusolverSpScsrlsvqr*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                           descrA: cusparseMatDescr_t; csrVal: ptr cfloat;
                           csrRowPtr: ptr cint; csrColInd: ptr cint; b: ptr cfloat;
                           tol: cfloat; reorder: cint; x: ptr cfloat;
                           singularity: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverSpScsrlsvqr", dyn.}
  proc cusolverSpDcsrlsvqr*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                           descrA: cusparseMatDescr_t; csrVal: ptr cdouble;
                           csrRowPtr: ptr cint; csrColInd: ptr cint; b: ptr cdouble;
                           tol: cdouble; reorder: cint; x: ptr cdouble;
                           singularity: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverSpDcsrlsvqr", dyn.}
  proc cusolverSpCcsrlsvqr*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                           descrA: cusparseMatDescr_t; csrVal: ptr cuComplex;
                           csrRowPtr: ptr cint; csrColInd: ptr cint; b: ptr cuComplex;
                           tol: cfloat; reorder: cint; x: ptr cuComplex;
                           singularity: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverSpCcsrlsvqr", dyn.}
  proc cusolverSpZcsrlsvqr*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                           descrA: cusparseMatDescr_t;
                           csrVal: ptr cuDoubleComplex; csrRowPtr: ptr cint;
                           csrColInd: ptr cint; b: ptr cuDoubleComplex; tol: cdouble;
                           reorder: cint; x: ptr cuDoubleComplex;
                           singularity: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverSpZcsrlsvqr", dyn.}
  ##  CPU linear solver based on QR factorization
  ##        solve A*x = b, A can be singular
  ##  [ls] stands for linear solve
  ##  [v] stands for vector
  ##  [qr] stands for QR factorization
  ##
  proc cusolverSpScsrlsvqrHost*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                               descrA: cusparseMatDescr_t; csrValA: ptr cfloat;
                               csrRowPtrA: ptr cint; csrColIndA: ptr cint;
                               b: ptr cfloat; tol: cfloat; reorder: cint;
                               x: ptr cfloat; singularity: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverSpScsrlsvqrHost", dyn.}
  proc cusolverSpDcsrlsvqrHost*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                               descrA: cusparseMatDescr_t; csrValA: ptr cdouble;
                               csrRowPtrA: ptr cint; csrColIndA: ptr cint;
                               b: ptr cdouble; tol: cdouble; reorder: cint;
                               x: ptr cdouble; singularity: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverSpDcsrlsvqrHost", dyn.}
  proc cusolverSpCcsrlsvqrHost*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                               descrA: cusparseMatDescr_t; csrValA: ptr cuComplex;
                               csrRowPtrA: ptr cint; csrColIndA: ptr cint;
                               b: ptr cuComplex; tol: cfloat; reorder: cint;
                               x: ptr cuComplex; singularity: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverSpCcsrlsvqrHost", dyn.}
  proc cusolverSpZcsrlsvqrHost*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                               descrA: cusparseMatDescr_t;
                               csrValA: ptr cuDoubleComplex; csrRowPtrA: ptr cint;
                               csrColIndA: ptr cint; b: ptr cuDoubleComplex;
                               tol: cdouble; reorder: cint; x: ptr cuDoubleComplex;
                               singularity: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverSpZcsrlsvqrHost", dyn.}
  ##  CPU linear solver based on Cholesky factorization
  ##        solve A*x = b, A can be singular
  ##  [ls] stands for linear solve
  ##  [v] stands for vector
  ##  [chol] stands for Cholesky factorization
  ##
  ##  Only works for symmetric positive definite matrix.
  ##  The upper part of A is ignored.
  ##
  proc cusolverSpScsrlsvcholHost*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                                 descrA: cusparseMatDescr_t; csrVal: ptr cfloat;
                                 csrRowPtr: ptr cint; csrColInd: ptr cint;
                                 b: ptr cfloat; tol: cfloat; reorder: cint;
                                 x: ptr cfloat; singularity: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverSpScsrlsvcholHost", dyn.}
  proc cusolverSpDcsrlsvcholHost*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                                 descrA: cusparseMatDescr_t; csrVal: ptr cdouble;
                                 csrRowPtr: ptr cint; csrColInd: ptr cint;
                                 b: ptr cdouble; tol: cdouble; reorder: cint;
                                 x: ptr cdouble; singularity: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverSpDcsrlsvcholHost", dyn.}
  proc cusolverSpCcsrlsvcholHost*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                                 descrA: cusparseMatDescr_t;
                                 csrVal: ptr cuComplex; csrRowPtr: ptr cint;
                                 csrColInd: ptr cint; b: ptr cuComplex; tol: cfloat;
                                 reorder: cint; x: ptr cuComplex;
                                 singularity: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverSpCcsrlsvcholHost", dyn.}
  proc cusolverSpZcsrlsvcholHost*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                                 descrA: cusparseMatDescr_t;
                                 csrVal: ptr cuDoubleComplex; csrRowPtr: ptr cint;
                                 csrColInd: ptr cint; b: ptr cuDoubleComplex;
                                 tol: cdouble; reorder: cint;
                                 x: ptr cuDoubleComplex; singularity: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverSpZcsrlsvcholHost", dyn.}
  ##  GPU linear solver based on Cholesky factorization
  ##        solve A*x = b, A can be singular
  ##  [ls] stands for linear solve
  ##  [v] stands for vector
  ##  [chol] stands for Cholesky factorization
  ##
  ##  Only works for symmetric positive definite matrix.
  ##  The upper part of A is ignored.
  ##
  proc cusolverSpScsrlsvchol*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                             descrA: cusparseMatDescr_t; csrVal: ptr cfloat;
                             csrRowPtr: ptr cint; csrColInd: ptr cint; b: ptr cfloat;
                             tol: cfloat; reorder: cint; x: ptr cfloat;
                             singularity: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverSpScsrlsvchol", dyn.}
    ##  output
  proc cusolverSpDcsrlsvchol*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                             descrA: cusparseMatDescr_t; csrVal: ptr cdouble;
                             csrRowPtr: ptr cint; csrColInd: ptr cint; b: ptr cdouble;
                             tol: cdouble; reorder: cint; x: ptr cdouble;
                             singularity: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverSpDcsrlsvchol", dyn.}
    ##  output
  proc cusolverSpCcsrlsvchol*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                             descrA: cusparseMatDescr_t; csrVal: ptr cuComplex;
                             csrRowPtr: ptr cint; csrColInd: ptr cint;
                             b: ptr cuComplex; tol: cfloat; reorder: cint;
                             x: ptr cuComplex; singularity: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverSpCcsrlsvchol", dyn.}
    ##  output
  proc cusolverSpZcsrlsvchol*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                             descrA: cusparseMatDescr_t;
                             csrVal: ptr cuDoubleComplex; csrRowPtr: ptr cint;
                             csrColInd: ptr cint; b: ptr cuDoubleComplex;
                             tol: cdouble; reorder: cint; x: ptr cuDoubleComplex;
                             singularity: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverSpZcsrlsvchol", dyn.}
    ##  output
  ##  CPU least square solver based on QR factorization
  ##        solve min|b - A*x|
  ##  [lsq] stands for least square
  ##  [v] stands for vector
  ##  [qr] stands for QR factorization
  ##
  proc cusolverSpScsrlsqvqrHost*(handle: cusolverSpHandle_t; m: cint; n: cint;
                                nnz: cint; descrA: cusparseMatDescr_t;
                                csrValA: ptr cfloat; csrRowPtrA: ptr cint;
                                csrColIndA: ptr cint; b: ptr cfloat; tol: cfloat;
                                rankA: ptr cint; x: ptr cfloat; p: ptr cint;
                                min_norm: ptr cfloat): cusolverStatus_t {.cdecl,
      importc: "cusolverSpScsrlsqvqrHost", dyn.}
  proc cusolverSpDcsrlsqvqrHost*(handle: cusolverSpHandle_t; m: cint; n: cint;
                                nnz: cint; descrA: cusparseMatDescr_t;
                                csrValA: ptr cdouble; csrRowPtrA: ptr cint;
                                csrColIndA: ptr cint; b: ptr cdouble; tol: cdouble;
                                rankA: ptr cint; x: ptr cdouble; p: ptr cint;
                                min_norm: ptr cdouble): cusolverStatus_t {.cdecl,
      importc: "cusolverSpDcsrlsqvqrHost", dyn.}
  proc cusolverSpCcsrlsqvqrHost*(handle: cusolverSpHandle_t; m: cint; n: cint;
                                nnz: cint; descrA: cusparseMatDescr_t;
                                csrValA: ptr cuComplex; csrRowPtrA: ptr cint;
                                csrColIndA: ptr cint; b: ptr cuComplex; tol: cfloat;
                                rankA: ptr cint; x: ptr cuComplex; p: ptr cint;
                                min_norm: ptr cfloat): cusolverStatus_t {.cdecl,
      importc: "cusolverSpCcsrlsqvqrHost", dyn.}
  proc cusolverSpZcsrlsqvqrHost*(handle: cusolverSpHandle_t; m: cint; n: cint;
                                nnz: cint; descrA: cusparseMatDescr_t;
                                csrValA: ptr cuDoubleComplex; csrRowPtrA: ptr cint;
                                csrColIndA: ptr cint; b: ptr cuDoubleComplex;
                                tol: cdouble; rankA: ptr cint;
                                x: ptr cuDoubleComplex; p: ptr cint;
                                min_norm: ptr cdouble): cusolverStatus_t {.cdecl,
      importc: "cusolverSpZcsrlsqvqrHost", dyn.}
  ##  CPU eigenvalue solver based on shift inverse
  ##       solve A*x = lambda * x
  ##    where lambda is the eigenvalue nearest mu0.
  ##  [eig] stands for eigenvalue solver
  ##  [si] stands for shift-inverse
  ##
  proc cusolverSpScsreigvsiHost*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                                descrA: cusparseMatDescr_t; csrValA: ptr cfloat;
                                csrRowPtrA: ptr cint; csrColIndA: ptr cint;
                                mu0: cfloat; x0: ptr cfloat; maxite: cint; tol: cfloat;
                                mu: ptr cfloat; x: ptr cfloat): cusolverStatus_t {.
      cdecl, importc: "cusolverSpScsreigvsiHost", dyn.}
  proc cusolverSpDcsreigvsiHost*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                                descrA: cusparseMatDescr_t; csrValA: ptr cdouble;
                                csrRowPtrA: ptr cint; csrColIndA: ptr cint;
                                mu0: cdouble; x0: ptr cdouble; maxite: cint;
                                tol: cdouble; mu: ptr cdouble; x: ptr cdouble): cusolverStatus_t {.
      cdecl, importc: "cusolverSpDcsreigvsiHost", dyn.}
  proc cusolverSpCcsreigvsiHost*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                                descrA: cusparseMatDescr_t;
                                csrValA: ptr cuComplex; csrRowPtrA: ptr cint;
                                csrColIndA: ptr cint; mu0: cuComplex;
                                x0: ptr cuComplex; maxite: cint; tol: cfloat;
                                mu: ptr cuComplex; x: ptr cuComplex): cusolverStatus_t {.
      cdecl, importc: "cusolverSpCcsreigvsiHost", dyn.}
  proc cusolverSpZcsreigvsiHost*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                                descrA: cusparseMatDescr_t;
                                csrValA: ptr cuDoubleComplex; csrRowPtrA: ptr cint;
                                csrColIndA: ptr cint; mu0: cuDoubleComplex;
                                x0: ptr cuDoubleComplex; maxite: cint; tol: cdouble;
                                mu: ptr cuDoubleComplex; x: ptr cuDoubleComplex): cusolverStatus_t {.
      cdecl, importc: "cusolverSpZcsreigvsiHost", dyn.}
  ##  GPU eigenvalue solver based on shift inverse
  ##       solve A*x = lambda * x
  ##    where lambda is the eigenvalue nearest mu0.
  ##  [eig] stands for eigenvalue solver
  ##  [si] stands for shift-inverse
  ##
  proc cusolverSpScsreigvsi*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                            descrA: cusparseMatDescr_t; csrValA: ptr cfloat;
                            csrRowPtrA: ptr cint; csrColIndA: ptr cint; mu0: cfloat;
                            x0: ptr cfloat; maxite: cint; eps: cfloat; mu: ptr cfloat;
                            x: ptr cfloat): cusolverStatus_t {.cdecl,
      importc: "cusolverSpScsreigvsi", dyn.}
  proc cusolverSpDcsreigvsi*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                            descrA: cusparseMatDescr_t; csrValA: ptr cdouble;
                            csrRowPtrA: ptr cint; csrColIndA: ptr cint; mu0: cdouble;
                            x0: ptr cdouble; maxite: cint; eps: cdouble;
                            mu: ptr cdouble; x: ptr cdouble): cusolverStatus_t {.cdecl,
      importc: "cusolverSpDcsreigvsi", dyn.}
  proc cusolverSpCcsreigvsi*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                            descrA: cusparseMatDescr_t; csrValA: ptr cuComplex;
                            csrRowPtrA: ptr cint; csrColIndA: ptr cint;
                            mu0: cuComplex; x0: ptr cuComplex; maxite: cint;
                            eps: cfloat; mu: ptr cuComplex; x: ptr cuComplex): cusolverStatus_t {.
      cdecl, importc: "cusolverSpCcsreigvsi", dyn.}
  proc cusolverSpZcsreigvsi*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                            descrA: cusparseMatDescr_t;
                            csrValA: ptr cuDoubleComplex; csrRowPtrA: ptr cint;
                            csrColIndA: ptr cint; mu0: cuDoubleComplex;
                            x0: ptr cuDoubleComplex; maxite: cint; eps: cdouble;
                            mu: ptr cuDoubleComplex; x: ptr cuDoubleComplex): cusolverStatus_t {.
      cdecl, importc: "cusolverSpZcsreigvsi", dyn.}
  ##  enclosed eigenvalues
  proc cusolverSpScsreigsHost*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                              descrA: cusparseMatDescr_t; csrValA: ptr cfloat;
                              csrRowPtrA: ptr cint; csrColIndA: ptr cint;
                              left_bottom_corner: cuComplex;
                              right_upper_corner: cuComplex; num_eigs: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverSpScsreigsHost", dyn.}
  proc cusolverSpDcsreigsHost*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                              descrA: cusparseMatDescr_t; csrValA: ptr cdouble;
                              csrRowPtrA: ptr cint; csrColIndA: ptr cint;
                              left_bottom_corner: cuDoubleComplex;
                              right_upper_corner: cuDoubleComplex;
                              num_eigs: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverSpDcsreigsHost", dyn.}
  proc cusolverSpCcsreigsHost*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                              descrA: cusparseMatDescr_t; csrValA: ptr cuComplex;
                              csrRowPtrA: ptr cint; csrColIndA: ptr cint;
                              left_bottom_corner: cuComplex;
                              right_upper_corner: cuComplex; num_eigs: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverSpCcsreigsHost", dyn.}
  proc cusolverSpZcsreigsHost*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                              descrA: cusparseMatDescr_t;
                              csrValA: ptr cuDoubleComplex; csrRowPtrA: ptr cint;
                              csrColIndA: ptr cint;
                              left_bottom_corner: cuDoubleComplex;
                              right_upper_corner: cuDoubleComplex;
                              num_eigs: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverSpZcsreigsHost", dyn.}
  ##  CPU symrcm
  ##    Symmetric reverse Cuthill McKee permutation
  ##
  ##
  proc cusolverSpXcsrsymrcmHost*(handle: cusolverSpHandle_t; n: cint; nnzA: cint;
                                descrA: cusparseMatDescr_t; csrRowPtrA: ptr cint;
                                csrColIndA: ptr cint; p: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverSpXcsrsymrcmHost", dyn.}
  ##  CPU symmdq
  ##    Symmetric minimum degree algorithm based on quotient graph
  ##
  ##
  proc cusolverSpXcsrsymmdqHost*(handle: cusolverSpHandle_t; n: cint; nnzA: cint;
                                descrA: cusparseMatDescr_t; csrRowPtrA: ptr cint;
                                csrColIndA: ptr cint; p: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverSpXcsrsymmdqHost", dyn.}
  ##  CPU symmdq
  ##    Symmetric Approximate minimum degree algorithm based on quotient graph
  ##
  ##
  proc cusolverSpXcsrsymamdHost*(handle: cusolverSpHandle_t; n: cint; nnzA: cint;
                                descrA: cusparseMatDescr_t; csrRowPtrA: ptr cint;
                                csrColIndA: ptr cint; p: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverSpXcsrsymamdHost", dyn.}
  ##  CPU permuation
  ##    P*A*Q^T
  ##
  ##
  proc cusolverSpXcsrperm_bufferSizeHost*(handle: cusolverSpHandle_t; m: cint;
      n: cint; nnzA: cint; descrA: cusparseMatDescr_t; csrRowPtrA: ptr cint;
      csrColIndA: ptr cint; p: ptr cint; q: ptr cint; bufferSizeInBytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverSpXcsrperm_bufferSizeHost", dyn.}
  proc cusolverSpXcsrpermHost*(handle: cusolverSpHandle_t; m: cint; n: cint;
                              nnzA: cint; descrA: cusparseMatDescr_t;
                              csrRowPtrA: ptr cint; csrColIndA: ptr cint; p: ptr cint;
                              q: ptr cint; map: ptr cint; pBuffer: pointer): cusolverStatus_t {.
      cdecl, importc: "cusolverSpXcsrpermHost", dyn.}
  ##
  ##   Low-level API: Batched QR
  ##
  ##
  proc cusolverSpCreateCsrqrInfo*(info: ptr csrqrInfo_t): cusolverStatus_t {.cdecl,
      importc: "cusolverSpCreateCsrqrInfo", dyn.}
  proc cusolverSpDestroyCsrqrInfo*(info: csrqrInfo_t): cusolverStatus_t {.cdecl,
      importc: "cusolverSpDestroyCsrqrInfo", dyn.}
  proc cusolverSpXcsrqrAnalysisBatched*(handle: cusolverSpHandle_t; m: cint; n: cint;
                                       nnzA: cint; descrA: cusparseMatDescr_t;
                                       csrRowPtrA: ptr cint; csrColIndA: ptr cint;
                                       info: csrqrInfo_t): cusolverStatus_t {.
      cdecl, importc: "cusolverSpXcsrqrAnalysisBatched", dyn.}
  proc cusolverSpScsrqrBufferInfoBatched*(handle: cusolverSpHandle_t; m: cint;
      n: cint; nnz: cint; descrA: cusparseMatDescr_t; csrVal: ptr cfloat;
      csrRowPtr: ptr cint; csrColInd: ptr cint; batchSize: cint; info: csrqrInfo_t;
      internalDataInBytes: ptr csize_t; workspaceInBytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverSpScsrqrBufferInfoBatched", dyn.}
  proc cusolverSpDcsrqrBufferInfoBatched*(handle: cusolverSpHandle_t; m: cint;
      n: cint; nnz: cint; descrA: cusparseMatDescr_t; csrVal: ptr cdouble;
      csrRowPtr: ptr cint; csrColInd: ptr cint; batchSize: cint; info: csrqrInfo_t;
      internalDataInBytes: ptr csize_t; workspaceInBytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverSpDcsrqrBufferInfoBatched", dyn.}
  proc cusolverSpCcsrqrBufferInfoBatched*(handle: cusolverSpHandle_t; m: cint;
      n: cint; nnz: cint; descrA: cusparseMatDescr_t; csrVal: ptr cuComplex;
      csrRowPtr: ptr cint; csrColInd: ptr cint; batchSize: cint; info: csrqrInfo_t;
      internalDataInBytes: ptr csize_t; workspaceInBytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverSpCcsrqrBufferInfoBatched", dyn.}
  proc cusolverSpZcsrqrBufferInfoBatched*(handle: cusolverSpHandle_t; m: cint;
      n: cint; nnz: cint; descrA: cusparseMatDescr_t; csrVal: ptr cuDoubleComplex;
      csrRowPtr: ptr cint; csrColInd: ptr cint; batchSize: cint; info: csrqrInfo_t;
      internalDataInBytes: ptr csize_t; workspaceInBytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverSpZcsrqrBufferInfoBatched", dyn.}
  proc cusolverSpScsrqrsvBatched*(handle: cusolverSpHandle_t; m: cint; n: cint;
                                 nnz: cint; descrA: cusparseMatDescr_t;
                                 csrValA: ptr cfloat; csrRowPtrA: ptr cint;
                                 csrColIndA: ptr cint; b: ptr cfloat; x: ptr cfloat;
                                 batchSize: cint; info: csrqrInfo_t;
                                 pBuffer: pointer): cusolverStatus_t {.cdecl,
      importc: "cusolverSpScsrqrsvBatched", dyn.}
  proc cusolverSpDcsrqrsvBatched*(handle: cusolverSpHandle_t; m: cint; n: cint;
                                 nnz: cint; descrA: cusparseMatDescr_t;
                                 csrValA: ptr cdouble; csrRowPtrA: ptr cint;
                                 csrColIndA: ptr cint; b: ptr cdouble; x: ptr cdouble;
                                 batchSize: cint; info: csrqrInfo_t;
                                 pBuffer: pointer): cusolverStatus_t {.cdecl,
      importc: "cusolverSpDcsrqrsvBatched", dyn.}
  proc cusolverSpCcsrqrsvBatched*(handle: cusolverSpHandle_t; m: cint; n: cint;
                                 nnz: cint; descrA: cusparseMatDescr_t;
                                 csrValA: ptr cuComplex; csrRowPtrA: ptr cint;
                                 csrColIndA: ptr cint; b: ptr cuComplex;
                                 x: ptr cuComplex; batchSize: cint;
                                 info: csrqrInfo_t; pBuffer: pointer): cusolverStatus_t {.
      cdecl, importc: "cusolverSpCcsrqrsvBatched", dyn.}
  proc cusolverSpZcsrqrsvBatched*(handle: cusolverSpHandle_t; m: cint; n: cint;
                                 nnz: cint; descrA: cusparseMatDescr_t;
                                 csrValA: ptr cuDoubleComplex;
                                 csrRowPtrA: ptr cint; csrColIndA: ptr cint;
                                 b: ptr cuDoubleComplex; x: ptr cuDoubleComplex;
                                 batchSize: cint; info: csrqrInfo_t;
                                 pBuffer: pointer): cusolverStatus_t {.cdecl,
      importc: "cusolverSpZcsrqrsvBatched", dyn.}
