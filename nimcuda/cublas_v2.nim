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
## 
##  This is the public header file for the new CUBLAS library API, it mapped the generic 
##  Cublas name functions to the actual _v2 implementations.
## 

when not defined(CUBLAS_V2_H):
  const
    CUBLAS_V2_H* = true
  import
    cublas_api

  const
    cublasCreate* = cublasCreate_v2
    cublasDestroy* = cublasDestroy_v2
    cublasGetVersion* = cublasGetVersion_v2
    cublasSetStream* = cublasSetStream_v2
    cublasGetStream* = cublasGetStream_v2
    cublasGetPointerMode* = cublasGetPointerMode_v2
    cublasSetPointerMode* = cublasSetPointerMode_v2
  ##  Blas3 Routines
  const
    cublasSnrm2* = cublasSnrm2_v2
    cublasDnrm2* = cublasDnrm2_v2
    cublasScnrm2* = cublasScnrm2_v2
    cublasDznrm2* = cublasDznrm2_v2
    cublasSdot* = cublasSdot_v2
    cublasDdot* = cublasDdot_v2
    cublasCdotu* = cublasCdotu_v2
    cublasCdotc* = cublasCdotc_v2
    cublasZdotu* = cublasZdotu_v2
    cublasZdotc* = cublasZdotc_v2
    cublasSscal* = cublasSscal_v2
    cublasDscal* = cublasDscal_v2
    cublasCscal* = cublasCscal_v2
    cublasCsscal* = cublasCsscal_v2
    cublasZscal* = cublasZscal_v2
    cublasZdscal* = cublasZdscal_v2
    cublasSaxpy* = cublasSaxpy_v2
    cublasDaxpy* = cublasDaxpy_v2
    cublasCaxpy* = cublasCaxpy_v2
    cublasZaxpy* = cublasZaxpy_v2
    cublasScopy* = cublasScopy_v2
    cublasDcopy* = cublasDcopy_v2
    cublasCcopy* = cublasCcopy_v2
    cublasZcopy* = cublasZcopy_v2
    cublasSswap* = cublasSswap_v2
    cublasDswap* = cublasDswap_v2
    cublasCswap* = cublasCswap_v2
    cublasZswap* = cublasZswap_v2
    cublasIsamax* = cublasIsamax_v2
    cublasIdamax* = cublasIdamax_v2
    cublasIcamax* = cublasIcamax_v2
    cublasIzamax* = cublasIzamax_v2
    cublasIsamin* = cublasIsamin_v2
    cublasIdamin* = cublasIdamin_v2
    cublasIcamin* = cublasIcamin_v2
    cublasIzamin* = cublasIzamin_v2
    cublasSasum* = cublasSasum_v2
    cublasDasum* = cublasDasum_v2
    cublasScasum* = cublasScasum_v2
    cublasDzasum* = cublasDzasum_v2
    cublasSrot* = cublasSrot_v2
    cublasDrot* = cublasDrot_v2
    cublasCrot* = cublasCrot_v2
    cublasCsrot* = cublasCsrot_v2
    cublasZrot* = cublasZrot_v2
    cublasZdrot* = cublasZdrot_v2
    cublasSrotg* = cublasSrotg_v2
    cublasDrotg* = cublasDrotg_v2
    cublasCrotg* = cublasCrotg_v2
    cublasZrotg* = cublasZrotg_v2
    cublasSrotm* = cublasSrotm_v2
    cublasDrotm* = cublasDrotm_v2
    cublasSrotmg* = cublasSrotmg_v2
    cublasDrotmg* = cublasDrotmg_v2
  ##  Blas2 Routines
  const
    cublasSgemv* = cublasSgemv_v2
    cublasDgemv* = cublasDgemv_v2
    cublasCgemv* = cublasCgemv_v2
    cublasZgemv* = cublasZgemv_v2
    cublasSgbmv* = cublasSgbmv_v2
    cublasDgbmv* = cublasDgbmv_v2
    cublasCgbmv* = cublasCgbmv_v2
    cublasZgbmv* = cublasZgbmv_v2
    cublasStrmv* = cublasStrmv_v2
    cublasDtrmv* = cublasDtrmv_v2
    cublasCtrmv* = cublasCtrmv_v2
    cublasZtrmv* = cublasZtrmv_v2
    cublasStbmv* = cublasStbmv_v2
    cublasDtbmv* = cublasDtbmv_v2
    cublasCtbmv* = cublasCtbmv_v2
    cublasZtbmv* = cublasZtbmv_v2
    cublasStpmv* = cublasStpmv_v2
    cublasDtpmv* = cublasDtpmv_v2
    cublasCtpmv* = cublasCtpmv_v2
    cublasZtpmv* = cublasZtpmv_v2
    cublasStrsv* = cublasStrsv_v2
    cublasDtrsv* = cublasDtrsv_v2
    cublasCtrsv* = cublasCtrsv_v2
    cublasZtrsv* = cublasZtrsv_v2
    cublasStpsv* = cublasStpsv_v2
    cublasDtpsv* = cublasDtpsv_v2
    cublasCtpsv* = cublasCtpsv_v2
    cublasZtpsv* = cublasZtpsv_v2
    cublasStbsv* = cublasStbsv_v2
    cublasDtbsv* = cublasDtbsv_v2
    cublasCtbsv* = cublasCtbsv_v2
    cublasZtbsv* = cublasZtbsv_v2
    cublasSsymv* = cublasSsymv_v2
    cublasDsymv* = cublasDsymv_v2
    cublasCsymv* = cublasCsymv_v2
    cublasZsymv* = cublasZsymv_v2
    cublasChemv* = cublasChemv_v2
    cublasZhemv* = cublasZhemv_v2
    cublasSsbmv* = cublasSsbmv_v2
    cublasDsbmv* = cublasDsbmv_v2
    cublasChbmv* = cublasChbmv_v2
    cublasZhbmv* = cublasZhbmv_v2
    cublasSspmv* = cublasSspmv_v2
    cublasDspmv* = cublasDspmv_v2
    cublasChpmv* = cublasChpmv_v2
    cublasZhpmv* = cublasZhpmv_v2
    cublasSger* = cublasSger_v2
    cublasDger* = cublasDger_v2
    cublasCgeru* = cublasCgeru_v2
    cublasCgerc* = cublasCgerc_v2
    cublasZgeru* = cublasZgeru_v2
    cublasZgerc* = cublasZgerc_v2
    cublasSsyr* = cublasSsyr_v2
    cublasDsyr* = cublasDsyr_v2
    cublasCsyr* = cublasCsyr_v2
    cublasZsyr* = cublasZsyr_v2
    cublasCher* = cublasCher_v2
    cublasZher* = cublasZher_v2
    cublasSspr* = cublasSspr_v2
    cublasDspr* = cublasDspr_v2
    cublasChpr* = cublasChpr_v2
    cublasZhpr* = cublasZhpr_v2
    cublasSsyr2* = cublasSsyr2_v2
    cublasDsyr2* = cublasDsyr2_v2
    cublasCsyr2* = cublasCsyr2_v2
    cublasZsyr2* = cublasZsyr2_v2
    cublasCher2* = cublasCher2_v2
    cublasZher2* = cublasZher2_v2
    cublasSspr2* = cublasSspr2_v2
    cublasDspr2* = cublasDspr2_v2
    cublasChpr2* = cublasChpr2_v2
    cublasZhpr2* = cublasZhpr2_v2
  ##  Blas3 Routines
  const
    cublasSgemm* = cublasSgemm_v2
    cublasDgemm* = cublasDgemm_v2
    cublasCgemm* = cublasCgemm_v2
    cublasZgemm* = cublasZgemm_v2
    cublasSsyrk* = cublasSsyrk_v2
    cublasDsyrk* = cublasDsyrk_v2
    cublasCsyrk* = cublasCsyrk_v2
    cublasZsyrk* = cublasZsyrk_v2
    cublasCherk* = cublasCherk_v2
    cublasZherk* = cublasZherk_v2
    cublasSsyr2k* = cublasSsyr2k_v2
    cublasDsyr2k* = cublasDsyr2k_v2
    cublasCsyr2k* = cublasCsyr2k_v2
    cublasZsyr2k* = cublasZsyr2k_v2
    cublasCher2k* = cublasCher2k_v2
    cublasZher2k* = cublasZher2k_v2
    cublasSsymm* = cublasSsymm_v2
    cublasDsymm* = cublasDsymm_v2
    cublasCsymm* = cublasCsymm_v2
    cublasZsymm* = cublasZsymm_v2
    cublasChemm* = cublasChemm_v2
    cublasZhemm* = cublasZhemm_v2
    cublasStrsm* = cublasStrsm_v2
    cublasDtrsm* = cublasDtrsm_v2
    cublasCtrsm* = cublasCtrsm_v2
    cublasZtrsm* = cublasZtrsm_v2
    cublasStrmm* = cublasStrmm_v2
    cublasDtrmm* = cublasDtrmm_v2
    cublasCtrmm* = cublasCtrmm_v2
    cublasZtrmm* = cublasZtrmm_v2