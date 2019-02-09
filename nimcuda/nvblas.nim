 {.deadCodeElim: on.}
when defined(windows):
  import os
  {.passL: "\"" & os.getEnv("CUDA_PATH") / "lib/x64" / "nvblas.lib" & "\"".}
  {.pragma: dyn.}
elif defined(macosx):
  const
    libName = "libnvblas.dylib"
  {.pragma: dyn, dynlib: libName.}
else:
  const
    libName = "libnvblas.so"
  {.pragma: dyn, dynlib: libName.}
import
  cuComplex

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

when not defined(NVBLAS_H):
  const
    NVBLAS_H* = true
  ##  GEMM
  proc sgemm1*(transa: cstring; transb: cstring; m: ptr cint; n: ptr cint; k: ptr cint;
              alpha: ptr cfloat; a: ptr cfloat; lda: ptr cint; b: ptr cfloat; ldb: ptr cint;
              beta: ptr cfloat; c: ptr cfloat; ldc: ptr cint) {.cdecl, importc: "sgemm_",
      dyn.}
  proc dgemm1*(transa: cstring; transb: cstring; m: ptr cint; n: ptr cint; k: ptr cint;
              alpha: ptr cdouble; a: ptr cdouble; lda: ptr cint; b: ptr cdouble;
              ldb: ptr cint; beta: ptr cdouble; c: ptr cdouble; ldc: ptr cint) {.cdecl,
      importc: "dgemm_", dyn.}
  proc cgemm1*(transa: cstring; transb: cstring; m: ptr cint; n: ptr cint; k: ptr cint;
              alpha: ptr cuComplex; a: ptr cuComplex; lda: ptr cint; b: ptr cuComplex;
              ldb: ptr cint; beta: ptr cuComplex; c: ptr cuComplex; ldc: ptr cint) {.cdecl,
      importc: "cgemm_", dyn.}
  proc zgemm1*(transa: cstring; transb: cstring; m: ptr cint; n: ptr cint; k: ptr cint;
              alpha: ptr cuDoubleComplex; a: ptr cuDoubleComplex; lda: ptr cint;
              b: ptr cuDoubleComplex; ldb: ptr cint; beta: ptr cuDoubleComplex;
              c: ptr cuDoubleComplex; ldc: ptr cint) {.cdecl, importc: "zgemm_",
      dyn.}
  proc sgemm*(transa: cstring; transb: cstring; m: ptr cint; n: ptr cint; k: ptr cint;
             alpha: ptr cfloat; a: ptr cfloat; lda: ptr cint; b: ptr cfloat; ldb: ptr cint;
             beta: ptr cfloat; c: ptr cfloat; ldc: ptr cint) {.cdecl, importc: "sgemm",
      dyn.}
  proc dgemm*(transa: cstring; transb: cstring; m: ptr cint; n: ptr cint; k: ptr cint;
             alpha: ptr cdouble; a: ptr cdouble; lda: ptr cint; b: ptr cdouble;
             ldb: ptr cint; beta: ptr cdouble; c: ptr cdouble; ldc: ptr cint) {.cdecl,
      importc: "dgemm", dyn.}
  proc cgemm*(transa: cstring; transb: cstring; m: ptr cint; n: ptr cint; k: ptr cint;
             alpha: ptr cuComplex; a: ptr cuComplex; lda: ptr cint; b: ptr cuComplex;
             ldb: ptr cint; beta: ptr cuComplex; c: ptr cuComplex; ldc: ptr cint) {.cdecl,
      importc: "cgemm", dyn.}
  proc zgemm*(transa: cstring; transb: cstring; m: ptr cint; n: ptr cint; k: ptr cint;
             alpha: ptr cuDoubleComplex; a: ptr cuDoubleComplex; lda: ptr cint;
             b: ptr cuDoubleComplex; ldb: ptr cint; beta: ptr cuDoubleComplex;
             c: ptr cuDoubleComplex; ldc: ptr cint) {.cdecl, importc: "zgemm",
      dyn.}
  ##  SYRK
  proc ssyrk1*(uplo: cstring; trans: cstring; n: ptr cint; k: ptr cint; alpha: ptr cfloat;
              a: ptr cfloat; lda: ptr cint; beta: ptr cfloat; c: ptr cfloat; ldc: ptr cint) {.
      cdecl, importc: "ssyrk_", dyn.}
  proc dsyrk1*(uplo: cstring; trans: cstring; n: ptr cint; k: ptr cint; alpha: ptr cdouble;
              a: ptr cdouble; lda: ptr cint; beta: ptr cdouble; c: ptr cdouble;
              ldc: ptr cint) {.cdecl, importc: "dsyrk_", dyn.}
  proc csyrk1*(uplo: cstring; trans: cstring; n: ptr cint; k: ptr cint;
              alpha: ptr cuComplex; a: ptr cuComplex; lda: ptr cint; beta: ptr cuComplex;
              c: ptr cuComplex; ldc: ptr cint) {.cdecl, importc: "csyrk_",
      dyn.}
  proc zsyrk1*(uplo: cstring; trans: cstring; n: ptr cint; k: ptr cint;
              alpha: ptr cuDoubleComplex; a: ptr cuDoubleComplex; lda: ptr cint;
              beta: ptr cuDoubleComplex; c: ptr cuDoubleComplex; ldc: ptr cint) {.cdecl,
      importc: "zsyrk_", dyn.}
  proc ssyrk*(uplo: cstring; trans: cstring; n: ptr cint; k: ptr cint; alpha: ptr cfloat;
             a: ptr cfloat; lda: ptr cint; beta: ptr cfloat; c: ptr cfloat; ldc: ptr cint) {.
      cdecl, importc: "ssyrk", dyn.}
  proc dsyrk*(uplo: cstring; trans: cstring; n: ptr cint; k: ptr cint; alpha: ptr cdouble;
             a: ptr cdouble; lda: ptr cint; beta: ptr cdouble; c: ptr cdouble; ldc: ptr cint) {.
      cdecl, importc: "dsyrk", dyn.}
  proc csyrk*(uplo: cstring; trans: cstring; n: ptr cint; k: ptr cint;
             alpha: ptr cuComplex; a: ptr cuComplex; lda: ptr cint; beta: ptr cuComplex;
             c: ptr cuComplex; ldc: ptr cint) {.cdecl, importc: "csyrk", dyn.}
  proc zsyrk*(uplo: cstring; trans: cstring; n: ptr cint; k: ptr cint;
             alpha: ptr cuDoubleComplex; a: ptr cuDoubleComplex; lda: ptr cint;
             beta: ptr cuDoubleComplex; c: ptr cuDoubleComplex; ldc: ptr cint) {.cdecl,
      importc: "zsyrk", dyn.}
  ##  HERK
  proc cherk1*(uplo: cstring; trans: cstring; n: ptr cint; k: ptr cint; alpha: ptr cfloat;
              a: ptr cuComplex; lda: ptr cint; beta: ptr cfloat; c: ptr cuComplex;
              ldc: ptr cint) {.cdecl, importc: "cherk_", dyn.}
  proc zherk1*(uplo: cstring; trans: cstring; n: ptr cint; k: ptr cint; alpha: ptr cdouble;
              a: ptr cuDoubleComplex; lda: ptr cint; beta: ptr cdouble;
              c: ptr cuDoubleComplex; ldc: ptr cint) {.cdecl, importc: "zherk_",
      dyn.}
  proc cherk*(uplo: cstring; trans: cstring; n: ptr cint; k: ptr cint; alpha: ptr cfloat;
             a: ptr cuComplex; lda: ptr cint; beta: ptr cfloat; c: ptr cuComplex;
             ldc: ptr cint) {.cdecl, importc: "cherk", dyn.}
  proc zherk*(uplo: cstring; trans: cstring; n: ptr cint; k: ptr cint; alpha: ptr cdouble;
             a: ptr cuDoubleComplex; lda: ptr cint; beta: ptr cdouble;
             c: ptr cuDoubleComplex; ldc: ptr cint) {.cdecl, importc: "zherk",
      dyn.}
  ##  TRSM
  proc strsm1*(side: cstring; uplo: cstring; transa: cstring; diag: cstring; m: ptr cint;
              n: ptr cint; alpha: ptr cfloat; a: ptr cfloat; lda: ptr cint; b: ptr cfloat;
              ldb: ptr cint) {.cdecl, importc: "strsm_", dyn.}
  proc dtrsm1*(side: cstring; uplo: cstring; transa: cstring; diag: cstring; m: ptr cint;
              n: ptr cint; alpha: ptr cdouble; a: ptr cdouble; lda: ptr cint;
              b: ptr cdouble; ldb: ptr cint) {.cdecl, importc: "dtrsm_", dyn.}
  proc ctrsm1*(side: cstring; uplo: cstring; transa: cstring; diag: cstring; m: ptr cint;
              n: ptr cint; alpha: ptr cuComplex; a: ptr cuComplex; lda: ptr cint;
              b: ptr cuComplex; ldb: ptr cint) {.cdecl, importc: "ctrsm_",
      dyn.}
  proc ztrsm1*(side: cstring; uplo: cstring; transa: cstring; diag: cstring; m: ptr cint;
              n: ptr cint; alpha: ptr cuDoubleComplex; a: ptr cuDoubleComplex;
              lda: ptr cint; b: ptr cuDoubleComplex; ldb: ptr cint) {.cdecl,
      importc: "ztrsm_", dyn.}
  proc strsm*(side: cstring; uplo: cstring; transa: cstring; diag: cstring; m: ptr cint;
             n: ptr cint; alpha: ptr cfloat; a: ptr cfloat; lda: ptr cint; b: ptr cfloat;
             ldb: ptr cint) {.cdecl, importc: "strsm", dyn.}
  proc dtrsm*(side: cstring; uplo: cstring; transa: cstring; diag: cstring; m: ptr cint;
             n: ptr cint; alpha: ptr cdouble; a: ptr cdouble; lda: ptr cint; b: ptr cdouble;
             ldb: ptr cint) {.cdecl, importc: "dtrsm", dyn.}
  proc ctrsm*(side: cstring; uplo: cstring; transa: cstring; diag: cstring; m: ptr cint;
             n: ptr cint; alpha: ptr cuComplex; a: ptr cuComplex; lda: ptr cint;
             b: ptr cuComplex; ldb: ptr cint) {.cdecl, importc: "ctrsm", dyn.}
  proc ztrsm*(side: cstring; uplo: cstring; transa: cstring; diag: cstring; m: ptr cint;
             n: ptr cint; alpha: ptr cuDoubleComplex; a: ptr cuDoubleComplex;
             lda: ptr cint; b: ptr cuDoubleComplex; ldb: ptr cint) {.cdecl,
      importc: "ztrsm", dyn.}
  ##  SYMM
  proc ssymm1*(side: cstring; uplo: cstring; m: ptr cint; n: ptr cint; alpha: ptr cfloat;
              a: ptr cfloat; lda: ptr cint; b: ptr cfloat; ldb: ptr cint; beta: ptr cfloat;
              c: ptr cfloat; ldc: ptr cint) {.cdecl, importc: "ssymm_", dyn.}
  proc dsymm1*(side: cstring; uplo: cstring; m: ptr cint; n: ptr cint; alpha: ptr cdouble;
              a: ptr cdouble; lda: ptr cint; b: ptr cdouble; ldb: ptr cint;
              beta: ptr cdouble; c: ptr cdouble; ldc: ptr cint) {.cdecl,
      importc: "dsymm_", dyn.}
  proc csymm1*(side: cstring; uplo: cstring; m: ptr cint; n: ptr cint;
              alpha: ptr cuComplex; a: ptr cuComplex; lda: ptr cint; b: ptr cuComplex;
              ldb: ptr cint; beta: ptr cuComplex; c: ptr cuComplex; ldc: ptr cint) {.cdecl,
      importc: "csymm_", dyn.}
  proc zsymm1*(side: cstring; uplo: cstring; m: ptr cint; n: ptr cint;
              alpha: ptr cuDoubleComplex; a: ptr cuDoubleComplex; lda: ptr cint;
              b: ptr cuDoubleComplex; ldb: ptr cint; beta: ptr cuDoubleComplex;
              c: ptr cuDoubleComplex; ldc: ptr cint) {.cdecl, importc: "zsymm_",
      dyn.}
  proc ssymm*(side: cstring; uplo: cstring; m: ptr cint; n: ptr cint; alpha: ptr cfloat;
             a: ptr cfloat; lda: ptr cint; b: ptr cfloat; ldb: ptr cint; beta: ptr cfloat;
             c: ptr cfloat; ldc: ptr cint) {.cdecl, importc: "ssymm", dyn.}
  proc dsymm*(side: cstring; uplo: cstring; m: ptr cint; n: ptr cint; alpha: ptr cdouble;
             a: ptr cdouble; lda: ptr cint; b: ptr cdouble; ldb: ptr cint;
             beta: ptr cdouble; c: ptr cdouble; ldc: ptr cint) {.cdecl, importc: "dsymm",
      dyn.}
  proc csymm*(side: cstring; uplo: cstring; m: ptr cint; n: ptr cint; alpha: ptr cuComplex;
             a: ptr cuComplex; lda: ptr cint; b: ptr cuComplex; ldb: ptr cint;
             beta: ptr cuComplex; c: ptr cuComplex; ldc: ptr cint) {.cdecl,
      importc: "csymm", dyn.}
  proc zsymm*(side: cstring; uplo: cstring; m: ptr cint; n: ptr cint;
             alpha: ptr cuDoubleComplex; a: ptr cuDoubleComplex; lda: ptr cint;
             b: ptr cuDoubleComplex; ldb: ptr cint; beta: ptr cuDoubleComplex;
             c: ptr cuDoubleComplex; ldc: ptr cint) {.cdecl, importc: "zsymm",
      dyn.}
  ##  HEMM
  proc chemm1*(side: cstring; uplo: cstring; m: ptr cint; n: ptr cint;
              alpha: ptr cuComplex; a: ptr cuComplex; lda: ptr cint; b: ptr cuComplex;
              ldb: ptr cint; beta: ptr cuComplex; c: ptr cuComplex; ldc: ptr cint) {.cdecl,
      importc: "chemm_", dyn.}
  proc zhemm1*(side: cstring; uplo: cstring; m: ptr cint; n: ptr cint;
              alpha: ptr cuDoubleComplex; a: ptr cuDoubleComplex; lda: ptr cint;
              b: ptr cuDoubleComplex; ldb: ptr cint; beta: ptr cuDoubleComplex;
              c: ptr cuDoubleComplex; ldc: ptr cint) {.cdecl, importc: "zhemm_",
      dyn.}
  ##  HEMM with no underscore
  proc chemm*(side: cstring; uplo: cstring; m: ptr cint; n: ptr cint; alpha: ptr cuComplex;
             a: ptr cuComplex; lda: ptr cint; b: ptr cuComplex; ldb: ptr cint;
             beta: ptr cuComplex; c: ptr cuComplex; ldc: ptr cint) {.cdecl,
      importc: "chemm", dyn.}
  proc zhemm*(side: cstring; uplo: cstring; m: ptr cint; n: ptr cint;
             alpha: ptr cuDoubleComplex; a: ptr cuDoubleComplex; lda: ptr cint;
             b: ptr cuDoubleComplex; ldb: ptr cint; beta: ptr cuDoubleComplex;
             c: ptr cuDoubleComplex; ldc: ptr cint) {.cdecl, importc: "zhemm",
      dyn.}
  ##  SYR2K
  proc ssyr2k1*(uplo: cstring; trans: cstring; n: ptr cint; k: ptr cint; alpha: ptr cfloat;
               a: ptr cfloat; lda: ptr cint; b: ptr cfloat; ldb: ptr cint; beta: ptr cfloat;
               c: ptr cfloat; ldc: ptr cint) {.cdecl, importc: "ssyr2k_", dyn.}
  proc dsyr2k1*(uplo: cstring; trans: cstring; n: ptr cint; k: ptr cint;
               alpha: ptr cdouble; a: ptr cdouble; lda: ptr cint; b: ptr cdouble;
               ldb: ptr cint; beta: ptr cdouble; c: ptr cdouble; ldc: ptr cint) {.cdecl,
      importc: "dsyr2k_", dyn.}
  proc csyr2k1*(uplo: cstring; trans: cstring; n: ptr cint; k: ptr cint;
               alpha: ptr cuComplex; a: ptr cuComplex; lda: ptr cint; b: ptr cuComplex;
               ldb: ptr cint; beta: ptr cuComplex; c: ptr cuComplex; ldc: ptr cint) {.cdecl,
      importc: "csyr2k_", dyn.}
  proc zsyr2k1*(uplo: cstring; trans: cstring; n: ptr cint; k: ptr cint;
               alpha: ptr cuDoubleComplex; a: ptr cuDoubleComplex; lda: ptr cint;
               b: ptr cuDoubleComplex; ldb: ptr cint; beta: ptr cuDoubleComplex;
               c: ptr cuDoubleComplex; ldc: ptr cint) {.cdecl, importc: "zsyr2k_",
      dyn.}
  ##  SYR2K no_underscore
  proc ssyr2k*(uplo: cstring; trans: cstring; n: ptr cint; k: ptr cint; alpha: ptr cfloat;
              a: ptr cfloat; lda: ptr cint; b: ptr cfloat; ldb: ptr cint; beta: ptr cfloat;
              c: ptr cfloat; ldc: ptr cint) {.cdecl, importc: "ssyr2k", dyn.}
  proc dsyr2k*(uplo: cstring; trans: cstring; n: ptr cint; k: ptr cint; alpha: ptr cdouble;
              a: ptr cdouble; lda: ptr cint; b: ptr cdouble; ldb: ptr cint;
              beta: ptr cdouble; c: ptr cdouble; ldc: ptr cint) {.cdecl,
      importc: "dsyr2k", dyn.}
  proc csyr2k*(uplo: cstring; trans: cstring; n: ptr cint; k: ptr cint;
              alpha: ptr cuComplex; a: ptr cuComplex; lda: ptr cint; b: ptr cuComplex;
              ldb: ptr cint; beta: ptr cuComplex; c: ptr cuComplex; ldc: ptr cint) {.cdecl,
      importc: "csyr2k", dyn.}
  proc zsyr2k*(uplo: cstring; trans: cstring; n: ptr cint; k: ptr cint;
              alpha: ptr cuDoubleComplex; a: ptr cuDoubleComplex; lda: ptr cint;
              b: ptr cuDoubleComplex; ldb: ptr cint; beta: ptr cuDoubleComplex;
              c: ptr cuDoubleComplex; ldc: ptr cint) {.cdecl, importc: "zsyr2k",
      dyn.}
  ##  HERK
  proc cher2k1*(uplo: cstring; trans: cstring; n: ptr cint; k: ptr cint;
               alpha: ptr cuComplex; a: ptr cuComplex; lda: ptr cint; b: ptr cuComplex;
               ldb: ptr cint; beta: ptr cfloat; c: ptr cuComplex; ldc: ptr cint) {.cdecl,
      importc: "cher2k_", dyn.}
  proc zher2k1*(uplo: cstring; trans: cstring; n: ptr cint; k: ptr cint;
               alpha: ptr cuDoubleComplex; a: ptr cuDoubleComplex; lda: ptr cint;
               b: ptr cuDoubleComplex; ldb: ptr cint; beta: ptr cdouble;
               c: ptr cuDoubleComplex; ldc: ptr cint) {.cdecl, importc: "zher2k_",
      dyn.}
  ##  HER2K with no underscore
  proc cher2k*(uplo: cstring; trans: cstring; n: ptr cint; k: ptr cint;
              alpha: ptr cuComplex; a: ptr cuComplex; lda: ptr cint; b: ptr cuComplex;
              ldb: ptr cint; beta: ptr cfloat; c: ptr cuComplex; ldc: ptr cint) {.cdecl,
      importc: "cher2k", dyn.}
  proc zher2k*(uplo: cstring; trans: cstring; n: ptr cint; k: ptr cint;
              alpha: ptr cuDoubleComplex; a: ptr cuDoubleComplex; lda: ptr cint;
              b: ptr cuDoubleComplex; ldb: ptr cint; beta: ptr cdouble;
              c: ptr cuDoubleComplex; ldc: ptr cint) {.cdecl, importc: "zher2k",
      dyn.}
  ##  TRMM
  proc strmm1*(side: cstring; uplo: cstring; transa: cstring; diag: cstring; m: ptr cint;
              n: ptr cint; alpha: ptr cfloat; a: ptr cfloat; lda: ptr cint; b: ptr cfloat;
              ldb: ptr cint) {.cdecl, importc: "strmm_", dyn.}
  proc dtrmm1*(side: cstring; uplo: cstring; transa: cstring; diag: cstring; m: ptr cint;
              n: ptr cint; alpha: ptr cdouble; a: ptr cdouble; lda: ptr cint;
              b: ptr cdouble; ldb: ptr cint) {.cdecl, importc: "dtrmm_", dyn.}
  proc ctrmm1*(side: cstring; uplo: cstring; transa: cstring; diag: cstring; m: ptr cint;
              n: ptr cint; alpha: ptr cuComplex; a: ptr cuComplex; lda: ptr cint;
              b: ptr cuComplex; ldb: ptr cint) {.cdecl, importc: "ctrmm_",
      dyn.}
  proc ztrmm1*(side: cstring; uplo: cstring; transa: cstring; diag: cstring; m: ptr cint;
              n: ptr cint; alpha: ptr cuDoubleComplex; a: ptr cuDoubleComplex;
              lda: ptr cint; b: ptr cuDoubleComplex; ldb: ptr cint) {.cdecl,
      importc: "ztrmm_", dyn.}
  proc strmm*(side: cstring; uplo: cstring; transa: cstring; diag: cstring; m: ptr cint;
             n: ptr cint; alpha: ptr cfloat; a: ptr cfloat; lda: ptr cint; b: ptr cfloat;
             ldb: ptr cint) {.cdecl, importc: "strmm", dyn.}
  proc dtrmm*(side: cstring; uplo: cstring; transa: cstring; diag: cstring; m: ptr cint;
             n: ptr cint; alpha: ptr cdouble; a: ptr cdouble; lda: ptr cint; b: ptr cdouble;
             ldb: ptr cint) {.cdecl, importc: "dtrmm", dyn.}
  proc ctrmm*(side: cstring; uplo: cstring; transa: cstring; diag: cstring; m: ptr cint;
             n: ptr cint; alpha: ptr cuComplex; a: ptr cuComplex; lda: ptr cint;
             b: ptr cuComplex; ldb: ptr cint) {.cdecl, importc: "ctrmm", dyn.}
  proc ztrmm*(side: cstring; uplo: cstring; transa: cstring; diag: cstring; m: ptr cint;
             n: ptr cint; alpha: ptr cuDoubleComplex; a: ptr cuDoubleComplex;
             lda: ptr cint; b: ptr cuDoubleComplex; ldb: ptr cint) {.cdecl,
      importc: "ztrmm", dyn.}