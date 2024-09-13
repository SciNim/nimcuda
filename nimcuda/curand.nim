when defined(windows):
  const
    libName = "curand.dll"
elif defined(macosx):
  const
    libName = "libcurand.dylib"
else:
  const
    libName = "libcurand.so"
type
  curandDistributionShift_st {.bycopy.} = object

  curandDistributionM2Shift_st {.bycopy.} = object

  curandHistogramM2_st {.bycopy.} = object

  curandDiscreteDistribution_st {.bycopy.} = object


import
  library_types, driver_types

##  Copyright 2010-2014 NVIDIA Corporation.  All rights reserved.
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

when not defined(CURAND_H):
  ##
  ##  \defgroup HOST Host API
  ##
  ##  @{
  ##
  const
    CURAND_VER_MAJOR* = 10
    CURAND_VER_MINOR* = 3
    CURAND_VER_PATCH* = 6
    CURAND_VER_BUILD* = 82
    CURAND_VERSION* = (
      CURAND_VER_MAJOR * 1000 + CURAND_VER_MINOR * 100 + CURAND_VER_PATCH)
  ##  CURAND Host API datatypes
  ##
  ##  @{
  ##
  ##
  ##  CURAND function call status types
  ##
  type
    curandStatus* {.size: sizeof(cint).} = enum
      CURAND_STATUS_SUCCESS = 0, ## < No errors
      CURAND_STATUS_VERSION_MISMATCH = 100, ## < Header file and linked library version do not match
      CURAND_STATUS_NOT_INITIALIZED = 101, ## < Generator not initialized
      CURAND_STATUS_ALLOCATION_FAILED = 102, ## < Memory allocation failed
      CURAND_STATUS_TYPE_ERROR = 103, ## < Generator is wrong type
      CURAND_STATUS_OUT_OF_RANGE = 104, ## < Argument out of range
      CURAND_STATUS_LENGTH_NOT_MULTIPLE = 105, ## < Length requested is not a multple of dimension
      CURAND_STATUS_DOUBLE_PRECISION_REQUIRED = 106, ## < GPU does not have double precision required by MRG32k3a
      CURAND_STATUS_LAUNCH_FAILURE = 201, ## < Kernel launch failure
      CURAND_STATUS_PREEXISTING_FAILURE = 202, ## < Preexisting failure on library entry
      CURAND_STATUS_INITIALIZATION_FAILED = 203, ## < Initialization of CUDA failed
      CURAND_STATUS_ARCH_MISMATCH = 204, ## < Architecture mismatch, GPU does not support requested feature
      CURAND_STATUS_INTERNAL_ERROR = 999 ## < Internal library error
  ##
  ##  CURAND function call status types
  ##
  ##  \cond UNHIDE_TYPEDEFS
  type
    curandStatus_t* = curandStatus
  ##  \endcond
  ##
  ##  CURAND generator types
  ##
  type
    curandRngType* {.size: sizeof(cint).} = enum
      CURAND_RNG_TEST = 0, CURAND_RNG_PSEUDO_DEFAULT = 100, ## < Default pseudorandom generator
      CURAND_RNG_PSEUDO_XORWOW = 101, ## < XORWOW pseudorandom generator
      CURAND_RNG_PSEUDO_MRG32K3A = 121, ## < MRG32k3a pseudorandom generator
      CURAND_RNG_PSEUDO_MTGP32 = 141, ## < Mersenne Twister MTGP32 pseudorandom generator
      CURAND_RNG_PSEUDO_MT19937 = 142, ## < Mersenne Twister MT19937 pseudorandom generator
      CURAND_RNG_PSEUDO_PHILOX4_32_10 = 161, ## < PHILOX-4x32-10 pseudorandom generator
      CURAND_RNG_QUASI_DEFAULT = 200, ## < Default quasirandom generator
      CURAND_RNG_QUASI_SOBOL32 = 201, ## < Sobol32 quasirandom generator
      CURAND_RNG_QUASI_SCRAMBLED_SOBOL32 = 202, ## < Scrambled Sobol32 quasirandom generator
      CURAND_RNG_QUASI_SOBOL64 = 203, ## < Sobol64 quasirandom generator
      CURAND_RNG_QUASI_SCRAMBLED_SOBOL64 = 204 ## < Scrambled Sobol64 quasirandom generator
  ##
  ##  CURAND generator types
  ##
  ##  \cond UNHIDE_TYPEDEFS
  type
    curandRngType_t* = curandRngType
  ##  \endcond
  ##
  ##  CURAND ordering of results in memory
  ##
  type
    curandOrdering* {.size: sizeof(cint).} = enum
      CURAND_ORDERING_PSEUDO_BEST = 100, ## < Best ordering for pseudorandom results
      CURAND_ORDERING_PSEUDO_DEFAULT = 101, ## < Specific default thread sequence for pseudorandom results, same as CURAND_ORDERING_PSEUDO_BEST
      CURAND_ORDERING_PSEUDO_SEEDED = 102, ## < Specific seeding pattern for fast lower quality pseudorandom results
      CURAND_ORDERING_PSEUDO_LEGACY = 103, ## < Specific legacy sequence for pseudorandom results, guaranteed to remain the same for all cuRAND release
      CURAND_ORDERING_PSEUDO_DYNAMIC = 104, ## < Specific ordering adjusted to the device it is being executed on, provides the best performance
      CURAND_ORDERING_QUASI_DEFAULT = 201 ## < Specific n-dimensional ordering for quasirandom results
  ##
  ##  CURAND ordering of results in memory
  ##
  ##  \cond UNHIDE_TYPEDEFS
  type
    curandOrdering_t* = curandOrdering
  ##  \endcond
  ##
  ##  CURAND choice of direction vector set
  ##
  type
    curandDirectionVectorSet* {.size: sizeof(cint).} = enum
      CURAND_DIRECTION_VECTORS_32_JOEKUO6 = 101, ## < Specific set of 32-bit direction vectors generated from polynomials recommended by S. Joe and F. Y. Kuo, for up to 20,000 dimensions
      CURAND_SCRAMBLED_DIRECTION_VECTORS_32_JOEKUO6 = 102, ## < Specific set of 32-bit direction vectors generated from polynomials recommended by S. Joe and F. Y. Kuo, for up to 20,000 dimensions, and scrambled
      CURAND_DIRECTION_VECTORS_64_JOEKUO6 = 103, ## < Specific set of 64-bit direction vectors generated from polynomials recommended by S. Joe and F. Y. Kuo, for up to 20,000 dimensions
      CURAND_SCRAMBLED_DIRECTION_VECTORS_64_JOEKUO6 = 104 ## < Specific set of 64-bit direction vectors generated from polynomials recommended by S. Joe and F. Y. Kuo, for up to 20,000 dimensions, and scrambled
  ##
  ##  CURAND choice of direction vector set
  ##
  ##  \cond UNHIDE_TYPEDEFS
  type
    curandDirectionVectorSet_t* = curandDirectionVectorSet
  ##  \endcond
  ##
  ##  CURAND array of 32-bit direction vectors
  ##
  ##  \cond UNHIDE_TYPEDEFS
  type
    curandDirectionVectors32_t* = array[32, cuint]
  ##  \endcond
  ##
  ##  CURAND array of 64-bit direction vectors
  ##
  ##  \cond UNHIDE_TYPEDEFS
  type
    curandDirectionVectors64_t* = array[64, culonglong]
  ##  \endcond *
  ##
  ##  CURAND generator (opaque)
  ##
  type curandGenerator_st {.importc, nodecl.} = object
  type
    curandGenerator_t* = ptr curandGenerator_st
  ##  \endcond
  ##
  ##  CURAND distribution
  ##
  ##  \cond UNHIDE_TYPEDEFS
  type
    curandDistribution_st* = cdouble
    curandDistribution_t* = ptr curandDistribution_st
    curandDistributionShift_t* = ptr curandDistributionShift_st
  ##  \endcond
  ##
  ##  CURAND distribution M2
  ##
  ##  \cond UNHIDE_TYPEDEFS
  type
    curandDistributionM2Shift_t* = ptr curandDistributionM2Shift_st
    curandHistogramM2_t* = ptr curandHistogramM2_st
    curandHistogramM2K_st* = cuint
    curandHistogramM2K_t* = ptr curandHistogramM2K_st
    curandHistogramM2V_st* = curandDistribution_st
    curandHistogramM2V_t* = ptr curandHistogramM2V_st
    curandDiscreteDistribution_t* = ptr curandDiscreteDistribution_st
  ##  \endcond
  ##
  ##  CURAND METHOD
  ##
  ##  \cond UNHIDE_ENUMS
  type
    curandMethod* {.size: sizeof(cint).} = enum
      CURAND_CHOOSE_BEST = 0,   ##  choose best depends on args
      CURAND_ITR = 1, CURAND_KNUTH = 2, CURAND_HITR = 3, CURAND_M1 = 4, CURAND_M2 = 5,
      CURAND_BINARY_SEARCH = 6, CURAND_DISCRETE_GAUSS = 7, CURAND_REJECTION = 8,
      CURAND_DEVICE_API = 9, CURAND_FAST_REJECTION = 10, CURAND_3RD = 11,
      CURAND_DEFINITION = 12, CURAND_POISSON = 13
  type
    curandMethod_t* = curandMethod
  ##  \endcond