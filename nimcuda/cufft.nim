when defined(windows):
  const
    libName = "cufft.dll"
elif defined(macosx):
  const
    libName = "libcufft.dylib"
else:
  const
    libName = "libcufft.so"
import
  cuComplex, library_types, driver_types

##  Copyright 2005-2021 NVIDIA Corporation.  All rights reserved.
##
##  NOTICE TO LICENSEE:
##
##  The source code and/or documentation ("Licensed Deliverables") are
##  subject to NVIDIA intellectual property rights under U.S. and
##  international Copyright laws.
##
##  The Licensed Deliverables contained herein are PROPRIETARY and
##  CONFIDENTIAL to NVIDIA and are being provided under the terms and
##  conditions of a form of NVIDIA software license agreement by and
##  between NVIDIA and Licensee ("License Agreement") or electronically
##  accepted by Licensee.  Notwithstanding any terms or conditions to
##  the contrary in the License Agreement, reproduction or disclosure
##  of the Licensed Deliverables to any third party without the express
##  written consent of NVIDIA is prohibited.
##
##  NOTWITHSTANDING ANY TERMS OR CONDITIONS TO THE CONTRARY IN THE
##  LICENSE AGREEMENT, NVIDIA MAKES NO REPRESENTATION ABOUT THE
##  SUITABILITY OF THESE LICENSED DELIVERABLES FOR ANY PURPOSE.  THEY ARE
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
##  C.F.R. 12.212 (SEPT 1995) and are provided to the U.S. Government
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
## !
##  \file cufft.h
##  \brief Public header file for the NVIDIA CUDA FFT library (CUFFT)
##

const
  CUFFT_VER_MAJOR* = 11
  CUFFT_VER_MINOR* = 2
  CUFFT_VER_PATCH* = 3
  CUFFT_VER_BUILD* = 61
  CUFFT_VERSION* = 11203

##  CUFFT API function return values

type
  cufftResult* {.size: sizeof(cint).} = enum
    CUFFT_SUCCESS = 0x0, CUFFT_INVALID_PLAN = 0x1, CUFFT_ALLOC_FAILED = 0x2,
    CUFFT_INVALID_TYPE = 0x3, CUFFT_INVALID_VALUE = 0x4, CUFFT_INTERNAL_ERROR = 0x5,
    CUFFT_EXEC_FAILED = 0x6, CUFFT_SETUP_FAILED = 0x7, CUFFT_INVALID_SIZE = 0x8,
    CUFFT_UNALIGNED_DATA = 0x9, CUFFT_INCOMPLETE_PARAMETER_LIST = 0xA,
    CUFFT_INVALID_DEVICE = 0xB, CUFFT_PARSE_ERROR = 0xC, CUFFT_NO_WORKSPACE = 0xD,
    CUFFT_NOT_IMPLEMENTED = 0xE, CUFFT_LICENSE_ERROR = 0x0F,
    CUFFT_NOT_SUPPORTED = 0x10


const
  MAX_CUFFT_ERROR* = 0x11

##  CUFFT defines and supports the following data types
##  cufftReal is a single-precision, floating-point real data type.
##  cufftDoubleReal is a double-precision, real data type.

type
  cufftReal* = cfloat
  cufftDoubleReal* = cdouble

##  cufftComplex is a single-precision, floating-point complex data type that
##  consists of interleaved real and imaginary components.
##  cufftDoubleComplex is the double-precision equivalent.

type
  cufftComplex* = cuComplex
  cufftDoubleComplex* = cuDoubleComplex

##  CUFFT transform directions

const
  CUFFT_FORWARD* = -1
  CUFFT_INVERSE* = 1

##  CUFFT supports the following transform types

type
  cufftType* {.size: sizeof(cint).} = enum
    CUFFT_C2C = 0x29,           ##  Complex to Complex, interleaved
    CUFFT_R2C = 0x2a,           ##  Real to Complex (interleaved)
    CUFFT_C2R = 0x2c,           ##  Complex (interleaved) to Real
    CUFFT_Z2Z = 0x69,           ##  Double-Complex to Double-Complex
    CUFFT_D2Z = 0x6a,           ##  Double to Double-Complex
    CUFFT_Z2D = 0x6c            ##  Double-Complex to Double


##  CUFFT supports the following data layouts

type
  cufftCompatibility* {.size: sizeof(cint).} = enum
    CUFFT_COMPATIBILITY_FFTW_PADDING = 0x01 ##  The default value


const
  CUFFT_COMPATIBILITY_DEFAULT* = CUFFT_COMPATIBILITY_FFTW_PADDING

