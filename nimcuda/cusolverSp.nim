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
  import
    cusparse, cublas_v2, cusolver_common

  discard "forward decl of cusolverSpContext"
  type
    #cusolverSpHandle_t* = ptr cusolverSpContext
    cusolverSpHandle_t* = pointer
  discard "forward decl of csrqrInfo"
  type
    #csrqrInfo_t* = ptr csrqrInfo
    csrqrInfo_t* = pointer
  proc cusolverSpCreate*(handle: ptr cusolverSpHandle_t): cusolverStatus_t {.cdecl,
      importc: "cusolverSpCreate", dynlib: libName.}
  proc cusolverSpDestroy*(handle: cusolverSpHandle_t): cusolverStatus_t {.cdecl,
      importc: "cusolverSpDestroy", dynlib: libName.}
  proc cusolverSpSetStream*(handle: cusolverSpHandle_t; streamId: cudaStream_t): cusolverStatus_t {.
      cdecl, importc: "cusolverSpSetStream", dynlib: libName.}
  proc cusolverSpGetStream*(handle: cusolverSpHandle_t; streamId: ptr cudaStream_t): cusolverStatus_t {.
      cdecl, importc: "cusolverSpGetStream", dynlib: libName.}
  proc cusolverSpXcsrissymHost*(handle: cusolverSpHandle_t; m: cint; nnzA: cint;
                               descrA: cusparseMatDescr_t; csrRowPtrA: ptr cint;
                               csrEndPtrA: ptr cint; csrColIndA: ptr cint;
                               issym: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverSpXcsrissymHost", dynlib: libName.}
  ##  -------- GPU linear solver by LU factorization
  ##        solve A*x = b, A can be singular
  ##  [ls] stands for linear solve
  ##  [v] stands for vector
  ##  [lu] stands for LU factorization
  ##
  proc cusolverSpScsrlsvluHost*(handle: cusolverSpHandle_t; n: cint; nnzA: cint;
                               descrA: cusparseMatDescr_t; csrValA: ptr cfloat;
                               csrRowPtrA: ptr cint; csrColIndA: ptr cint;
                               b: ptr cfloat; tol: cfloat; reorder: cint;
                               x: ptr cfloat; singularity: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverSpScsrlsvluHost", dynlib: libName.}
  proc cusolverSpDcsrlsvluHost*(handle: cusolverSpHandle_t; n: cint; nnzA: cint;
                               descrA: cusparseMatDescr_t; csrValA: ptr cdouble;
                               csrRowPtrA: ptr cint; csrColIndA: ptr cint;
                               b: ptr cdouble; tol: cdouble; reorder: cint;
                               x: ptr cdouble; singularity: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverSpDcsrlsvluHost", dynlib: libName.}
  proc cusolverSpCcsrlsvluHost*(handle: cusolverSpHandle_t; n: cint; nnzA: cint;
                               descrA: cusparseMatDescr_t; csrValA: ptr cuComplex;
                               csrRowPtrA: ptr cint; csrColIndA: ptr cint;
                               b: ptr cuComplex; tol: cfloat; reorder: cint;
                               x: ptr cuComplex; singularity: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverSpCcsrlsvluHost", dynlib: libName.}
  proc cusolverSpZcsrlsvluHost*(handle: cusolverSpHandle_t; n: cint; nnzA: cint;
                               descrA: cusparseMatDescr_t;
                               csrValA: ptr cuDoubleComplex; csrRowPtrA: ptr cint;
                               csrColIndA: ptr cint; b: ptr cuDoubleComplex;
                               tol: cdouble; reorder: cint; x: ptr cuDoubleComplex;
                               singularity: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverSpZcsrlsvluHost", dynlib: libName.}
  ##  -------- GPU linear solver by QR factorization
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
      importc: "cusolverSpScsrlsvqr", dynlib: libName.}
  proc cusolverSpDcsrlsvqr*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                           descrA: cusparseMatDescr_t; csrVal: ptr cdouble;
                           csrRowPtr: ptr cint; csrColInd: ptr cint; b: ptr cdouble;
                           tol: cdouble; reorder: cint; x: ptr cdouble;
                           singularity: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverSpDcsrlsvqr", dynlib: libName.}
  proc cusolverSpCcsrlsvqr*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                           descrA: cusparseMatDescr_t; csrVal: ptr cuComplex;
                           csrRowPtr: ptr cint; csrColInd: ptr cint; b: ptr cuComplex;
                           tol: cfloat; reorder: cint; x: ptr cuComplex;
                           singularity: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverSpCcsrlsvqr", dynlib: libName.}
  proc cusolverSpZcsrlsvqr*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                           descrA: cusparseMatDescr_t;
                           csrVal: ptr cuDoubleComplex; csrRowPtr: ptr cint;
                           csrColInd: ptr cint; b: ptr cuDoubleComplex; tol: cdouble;
                           reorder: cint; x: ptr cuDoubleComplex;
                           singularity: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverSpZcsrlsvqr", dynlib: libName.}
  ##  -------- CPU linear solver by QR factorization
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
      cdecl, importc: "cusolverSpScsrlsvqrHost", dynlib: libName.}
  proc cusolverSpDcsrlsvqrHost*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                               descrA: cusparseMatDescr_t; csrValA: ptr cdouble;
                               csrRowPtrA: ptr cint; csrColIndA: ptr cint;
                               b: ptr cdouble; tol: cdouble; reorder: cint;
                               x: ptr cdouble; singularity: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverSpDcsrlsvqrHost", dynlib: libName.}
  proc cusolverSpCcsrlsvqrHost*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                               descrA: cusparseMatDescr_t; csrValA: ptr cuComplex;
                               csrRowPtrA: ptr cint; csrColIndA: ptr cint;
                               b: ptr cuComplex; tol: cfloat; reorder: cint;
                               x: ptr cuComplex; singularity: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverSpCcsrlsvqrHost", dynlib: libName.}
  proc cusolverSpZcsrlsvqrHost*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                               descrA: cusparseMatDescr_t;
                               csrValA: ptr cuDoubleComplex; csrRowPtrA: ptr cint;
                               csrColIndA: ptr cint; b: ptr cuDoubleComplex;
                               tol: cdouble; reorder: cint; x: ptr cuDoubleComplex;
                               singularity: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverSpZcsrlsvqrHost", dynlib: libName.}
  ##  -------- CPU linear solver by Cholesky factorization
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
      cdecl, importc: "cusolverSpScsrlsvcholHost", dynlib: libName.}
  proc cusolverSpDcsrlsvcholHost*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                                 descrA: cusparseMatDescr_t; csrVal: ptr cdouble;
                                 csrRowPtr: ptr cint; csrColInd: ptr cint;
                                 b: ptr cdouble; tol: cdouble; reorder: cint;
                                 x: ptr cdouble; singularity: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverSpDcsrlsvcholHost", dynlib: libName.}
  proc cusolverSpCcsrlsvcholHost*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                                 descrA: cusparseMatDescr_t;
                                 csrVal: ptr cuComplex; csrRowPtr: ptr cint;
                                 csrColInd: ptr cint; b: ptr cuComplex; tol: cfloat;
                                 reorder: cint; x: ptr cuComplex;
                                 singularity: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverSpCcsrlsvcholHost", dynlib: libName.}
  proc cusolverSpZcsrlsvcholHost*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                                 descrA: cusparseMatDescr_t;
                                 csrVal: ptr cuDoubleComplex; csrRowPtr: ptr cint;
                                 csrColInd: ptr cint; b: ptr cuDoubleComplex;
                                 tol: cdouble; reorder: cint;
                                 x: ptr cuDoubleComplex; singularity: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverSpZcsrlsvcholHost", dynlib: libName.}
  ##  -------- GPU linear solver by Cholesky factorization
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
      importc: "cusolverSpScsrlsvchol", dynlib: libName.}
    ##  output
  proc cusolverSpDcsrlsvchol*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                             descrA: cusparseMatDescr_t; csrVal: ptr cdouble;
                             csrRowPtr: ptr cint; csrColInd: ptr cint; b: ptr cdouble;
                             tol: cdouble; reorder: cint; x: ptr cdouble;
                             singularity: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverSpDcsrlsvchol", dynlib: libName.}
    ##  output
  proc cusolverSpCcsrlsvchol*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                             descrA: cusparseMatDescr_t; csrVal: ptr cuComplex;
                             csrRowPtr: ptr cint; csrColInd: ptr cint;
                             b: ptr cuComplex; tol: cfloat; reorder: cint;
                             x: ptr cuComplex; singularity: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverSpCcsrlsvchol", dynlib: libName.}
    ##  output
  proc cusolverSpZcsrlsvchol*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                             descrA: cusparseMatDescr_t;
                             csrVal: ptr cuDoubleComplex; csrRowPtr: ptr cint;
                             csrColInd: ptr cint; b: ptr cuDoubleComplex;
                             tol: cdouble; reorder: cint; x: ptr cuDoubleComplex;
                             singularity: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverSpZcsrlsvchol", dynlib: libName.}
    ##  output
  ##  ----------- CPU least square solver by QR factorization
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
      importc: "cusolverSpScsrlsqvqrHost", dynlib: libName.}
  proc cusolverSpDcsrlsqvqrHost*(handle: cusolverSpHandle_t; m: cint; n: cint;
                                nnz: cint; descrA: cusparseMatDescr_t;
                                csrValA: ptr cdouble; csrRowPtrA: ptr cint;
                                csrColIndA: ptr cint; b: ptr cdouble; tol: cdouble;
                                rankA: ptr cint; x: ptr cdouble; p: ptr cint;
                                min_norm: ptr cdouble): cusolverStatus_t {.cdecl,
      importc: "cusolverSpDcsrlsqvqrHost", dynlib: libName.}
  proc cusolverSpCcsrlsqvqrHost*(handle: cusolverSpHandle_t; m: cint; n: cint;
                                nnz: cint; descrA: cusparseMatDescr_t;
                                csrValA: ptr cuComplex; csrRowPtrA: ptr cint;
                                csrColIndA: ptr cint; b: ptr cuComplex; tol: cfloat;
                                rankA: ptr cint; x: ptr cuComplex; p: ptr cint;
                                min_norm: ptr cfloat): cusolverStatus_t {.cdecl,
      importc: "cusolverSpCcsrlsqvqrHost", dynlib: libName.}
  proc cusolverSpZcsrlsqvqrHost*(handle: cusolverSpHandle_t; m: cint; n: cint;
                                nnz: cint; descrA: cusparseMatDescr_t;
                                csrValA: ptr cuDoubleComplex; csrRowPtrA: ptr cint;
                                csrColIndA: ptr cint; b: ptr cuDoubleComplex;
                                tol: cdouble; rankA: ptr cint;
                                x: ptr cuDoubleComplex; p: ptr cint;
                                min_norm: ptr cdouble): cusolverStatus_t {.cdecl,
      importc: "cusolverSpZcsrlsqvqrHost", dynlib: libName.}
  ##  --------- CPU eigenvalue solver by shift inverse
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
      cdecl, importc: "cusolverSpScsreigvsiHost", dynlib: libName.}
  proc cusolverSpDcsreigvsiHost*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                                descrA: cusparseMatDescr_t; csrValA: ptr cdouble;
                                csrRowPtrA: ptr cint; csrColIndA: ptr cint;
                                mu0: cdouble; x0: ptr cdouble; maxite: cint;
                                tol: cdouble; mu: ptr cdouble; x: ptr cdouble): cusolverStatus_t {.
      cdecl, importc: "cusolverSpDcsreigvsiHost", dynlib: libName.}
  proc cusolverSpCcsreigvsiHost*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                                descrA: cusparseMatDescr_t;
                                csrValA: ptr cuComplex; csrRowPtrA: ptr cint;
                                csrColIndA: ptr cint; mu0: cuComplex;
                                x0: ptr cuComplex; maxite: cint; tol: cfloat;
                                mu: ptr cuComplex; x: ptr cuComplex): cusolverStatus_t {.
      cdecl, importc: "cusolverSpCcsreigvsiHost", dynlib: libName.}
  proc cusolverSpZcsreigvsiHost*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                                descrA: cusparseMatDescr_t;
                                csrValA: ptr cuDoubleComplex; csrRowPtrA: ptr cint;
                                csrColIndA: ptr cint; mu0: cuDoubleComplex;
                                x0: ptr cuDoubleComplex; maxite: cint; tol: cdouble;
                                mu: ptr cuDoubleComplex; x: ptr cuDoubleComplex): cusolverStatus_t {.
      cdecl, importc: "cusolverSpZcsreigvsiHost", dynlib: libName.}
  ##  --------- GPU eigenvalue solver by shift inverse
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
      importc: "cusolverSpScsreigvsi", dynlib: libName.}
  proc cusolverSpDcsreigvsi*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                            descrA: cusparseMatDescr_t; csrValA: ptr cdouble;
                            csrRowPtrA: ptr cint; csrColIndA: ptr cint; mu0: cdouble;
                            x0: ptr cdouble; maxite: cint; eps: cdouble;
                            mu: ptr cdouble; x: ptr cdouble): cusolverStatus_t {.cdecl,
      importc: "cusolverSpDcsreigvsi", dynlib: libName.}
  proc cusolverSpCcsreigvsi*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                            descrA: cusparseMatDescr_t; csrValA: ptr cuComplex;
                            csrRowPtrA: ptr cint; csrColIndA: ptr cint;
                            mu0: cuComplex; x0: ptr cuComplex; maxite: cint;
                            eps: cfloat; mu: ptr cuComplex; x: ptr cuComplex): cusolverStatus_t {.
      cdecl, importc: "cusolverSpCcsreigvsi", dynlib: libName.}
  proc cusolverSpZcsreigvsi*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                            descrA: cusparseMatDescr_t;
                            csrValA: ptr cuDoubleComplex; csrRowPtrA: ptr cint;
                            csrColIndA: ptr cint; mu0: cuDoubleComplex;
                            x0: ptr cuDoubleComplex; maxite: cint; eps: cdouble;
                            mu: ptr cuDoubleComplex; x: ptr cuDoubleComplex): cusolverStatus_t {.
      cdecl, importc: "cusolverSpZcsreigvsi", dynlib: libName.}
  ##  ----------- enclosed eigenvalues
  proc cusolverSpScsreigsHost*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                              descrA: cusparseMatDescr_t; csrValA: ptr cfloat;
                              csrRowPtrA: ptr cint; csrColIndA: ptr cint;
                              left_bottom_corner: cuComplex;
                              right_upper_corner: cuComplex; num_eigs: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverSpScsreigsHost", dynlib: libName.}
  proc cusolverSpDcsreigsHost*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                              descrA: cusparseMatDescr_t; csrValA: ptr cdouble;
                              csrRowPtrA: ptr cint; csrColIndA: ptr cint;
                              left_bottom_corner: cuDoubleComplex;
                              right_upper_corner: cuDoubleComplex;
                              num_eigs: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverSpDcsreigsHost", dynlib: libName.}
  proc cusolverSpCcsreigsHost*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                              descrA: cusparseMatDescr_t; csrValA: ptr cuComplex;
                              csrRowPtrA: ptr cint; csrColIndA: ptr cint;
                              left_bottom_corner: cuComplex;
                              right_upper_corner: cuComplex; num_eigs: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverSpCcsreigsHost", dynlib: libName.}
  proc cusolverSpZcsreigsHost*(handle: cusolverSpHandle_t; m: cint; nnz: cint;
                              descrA: cusparseMatDescr_t;
                              csrValA: ptr cuDoubleComplex; csrRowPtrA: ptr cint;
                              csrColIndA: ptr cint;
                              left_bottom_corner: cuDoubleComplex;
                              right_upper_corner: cuDoubleComplex;
                              num_eigs: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverSpZcsreigsHost", dynlib: libName.}
  ##  --------- CPU symrcm
  ##    Symmetric reverse Cuthill McKee permutation
  ##
  ##
  proc cusolverSpXcsrsymrcmHost*(handle: cusolverSpHandle_t; n: cint; nnzA: cint;
                                descrA: cusparseMatDescr_t; csrRowPtrA: ptr cint;
                                csrColIndA: ptr cint; p: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverSpXcsrsymrcmHost", dynlib: libName.}
  ##  --------- CPU symmdq
  ##    Symmetric minimum degree algorithm by quotient graph
  ##
  ##
  proc cusolverSpXcsrsymmdqHost*(handle: cusolverSpHandle_t; n: cint; nnzA: cint;
                                descrA: cusparseMatDescr_t; csrRowPtrA: ptr cint;
                                csrColIndA: ptr cint; p: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverSpXcsrsymmdqHost", dynlib: libName.}
  ##  --------- CPU symmdq
  ##    Symmetric Approximate minimum degree algorithm by quotient graph
  ##
  ##
  proc cusolverSpXcsrsymamdHost*(handle: cusolverSpHandle_t; n: cint; nnzA: cint;
                                descrA: cusparseMatDescr_t; csrRowPtrA: ptr cint;
                                csrColIndA: ptr cint; p: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverSpXcsrsymamdHost", dynlib: libName.}
  ##  --------- CPU metis
  ##    symmetric reordering
  ##
  proc cusolverSpXcsrmetisndHost*(handle: cusolverSpHandle_t; n: cint; nnzA: cint;
                                 descrA: cusparseMatDescr_t; csrRowPtrA: ptr cint;
                                 csrColIndA: ptr cint; options: ptr clonglong;
                                 p: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverSpXcsrmetisndHost", dynlib: libName.}
  ##  --------- CPU zfd
  ##   Zero free diagonal reordering
  ##
  proc cusolverSpScsrzfdHost*(handle: cusolverSpHandle_t; n: cint; nnz: cint;
                             descrA: cusparseMatDescr_t; csrValA: ptr cfloat;
                             csrRowPtrA: ptr cint; csrColIndA: ptr cint; P: ptr cint;
                             numnz: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverSpScsrzfdHost", dynlib: libName.}
  proc cusolverSpDcsrzfdHost*(handle: cusolverSpHandle_t; n: cint; nnz: cint;
                             descrA: cusparseMatDescr_t; csrValA: ptr cdouble;
                             csrRowPtrA: ptr cint; csrColIndA: ptr cint; P: ptr cint;
                             numnz: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverSpDcsrzfdHost", dynlib: libName.}
  proc cusolverSpCcsrzfdHost*(handle: cusolverSpHandle_t; n: cint; nnz: cint;
                             descrA: cusparseMatDescr_t; csrValA: ptr cuComplex;
                             csrRowPtrA: ptr cint; csrColIndA: ptr cint; P: ptr cint;
                             numnz: ptr cint): cusolverStatus_t {.cdecl,
      importc: "cusolverSpCcsrzfdHost", dynlib: libName.}
  proc cusolverSpZcsrzfdHost*(handle: cusolverSpHandle_t; n: cint; nnz: cint;
                             descrA: cusparseMatDescr_t;
                             csrValA: ptr cuDoubleComplex; csrRowPtrA: ptr cint;
                             csrColIndA: ptr cint; P: ptr cint; numnz: ptr cint): cusolverStatus_t {.
      cdecl, importc: "cusolverSpZcsrzfdHost", dynlib: libName.}
  ##  --------- CPU permuation
  ##    P*A*Q^T
  ##
  ##
  proc cusolverSpXcsrperm_bufferSizeHost*(handle: cusolverSpHandle_t; m: cint;
      n: cint; nnzA: cint; descrA: cusparseMatDescr_t; csrRowPtrA: ptr cint;
      csrColIndA: ptr cint; p: ptr cint; q: ptr cint; bufferSizeInBytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverSpXcsrperm_bufferSizeHost", dynlib: libName.}
  proc cusolverSpXcsrpermHost*(handle: cusolverSpHandle_t; m: cint; n: cint;
                              nnzA: cint; descrA: cusparseMatDescr_t;
                              csrRowPtrA: ptr cint; csrColIndA: ptr cint; p: ptr cint;
                              q: ptr cint; map: ptr cint; pBuffer: pointer): cusolverStatus_t {.
      cdecl, importc: "cusolverSpXcsrpermHost", dynlib: libName.}
  ##
  ##   Low-level API: Batched QR
  ##
  ##
  proc cusolverSpCreateCsrqrInfo*(info: ptr csrqrInfo_t): cusolverStatus_t {.cdecl,
      importc: "cusolverSpCreateCsrqrInfo", dynlib: libName.}
  proc cusolverSpDestroyCsrqrInfo*(info: csrqrInfo_t): cusolverStatus_t {.cdecl,
      importc: "cusolverSpDestroyCsrqrInfo", dynlib: libName.}
  proc cusolverSpXcsrqrAnalysisBatched*(handle: cusolverSpHandle_t; m: cint; n: cint;
                                       nnzA: cint; descrA: cusparseMatDescr_t;
                                       csrRowPtrA: ptr cint; csrColIndA: ptr cint;
                                       info: csrqrInfo_t): cusolverStatus_t {.
      cdecl, importc: "cusolverSpXcsrqrAnalysisBatched", dynlib: libName.}
  proc cusolverSpScsrqrBufferInfoBatched*(handle: cusolverSpHandle_t; m: cint;
      n: cint; nnz: cint; descrA: cusparseMatDescr_t; csrVal: ptr cfloat;
      csrRowPtr: ptr cint; csrColInd: ptr cint; batchSize: cint; info: csrqrInfo_t;
      internalDataInBytes: ptr csize_t; workspaceInBytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverSpScsrqrBufferInfoBatched", dynlib: libName.}
  proc cusolverSpDcsrqrBufferInfoBatched*(handle: cusolverSpHandle_t; m: cint;
      n: cint; nnz: cint; descrA: cusparseMatDescr_t; csrVal: ptr cdouble;
      csrRowPtr: ptr cint; csrColInd: ptr cint; batchSize: cint; info: csrqrInfo_t;
      internalDataInBytes: ptr csize_t; workspaceInBytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverSpDcsrqrBufferInfoBatched", dynlib: libName.}
  proc cusolverSpCcsrqrBufferInfoBatched*(handle: cusolverSpHandle_t; m: cint;
      n: cint; nnz: cint; descrA: cusparseMatDescr_t; csrVal: ptr cuComplex;
      csrRowPtr: ptr cint; csrColInd: ptr cint; batchSize: cint; info: csrqrInfo_t;
      internalDataInBytes: ptr csize_t; workspaceInBytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverSpCcsrqrBufferInfoBatched", dynlib: libName.}
  proc cusolverSpZcsrqrBufferInfoBatched*(handle: cusolverSpHandle_t; m: cint;
      n: cint; nnz: cint; descrA: cusparseMatDescr_t; csrVal: ptr cuDoubleComplex;
      csrRowPtr: ptr cint; csrColInd: ptr cint; batchSize: cint; info: csrqrInfo_t;
      internalDataInBytes: ptr csize_t; workspaceInBytes: ptr csize_t): cusolverStatus_t {.
      cdecl, importc: "cusolverSpZcsrqrBufferInfoBatched", dynlib: libName.}
  proc cusolverSpScsrqrsvBatched*(handle: cusolverSpHandle_t; m: cint; n: cint;
                                 nnz: cint; descrA: cusparseMatDescr_t;
                                 csrValA: ptr cfloat; csrRowPtrA: ptr cint;
                                 csrColIndA: ptr cint; b: ptr cfloat; x: ptr cfloat;
                                 batchSize: cint; info: csrqrInfo_t;
                                 pBuffer: pointer): cusolverStatus_t {.cdecl,
      importc: "cusolverSpScsrqrsvBatched", dynlib: libName.}
  proc cusolverSpDcsrqrsvBatched*(handle: cusolverSpHandle_t; m: cint; n: cint;
                                 nnz: cint; descrA: cusparseMatDescr_t;
                                 csrValA: ptr cdouble; csrRowPtrA: ptr cint;
                                 csrColIndA: ptr cint; b: ptr cdouble; x: ptr cdouble;
                                 batchSize: cint; info: csrqrInfo_t;
                                 pBuffer: pointer): cusolverStatus_t {.cdecl,
      importc: "cusolverSpDcsrqrsvBatched", dynlib: libName.}
  proc cusolverSpCcsrqrsvBatched*(handle: cusolverSpHandle_t; m: cint; n: cint;
                                 nnz: cint; descrA: cusparseMatDescr_t;
                                 csrValA: ptr cuComplex; csrRowPtrA: ptr cint;
                                 csrColIndA: ptr cint; b: ptr cuComplex;
                                 x: ptr cuComplex; batchSize: cint;
                                 info: csrqrInfo_t; pBuffer: pointer): cusolverStatus_t {.
      cdecl, importc: "cusolverSpCcsrqrsvBatched", dynlib: libName.}
  proc cusolverSpZcsrqrsvBatched*(handle: cusolverSpHandle_t; m: cint; n: cint;
                                 nnz: cint; descrA: cusparseMatDescr_t;
                                 csrValA: ptr cuDoubleComplex;
                                 csrRowPtrA: ptr cint; csrColIndA: ptr cint;
                                 b: ptr cuDoubleComplex; x: ptr cuDoubleComplex;
                                 batchSize: cint; info: csrqrInfo_t;
                                 pBuffer: pointer): cusolverStatus_t {.cdecl,
      importc: "cusolverSpZcsrqrsvBatched", dynlib: libName.}
