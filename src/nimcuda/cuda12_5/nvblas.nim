when defined(windows):
  const
    libName = "nvblas.dll"
elif defined(macosx):
  const
    libName = "libnvblas.dylib"
else:
  const
    libName = "libnvblas.so"
import
  cuComplex
import ./libpaths
tellCompilerToUseCuda()
##
##  Copyright 1993-2019 NVIDIA Corporation. All rights reserved.
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

##  GEMM

proc sgemmUnderScore*(transa: cstring; transb: cstring; m: ptr cint; n: ptr cint; k: ptr cint;
            alpha: ptr cfloat; a: ptr cfloat; lda: ptr cint; b: ptr cfloat; ldb: ptr cint;
            beta: ptr cfloat; c: ptr cfloat; ldc: ptr cint) {.cdecl, importc: "sgemm_",
    dynlib: libName.}
proc dgemmUnderScore*(transa: cstring; transb: cstring; m: ptr cint; n: ptr cint; k: ptr cint;
            alpha: ptr cdouble; a: ptr cdouble; lda: ptr cint; b: ptr cdouble;
            ldb: ptr cint; beta: ptr cdouble; c: ptr cdouble; ldc: ptr cint) {.cdecl,
    importc: "dgemm_", dynlib: libName.}
proc cgemmUnderScore*(transa: cstring; transb: cstring; m: ptr cint; n: ptr cint; k: ptr cint;
            alpha: ptr cuComplex; a: ptr cuComplex; lda: ptr cint; b: ptr cuComplex;
            ldb: ptr cint; beta: ptr cuComplex; c: ptr cuComplex; ldc: ptr cint) {.cdecl,
    importc: "cgemm_", dynlib: libName.}
proc zgemmUnderScore*(transa: cstring; transb: cstring; m: ptr cint; n: ptr cint; k: ptr cint;
            alpha: ptr cuDoubleComplex; a: ptr cuDoubleComplex; lda: ptr cint;
            b: ptr cuDoubleComplex; ldb: ptr cint; beta: ptr cuDoubleComplex;
            c: ptr cuDoubleComplex; ldc: ptr cint) {.cdecl, importc: "zgemm_",
    dynlib: libName.}
proc sgemm*(transa: cstring; transb: cstring; m: ptr cint; n: ptr cint; k: ptr cint;
           alpha: ptr cfloat; a: ptr cfloat; lda: ptr cint; b: ptr cfloat; ldb: ptr cint;
           beta: ptr cfloat; c: ptr cfloat; ldc: ptr cint) {.cdecl, importc: "sgemm",
    dynlib: libName.}
proc dgemm*(transa: cstring; transb: cstring; m: ptr cint; n: ptr cint; k: ptr cint;
           alpha: ptr cdouble; a: ptr cdouble; lda: ptr cint; b: ptr cdouble; ldb: ptr cint;
           beta: ptr cdouble; c: ptr cdouble; ldc: ptr cint) {.cdecl, importc: "dgemm",
    dynlib: libName.}
proc cgemm*(transa: cstring; transb: cstring; m: ptr cint; n: ptr cint; k: ptr cint;
           alpha: ptr cuComplex; a: ptr cuComplex; lda: ptr cint; b: ptr cuComplex;
           ldb: ptr cint; beta: ptr cuComplex; c: ptr cuComplex; ldc: ptr cint) {.cdecl,
    importc: "cgemm", dynlib: libName.}
proc zgemm*(transa: cstring; transb: cstring; m: ptr cint; n: ptr cint; k: ptr cint;
           alpha: ptr cuDoubleComplex; a: ptr cuDoubleComplex; lda: ptr cint;
           b: ptr cuDoubleComplex; ldb: ptr cint; beta: ptr cuDoubleComplex;
           c: ptr cuDoubleComplex; ldc: ptr cint) {.cdecl, importc: "zgemm",
    dynlib: libName.}
##  SYRK