##
##  structure definition used by the shim between old and new APIs
##

const
  MAX_SHIM_RANK* = 3

##  cufftHandle is a handle type used to store and access CUFFT plans.

type
  cufftHandle* = cint

proc cufftPlan1d*(plan: ptr cufftHandle; nx: cint; `type`: cufftType; batch: cint): cufftResult {.
    cdecl, importc: "cufftPlan1d", dynlib: libName.}
proc cufftPlan2d*(plan: ptr cufftHandle; nx: cint; ny: cint; `type`: cufftType): cufftResult {.
    cdecl, importc: "cufftPlan2d", dynlib: libName.}
proc cufftPlan3d*(plan: ptr cufftHandle; nx: cint; ny: cint; nz: cint; `type`: cufftType): cufftResult {.
    cdecl, importc: "cufftPlan3d", dynlib: libName.}
proc cufftPlanMany*(plan: ptr cufftHandle; rank: cint; n: ptr cint; inembed: ptr cint;
                   istride: cint; idist: cint; onembed: ptr cint; ostride: cint;
                   odist: cint; `type`: cufftType; batch: cint): cufftResult {.cdecl,
    importc: "cufftPlanMany", dynlib: libName.}
proc cufftMakePlan1d*(plan: cufftHandle; nx: cint; `type`: cufftType; batch: cint;
                     workSize: ptr csize_t): cufftResult {.cdecl,
    importc: "cufftMakePlan1d", dynlib: libName.}
proc cufftMakePlan2d*(plan: cufftHandle; nx: cint; ny: cint; `type`: cufftType;
                     workSize: ptr csize_t): cufftResult {.cdecl,
    importc: "cufftMakePlan2d", dynlib: libName.}
proc cufftMakePlan3d*(plan: cufftHandle; nx: cint; ny: cint; nz: cint; `type`: cufftType;
                     workSize: ptr csize_t): cufftResult {.cdecl,
    importc: "cufftMakePlan3d", dynlib: libName.}
proc cufftMakePlanMany*(plan: cufftHandle; rank: cint; n: ptr cint; inembed: ptr cint;
                       istride: cint; idist: cint; onembed: ptr cint; ostride: cint;
                       odist: cint; `type`: cufftType; batch: cint;
                       workSize: ptr csize_t): cufftResult {.cdecl,
    importc: "cufftMakePlanMany", dynlib: libName.}
proc cufftMakePlanMany64*(plan: cufftHandle; rank: cint; n: ptr clonglong;
                         inembed: ptr clonglong; istride: clonglong;
                         idist: clonglong; onembed: ptr clonglong;
                         ostride: clonglong; odist: clonglong; `type`: cufftType;
                         batch: clonglong; workSize: ptr csize_t): cufftResult {.
    cdecl, importc: "cufftMakePlanMany64", dynlib: libName.}
proc cufftGetSizeMany64*(plan: cufftHandle; rank: cint; n: ptr clonglong;
                        inembed: ptr clonglong; istride: clonglong; idist: clonglong;
                        onembed: ptr clonglong; ostride: clonglong; odist: clonglong;
                        `type`: cufftType; batch: clonglong; workSize: ptr csize_t): cufftResult {.
    cdecl, importc: "cufftGetSizeMany64", dynlib: libName.}
proc cufftEstimate1d*(nx: cint; `type`: cufftType; batch: cint; workSize: ptr csize_t): cufftResult {.
    cdecl, importc: "cufftEstimate1d", dynlib: libName.}
proc cufftEstimate2d*(nx: cint; ny: cint; `type`: cufftType; workSize: ptr csize_t): cufftResult {.
    cdecl, importc: "cufftEstimate2d", dynlib: libName.}
proc cufftEstimate3d*(nx: cint; ny: cint; nz: cint; `type`: cufftType;
                     workSize: ptr csize_t): cufftResult {.cdecl,
    importc: "cufftEstimate3d", dynlib: libName.}
proc cufftEstimateMany*(rank: cint; n: ptr cint; inembed: ptr cint; istride: cint;
                       idist: cint; onembed: ptr cint; ostride: cint; odist: cint;
                       `type`: cufftType; batch: cint; workSize: ptr csize_t): cufftResult {.
    cdecl, importc: "cufftEstimateMany", dynlib: libName.}
proc cufftCreate*(handle: ptr cufftHandle): cufftResult {.cdecl,
    importc: "cufftCreate", dynlib: libName.}
proc cufftGetSize1d*(handle: cufftHandle; nx: cint; `type`: cufftType; batch: cint;
                    workSize: ptr csize_t): cufftResult {.cdecl,
    importc: "cufftGetSize1d", dynlib: libName.}
