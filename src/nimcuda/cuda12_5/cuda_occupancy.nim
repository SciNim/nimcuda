import ./helpers
import ./libpaths
tellCompilerToUseCuda()

##
##  Copyright 1993-2017 NVIDIA Corporation.  All rights reserved.
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
##  CUDA Occupancy Calculator
##
##  NAME
##
##    cudaOccMaxActiveBlocksPerMultiprocessor,
##    cudaOccMaxPotentialOccupancyBlockSize,
##    cudaOccMaxPotentialOccupancyBlockSizeVariableSMem
##    cudaOccAvailableDynamicSMemPerBlock
##
##  DESCRIPTION
##
##    The CUDA occupancy calculator provides a standalone, programmatical
##    interface to compute the occupancy of a function on a device. It can also
##    provide occupancy-oriented launch configuration suggestions.
##
##    The function and device are defined by the user through
##    cudaOccFuncAttributes, cudaOccDeviceProp, and cudaOccDeviceState
##    structures. All APIs require all 3 of them.
##
##    See the structure definition for more details about the device / function
##    descriptors.
##
##    See each API's prototype for API usage.
##
##  COMPATIBILITY
##
##    The occupancy calculator will be updated on each major CUDA toolkit
##    release. It does not provide forward compatibility, i.e. new hardwares
##    released after this implementation's release will not be supported.
##
##  NOTE
##
##    If there is access to CUDA runtime, and the sole intent is to calculate
##    occupancy related values on one of the accessible CUDA devices, using CUDA
##    runtime's occupancy calculation APIs is recommended.
##
##

##  __OCC_INLINE will be undefined at the end of this header
##

type
  cudaOccError_enum* = enum
    CUDA_OCC_SUCCESS = 0,       ##  no error encountered
    CUDA_OCC_ERROR_INVALID_INPUT = 1, ##  input parameter is invalid
    CUDA_OCC_ERROR_UNKNOWN_DEVICE = 2 ##  requested device is not supported in
                                   ##  current implementation or device is
                                   ##  invalid


type
  cudaOccError* = cudaOccError_enum


##
##  The CUDA occupancy calculator computes the occupancy of the function
##  described by attributes with the given block size (blockSize), static device
##  properties (properties), dynamic device states (states) and per-block dynamic
##  shared memory allocation (dynamicSMemSize) in bytes, and output it through
##  result along with other useful information. The occupancy is computed in
##  terms of the maximum number of active blocks per multiprocessor. The user can
##  then convert it to other metrics, such as number of active warps.
##
##  RETURN VALUE
##
##  The occupancy and related information is returned through result.
##
##  If result->activeBlocksPerMultiprocessor is 0, then the given parameter
##  combination cannot run on the device.
##
##  ERRORS
##
##      CUDA_OCC_ERROR_INVALID_INPUT   input parameter is invalid.
##      CUDA_OCC_ERROR_UNKNOWN_DEVICE  requested device is not supported in
##      current implementation or device is invalid
##

# proc cudaOccMaxActiveBlocksPerMultiprocessor*(result: ptr cudaOccResult;
#     properties: ptr cudaOccDeviceProp; attributes: ptr cudaOccFuncAttributes;
#     state: ptr cudaOccDeviceState; blockSize: cint; dynamicSmemSize: csize_t): cudaOccError {.
#     inline.}
##  out
##  in
##  in
##  in
##  in
##  in
##
##  The CUDA launch configurator C API suggests a grid / block size pair (in
##  minGridSize and blockSize) that achieves the best potential occupancy
##  (i.e. maximum number of active warps with the smallest number of blocks) for
##  the given function described by attributes, on a device described by
##  properties with settings in state.
##
##  If per-block dynamic shared memory allocation is not needed, the user should
##  leave both blockSizeToDynamicSMemSize and dynamicSMemSize as 0.
##
##  If per-block dynamic shared memory allocation is needed, then if the dynamic
##  shared memory size is constant regardless of block size, the size should be
##  passed through dynamicSMemSize, and blockSizeToDynamicSMemSize should be
##  NULL.
##
##  Otherwise, if the per-block dynamic shared memory size varies with different
##  block sizes, the user needs to provide a pointer to an unary function through
##  blockSizeToDynamicSMemSize that computes the dynamic shared memory needed by
##  a block of the function for any given block size. dynamicSMemSize is
##  ignored. An example signature is:
##
##     // Take block size, returns dynamic shared memory needed
##     size_t blockToSmem(int blockSize);
##
##  RETURN VALUE
##
##  The suggested block size and the minimum number of blocks needed to achieve
##  the maximum occupancy are returned through blockSize and minGridSize.
##
##  If *blockSize is 0, then the given combination cannot run on the device.
##
##  ERRORS
##
##      CUDA_OCC_ERROR_INVALID_INPUT   input parameter is invalid.
##      CUDA_OCC_ERROR_UNKNOWN_DEVICE  requested device is not supported in
##      current implementation or device is invalid
##
##

# proc cudaOccMaxPotentialOccupancyBlockSize*(minGridSize: ptr cint;
#     blockSize: ptr cint; properties: ptr cudaOccDeviceProp;
#     attributes: ptr cudaOccFuncAttributes; state: ptr cudaOccDeviceState;
#     blockSizeToDynamicSMemSize: proc (a1: cint): csize_t; dynamicSMemSize: csize_t): cudaOccError {.
#     inline.}
##  out
##  out
##  in
##  in
##  in
##  in
##  in
##
##  The CUDA launch configurator C++ API suggests a grid / block size pair (in
##  minGridSize and blockSize) that achieves the best potential occupancy
##  (i.e. the maximum number of active warps with the smallest number of blocks)
##  for the given function described by attributes, on a device described by
##  properties with settings in state.
##
##  If per-block dynamic shared memory allocation is 0 or constant regardless of
##  block size, the user can use cudaOccMaxPotentialOccupancyBlockSize to
##  configure the launch. A constant dynamic shared memory allocation size in
##  bytes can be passed through dynamicSMemSize.
##
##  Otherwise, if the per-block dynamic shared memory size varies with different
##  block sizes, the user needs to use
##  cudaOccMaxPotentialOccupancyBlockSizeVariableSmem instead, and provide a
##  functor / pointer to an unary function (blockSizeToDynamicSMemSize) that
##  computes the dynamic shared memory needed by func for any given block
##  size. An example signature is:
##
##   // Take block size, returns per-block dynamic shared memory needed
##   size_t blockToSmem(int blockSize);
##
##  RETURN VALUE
##
##  The suggested block size and the minimum number of blocks needed to achieve
##  the maximum occupancy are returned through blockSize and minGridSize.
##
##  If *blockSize is 0, then the given combination cannot run on the device.
##
##  ERRORS
##
##      CUDA_OCC_ERROR_INVALID_INPUT   input parameter is invalid.
##      CUDA_OCC_ERROR_UNKNOWN_DEVICE  requested device is not supported in
##      current implementation or device is invalid
##
##