proc ssyrkUnderScore*(uplo: cstring; trans: cstring; n: ptr cint; k: ptr cint; alpha: ptr cfloat;
            a: ptr cfloat; lda: ptr cint; beta: ptr cfloat; c: ptr cfloat; ldc: ptr cint) {.
    cdecl, importc: "ssyrk_", dynlib: libName.}
proc dsyrkUnderScore*(uplo: cstring; trans: cstring; n: ptr cint; k: ptr cint; alpha: ptr cdouble;
            a: ptr cdouble; lda: ptr cint; beta: ptr cdouble; c: ptr cdouble; ldc: ptr cint) {.
    cdecl, importc: "dsyrk_", dynlib: libName.}
proc csyrkUnderScore*(uplo: cstring; trans: cstring; n: ptr cint; k: ptr cint; alpha: ptr cuComplex;
            a: ptr cuComplex; lda: ptr cint; beta: ptr cuComplex; c: ptr cuComplex;
            ldc: ptr cint) {.cdecl, importc: "csyrk_", dynlib: libName.}
proc zsyrkUnderScore*(uplo: cstring; trans: cstring; n: ptr cint; k: ptr cint;
            alpha: ptr cuDoubleComplex; a: ptr cuDoubleComplex; lda: ptr cint;
            beta: ptr cuDoubleComplex; c: ptr cuDoubleComplex; ldc: ptr cint) {.cdecl,
    importc: "zsyrk_", dynlib: libName.}
proc ssyrk*(uplo: cstring; trans: cstring; n: ptr cint; k: ptr cint; alpha: ptr cfloat;
           a: ptr cfloat; lda: ptr cint; beta: ptr cfloat; c: ptr cfloat; ldc: ptr cint) {.
    cdecl, importc: "ssyrk", dynlib: libName.}
proc dsyrk*(uplo: cstring; trans: cstring; n: ptr cint; k: ptr cint; alpha: ptr cdouble;
           a: ptr cdouble; lda: ptr cint; beta: ptr cdouble; c: ptr cdouble; ldc: ptr cint) {.
    cdecl, importc: "dsyrk", dynlib: libName.}
proc csyrk*(uplo: cstring; trans: cstring; n: ptr cint; k: ptr cint; alpha: ptr cuComplex;
           a: ptr cuComplex; lda: ptr cint; beta: ptr cuComplex; c: ptr cuComplex;
           ldc: ptr cint) {.cdecl, importc: "csyrk", dynlib: libName.}
proc zsyrk*(uplo: cstring; trans: cstring; n: ptr cint; k: ptr cint;
           alpha: ptr cuDoubleComplex; a: ptr cuDoubleComplex; lda: ptr cint;
           beta: ptr cuDoubleComplex; c: ptr cuDoubleComplex; ldc: ptr cint) {.cdecl,
    importc: "zsyrk", dynlib: libName.}
##  HERK

proc cherkUnderScore*(uplo: cstring; trans: cstring; n: ptr cint; k: ptr cint; alpha: ptr cfloat;
            a: ptr cuComplex; lda: ptr cint; beta: ptr cfloat; c: ptr cuComplex;
            ldc: ptr cint) {.cdecl, importc: "cherk_", dynlib: libName.}
proc zherkUnderScore*(uplo: cstring; trans: cstring; n: ptr cint; k: ptr cint; alpha: ptr cdouble;
            a: ptr cuDoubleComplex; lda: ptr cint; beta: ptr cdouble;
            c: ptr cuDoubleComplex; ldc: ptr cint) {.cdecl, importc: "zherk_",
    dynlib: libName.}
proc cherk*(uplo: cstring; trans: cstring; n: ptr cint; k: ptr cint; alpha: ptr cfloat;
           a: ptr cuComplex; lda: ptr cint; beta: ptr cfloat; c: ptr cuComplex;
           ldc: ptr cint) {.cdecl, importc: "cherk", dynlib: libName.}
proc zherk*(uplo: cstring; trans: cstring; n: ptr cint; k: ptr cint; alpha: ptr cdouble;
           a: ptr cuDoubleComplex; lda: ptr cint; beta: ptr cdouble;
           c: ptr cuDoubleComplex; ldc: ptr cint) {.cdecl, importc: "zherk",
    dynlib: libName.}
