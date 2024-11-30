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
##
##  This is the public header file for the new CUBLAS library API, it mapped the generic
##  Cublas name functions to the actual _v2 implementations.
##

import ./libpaths
tellCompilerToUseCuda()

when defined(CUBLAS_H):
  discard
import
  cublas_api

const
  cublasCreate* = cublasCreate_v2
  cublasDestroy* = cublasDestroy_v2
  cublasGetVersion* = cublasGetVersion_v2
  cublasSetWorkspace* = cublasSetWorkspace_v2
  cublasSetStream* = cublasSetStream_v2
  cublasGetStream* = cublasGetStream_v2
  cublasGetPointerMode* = cublasGetPointerMode_v2
  cublasSetPointerMode* = cublasSetPointerMode_v2

##  32-bit integer
##  Blas1 Routines

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

##  64-bit integer
##  Blas1 Routines

const
  cublasSnrm2_64* = cublasSnrm2_v2_64
  cublasDnrm2_64* = cublasDnrm2_v2_64
  cublasScnrm2_64* = cublasScnrm2_v2_64
  cublasDznrm2_64* = cublasDznrm2_v2_64
  cublasSdot_64* = cublasSdot_v2_64
  cublasDdot_64* = cublasDdot_v2_64
  cublasCdotu_64* = cublasCdotu_v2_64
  cublasCdotc_64* = cublasCdotc_v2_64
  cublasZdotu_64* = cublasZdotu_v2_64
  cublasZdotc_64* = cublasZdotc_v2_64
  cublasSscal_64* = cublasSscal_v2_64
  cublasDscal_64* = cublasDscal_v2_64
  cublasCscal_64* = cublasCscal_v2_64
  cublasCsscal_64* = cublasCsscal_v2_64
  cublasZscal_64* = cublasZscal_v2_64
  cublasZdscal_64* = cublasZdscal_v2_64
  cublasSaxpy_64* = cublasSaxpy_v2_64
  cublasDaxpy_64* = cublasDaxpy_v2_64
  cublasCaxpy_64* = cublasCaxpy_v2_64
  cublasZaxpy_64* = cublasZaxpy_v2_64
  cublasScopy_64* = cublasScopy_v2_64
  cublasDcopy_64* = cublasDcopy_v2_64
  cublasCcopy_64* = cublasCcopy_v2_64
  cublasZcopy_64* = cublasZcopy_v2_64
  cublasSswap_64* = cublasSswap_v2_64
  cublasDswap_64* = cublasDswap_v2_64
  cublasCswap_64* = cublasCswap_v2_64
  cublasZswap_64* = cublasZswap_v2_64
  cublasIsamax_64* = cublasIsamax_v2_64
  cublasIdamax_64* = cublasIdamax_v2_64
  cublasIcamax_64* = cublasIcamax_v2_64
  cublasIzamax_64* = cublasIzamax_v2_64
  cublasIsamin_64* = cublasIsamin_v2_64
  cublasIdamin_64* = cublasIdamin_v2_64
  cublasIcamin_64* = cublasIcamin_v2_64
  cublasIzamin_64* = cublasIzamin_v2_64
  cublasSasum_64* = cublasSasum_v2_64
  cublasDasum_64* = cublasDasum_v2_64
  cublasScasum_64* = cublasScasum_v2_64
  cublasDzasum_64* = cublasDzasum_v2_64
  cublasSrot_64* = cublasSrot_v2_64
  cublasDrot_64* = cublasDrot_v2_64
  cublasCrot_64* = cublasCrot_v2_64
  cublasCsrot_64* = cublasCsrot_v2_64
  cublasZrot_64* = cublasZrot_v2_64
  cublasZdrot_64* = cublasZdrot_v2_64
  # cublasSrotg_64* = cublasSrotg_v2_64
  # cublasDrotg_64* = cublasDrotg_v2_64
  # cublasCrotg_64* = cublasCrotg_v2_64
  # cublasZrotg_64* = cublasZrotg_v2_64
  cublasSrotm_64* = cublasSrotm_v2_64
  cublasDrotm_64* = cublasDrotm_v2_64
  # cublasSrotmg_64* = cublasSrotmg_v2_64
  # cublasDrotmg_64* = cublasDrotmg_v2_64

##  Blas2 Routines