##
##
##  The CUDA dynamic shared memory calculator computes the maximum size of
##  per-block dynamic shared memory if we want to place numBlocks blocks
##  on an SM.
##
##  RETURN VALUE
##
##  Returns in *dynamicSmemSize the maximum size of dynamic shared memory to allow
##  numBlocks blocks per SM.
##
##  ERRORS
##
##      CUDA_OCC_ERROR_INVALID_INPUT   input parameter is invalid.
##      CUDA_OCC_ERROR_UNKNOWN_DEVICE  requested device is not supported in
##      current implementation or device is invalid
##
##

# proc cudaOccAvailableDynamicSMemPerBlock*(dynamicSmemSize: ptr csize_t;
#     properties: ptr cudaOccDeviceProp; attributes: ptr cudaOccFuncAttributes;
#     state: ptr cudaOccDeviceState; numBlocks: cint; blockSize: cint): cudaOccError {.
#     inline.}
##
##  Data structures
##
##  These structures are subject to change for future architecture and CUDA
##  releases. C users should initialize the structure as {0}.
##
##
##
##  Device descriptor
##
##  This structure describes a device.
##

type
  cudaOccDeviceProp* {.bycopy.} = object
    computeMajor*: cint
    ##  Compute capability major version
    computeMinor*: cint
    ##  Compute capability minor
    ##  version. None supported minor version
    ##  may cause error
    maxThreadsPerBlock*: cint
    ##  Maximum number of threads per block
    maxThreadsPerMultiprocessor*: cint
    ##  Maximum number of threads per SM
    ##  i.e. (Max. number of warps) x (warp
    ##  size)
    regsPerBlock*: cint
    ##  Maximum number of registers per block
    regsPerMultiprocessor*: cint
    ##  Maximum number of registers per SM
    warpSize*: cint
    ##  Warp size
    sharedMemPerBlock*: csize_t
    ##  Maximum shared memory size per block
    sharedMemPerMultiprocessor*: csize_t
    ##  Maximum shared memory size per SM
    numSms*: cint
    ##  Number of SMs available
    sharedMemPerBlockOptin*: csize_t
    ##  Maximum optin shared memory size per block
    reservedSharedMemPerBlock*: csize_t
    ##  Shared memory per block reserved by driver
    ##  #ifdef __cplusplus
    ##  This structure can be converted from a cudaDeviceProp structure for users
    ##  that use this header in their CUDA applications.
    ##
    ##  If the application have access to the CUDA Runtime API, the application
    ##  can obtain the device properties of a CUDA device through
    ##  cudaGetDeviceProperties, and initialize a cudaOccDeviceProp with the
    ##  cudaDeviceProp structure.
    ##
    ##  Example:
    ##
    ##      {
    ##          cudaDeviceProp prop;
    ##
    ##          cudaGetDeviceProperties(&prop, ...);
    ##
    ##          cudaOccDeviceProp occProp = prop;
    ##
    ##          ...
    ##
    ##          cudaOccMaxPotentialOccupancyBlockSize(..., &occProp, ...);
    ##      }
    ##
    ##
    ##  template<typename DeviceProp>
    ##  __OCC_INLINE
    ##  cudaOccDeviceProp(const DeviceProp &props)
    ##  :   computeMajor                (props.major),
    ##      computeMinor                (props.minor),
    ##      maxThreadsPerBlock          (props.maxThreadsPerBlock),
    ##      maxThreadsPerMultiprocessor (props.maxThreadsPerMultiProcessor),
    ##      regsPerBlock                (props.regsPerBlock),
    ##      regsPerMultiprocessor       (props.regsPerMultiprocessor),
    ##      warpSize                    (props.warpSize),
    ##      sharedMemPerBlock           (props.sharedMemPerBlock),
    ##      sharedMemPerMultiprocessor  (props.sharedMemPerMultiprocessor),
    ##      numSms                      (props.multiProcessorCount),
    ##      sharedMemPerBlockOptin      (props.sharedMemPerBlockOptin),
    ##      reservedSharedMemPerBlock   (props.reservedSharedMemPerBlock)
    ##  {}
    ##
    ##  __OCC_INLINE
    ##  cudaOccDeviceProp()
    ##  :   computeMajor                (0),
    ##      computeMinor                (0),
    ##      maxThreadsPerBlock          (0),
    ##      maxThreadsPerMultiprocessor (0),
    ##      regsPerBlock                (0),
    ##      regsPerMultiprocessor       (0),
    ##      warpSize                    (0),
    ##      sharedMemPerBlock           (0),
    ##      sharedMemPerMultiprocessor  (0),
    ##      numSms                      (0),
    ##      sharedMemPerBlockOptin      (0),
    ##      reservedSharedMemPerBlock   (0)
    ##  {}
    ##  #endif // __cplusplus


##
##  Partitioned global caching option
##

type
  cudaOccPartitionedGCConfig* = enum
    PARTITIONED_GC_OFF,       ##  Disable partitioned global caching
    PARTITIONED_GC_ON,        ##  Prefer partitioned global caching
    PARTITIONED_GC_ON_STRICT  ##  Force partitioned global caching


##
##  Per function opt in maximum dynamic shared memory limit
##

type
  cudaOccFuncShmemConfig* = enum
    FUNC_SHMEM_LIMIT_DEFAULT, ##  Default shmem limit
    FUNC_SHMEM_LIMIT_OPTIN    ##  Use the optin shmem limit


##
##  Function descriptor
##
##  This structure describes a CUDA function.
##

type
  cudaOccFuncAttributes* {.bycopy.} = object
    maxThreadsPerBlock*: cint
    ##  Maximum block size the function can work with. If
    ##  unlimited, use INT_MAX or any value greater than
    ##  or equal to maxThreadsPerBlock of the device
    numRegs*: cint
    ##  Number of registers used. When the function is
    ##  launched on device, the register count may change
    ##  due to internal tools requirements.
    sharedSizeBytes*: csize_t
    ##  Number of static shared memory used
    partitionedGCConfig*: cudaOccPartitionedGCConfig
    ##  Partitioned global caching is required to enable
    ##  caching on certain chips, such as sm_52
    ##  devices. Partitioned global caching can be
    ##  automatically disabled if the occupancy
    ##  requirement of the launch cannot support caching.
    ##
    ##  To override this behavior with caching on and
    ##  calculate occupancy strictly according to the
    ##  preference, set partitionedGCConfig to
    ##  PARTITIONED_GC_ON_STRICT. This is especially
    ##  useful for experimenting and finding launch
    ##  configurations (MaxPotentialOccupancyBlockSize)
    ##  that allow global caching to take effect.
    ##
    ##  This flag only affects the occupancy calculation.
    shmemLimitConfig*: cudaOccFuncShmemConfig
    ##  Certain chips like sm_70 allow a user to opt into
    ##  a higher per block limit of dynamic shared memory
    ##  This optin is performed on a per function basis
    ##  using the cuFuncSetAttribute function
    maxDynamicSharedSizeBytes*: csize_t
    ##  User set limit on maximum dynamic shared memory
    ##  usable by the kernel
    ##  This limit is set using the cuFuncSetAttribute
    ##  function.
    numBlockBarriers*: cint
    ##  Number of block barriers used (default to 1)

  cudaOccCacheConfig* = enum
    CACHE_PREFER_NONE = 0x00,   ##  no preference for shared memory or L1 (default)
    CACHE_PREFER_SHARED = 0x01, ##  prefer larger shared memory and smaller L1 cache
    CACHE_PREFER_L1 = 0x02,     ##  prefer larger L1 cache and smaller shared memory
    CACHE_PREFER_EQUAL = 0x03   ##  prefer equal sized L1 cache and shared memory
  cudaOccCarveoutConfig* = enum
    SHAREDMEM_CARVEOUT_DEFAULT = -1, ##  no preference for shared memory or L1 (default)
    SHAREDMEM_CARVEOUT_MAX_L1 = 0, ##  prefer maximum available L1 cache, minimum shared memory
    SHAREDMEM_CARVEOUT_HALF = 50, ##  prefer half of maximum available shared memory, with the rest as L1 cache
    SHAREDMEM_CARVEOUT_MAX_SHARED = 100 ##  prefer maximum available shared memory, minimum L1 cache