##  TRSM

proc strsmUnderScore*(side: cstring; uplo: cstring; transa: cstring; diag: cstring; m: ptr cint;
            n: ptr cint; alpha: ptr cfloat; a: ptr cfloat; lda: ptr cint; b: ptr cfloat;
            ldb: ptr cint) {.cdecl, importc: "strsm_", dynlib: libName.}
proc dtrsmUnderScore*(side: cstring; uplo: cstring; transa: cstring; diag: cstring; m: ptr cint;
            n: ptr cint; alpha: ptr cdouble; a: ptr cdouble; lda: ptr cint; b: ptr cdouble;
            ldb: ptr cint) {.cdecl, importc: "dtrsm_", dynlib: libName.}
proc ctrsmUnderScore*(side: cstring; uplo: cstring; transa: cstring; diag: cstring; m: ptr cint;
            n: ptr cint; alpha: ptr cuComplex; a: ptr cuComplex; lda: ptr cint;
            b: ptr cuComplex; ldb: ptr cint) {.cdecl, importc: "ctrsm_", dynlib: libName.}
proc ztrsmUnderScore*(side: cstring; uplo: cstring; transa: cstring; diag: cstring; m: ptr cint;
            n: ptr cint; alpha: ptr cuDoubleComplex; a: ptr cuDoubleComplex;
            lda: ptr cint; b: ptr cuDoubleComplex; ldb: ptr cint) {.cdecl,
    importc: "ztrsm_", dynlib: libName.}
proc strsm*(side: cstring; uplo: cstring; transa: cstring; diag: cstring; m: ptr cint;
           n: ptr cint; alpha: ptr cfloat; a: ptr cfloat; lda: ptr cint; b: ptr cfloat;
           ldb: ptr cint) {.cdecl, importc: "strsm", dynlib: libName.}
proc dtrsm*(side: cstring; uplo: cstring; transa: cstring; diag: cstring; m: ptr cint;
           n: ptr cint; alpha: ptr cdouble; a: ptr cdouble; lda: ptr cint; b: ptr cdouble;
           ldb: ptr cint) {.cdecl, importc: "dtrsm", dynlib: libName.}
proc ctrsm*(side: cstring; uplo: cstring; transa: cstring; diag: cstring; m: ptr cint;
           n: ptr cint; alpha: ptr cuComplex; a: ptr cuComplex; lda: ptr cint;
           b: ptr cuComplex; ldb: ptr cint) {.cdecl, importc: "ctrsm", dynlib: libName.}
proc ztrsm*(side: cstring; uplo: cstring; transa: cstring; diag: cstring; m: ptr cint;
           n: ptr cint; alpha: ptr cuDoubleComplex; a: ptr cuDoubleComplex;
           lda: ptr cint; b: ptr cuDoubleComplex; ldb: ptr cint) {.cdecl,
    importc: "ztrsm", dynlib: libName.}
##  SYMM

proc ssymmUnderScore*(side: cstring; uplo: cstring; m: ptr cint; n: ptr cint; alpha: ptr cfloat;
            a: ptr cfloat; lda: ptr cint; b: ptr cfloat; ldb: ptr cint; beta: ptr cfloat;
            c: ptr cfloat; ldc: ptr cint) {.cdecl, importc: "ssymm_", dynlib: libName.}
proc dsymmUnderScore*(side: cstring; uplo: cstring; m: ptr cint; n: ptr cint; alpha: ptr cdouble;
            a: ptr cdouble; lda: ptr cint; b: ptr cdouble; ldb: ptr cint; beta: ptr cdouble;
            c: ptr cdouble; ldc: ptr cint) {.cdecl, importc: "dsymm_", dynlib: libName.}
proc csymmUnderScore*(side: cstring; uplo: cstring; m: ptr cint; n: ptr cint; alpha: ptr cuComplex;
            a: ptr cuComplex; lda: ptr cint; b: ptr cuComplex; ldb: ptr cint;
            beta: ptr cuComplex; c: ptr cuComplex; ldc: ptr cint) {.cdecl,
    importc: "csymm_", dynlib: libName.}