const
  cublasSgemv_64* = cublasSgemv_v2_64
  cublasDgemv_64* = cublasDgemv_v2_64
  cublasCgemv_64* = cublasCgemv_v2_64
  cublasZgemv_64* = cublasZgemv_v2_64
  cublasSgbmv_64* = cublasSgbmv_v2_64
  cublasDgbmv_64* = cublasDgbmv_v2_64
  cublasCgbmv_64* = cublasCgbmv_v2_64
  cublasZgbmv_64* = cublasZgbmv_v2_64
  cublasStrmv_64* = cublasStrmv_v2_64
  cublasDtrmv_64* = cublasDtrmv_v2_64
  cublasCtrmv_64* = cublasCtrmv_v2_64
  cublasZtrmv_64* = cublasZtrmv_v2_64
  cublasStbmv_64* = cublasStbmv_v2_64
  cublasDtbmv_64* = cublasDtbmv_v2_64
  cublasCtbmv_64* = cublasCtbmv_v2_64
  cublasZtbmv_64* = cublasZtbmv_v2_64
  cublasStpmv_64* = cublasStpmv_v2_64
  cublasDtpmv_64* = cublasDtpmv_v2_64
  cublasCtpmv_64* = cublasCtpmv_v2_64
  cublasZtpmv_64* = cublasZtpmv_v2_64
  cublasStrsv_64* = cublasStrsv_v2_64
  cublasDtrsv_64* = cublasDtrsv_v2_64
  cublasCtrsv_64* = cublasCtrsv_v2_64
  cublasZtrsv_64* = cublasZtrsv_v2_64
  cublasStpsv_64* = cublasStpsv_v2_64
  cublasDtpsv_64* = cublasDtpsv_v2_64
  cublasCtpsv_64* = cublasCtpsv_v2_64
  cublasZtpsv_64* = cublasZtpsv_v2_64
  cublasStbsv_64* = cublasStbsv_v2_64
  cublasDtbsv_64* = cublasDtbsv_v2_64
  cublasCtbsv_64* = cublasCtbsv_v2_64
  cublasZtbsv_64* = cublasZtbsv_v2_64
  cublasSsymv_64* = cublasSsymv_v2_64
  cublasDsymv_64* = cublasDsymv_v2_64
  cublasCsymv_64* = cublasCsymv_v2_64
  cublasZsymv_64* = cublasZsymv_v2_64
  cublasChemv_64* = cublasChemv_v2_64
  cublasZhemv_64* = cublasZhemv_v2_64
  cublasSsbmv_64* = cublasSsbmv_v2_64
  cublasDsbmv_64* = cublasDsbmv_v2_64
  cublasChbmv_64* = cublasChbmv_v2_64
  cublasZhbmv_64* = cublasZhbmv_v2_64
  cublasSspmv_64* = cublasSspmv_v2_64
  cublasDspmv_64* = cublasDspmv_v2_64
  cublasChpmv_64* = cublasChpmv_v2_64
  cublasZhpmv_64* = cublasZhpmv_v2_64
  cublasSger_64* = cublasSger_v2_64
  cublasDger_64* = cublasDger_v2_64
  cublasCgeru_64* = cublasCgeru_v2_64
  cublasCgerc_64* = cublasCgerc_v2_64
  cublasZgeru_64* = cublasZgeru_v2_64
  cublasZgerc_64* = cublasZgerc_v2_64
  cublasSsyr_64* = cublasSsyr_v2_64
  cublasDsyr_64* = cublasDsyr_v2_64
  cublasCsyr_64* = cublasCsyr_v2_64
  cublasZsyr_64* = cublasZsyr_v2_64
  cublasCher_64* = cublasCher_v2_64
  cublasZher_64* = cublasZher_v2_64
  cublasSspr_64* = cublasSspr_v2_64
  cublasDspr_64* = cublasDspr_v2_64
  cublasChpr_64* = cublasChpr_v2_64
  cublasZhpr_64* = cublasZhpr_v2_64
  cublasSsyr2_64* = cublasSsyr2_v2_64
  cublasDsyr2_64* = cublasDsyr2_v2_64
  cublasCsyr2_64* = cublasCsyr2_v2_64
  cublasZsyr2_64* = cublasZsyr2_v2_64
  cublasCher2_64* = cublasCher2_v2_64
  cublasZher2_64* = cublasZher2_v2_64
  cublasSspr2_64* = cublasSspr2_v2_64
  cublasDspr2_64* = cublasDspr2_v2_64
  cublasChpr2_64* = cublasChpr2_v2_64
  cublasZhpr2_64* = cublasZhpr2_v2_64

##  Blas3 Routines

const
  cublasSgemm_64* = cublasSgemm_v2_64
  cublasDgemm_64* = cublasDgemm_v2_64
  cublasCgemm_64* = cublasCgemm_v2_64
  cublasZgemm_64* = cublasZgemm_v2_64
  cublasSsyrk_64* = cublasSsyrk_v2_64
  cublasDsyrk_64* = cublasDsyrk_v2_64
  cublasCsyrk_64* = cublasCsyrk_v2_64
  cublasZsyrk_64* = cublasZsyrk_v2_64
  cublasCherk_64* = cublasCherk_v2_64
  cublasZherk_64* = cublasZherk_v2_64
  cublasSsyr2k_64* = cublasSsyr2k_v2_64
  cublasDsyr2k_64* = cublasDsyr2k_v2_64
  cublasCsyr2k_64* = cublasCsyr2k_v2_64
  cublasZsyr2k_64* = cublasZsyr2k_v2_64
  cublasCher2k_64* = cublasCher2k_v2_64
  cublasZher2k_64* = cublasZher2k_v2_64
  cublasSsymm_64* = cublasSsymm_v2_64
  cublasDsymm_64* = cublasDsymm_v2_64
  cublasCsymm_64* = cublasCsymm_v2_64
  cublasZsymm_64* = cublasZsymm_v2_64
  cublasChemm_64* = cublasChemm_v2_64
  cublasZhemm_64* = cublasZhemm_v2_64
  cublasStrsm_64* = cublasStrsm_v2_64
  cublasDtrsm_64* = cublasDtrsm_v2_64
  cublasCtrsm_64* = cublasCtrsm_v2_64
  cublasZtrsm_64* = cublasZtrsm_v2_64
  cublasStrmm_64* = cublasStrmm_v2_64
  cublasDtrmm_64* = cublasDtrmm_v2_64
  cublasCtrmm_64* = cublasCtrmm_v2_64
  cublasZtrmm_64* = cublasZtrmm_v2_64