##
##  Device state descriptor
##
##  This structure describes device settings that affect occupancy calculation.
##

type
  cudaOccDeviceState* {.bycopy.} = object
    ##  Cache / shared memory split preference. Deprecated on Volta
    cacheConfig*: cudaOccCacheConfig
    ##  Shared memory / L1 split preference. Supported on only Volta
    carveoutConfig*: cint

  cudaOccLimitingFactor* = enum
    OCC_LIMIT_WARPS = 0x01,     ##  - warps available
    OCC_LIMIT_REGISTERS = 0x02, ##  - registers available
    OCC_LIMIT_SHARED_MEMORY = 0x04, ##  - shared memory available
    OCC_LIMIT_BLOCKS = 0x08,    ##  - blocks available
    OCC_LIMIT_BARRIERS = 0x10   ##  - barrier available


##
##  Occupancy output
##
##  This structure contains occupancy calculator's output.
##

type
  cudaOccResult* {.bycopy.} = object
    activeBlocksPerMultiprocessor*: cint
    ##  Occupancy
    limitingFactors*: cuint
    ##  Factors that limited occupancy. A bit
    ##  field that counts the limiting
    ##  factors, see cudaOccLimitingFactor
    blockLimitRegs*: cint
    ##  Occupancy due to register
    ##  usage, INT_MAX if the kernel does not
    ##  use any register.
    blockLimitSharedMem*: cint
    ##  Occupancy due to shared memory
    ##  usage, INT_MAX if the kernel does not
    ##  use shared memory.
    blockLimitWarps*: cint
    ##  Occupancy due to block size limit
    blockLimitBlocks*: cint
    ##  Occupancy due to maximum number of blocks
    ##  managable per SM
    blockLimitBarriers*: cint
    ##  Occupancy due to block barrier usage
    allocatedRegistersPerBlock*: cint
    ##  Actual number of registers allocated per
    ##  block
    allocatedSharedMemPerBlock*: csize_t
    ##  Actual size of shared memory allocated
    ##  per block
    partitionedGCConfig*: cudaOccPartitionedGCConfig
    ##  Report if partitioned global caching
    ##  is actually enabled.


##
##  Partitioned global caching support
##
##  See cudaOccPartitionedGlobalCachingModeSupport
##

type
  cudaOccPartitionedGCSupport* = enum
    PARTITIONED_GC_NOT_SUPPORTED, ##  Partitioned global caching is not supported
    PARTITIONED_GC_SUPPORTED  ##  Partitioned global caching is supported


##
##  Implementation
##
##
##  Max compute capability supported
##

const
  CUDA_OCC_MAJOR* = 9
  CUDA_OCC_MINOR* = 0

## ///////////////////////////////////////
##     Mathematical Helper Functions     //
## ///////////////////////////////////////

proc occMin*(lhs: cint; rhs: cint): cint {.inline.} =
  return if rhs < lhs: rhs else: lhs

proc occDivideRoundUp*(x: cint; y: cint): cint {.inline.} =
  return (x + (y - 1)) div y

proc occRoundUp*(x: cint; y: cint): cint {.inline.} =
  return y * occDivideRoundUp(x, y)

## ///////////////////////////////////////
##       Architectural Properties        //
## ///////////////////////////////////////
##
##  Granularity of shared memory allocation
##

proc cudaOccSMemAllocationGranularity*(limit: ptr cint;
                                      properties: ptr cudaOccDeviceProp): cudaOccError {.
    inline.} =
  var value: cint
  case properties.computeMajor
  of 3, 5, 6, 7:
    value = 256
  of 8, 9:
    value = 128
  else:
    return CUDA_OCC_ERROR_UNKNOWN_DEVICE
  limit[] = value
  return CUDA_OCC_SUCCESS

##
##  Maximum number of registers per thread
##

proc cudaOccRegAllocationMaxPerThread*(limit: ptr cint;
                                      properties: ptr cudaOccDeviceProp): cudaOccError {.
    inline.} =
  var value: cint
  case properties.computeMajor
  of 3, 5, 6:
    value = 255
  of 7, 8, 9:
    value = 256
  else:
    return CUDA_OCC_ERROR_UNKNOWN_DEVICE
  limit[] = value
  return CUDA_OCC_SUCCESS

##
##  Granularity of register allocation
##

proc cudaOccRegAllocationGranularity*(limit: ptr cint;
                                     properties: ptr cudaOccDeviceProp): cudaOccError {.
    inline.} =
  var value: cint
  case properties.computeMajor
  of 3, 5, 6, 7, 8, 9:
    value = 256
  else:
    return CUDA_OCC_ERROR_UNKNOWN_DEVICE
  limit[] = value
  return CUDA_OCC_SUCCESS

##
##  Number of sub-partitions
##

proc cudaOccSubPartitionsPerMultiprocessor*(limit: ptr cint;
    properties: ptr cudaOccDeviceProp): cudaOccError {.inline.} =
  var value: cint
  case properties.computeMajor
  of 3, 5, 7, 8, 9:
    value = 4
  of 6:
    value = if properties.computeMinor: 4 else: 2
  else:
    return CUDA_OCC_ERROR_UNKNOWN_DEVICE
  limit[] = value
  return CUDA_OCC_SUCCESS

##
##  Maximum number of blocks that can run simultaneously on a multiprocessor
##

proc cudaOccMaxBlocksPerMultiprocessor*(limit: ptr cint;
                                       properties: ptr cudaOccDeviceProp): cudaOccError {.
    inline.} =
  var value: cint
  case properties.computeMajor
  of 3:
    value = 16
  of 5, 6:
    value = 32
  of 7:
    var isTuring: cint = properties.computeMinor == 5
    value = if (isTuring): 16 else: 32
  of 8:
    if properties.computeMinor == 0:
      value = 32
    elif properties.computeMinor == 9:
      value = 24
    else:
      value = 16
  of 9:
    value = 32
  else:
    return CUDA_OCC_ERROR_UNKNOWN_DEVICE
  limit[] = value
  return CUDA_OCC_SUCCESS