proc zsymmUnderScore*(side: cstring; uplo: cstring; m: ptr cint; n: ptr cint;
            alpha: ptr cuDoubleComplex; a: ptr cuDoubleComplex; lda: ptr cint;
            b: ptr cuDoubleComplex; ldb: ptr cint; beta: ptr cuDoubleComplex;
            c: ptr cuDoubleComplex; ldc: ptr cint) {.cdecl, importc: "zsymm_",
    dynlib: libName.}
proc ssymm*(side: cstring; uplo: cstring; m: ptr cint; n: ptr cint; alpha: ptr cfloat;
           a: ptr cfloat; lda: ptr cint; b: ptr cfloat; ldb: ptr cint; beta: ptr cfloat;
           c: ptr cfloat; ldc: ptr cint) {.cdecl, importc: "ssymm", dynlib: libName.}
proc dsymm*(side: cstring; uplo: cstring; m: ptr cint; n: ptr cint; alpha: ptr cdouble;
           a: ptr cdouble; lda: ptr cint; b: ptr cdouble; ldb: ptr cint; beta: ptr cdouble;
           c: ptr cdouble; ldc: ptr cint) {.cdecl, importc: "dsymm", dynlib: libName.}
proc csymm*(side: cstring; uplo: cstring; m: ptr cint; n: ptr cint; alpha: ptr cuComplex;
           a: ptr cuComplex; lda: ptr cint; b: ptr cuComplex; ldb: ptr cint;
           beta: ptr cuComplex; c: ptr cuComplex; ldc: ptr cint) {.cdecl,
    importc: "csymm", dynlib: libName.}
proc zsymm*(side: cstring; uplo: cstring; m: ptr cint; n: ptr cint;
           alpha: ptr cuDoubleComplex; a: ptr cuDoubleComplex; lda: ptr cint;
           b: ptr cuDoubleComplex; ldb: ptr cint; beta: ptr cuDoubleComplex;
           c: ptr cuDoubleComplex; ldc: ptr cint) {.cdecl, importc: "zsymm",
    dynlib: libName.}
##  HEMM

proc chemmUnderScore*(side: cstring; uplo: cstring; m: ptr cint; n: ptr cint; alpha: ptr cuComplex;
            a: ptr cuComplex; lda: ptr cint; b: ptr cuComplex; ldb: ptr cint;
            beta: ptr cuComplex; c: ptr cuComplex; ldc: ptr cint) {.cdecl,
    importc: "chemm_", dynlib: libName.}
proc zhemmUnderScore*(side: cstring; uplo: cstring; m: ptr cint; n: ptr cint;
            alpha: ptr cuDoubleComplex; a: ptr cuDoubleComplex; lda: ptr cint;
            b: ptr cuDoubleComplex; ldb: ptr cint; beta: ptr cuDoubleComplex;
            c: ptr cuDoubleComplex; ldc: ptr cint) {.cdecl, importc: "zhemm_",
    dynlib: libName.}
##  HEMM with no underscore

proc chemm*(side: cstring; uplo: cstring; m: ptr cint; n: ptr cint; alpha: ptr cuComplex;
           a: ptr cuComplex; lda: ptr cint; b: ptr cuComplex; ldb: ptr cint;
           beta: ptr cuComplex; c: ptr cuComplex; ldc: ptr cint) {.cdecl,
    importc: "chemm", dynlib: libName.}
proc zhemm*(side: cstring; uplo: cstring; m: ptr cint; n: ptr cint;
           alpha: ptr cuDoubleComplex; a: ptr cuDoubleComplex; lda: ptr cint;
           b: ptr cuDoubleComplex; ldb: ptr cint; beta: ptr cuDoubleComplex;
           c: ptr cuDoubleComplex; ldc: ptr cint) {.cdecl, importc: "zhemm",
    dynlib: libName.}