proc cufftGetSize2d*(handle: cufftHandle; nx: cint; ny: cint; `type`: cufftType;
                    workSize: ptr csize_t): cufftResult {.cdecl,
    importc: "cufftGetSize2d", dynlib: libName.}
proc cufftGetSize3d*(handle: cufftHandle; nx: cint; ny: cint; nz: cint;
                    `type`: cufftType; workSize: ptr csize_t): cufftResult {.cdecl,
    importc: "cufftGetSize3d", dynlib: libName.}
proc cufftGetSizeMany*(handle: cufftHandle; rank: cint; n: ptr cint; inembed: ptr cint;
                      istride: cint; idist: cint; onembed: ptr cint; ostride: cint;
                      odist: cint; `type`: cufftType; batch: cint;
                      workArea: ptr csize_t): cufftResult {.cdecl,
    importc: "cufftGetSizeMany", dynlib: libName.}
proc cufftGetSize*(handle: cufftHandle; workSize: ptr csize_t): cufftResult {.cdecl,
    importc: "cufftGetSize", dynlib: libName.}
proc cufftSetWorkArea*(plan: cufftHandle; workArea: pointer): cufftResult {.cdecl,
    importc: "cufftSetWorkArea", dynlib: libName.}
proc cufftSetAutoAllocation*(plan: cufftHandle; autoAllocate: cint): cufftResult {.
    cdecl, importc: "cufftSetAutoAllocation", dynlib: libName.}
proc cufftExecC2C*(plan: cufftHandle; idata: ptr cufftComplex;
                  odata: ptr cufftComplex; direction: cint): cufftResult {.cdecl,
    importc: "cufftExecC2C", dynlib: libName.}
proc cufftExecR2C*(plan: cufftHandle; idata: ptr cufftReal; odata: ptr cufftComplex): cufftResult {.
    cdecl, importc: "cufftExecR2C", dynlib: libName.}
proc cufftExecC2R*(plan: cufftHandle; idata: ptr cufftComplex; odata: ptr cufftReal): cufftResult {.
    cdecl, importc: "cufftExecC2R", dynlib: libName.}
proc cufftExecZ2Z*(plan: cufftHandle; idata: ptr cufftDoubleComplex;
                  odata: ptr cufftDoubleComplex; direction: cint): cufftResult {.
    cdecl, importc: "cufftExecZ2Z", dynlib: libName.}
proc cufftExecD2Z*(plan: cufftHandle; idata: ptr cufftDoubleReal;
                  odata: ptr cufftDoubleComplex): cufftResult {.cdecl,
    importc: "cufftExecD2Z", dynlib: libName.}
proc cufftExecZ2D*(plan: cufftHandle; idata: ptr cufftDoubleComplex;
                  odata: ptr cufftDoubleReal): cufftResult {.cdecl,
    importc: "cufftExecZ2D", dynlib: libName.}
##  utility functions

proc cufftSetStream*(plan: cufftHandle; stream: cudaStream_t): cufftResult {.cdecl,
    importc: "cufftSetStream", dynlib: libName.}
proc cufftDestroy*(plan: cufftHandle): cufftResult {.cdecl, importc: "cufftDestroy",
    dynlib: libName.}
proc cufftGetVersion*(version: ptr cint): cufftResult {.cdecl,
    importc: "cufftGetVersion", dynlib: libName.}
proc cufftGetProperty*(`type`: libraryPropertyType; value: ptr cint): cufftResult {.
    cdecl, importc: "cufftGetProperty", dynlib: libName.}
##
##  Set/Get PlanProperty APIs configures per-plan behavior
##

type
  cufftProperty* {.size: sizeof(cint).} = enum
    NVFFT_PLAN_PROPERTY_INT64_PATIENT_JIT = 0x1,
    NVFFT_PLAN_PROPERTY_INT64_MAX_NUM_HOST_THREADS = 0x2


proc cufftSetPlanPropertyInt64*(plan: cufftHandle; property: cufftProperty;
                               inputValueInt: clonglong): cufftResult {.cdecl,
    importc: "cufftSetPlanPropertyInt64", dynlib: libName.}
proc cufftGetPlanPropertyInt64*(plan: cufftHandle; property: cufftProperty;
                               returnPtrValue: ptr clonglong): cufftResult {.cdecl,
    importc: "cufftGetPlanPropertyInt64", dynlib: libName.}
proc cufftResetPlanProperty*(plan: cufftHandle; property: cufftProperty): cufftResult {.
    cdecl, importc: "cufftResetPlanProperty", dynlib: libName.}