##
##  Align up shared memory based on compute major configurations
##

proc cudaOccAlignUpShmemSizeVoltaPlus*(shMemSize: ptr csize_t;
                                      properties: ptr cudaOccDeviceProp): cudaOccError {.
    inline.} =
  ##  Volta and Turing have shared L1 cache / shared memory, and support cache
  ##  configuration to trade one for the other. These values are needed to
  ##  map carveout config ratio to the next available architecture size
  var size: csize_t = shMemSize[]
  case properties.computeMajor
  of 7:
    ##  Turing supports 32KB and 64KB shared mem.
    var isTuring: cint = properties.computeMinor == 5
    if isTuring:
      if size <= 32 * 1024:
        shMemSize[] = 32 * 1024
      elif size <= 64 * 1024:
        shMemSize[] = 64 * 1024
      else:
        return CUDA_OCC_ERROR_INVALID_INPUT
    else:
      if size == 0:
        shMemSize[] = 0
      elif size <= 8 * 1024:
        shMemSize[] = 8 * 1024
      elif size <= 16 * 1024:
        shMemSize[] = 16 * 1024
      elif size <= 32 * 1024:
        shMemSize[] = 32 * 1024
      elif size <= 64 * 1024:
        shMemSize[] = 64 * 1024
      elif size <= 96 * 1024:
        shMemSize[] = 96 * 1024
      else:
        return CUDA_OCC_ERROR_INVALID_INPUT
  of 8:
    if properties.computeMinor == 0 or properties.computeMinor == 7:
      if size == 0:
        shMemSize[] = 0
      elif size <= 8 * 1024:
        shMemSize[] = 8 * 1024
      elif size <= 16 * 1024:
        shMemSize[] = 16 * 1024
      elif size <= 32 * 1024:
        shMemSize[] = 32 * 1024
      elif size <= 64 * 1024:
        shMemSize[] = 64 * 1024
      elif size <= 100 * 1024:
        shMemSize[] = 100 * 1024
      elif size <= 132 * 1024:
        shMemSize[] = 132 * 1024
      elif size <= 164 * 1024:
        shMemSize[] = 164 * 1024
      else:
        return CUDA_OCC_ERROR_INVALID_INPUT
    else:
      if size == 0:
        shMemSize[] = 0
      elif size <= 8 * 1024:
        shMemSize[] = 8 * 1024
      elif size <= 16 * 1024:
        shMemSize[] = 16 * 1024
      elif size <= 32 * 1024:
        shMemSize[] = 32 * 1024
      elif size <= 64 * 1024:
        shMemSize[] = 64 * 1024
      elif size <= 100 * 1024:
        shMemSize[] = 100 * 1024
      else:
        return CUDA_OCC_ERROR_INVALID_INPUT
  of 9:
    if size == 0:
      shMemSize[] = 0
    elif size <= 8 * 1024:
      shMemSize[] = 8 * 1024
    elif size <= 16 * 1024:
      shMemSize[] = 16 * 1024
    elif size <= 32 * 1024:
      shMemSize[] = 32 * 1024
    elif size <= 64 * 1024:
      shMemSize[] = 64 * 1024
    elif size <= 100 * 1024:
      shMemSize[] = 100 * 1024
    elif size <= 132 * 1024:
      shMemSize[] = 132 * 1024
    elif size <= 164 * 1024:
      shMemSize[] = 164 * 1024
    elif size <= 196 * 1024:
      shMemSize[] = 196 * 1024
    elif size <= 228 * 1024:
      shMemSize[] = 228 * 1024
    else:
      return CUDA_OCC_ERROR_INVALID_INPUT
  else:
    return CUDA_OCC_ERROR_UNKNOWN_DEVICE
  return CUDA_OCC_SUCCESS

##
##  Shared memory based on the new carveoutConfig API introduced with Volta
##

proc cudaOccSMemPreferenceVoltaPlus*(limit: ptr csize_t;
                                    properties: ptr cudaOccDeviceProp;
                                    state: ptr cudaOccDeviceState): cudaOccError {.
    inline.} =
  var status: cudaOccError = CUDA_OCC_SUCCESS
  var preferenceShmemSize: csize_t
  ##  CUDA 9.0 introduces a new API to set shared memory - L1 configuration on supported
  ##  devices. This preference will take precedence over the older cacheConfig setting.
  ##  Map cacheConfig to its effective preference value.
  var effectivePreference: cint = state.carveoutConfig
  if (effectivePreference < SHAREDMEM_CARVEOUT_DEFAULT) or
      (effectivePreference > SHAREDMEM_CARVEOUT_MAX_SHARED):
    return CUDA_OCC_ERROR_INVALID_INPUT
  if effectivePreference == SHAREDMEM_CARVEOUT_DEFAULT:
    case state.cacheConfig
    of CACHE_PREFER_L1:
      effectivePreference = SHAREDMEM_CARVEOUT_MAX_L1
    of CACHE_PREFER_SHARED:
      effectivePreference = SHAREDMEM_CARVEOUT_MAX_SHARED
    of CACHE_PREFER_EQUAL:
      effectivePreference = SHAREDMEM_CARVEOUT_HALF
    else:
      effectivePreference = SHAREDMEM_CARVEOUT_DEFAULT
  if effectivePreference == SHAREDMEM_CARVEOUT_DEFAULT:
    preferenceShmemSize = properties.sharedMemPerMultiprocessor
  else:
    preferenceShmemSize = ((csize_t)(effectivePreference) *
        properties.sharedMemPerMultiprocessor) div 100
  status = cudaOccAlignUpShmemSizeVoltaPlus(addr(preferenceShmemSize), properties)
  limit[] = preferenceShmemSize
  return status

##
##  Shared memory based on the cacheConfig
##

proc cudaOccSMemPreference*(limit: ptr csize_t; properties: ptr cudaOccDeviceProp;
                           state: ptr cudaOccDeviceState): cudaOccError {.inline.} =
  var bytes: csize_t = 0
  var sharedMemPerMultiprocessorHigh: csize_t = properties.sharedMemPerMultiprocessor
  var cacheConfig: cudaOccCacheConfig = state.cacheConfig
  ##  Kepler has shared L1 cache / shared memory, and support cache
  ##  configuration to trade one for the other. These values are needed to
  ##  calculate the correct shared memory size for user requested cache
  ##  configuration.
  ##
  var minCacheSize: csize_t = 16384
  var maxCacheSize: csize_t = 49152
  var cacheAndSharedTotal: csize_t = sharedMemPerMultiprocessorHigh + minCacheSize
  var sharedMemPerMultiprocessorLow: csize_t = cacheAndSharedTotal - maxCacheSize
  case properties.computeMajor
  of 3: ##  Kepler supports 16KB, 32KB, or 48KB partitions for L1. The rest
      ##  is shared memory.
      ##
    case cacheConfig           ##  default :
    of CACHE_PREFER_NONE, CACHE_PREFER_SHARED:
      bytes = sharedMemPerMultiprocessorHigh
    of CACHE_PREFER_L1:
      bytes = sharedMemPerMultiprocessorLow
    of CACHE_PREFER_EQUAL: ##  Equal is the mid-point between high and low. It should be
                         ##  equivalent to low + 16KB.
                         ##
      bytes = (sharedMemPerMultiprocessorHigh + sharedMemPerMultiprocessorLow) div
          2
    else:
      bytes = sharedMemPerMultiprocessorHigh
  of 5, 6:                      ##  Maxwell and Pascal have dedicated shared memory.
        ##
    bytes = sharedMemPerMultiprocessorHigh
  else:
    return CUDA_OCC_ERROR_UNKNOWN_DEVICE
  limit[] = bytes
  return CUDA_OCC_SUCCESS