##  SYR2K

proc ssyr2kUnderScore*(uplo: cstring; trans: cstring; n: ptr cint; k: ptr cint; alpha: ptr cfloat;
             a: ptr cfloat; lda: ptr cint; b: ptr cfloat; ldb: ptr cint; beta: ptr cfloat;
             c: ptr cfloat; ldc: ptr cint) {.cdecl, importc: "ssyr2k_", dynlib: libName.}
proc dsyr2kUnderScore*(uplo: cstring; trans: cstring; n: ptr cint; k: ptr cint; alpha: ptr cdouble;
             a: ptr cdouble; lda: ptr cint; b: ptr cdouble; ldb: ptr cint;
             beta: ptr cdouble; c: ptr cdouble; ldc: ptr cint) {.cdecl,
    importc: "dsyr2k_", dynlib: libName.}
proc csyr2kUnderScore*(uplo: cstring; trans: cstring; n: ptr cint; k: ptr cint;
             alpha: ptr cuComplex; a: ptr cuComplex; lda: ptr cint; b: ptr cuComplex;
             ldb: ptr cint; beta: ptr cuComplex; c: ptr cuComplex; ldc: ptr cint) {.cdecl,
    importc: "csyr2k_", dynlib: libName.}
proc zsyr2kUnderScore*(uplo: cstring; trans: cstring; n: ptr cint; k: ptr cint;
             alpha: ptr cuDoubleComplex; a: ptr cuDoubleComplex; lda: ptr cint;
             b: ptr cuDoubleComplex; ldb: ptr cint; beta: ptr cuDoubleComplex;
             c: ptr cuDoubleComplex; ldc: ptr cint) {.cdecl, importc: "zsyr2k_",
    dynlib: libName.}
##  SYR2K no_underscore

proc ssyr2k*(uplo: cstring; trans: cstring; n: ptr cint; k: ptr cint; alpha: ptr cfloat;
            a: ptr cfloat; lda: ptr cint; b: ptr cfloat; ldb: ptr cint; beta: ptr cfloat;
            c: ptr cfloat; ldc: ptr cint) {.cdecl, importc: "ssyr2k", dynlib: libName.}
proc dsyr2k*(uplo: cstring; trans: cstring; n: ptr cint; k: ptr cint; alpha: ptr cdouble;
            a: ptr cdouble; lda: ptr cint; b: ptr cdouble; ldb: ptr cint; beta: ptr cdouble;
            c: ptr cdouble; ldc: ptr cint) {.cdecl, importc: "dsyr2k", dynlib: libName.}
proc csyr2k*(uplo: cstring; trans: cstring; n: ptr cint; k: ptr cint; alpha: ptr cuComplex;
            a: ptr cuComplex; lda: ptr cint; b: ptr cuComplex; ldb: ptr cint;
            beta: ptr cuComplex; c: ptr cuComplex; ldc: ptr cint) {.cdecl,
    importc: "csyr2k", dynlib: libName.}
proc zsyr2k*(uplo: cstring; trans: cstring; n: ptr cint; k: ptr cint;
            alpha: ptr cuDoubleComplex; a: ptr cuDoubleComplex; lda: ptr cint;
            b: ptr cuDoubleComplex; ldb: ptr cint; beta: ptr cuDoubleComplex;
            c: ptr cuDoubleComplex; ldc: ptr cint) {.cdecl, importc: "zsyr2k",
    dynlib: libName.}
##  HERK

proc cher2kUnderScore*(uplo: cstring; trans: cstring; n: ptr cint; k: ptr cint;
             alpha: ptr cuComplex; a: ptr cuComplex; lda: ptr cint; b: ptr cuComplex;
             ldb: ptr cint; beta: ptr cfloat; c: ptr cuComplex; ldc: ptr cint) {.cdecl,
    importc: "cher2k_", dynlib: libName.}