##
##  Shared memory based on config requested by User
##

proc cudaOccSMemPerMultiprocessor*(limit: ptr csize_t;
                                  properties: ptr cudaOccDeviceProp;
                                  state: ptr cudaOccDeviceState): cudaOccError {.
    inline, discardable.} =
  ##  Volta introduces a new API that allows for shared memory carveout preference. Because it is a shared memory preference,
  ##  it is handled separately from the cache config preference.
  if properties.computeMajor >= 7:
    return cudaOccSMemPreferenceVoltaPlus(limit, properties, state)
  return cudaOccSMemPreference(limit, properties, state)

##
##  Return the per block shared memory limit based on function config
##

proc cudaOccSMemPerBlock*(limit: ptr csize_t; properties: ptr cudaOccDeviceProp;
                         shmemLimitConfig: cudaOccFuncShmemConfig;
                         smemPerCta: csize_t): cudaOccError {.inline.} =
  case properties.computeMajor
  of 2, 3, 4, 5, 6:
    limit[] = properties.sharedMemPerBlock
  of 7, 8, 9:
    case shmemLimitConfig      ##  default:
    of FUNC_SHMEM_LIMIT_DEFAULT:
      limit[] = properties.sharedMemPerBlock
    of FUNC_SHMEM_LIMIT_OPTIN:
      if smemPerCta > properties.sharedMemPerBlock:
        limit[] = properties.sharedMemPerBlockOptin
      else:
        limit[] = properties.sharedMemPerBlock
    else:
      limit[] = properties.sharedMemPerBlock
  else:
    return CUDA_OCC_ERROR_UNKNOWN_DEVICE
  ##  Starting Ampere, CUDA driver reserves additional shared memory per block
  if properties.computeMajor >= 8:
    limit[] += properties.reservedSharedMemPerBlock
  return CUDA_OCC_SUCCESS

##
##  Partitioned global caching mode support
##

proc cudaOccPartitionedGlobalCachingModeSupport*(
    limit: ptr cudaOccPartitionedGCSupport; properties: ptr cudaOccDeviceProp): cudaOccError {.
    inline, discardable.} =
  limit[] = PARTITIONED_GC_NOT_SUPPORTED
  if (properties.computeMajor == 5 and
      (properties.computeMinor == 2 or properties.computeMinor == 3)) or
      properties.computeMajor == 6:
    limit[] = PARTITIONED_GC_SUPPORTED
  if properties.computeMajor == 6 and properties.computeMinor == 0:
    limit[] = PARTITIONED_GC_NOT_SUPPORTED
  return CUDA_OCC_SUCCESS

## ////////////////////////////////////////////
##             User Input Sanity              //
## ////////////////////////////////////////////

proc cudaOccDevicePropCheck*(properties: ptr cudaOccDeviceProp): cudaOccError {.
    inline.} =
  ##  Verify device properties
  ##
  ##  Each of these limits must be a positive number.
  ##
  ##  Compute capacity is checked during the occupancy calculation
  ##
  if properties.maxThreadsPerBlock <= 0 or
      properties.maxThreadsPerMultiprocessor <= 0 or properties.regsPerBlock <= 0 or
      properties.regsPerMultiprocessor <= 0 or properties.warpSize <= 0 or
      properties.sharedMemPerBlock <= 0 or
      properties.sharedMemPerMultiprocessor <= 0 or properties.numSms <= 0:
    return CUDA_OCC_ERROR_INVALID_INPUT
  return CUDA_OCC_SUCCESS

proc cudaOccFuncAttributesCheck*(attributes: ptr cudaOccFuncAttributes): cudaOccError {.
    inline.} =
  ##  Verify function attributes
  ##
  if attributes.maxThreadsPerBlock <= 0 or attributes.numRegs < 0:
    ##  Compiler may choose not to use
    ##  any register (empty kernels,
    ##  etc.)
    return CUDA_OCC_ERROR_INVALID_INPUT
  return CUDA_OCC_SUCCESS

proc cudaOccDeviceStateCheck*(state: ptr cudaOccDeviceState): cudaOccError {.inline.} =
  # cast[nil](state)
  ##  silence unused-variable warning
  ##  Placeholder
  ##
  return CUDA_OCC_SUCCESS

proc cudaOccInputCheck*(properties: ptr cudaOccDeviceProp;
                       attributes: ptr cudaOccFuncAttributes;
                       state: ptr cudaOccDeviceState): cudaOccError {.inline.} =
  var status: cudaOccError = CUDA_OCC_SUCCESS
  status = cudaOccDevicePropCheck(properties)
  if status != CUDA_OCC_SUCCESS:
    return status
  status = cudaOccFuncAttributesCheck(attributes)
  if status != CUDA_OCC_SUCCESS:
    return status
  status = cudaOccDeviceStateCheck(state)
  if status != CUDA_OCC_SUCCESS:
    return status
  return status

## ////////////////////////////////////////////
##     Occupancy calculation Functions        //
## ////////////////////////////////////////////

proc cudaOccPartitionedGCExpected*(properties: ptr cudaOccDeviceProp;
                                  attributes: ptr cudaOccFuncAttributes): cudaOccPartitionedGCConfig {.
    inline.} =
  var gcSupport: cudaOccPartitionedGCSupport
  var gcConfig: cudaOccPartitionedGCConfig
  cudaOccPartitionedGlobalCachingModeSupport(addr(gcSupport), properties)
  gcConfig = attributes.partitionedGCConfig
  if gcSupport == PARTITIONED_GC_NOT_SUPPORTED:
    gcConfig = PARTITIONED_GC_OFF
  return gcConfig

##  Warp limit
##

proc cudaOccMaxBlocksPerSMWarpsLimit*(limit: ptr cint;
                                     gcConfig: cudaOccPartitionedGCConfig;
                                     properties: ptr cudaOccDeviceProp;
                                     attributes: ptr cudaOccFuncAttributes;
                                     blockSize: cint): cudaOccError {.inline.} =
  var status: cudaOccError = CUDA_OCC_SUCCESS
  var maxWarpsPerSm: cint
  var warpsAllocatedPerCTA: cint
  var maxBlocks: cint
  # cast[nil](attributes)
  ##  silence unused-variable warning
  if blockSize > properties.maxThreadsPerBlock:
    maxBlocks = 0
  else:
    maxWarpsPerSm = properties.maxThreadsPerMultiprocessor div
        properties.warpSize
    warpsAllocatedPerCTA = occDivideRoundUp(blockSize, properties.warpSize)
    maxBlocks = 0
    if gcConfig != PARTITIONED_GC_OFF:
      var maxBlocksPerSmPartition: cint
      var maxWarpsPerSmPartition: cint
      ##  If partitioned global caching is on, then a CTA can only use a SM
      ##  partition (a half SM), and thus a half of the warp slots
      ##  available per SM
      ##
      maxWarpsPerSmPartition = maxWarpsPerSm div 2
      maxBlocksPerSmPartition = maxWarpsPerSmPartition div warpsAllocatedPerCTA
      maxBlocks = maxBlocksPerSmPartition * 2
    else:
      maxBlocks = maxWarpsPerSm div warpsAllocatedPerCTA
  limit[] = maxBlocks
  return status

##  Shared memory limit
##

proc cudaOccMaxBlocksPerSMSmemLimit*(limit: ptr cint; resultVar: ptr cudaOccResult;
                                    properties: ptr cudaOccDeviceProp;
                                    attributes: ptr cudaOccFuncAttributes;
                                    state: ptr cudaOccDeviceState; blockSize: cint;
                                    dynamicSmemSize: csize_t): cudaOccError {.
    inline.} =
  var status: cudaOccError = CUDA_OCC_SUCCESS
  var allocationGranularity: cint
  var userSmemPreference: csize_t = 0
  var totalSmemUsagePerCTA: csize_t
  var maxSmemUsagePerCTA: csize_t
  var smemAllocatedPerCTA: csize_t
  var staticSmemSize: csize_t
  var sharedMemPerMultiprocessor: csize_t
  var smemLimitPerCTA: csize_t
  var maxBlocks: cint
  var dynamicSmemSizeExceeded: cint = 0
  var totalSmemSizeExceeded: cint = 0
  # cast[nil](blockSize)
  ##  silence unused-variable warning
  status = cudaOccSMemAllocationGranularity(addr(allocationGranularity), properties)
  if status != CUDA_OCC_SUCCESS:
    return status
  status = cudaOccSMemPerMultiprocessor(addr(userSmemPreference), properties, state)
  if status != CUDA_OCC_SUCCESS:
    return status
  staticSmemSize = attributes.sharedSizeBytes +
      properties.reservedSharedMemPerBlock
  totalSmemUsagePerCTA = staticSmemSize + dynamicSmemSize
  smemAllocatedPerCTA = csize_t occRoundUp(cast[cint](totalSmemUsagePerCTA),
                                 cast[cint](allocationGranularity))
  maxSmemUsagePerCTA = staticSmemSize + attributes.maxDynamicSharedSizeBytes
  dynamicSmemSizeExceeded = 0
  totalSmemSizeExceeded = 0
  ##  Obtain the user set maximum dynamic size if it exists
  ##  If so, the current launch dynamic shared memory must not
  ##  exceed the set limit
  if attributes.shmemLimitConfig != FUNC_SHMEM_LIMIT_DEFAULT and
      dynamicSmemSize > attributes.maxDynamicSharedSizeBytes:
    dynamicSmemSizeExceeded = 1
  status = cudaOccSMemPerBlock(addr(smemLimitPerCTA), properties,
                             attributes.shmemLimitConfig, maxSmemUsagePerCTA)
  if status != CUDA_OCC_SUCCESS:
    return status
  if smemAllocatedPerCTA > smemLimitPerCTA:
    totalSmemSizeExceeded = 1
  if dynamicSmemSizeExceeded or totalSmemSizeExceeded:
    maxBlocks = 0
  else:
    ##  User requested shared memory limit is used as long as it is greater
    ##  than the total shared memory used per CTA, i.e. as long as at least
    ##  one CTA can be launched.
    if userSmemPreference >= smemAllocatedPerCTA:
      sharedMemPerMultiprocessor = userSmemPreference
    else:
      ##  On Volta+, user requested shared memory will limit occupancy
      ##  if it's less than shared memory per CTA. Otherwise, the
      ##  maximum shared memory limit is used.
      if properties.computeMajor >= 7:
        sharedMemPerMultiprocessor = smemAllocatedPerCTA
        status = cudaOccAlignUpShmemSizeVoltaPlus(
            addr(sharedMemPerMultiprocessor), properties)
        if status != CUDA_OCC_SUCCESS:
          return status
      else:
        sharedMemPerMultiprocessor = properties.sharedMemPerMultiprocessor
    if smemAllocatedPerCTA > 0:
      maxBlocks = (cint)(sharedMemPerMultiprocessor div smemAllocatedPerCTA)
    else:
      maxBlocks = cint.high
  resultVar.allocatedSharedMemPerBlock = smemAllocatedPerCTA
  limit[] = maxBlocks
  return status