proc zher2kUnderScore*(uplo: cstring; trans: cstring; n: ptr cint; k: ptr cint;
             alpha: ptr cuDoubleComplex; a: ptr cuDoubleComplex; lda: ptr cint;
             b: ptr cuDoubleComplex; ldb: ptr cint; beta: ptr cdouble;
             c: ptr cuDoubleComplex; ldc: ptr cint) {.cdecl, importc: "zher2k_",
    dynlib: libName.}
##  HER2K with no underscore

proc cher2k*(uplo: cstring; trans: cstring; n: ptr cint; k: ptr cint; alpha: ptr cuComplex;
            a: ptr cuComplex; lda: ptr cint; b: ptr cuComplex; ldb: ptr cint;
            beta: ptr cfloat; c: ptr cuComplex; ldc: ptr cint) {.cdecl, importc: "cher2k",
    dynlib: libName.}
proc zher2k*(uplo: cstring; trans: cstring; n: ptr cint; k: ptr cint;
            alpha: ptr cuDoubleComplex; a: ptr cuDoubleComplex; lda: ptr cint;
            b: ptr cuDoubleComplex; ldb: ptr cint; beta: ptr cdouble;
            c: ptr cuDoubleComplex; ldc: ptr cint) {.cdecl, importc: "zher2k",
    dynlib: libName.}
##  TRMM

proc strmmUnderScore*(side: cstring; uplo: cstring; transa: cstring; diag: cstring; m: ptr cint;
            n: ptr cint; alpha: ptr cfloat; a: ptr cfloat; lda: ptr cint; b: ptr cfloat;
            ldb: ptr cint) {.cdecl, importc: "strmm_", dynlib: libName.}
proc dtrmmUnderScore*(side: cstring; uplo: cstring; transa: cstring; diag: cstring; m: ptr cint;
            n: ptr cint; alpha: ptr cdouble; a: ptr cdouble; lda: ptr cint; b: ptr cdouble;
            ldb: ptr cint) {.cdecl, importc: "dtrmm_", dynlib: libName.}
proc ctrmmUnderScore*(side: cstring; uplo: cstring; transa: cstring; diag: cstring; m: ptr cint;
            n: ptr cint; alpha: ptr cuComplex; a: ptr cuComplex; lda: ptr cint;
            b: ptr cuComplex; ldb: ptr cint) {.cdecl, importc: "ctrmm_", dynlib: libName.}
proc ztrmmUnderScore*(side: cstring; uplo: cstring; transa: cstring; diag: cstring; m: ptr cint;
            n: ptr cint; alpha: ptr cuDoubleComplex; a: ptr cuDoubleComplex;
            lda: ptr cint; b: ptr cuDoubleComplex; ldb: ptr cint) {.cdecl,
    importc: "ztrmm_", dynlib: libName.}
proc strmm*(side: cstring; uplo: cstring; transa: cstring; diag: cstring; m: ptr cint;
           n: ptr cint; alpha: ptr cfloat; a: ptr cfloat; lda: ptr cint; b: ptr cfloat;
           ldb: ptr cint) {.cdecl, importc: "strmm", dynlib: libName.}
proc dtrmm*(side: cstring; uplo: cstring; transa: cstring; diag: cstring; m: ptr cint;
           n: ptr cint; alpha: ptr cdouble; a: ptr cdouble; lda: ptr cint; b: ptr cdouble;
           ldb: ptr cint) {.cdecl, importc: "dtrmm", dynlib: libName.}
proc ctrmm*(side: cstring; uplo: cstring; transa: cstring; diag: cstring; m: ptr cint;
           n: ptr cint; alpha: ptr cuComplex; a: ptr cuComplex; lda: ptr cint;
           b: ptr cuComplex; ldb: ptr cint) {.cdecl, importc: "ctrmm", dynlib: libName.}
proc ztrmm*(side: cstring; uplo: cstring; transa: cstring; diag: cstring; m: ptr cint;
           n: ptr cint; alpha: ptr cuDoubleComplex; a: ptr cuDoubleComplex;
           lda: ptr cint; b: ptr cuDoubleComplex; ldb: ptr cint) {.cdecl,
    importc: "ztrmm", dynlib: libName.}