proc cudaOccMaxBlocksPerSMRegsLimit*(limit: ptr cint;
                                    gcConfig: ptr cudaOccPartitionedGCConfig;
                                    resultVar: ptr cudaOccResult;
                                    properties: ptr cudaOccDeviceProp;
                                    attributes: ptr cudaOccFuncAttributes;
                                    blockSize: cint): cudaOccError {.inline.} =
  var status: cudaOccError = CUDA_OCC_SUCCESS
  var allocationGranularity: cint
  var warpsAllocatedPerCTA: cint
  var regsAllocatedPerCTA: cint
  var regsAssumedPerCTA: cint
  var regsPerWarp: cint
  var regsAllocatedPerWarp: cint
  var numSubPartitions: cint
  var numRegsPerSubPartition: cint
  var numWarpsPerSubPartition: cint
  var numWarpsPerSM: cint
  var maxBlocks: cint
  var maxRegsPerThread: cint
  status = cudaOccRegAllocationGranularity(addr(allocationGranularity), properties)
  if status != CUDA_OCC_SUCCESS:
    return status
  status = cudaOccRegAllocationMaxPerThread(addr(maxRegsPerThread), properties)
  if status != CUDA_OCC_SUCCESS:
    return status
  status = cudaOccSubPartitionsPerMultiprocessor(addr(numSubPartitions), properties)
  if status != CUDA_OCC_SUCCESS:
    return status
  warpsAllocatedPerCTA = occDivideRoundUp(blockSize, properties.warpSize)
  ##  GPUs of compute capability 2.x and higher allocate registers to warps
  ##
  ##  Number of regs per warp is regs per thread x warp size, rounded up to
  ##  register allocation granularity
  ##
  regsPerWarp = attributes.numRegs * properties.warpSize
  regsAllocatedPerWarp = occRoundUp(regsPerWarp, allocationGranularity)
  regsAllocatedPerCTA = regsAllocatedPerWarp * warpsAllocatedPerCTA
  ##  Hardware verifies if a launch fits the per-CTA register limit. For
  ##  historical reasons, the verification logic assumes register
  ##  allocations are made to all partitions simultaneously. Therefore, to
  ##  simulate the hardware check, the warp allocation needs to be rounded
  ##  up to the number of partitions.
  ##
  regsAssumedPerCTA = regsAllocatedPerWarp *
      occRoundUp(warpsAllocatedPerCTA, numSubPartitions)
  if properties.regsPerBlock < regsAssumedPerCTA or
      properties.regsPerBlock < regsAllocatedPerCTA or
      attributes.numRegs > maxRegsPerThread: ##  Software check
  ##  Hardware check
    ##  Per thread limit check
    maxBlocks = 0
  else:
    if regsAllocatedPerWarp > 0:
      ##  Registers are allocated in each sub-partition. The max number
      ##  of warps that can fit on an SM is equal to the max number of
      ##  warps per sub-partition x number of sub-partitions.
      ##
      numRegsPerSubPartition = properties.regsPerMultiprocessor div
          numSubPartitions
      numWarpsPerSubPartition = numRegsPerSubPartition div regsAllocatedPerWarp
      maxBlocks = 0
      if gcConfig[] != PARTITIONED_GC_OFF:
        var numSubPartitionsPerSmPartition: cint
        var numWarpsPerSmPartition: cint
        var maxBlocksPerSmPartition: cint
        ##  If partitioned global caching is on, then a CTA can only
        ##  use a half SM, and thus a half of the registers available
        ##  per SM
        ##
        numSubPartitionsPerSmPartition = numSubPartitions div 2
        numWarpsPerSmPartition = numWarpsPerSubPartition *
            numSubPartitionsPerSmPartition
        maxBlocksPerSmPartition = numWarpsPerSmPartition div
            warpsAllocatedPerCTA
        maxBlocks = maxBlocksPerSmPartition * 2
      if maxBlocks == 0 and gcConfig[] != PARTITIONED_GC_ON_STRICT:
        ##  In case *gcConfig was PARTITIONED_GC_ON flip it OFF since
        ##  this is what it will be if we spread CTA across partitions.
        ##
        gcConfig[] = PARTITIONED_GC_OFF
        numWarpsPerSM = numWarpsPerSubPartition * numSubPartitions
        maxBlocks = numWarpsPerSM div warpsAllocatedPerCTA
    else:
      maxBlocks = cint.high
  resultVar.allocatedRegistersPerBlock = regsAllocatedPerCTA
  limit[] = maxBlocks
  return status

##  Barrier limit
##

proc cudaOccMaxBlocksPerSMBlockBarrierLimit*(limit: ptr cint; ctaLimitBlocks: cint;
    attributes: ptr cudaOccFuncAttributes): cudaOccError {.inline.} =
  var status: cudaOccError = CUDA_OCC_SUCCESS
  var numBarriersAvailable: cint = ctaLimitBlocks * 2
  var numBarriersUsed: cint = attributes.numBlockBarriers
  var maxBlocks: cint = cint.high
  if numBarriersUsed:
    maxBlocks = numBarriersAvailable div numBarriersUsed
  limit[] = maxBlocks
  return status

## ////////////////////////////////
##       API Implementations      //
## ////////////////////////////////

proc cudaOccMaxActiveBlocksPerMultiprocessor*(resultVar: ptr cudaOccResult;
    properties: ptr cudaOccDeviceProp; attributes: ptr cudaOccFuncAttributes;
    state: ptr cudaOccDeviceState; blockSize: cint; dynamicSmemSize: csize_t): cudaOccError {.
    inline.} =
  var status: cudaOccError = CUDA_OCC_SUCCESS
  var ctaLimitWarps: cint = 0
  var ctaLimitBlocks: cint = 0
  var ctaLimitSMem: cint = 0
  var ctaLimitRegs: cint = 0
  var ctaLimitBars: cint = 0
  var ctaLimit: cint = 0
  var limitingFactors: cuint = 0
  var gcConfig: cudaOccPartitionedGCConfig = PARTITIONED_GC_OFF
  if not resultVar or not properties or not attributes or not state or blockSize <= 0:
    return CUDA_OCC_ERROR_INVALID_INPUT
  status = cudaOccInputCheck(properties, attributes, state)
  if status != CUDA_OCC_SUCCESS:
    return status
  gcConfig = cudaOccPartitionedGCExpected(properties, attributes)
  ## ////////////////////////
  ##  Compute occupancy
  ## ////////////////////////
  ##  Limits due to registers/SM
  ##  Also compute if partitioned global caching has to be turned off
  ##
  status = cudaOccMaxBlocksPerSMRegsLimit(addr(ctaLimitRegs), addr(gcConfig),
                                        resultVar, properties, attributes, blockSize)
  if status != CUDA_OCC_SUCCESS:
    return status
  if properties.computeMajor == 6 and properties.computeMinor == 0 and ctaLimitRegs:
    var propertiesGP10x: cudaOccDeviceProp
    var gcConfigGP10x: cudaOccPartitionedGCConfig = gcConfig
    var ctaLimitRegsGP10x: cint = 0
    ##  Set up properties for GP10x
    copyMem(addr(propertiesGP10x), properties, sizeof((propertiesGP10x)))
    propertiesGP10x.computeMinor = 1
    status = cudaOccMaxBlocksPerSMRegsLimit(addr(ctaLimitRegsGP10x),
        addr(gcConfigGP10x), resultVar, addr(propertiesGP10x), attributes, blockSize)
    if status != CUDA_OCC_SUCCESS:
      return status
    if ctaLimitRegsGP10x == 0:
      ctaLimitRegs = 0
  status = cudaOccMaxBlocksPerSMWarpsLimit(addr(ctaLimitWarps), gcConfig,
      properties, attributes, blockSize)
  if status != CUDA_OCC_SUCCESS:
    return status
  status = cudaOccMaxBlocksPerMultiprocessor(addr(ctaLimitBlocks), properties)
  if status != CUDA_OCC_SUCCESS:
    return status
  status = cudaOccMaxBlocksPerSMSmemLimit(addr(ctaLimitSMem), resultVar, properties,
                                        attributes, state, blockSize,
                                        dynamicSmemSize)
  if status != CUDA_OCC_SUCCESS:
    return status
  ctaLimit = occMin(ctaLimitRegs,
                  occMin(ctaLimitSMem, occMin(ctaLimitWarps, ctaLimitBlocks)))
  ##  Determine occupancy limiting factors
  ##
  if ctaLimit == ctaLimitWarps:
    limitingFactors = limitingFactors or OCC_LIMIT_WARPS
  if ctaLimit == ctaLimitRegs:
    limitingFactors = limitingFactors or OCC_LIMIT_REGISTERS
  if ctaLimit == ctaLimitSMem:
    limitingFactors = limitingFactors or OCC_LIMIT_SHARED_MEMORY
  if ctaLimit == ctaLimitBlocks:
    limitingFactors = limitingFactors or OCC_LIMIT_BLOCKS
  if properties.computeMajor >= 9 and attributes.numBlockBarriers > 0:
    ##  Limits due to barrier/SM
    ##
    status = cudaOccMaxBlocksPerSMBlockBarrierLimit(addr(ctaLimitBars),
        ctaLimitBlocks, attributes)
    if status != CUDA_OCC_SUCCESS:
      return status
    ctaLimit = occMin(ctaLimitBars, ctaLimit)
    ##  Determine if this is occupancy limiting factor
    ##
    if ctaLimit == ctaLimitBars:
      limitingFactors = limitingFactors or OCC_LIMIT_BARRIERS
  else:
    ctaLimitBars = INT_MAX
  ##  Fill in the return values
  ##
  resultVar.limitingFactors = limitingFactors
  resultVar.blockLimitRegs = ctaLimitRegs
  resultVar.blockLimitSharedMem = ctaLimitSMem
  resultVar.blockLimitWarps = ctaLimitWarps
  resultVar.blockLimitBlocks = ctaLimitBlocks
  resultVar.blockLimitBarriers = ctaLimitBars
  resultVar.partitionedGCConfig = gcConfig
  ##  Final occupancy
  resultVar.activeBlocksPerMultiprocessor = ctaLimit
  return CUDA_OCC_SUCCESS

proc cudaOccAvailableDynamicSMemPerBlock*(bytesAvailable: ptr csize_t;
    properties: ptr cudaOccDeviceProp; attributes: ptr cudaOccFuncAttributes;
    state: ptr cudaOccDeviceState; numBlocks: cint; blockSize: cint): cudaOccError {.
    inline.} =
  var allocationGranularity: cint
  var smemLimitPerBlock: csize_t
  var smemAvailableForDynamic: csize_t
  var userSmemPreference: csize_t = 0
  var sharedMemPerMultiprocessor: csize_t
  var resultVar: cudaOccResult
  var status: cudaOccError = CUDA_OCC_SUCCESS
  if numBlocks <= 0:
    return CUDA_OCC_ERROR_INVALID_INPUT
  status = cudaOccMaxActiveBlocksPerMultiprocessor(addr(resultVar), properties,
      attributes, state, blockSize, 0)
  if status != CUDA_OCC_SUCCESS:
    return status
  if resultVar.activeBlocksPerMultiprocessor < numBlocks:
    return CUDA_OCC_ERROR_INVALID_INPUT
  status = cudaOccSMemAllocationGranularity(addr(allocationGranularity), properties)
  if status != CUDA_OCC_SUCCESS:
    return status
  status = cudaOccSMemPerBlock(addr(smemLimitPerBlock), properties,
                             attributes.shmemLimitConfig,
                             properties.sharedMemPerMultiprocessor)
  if status != CUDA_OCC_SUCCESS:
    return status
  cudaOccSMemPerMultiprocessor(addr(userSmemPreference), properties, state)
  if numBlocks == 1:
    sharedMemPerMultiprocessor = smemLimitPerBlock
  else:
    if not userSmemPreference:
      userSmemPreference = 1
      status = cudaOccAlignUpShmemSizeVoltaPlus(addr(userSmemPreference),
          properties)
      if status != CUDA_OCC_SUCCESS:
        return status
    sharedMemPerMultiprocessor = userSmemPreference
  ##  Compute total shared memory available per SM
  ##
  smemAvailableForDynamic = sharedMemPerMultiprocessor div numBlocks
  smemAvailableForDynamic = (smemAvailableForDynamic div allocationGranularity) *
      allocationGranularity
  ##  Cap shared memory
  ##
  if smemAvailableForDynamic > smemLimitPerBlock:
    smemAvailableForDynamic = smemLimitPerBlock
  smemAvailableForDynamic = smemAvailableForDynamic - attributes.sharedSizeBytes
  ##  Cap computed dynamic SM by user requested limit specified via cuFuncSetAttribute()
  ##
  if smemAvailableForDynamic > attributes.maxDynamicSharedSizeBytes:
    smemAvailableForDynamic = attributes.maxDynamicSharedSizeBytes
  bytesAvailable[] = smemAvailableForDynamic
  return CUDA_OCC_SUCCESS

proc cudaOccMaxPotentialOccupancyBlockSize*(minGridSize: ptr cint;
    blockSize: ptr cint; properties: ptr cudaOccDeviceProp;
    attributes: ptr cudaOccFuncAttributes; state: ptr cudaOccDeviceState;
    blockSizeToDynamicSMemSize: proc (a1: cint): csize_t; dynamicSMemSize: csize_t): cudaOccError {.
    inline.} =
  var status: cudaOccError = CUDA_OCC_SUCCESS
  var resultVar: cudaOccResult
  ##  Limits
  var occupancyLimit: cint
  var granularity: cint
  var blockSizeLimit: cint
  ##  Recorded maximum
  var maxBlockSize: cint = 0
  var numBlocks: cint = 0
  var maxOccupancy: cint = 0
  ##  Temporary
  var blockSizeToTryAligned: cint
  var blockSizeToTry: cint
  var blockSizeLimitAligned: cint
  var occupancyInBlocks: cint
  var occupancyInThreads: cint
  ## ////////////////////////
  ##  Check user input
  ## ////////////////////////
  if not minGridSize or not blockSize or not properties or not attributes or not state:
    return CUDA_OCC_ERROR_INVALID_INPUT
  status = cudaOccInputCheck(properties, attributes, state)
  if status != CUDA_OCC_SUCCESS:
    return status
  occupancyLimit = properties.maxThreadsPerMultiprocessor
  granularity = properties.warpSize
  blockSizeLimit = occMin(properties.maxThreadsPerBlock,
                        attributes.maxThreadsPerBlock)
  blockSizeLimitAligned = occRoundUp(blockSizeLimit, granularity)
  blockSizeToTryAligned = blockSizeLimitAligned

  var dynamicSMemSizeVar = dynamicSMemSize
  while blockSizeToTryAligned > 0:
    blockSizeToTry = occMin(blockSizeLimit, blockSizeToTryAligned)
    ##  Ignore dynamicSMemSize if the user provides a mapping
    ##
    if blockSizeToDynamicSMemSize:
      dynamicSMemSizeVar = blockSizeToDynamicSMemSize(blockSizeToTry)
    status = cudaOccMaxActiveBlocksPerMultiprocessor(addr(resultVar), properties,
        attributes, state, blockSizeToTry, dynamicSMemSizeVar)
    if status != CUDA_OCC_SUCCESS:
      return status
    occupancyInBlocks = resultVar.activeBlocksPerMultiprocessor
    occupancyInThreads = blockSizeToTry * occupancyInBlocks
    if occupancyInThreads > maxOccupancy:
      maxBlockSize = blockSizeToTry
      numBlocks = occupancyInBlocks
      maxOccupancy = occupancyInThreads
    if occupancyLimit == maxOccupancy:
      break
    dec(blockSizeToTryAligned, granularity)
  ## ////////////////////////
  ##  Return best available
  ## ////////////////////////
  ##  Suggested min grid size to achieve a full machine launch
  ##
  minGridSize[] = numBlocks * properties.numSms
  blockSize[] = maxBlockSize
  return status
