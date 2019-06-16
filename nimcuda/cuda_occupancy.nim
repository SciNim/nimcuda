##  typedef struct {} cudaOccResult;
##  typedef struct {} cudaOccDeviceProp;
##  typedef struct {} cudaOccFuncAttributes;
##  typedef struct {} cudaOccDeviceState;

## *
##  CUDA Occupancy Calculator
##
##  NAME
##
##    cudaOccMaxActiveBlocksPerMultiprocessor,
##    cudaOccMaxPotentialOccupancyBlockSize,
##    cudaOccMaxPotentialOccupancyBlockSizeVariableSMem
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


## *
##  Data structures
##
##  These structures are subject to change for future architecture and CUDA
##  releases. C users should initialize the structure as {0}.
##
##
## *
##  Device descriptor
##
##  This structure describes a device.
##

type
  cudaOccDeviceProp* = object
    computeMajor*: cint        ##  Compute capability major version
    computeMinor*: cint        ##  Compute capability minor
                      ##  version. None supported minor version
                      ##  may cause error
    maxThreadsPerBlock*: cint  ##  Maximum number of threads per block
    maxThreadsPerMultiprocessor*: cint ##  Maximum number of threads per SM
                                     ##  i.e. (Max. number of warps) x (warp
                                     ##  size)
    regsPerBlock*: cint        ##  Maximum number of registers per block
    regsPerMultiprocessor*: cint ##  Maximum number of registers per SM
    warpSize*: cint            ##  Warp size
    sharedMemPerBlock*: csize  ##  Maximum shared memory size per block
    sharedMemPerMultiprocessor*: csize ##  Maximum shared memory size per SM
    numSms*: cint              ##  Number of SMs available


## *
##  Partitioned global caching option
##

type
  cudaOccPartitionedGCConfig* = enum
    PARTITIONED_GC_OFF,       ##  Disable partitioned global caching
    PARTITIONED_GC_ON,        ##  Prefer partitioned global caching
    PARTITIONED_GC_ON_STRICT  ##  Force partitioned global caching


## *
##  Function descriptor
##
##  This structure describes a CUDA function.
##

type
  cudaOccFuncAttributes* = object
    maxThreadsPerBlock*: cint  ##  Maximum block size the function can work with. If
                            ##  unlimited, use INT_MAX or any value greater than
                            ##  or equal to maxThreadsPerBlock of the device
    numRegs*: cint             ##  Number of registers used. When the function is
                 ##  launched on device, the register count may change
                 ##  due to internal tools requirements.
    sharedSizeBytes*: csize    ##  Number of static shared memory used
    partitionedGCConfig*: cudaOccPartitionedGCConfig ##  Partitioned global caching is required to enable
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

  cudaOccCacheConfig* = enum
    CACHE_PREFER_NONE = 0x00000000, ##  no preference for shared memory or L1 (default)
    CACHE_PREFER_SHARED = 0x00000001, ##  prefer larger shared memory and smaller L1 cache
    CACHE_PREFER_L1 = 0x00000002, ##  prefer larger L1 cache and smaller shared memory
    CACHE_PREFER_EQUAL = 0x00000003


## *
##  Device state descriptor
##
##  This structure describes device settings that affect occupancy calculation.
##

type
  cudaOccDeviceState* = object
    cacheConfig*: cudaOccCacheConfig ##  Cache / L1 split preference. Ignored for
                                   ##  sm1x/5x (Tesla/Maxwell)

  cudaOccLimitingFactor* = enum
    OCC_LIMIT_WARPS = 0x00000001, ##  - warps available
    OCC_LIMIT_REGISTERS = 0x00000002, ##  - registers available
    OCC_LIMIT_SHARED_MEMORY = 0x00000004, ##  - shared memory available
    OCC_LIMIT_BLOCKS = 0x00000008


## *
##  Occupancy output
##
##  This structure contains occupancy calculator's output.
##

type
  cudaOccResult* = object
    activeBlocksPerMultiprocessor*: cint ##  Occupancy
    limitingFactors*: cuint    ##  Factors that limited occupancy. A bit
                          ##  field that counts the limiting
                          ##  factors, see cudaOccLimitingFactor
    blockLimitRegs*: cint      ##  Occupancy due to register
                        ##  usage, INT_MAX if the kernel does not
                        ##  use any register.
    blockLimitSharedMem*: cint ##  Occupancy due to shared memory
                             ##  usage, INT_MAX if the kernel does not
                             ##  use shared memory.
    blockLimitWarps*: cint     ##  Occupancy due to block size limit
    blockLimitBlocks*: cint    ##  Occupancy due to maximum number of blocks
                          ##  managable per SM
    allocatedRegistersPerBlock*: cint ##  Actual number of registers allocated per
                                    ##  block
    allocatedSharedMemPerBlock*: csize ##  Actual size of shared memory allocated
                                     ##  per block
    partitionedGCConfig*: cudaOccPartitionedGCConfig ##  Report if partitioned global caching
                                                   ##  is actually enabled.


## *
##  Partitioned global caching support
##
##  See cudaOccPartitionedGlobalCachingModeSupport
##

type
  cudaOccPartitionedGCSupport* = enum
    PARTITIONED_GC_NOT_SUPPORTED, ##  Partitioned global caching is not supported
    PARTITIONED_GC_SUPPORTED, ##  Partitioned global caching is supported
    PARTITIONED_GC_ALWAYS_ON  ##  This is only needed for Pascal. This, and
                            ##  all references / explanations for this,
                            ##  should be removed from the header before
                            ##  exporting to toolkit.


## *
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

# proc cudaOccMaxActiveBlocksPerMultiprocessor(result: ptr cudaOccResult;
#     properties: ptr cudaOccDeviceProp; attributes: ptr cudaOccFuncAttributes;
#     state: ptr cudaOccDeviceState; blockSize: cint; dynamicSmemSize: csize): cudaOccError {.
#     inline.}
##  out
##  in
##  in
##  in
##  in
##  in
## *
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

# proc cudaOccMaxPotentialOccupancyBlockSize(minGridSize: ptr cint;
#     blockSize: ptr cint; properties: ptr cudaOccDeviceProp;
#     attributes: ptr cudaOccFuncAttributes; state: ptr cudaOccDeviceState;
#     blockSizeToDynamicSMemSize: proc (a2: cint): csize; dynamicSMemSize: csize): cudaOccError {.
#     inline.}
##  out
##  out
##  in
##  in
##  in
##  in
##  in
## *
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

## *
##  Implementation
##
## *
##  Max compute capability supported
##

const
  CUDA_OCC_MAJOR* = 6
  CUDA_OCC_MINOR* = 0

## ////////////////////////////////////////
##     Mathematical Helper Functions     //
## ////////////////////////////////////////

proc occMin*(lhs: cint; rhs: cint): cint {.inline.} =
  return if rhs < lhs: rhs else: lhs

proc occDivideRoundUp*(x: cint; y: cint): cint {.inline.} =
  return (x + (y - 1)) div y

proc occRoundUp*(x: cint; y: cint): cint {.inline.} =
  return y * occDivideRoundUp(x, y)

## ////////////////////////////////////////
##       Architectural Properties        //
## ////////////////////////////////////////
## *
##  Granularity of shared memory allocation
##

proc cudaOccSMemAllocationGranularity*(limit: ptr cint;
                                      properties: ptr cudaOccDeviceProp): cudaOccError {.
    inline.} =
  var value: cint
  case properties.computeMajor
  of 2:
    value = 128
  of 3, 5, 6:
    value = 256
  else:
    return CUDA_OCC_ERROR_UNKNOWN_DEVICE
  limit[] = value
  return CUDA_OCC_SUCCESS

## *
##  Granularity of register allocation
##

proc cudaOccRegAllocationGranularity*(limit: ptr cint;
                                     properties: ptr cudaOccDeviceProp;
                                     regsPerThread: cint): cudaOccError {.inline.} =
  var value: cint
  case properties.computeMajor
  of 2:                        ##  Fermi+ allocates registers to warps
      ##
    case regsPerThread
    of 21, 22, 29, 30, 37, 38, 45, 46:
      value = 128
    else:
      value = 64
  of 3, 5, 6:
    value = 256
  else:
    return CUDA_OCC_ERROR_UNKNOWN_DEVICE
  limit[] = value
  return CUDA_OCC_SUCCESS

## *
##  Number of sub-partitions
##

proc cudaOccSubPartitionsPerMultiprocessor*(limit: ptr cint;
    properties: ptr cudaOccDeviceProp): cudaOccError {.inline.} =
  var value: cint
  case properties.computeMajor
  of 2:
    value = 2
  of 3, 5:
    value = 4
  of 6:
    value = 4
  else:
    return CUDA_OCC_ERROR_UNKNOWN_DEVICE
  limit[] = value
  return CUDA_OCC_SUCCESS

## *
##  Maximum number of blocks that can run simultaneously on a multiprocessor
##

proc cudaOccMaxBlocksPerMultiprocessor*(limit: ptr cint;
                                       properties: ptr cudaOccDeviceProp): cudaOccError {.
    inline.} =
  var value: cint
  case properties.computeMajor
  of 2:
    value = 8
  of 3:
    value = 16
  of 5:
    value = 32
  of 6:
    value = 32
  else:
    return CUDA_OCC_ERROR_UNKNOWN_DEVICE
  limit[] = value
  return CUDA_OCC_SUCCESS

## *
##  Shared memory based on config requested by User
##

proc cudaOccSMemPerMultiprocessor*(limit: ptr csize;
                                  properties: ptr cudaOccDeviceProp;
                                  cacheConfig: cudaOccCacheConfig): cudaOccError {.
    inline.} =
  var bytes: csize = 0
  var sharedMemPerMultiprocessorHigh: csize = properties.sharedMemPerMultiprocessor
  ##  Fermi and Kepler has shared L1 cache / shared memory, and support cache
  ##  configuration to trade one for the other. These values are needed to
  ##  calculate the correct shared memory size for user requested cache
  ##  configuration.
  ##
  var minCacheSize: csize = 16384
  var maxCacheSize: csize = 49152
  var cacheAndSharedTotal: csize = sharedMemPerMultiprocessorHigh + minCacheSize
  var sharedMemPerMultiprocessorLow: csize = cacheAndSharedTotal - maxCacheSize
  case properties.computeMajor
  of 2: ##  Fermi supports 48KB / 16KB or 16KB / 48KB partitions for shared /
      ##  L1.
      ##
    case cacheConfig
    of CACHE_PREFER_NONE, CACHE_PREFER_SHARED, CACHE_PREFER_EQUAL:
      bytes = sharedMemPerMultiprocessorHigh
    of CACHE_PREFER_L1:
      bytes = sharedMemPerMultiprocessorLow
  of 3: ##  Kepler supports 16KB, 32KB, or 48KB partitions for L1. The rest
      ##  is shared memory.
      ##
    case cacheConfig
    of CACHE_PREFER_NONE, CACHE_PREFER_SHARED:
      bytes = sharedMemPerMultiprocessorHigh
    of CACHE_PREFER_L1:
      bytes = sharedMemPerMultiprocessorLow
    of CACHE_PREFER_EQUAL: ##  Equal is the mid-point between high and low. It should be
                         ##  equivalent to low + 16KB.
                         ##
      bytes = (sharedMemPerMultiprocessorHigh + sharedMemPerMultiprocessorLow) div
          2
  of 5, 6: 
        ##  Maxwell and Pascal have dedicated shared memory.
        ##
    bytes = sharedMemPerMultiprocessorHigh
  else:
    return CUDA_OCC_ERROR_UNKNOWN_DEVICE
  limit[] = bytes
  return CUDA_OCC_SUCCESS

## *
##  Partitioned global caching mode support
##

proc cudaOccPartitionedGlobalCachingModeSupport*(
    limit: ptr cudaOccPartitionedGCSupport; properties: ptr cudaOccDeviceProp): cudaOccError {.
    inline.} =
  limit[] = PARTITIONED_GC_NOT_SUPPORTED
  if (properties.computeMajor == 5 and
      (properties.computeMinor == 2 or properties.computeMinor == 3)) or
      properties.computeMajor == 6:
    limit[] = PARTITIONED_GC_SUPPORTED
  if properties.computeMajor == 6 and properties.computeMinor == 0:
    limit[] = PARTITIONED_GC_NOT_SUPPORTED
  return CUDA_OCC_SUCCESS

## /////////////////////////////////////////////
##             User Input Sanity              //
## /////////////////////////////////////////////

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

## /////////////////////////////////////////////
##     Occupancy calculation Functions        //
## /////////////////////////////////////////////

proc cudaOccPartitionedGCForced*(properties: ptr cudaOccDeviceProp): bool {.inline.} =
  var gcSupport: cudaOccPartitionedGCSupport
  discard cudaOccPartitionedGlobalCachingModeSupport(addr(gcSupport), properties)
  return gcSupport == PARTITIONED_GC_ALWAYS_ON

proc cudaOccPartitionedGCExpected*(properties: ptr cudaOccDeviceProp;
                                  attributes: ptr cudaOccFuncAttributes): cudaOccPartitionedGCConfig {.
    inline.} =
  var gcSupport: cudaOccPartitionedGCSupport
  var gcConfig: cudaOccPartitionedGCConfig
  discard cudaOccPartitionedGlobalCachingModeSupport(addr(gcSupport), properties)
  gcConfig = attributes.partitionedGCConfig
  if gcSupport == PARTITIONED_GC_NOT_SUPPORTED:
    gcConfig = PARTITIONED_GC_OFF
  if cudaOccPartitionedGCForced(properties):
    gcConfig = PARTITIONED_GC_ON
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

proc cudaOccMaxBlocksPerSMSmemLimit*(limit: ptr cint; res: ptr cudaOccResult;
                                    properties: ptr cudaOccDeviceProp;
                                    attributes: ptr cudaOccFuncAttributes;
                                    state: ptr cudaOccDeviceState; blockSize: cint;
                                    dynamicSmemSize: csize): cudaOccError {.inline.} =
  var status: cudaOccError = CUDA_OCC_SUCCESS
  var allocationGranularity: cint
  var userSmemPreference: csize
  var totalSmemUsagePerCTA: csize
  var smemAllocatedPerCTA: csize
  var sharedMemPerMultiprocessor: csize
  var maxBlocks: cint
  status = cudaOccSMemAllocationGranularity(addr(allocationGranularity), properties)
  if status != CUDA_OCC_SUCCESS:
    return status
  status = cudaOccSMemPerMultiprocessor(addr(userSmemPreference), properties,
                                      state.cacheConfig)
  if status != CUDA_OCC_SUCCESS:
    return status
  totalSmemUsagePerCTA = attributes.sharedSizeBytes + dynamicSmemSize
  smemAllocatedPerCTA = occRoundUp(cast[cint](totalSmemUsagePerCTA),
                                 cast[cint](allocationGranularity))
  if smemAllocatedPerCTA > properties.sharedMemPerBlock:
    maxBlocks = 0
  else:
    ##  User requested shared memory limit is used as long as it is greater
    ##  than the total shared memory used per CTA, i.e. as long as at least
    ##  one CTA can be launched. Otherwise, the maximum shared memory limit
    ##  is used instead.
    ##
    if userSmemPreference >= smemAllocatedPerCTA:
      sharedMemPerMultiprocessor = userSmemPreference
    else:
      sharedMemPerMultiprocessor = properties.sharedMemPerMultiprocessor
    if smemAllocatedPerCTA > 0:
      maxBlocks = (cint)(sharedMemPerMultiprocessor div smemAllocatedPerCTA)
    else:
      maxBlocks = high(cint)
  res.allocatedSharedMemPerBlock = smemAllocatedPerCTA
  limit[] = maxBlocks
  return status

proc cudaOccMaxBlocksPerSMRegsLimit*(limit: ptr cint;
                                    gcConfig: ptr cudaOccPartitionedGCConfig;
                                    res: ptr cudaOccResult;
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
  status = cudaOccRegAllocationGranularity(addr(allocationGranularity), properties,
      attributes.numRegs)
  ##  Fermi requires special handling of certain register usage
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
      properties.regsPerBlock < regsAllocatedPerCTA: ##  Hardware check
    ##  Software check
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
      var gcOff = (gcConfig[] == PARTITIONED_GC_OFF)
      var zeroOccupancy = (maxBlocks == 0)
      var cachingForced = (gcConfig[] == PARTITIONED_GC_ON_STRICT or
          cudaOccPartitionedGCForced(properties))
      if gcOff or (zeroOccupancy and (not cachingForced)):
        gcConfig[] = PARTITIONED_GC_OFF
        numWarpsPerSM = numWarpsPerSubPartition * numSubPartitions
        maxBlocks = numWarpsPerSM div warpsAllocatedPerCTA
    else:
      maxBlocks = high(cint)
  res.allocatedRegistersPerBlock = regsAllocatedPerCTA
  limit[] = maxBlocks
  return status

## /////////////////////////////////
##       API Implementations      //
## /////////////////////////////////

proc cudaOccMaxActiveBlocksPerMultiprocessor*(res: ptr cudaOccResult;
    properties: ptr cudaOccDeviceProp; attributes: ptr cudaOccFuncAttributes;
    state: ptr cudaOccDeviceState; blockSize: cint; dynamicSmemSize: csize): cudaOccError {.
    inline.} =
  var status: cudaOccError = CUDA_OCC_SUCCESS
  var ctaLimitWarps: cint = 0
  var ctaLimitBlocks: cint = 0
  var ctaLimitSMem: cint = 0
  var ctaLimitRegs: cint = 0
  var ctaLimit: cint = 0
  var limitingFactors: cuint = 0
  var gcConfig: cudaOccPartitionedGCConfig = PARTITIONED_GC_OFF
  if res.isNil or properties.isNil or attributes.isNil or state.isNil or blockSize <= 0:
    return CUDA_OCC_ERROR_INVALID_INPUT
  status = cudaOccInputCheck(properties, attributes, state)
  if status != CUDA_OCC_SUCCESS:
    return status
  gcConfig = cudaOccPartitionedGCExpected(properties, attributes)
  ## /////////////////////////
  ##  Compute occupancy
  ## /////////////////////////
  ##  Limits due to registers/SM
  ##  Also compute if partitioned global caching has to be turned off
  ##
  status = cudaOccMaxBlocksPerSMRegsLimit(addr(ctaLimitRegs), addr(gcConfig),
                                        res, properties, attributes, blockSize)
  if status != CUDA_OCC_SUCCESS:
    return status
  status = cudaOccMaxBlocksPerSMWarpsLimit(addr(ctaLimitWarps), gcConfig,
      properties, attributes, blockSize)
  if status != CUDA_OCC_SUCCESS:
    return status
  status = cudaOccMaxBlocksPerMultiprocessor(addr(ctaLimitBlocks), properties)
  if status != CUDA_OCC_SUCCESS:
    return status
  status = cudaOccMaxBlocksPerSMSmemLimit(addr(ctaLimitSMem), res, properties,
                                        attributes, state, blockSize,
                                        dynamicSmemSize)
  if status != CUDA_OCC_SUCCESS:
    return status
  ctaLimit = occMin(ctaLimitRegs,
                  occMin(ctaLimitSMem, occMin(ctaLimitWarps, ctaLimitBlocks)))
  ##  Fill in the return values
  ##
  ##  Determine occupancy limiting factors
  ##
  if ctaLimit == ctaLimitWarps:
    limitingFactors = limitingFactors or OCC_LIMIT_WARPS.cuint
  if ctaLimit == ctaLimitRegs:
    limitingFactors = limitingFactors or OCC_LIMIT_REGISTERS.cuint
  if ctaLimit == ctaLimitSMem:
    limitingFactors = limitingFactors or OCC_LIMIT_SHARED_MEMORY.cuint
  if ctaLimit == ctaLimitBlocks:
    limitingFactors = limitingFactors or OCC_LIMIT_BLOCKS.cuint
  res.limitingFactors = limitingFactors
  res.blockLimitRegs = ctaLimitRegs
  res.blockLimitSharedMem = ctaLimitSMem
  res.blockLimitWarps = ctaLimitWarps
  res.blockLimitBlocks = ctaLimitBlocks
  res.partitionedGCConfig = gcConfig
  ##  Final occupancy
  res.activeBlocksPerMultiprocessor = ctaLimit
  return CUDA_OCC_SUCCESS

proc cudaOccMaxPotentialOccupancyBlockSize*(minGridSize: ptr cint;
    blockSize: ptr cint; properties: ptr cudaOccDeviceProp;
    attributes: ptr cudaOccFuncAttributes; state: ptr cudaOccDeviceState;
    blockSizeToDynamicSMemSize: proc (a2: cint): csize; dynamicSMemSize: var csize): cudaOccError {.
    inline.} =
  var status: cudaOccError = CUDA_OCC_SUCCESS
  var res: cudaOccResult
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
  ## /////////////////////////
  ##  Check user input
  ## /////////////////////////
  if minGridSize.isNil or blockSize.isNil or properties.isNil or attributes.isNil or state.isNil:
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
  while blockSizeToTryAligned > 0:
    blockSizeToTry = occMin(blockSizeLimit, blockSizeToTryAligned)
    ##  Ignore dynamicSMemSize if the user provides a mapping
    ##
    if not blockSizeToDynamicSMemSize.isNil:
      dynamicSMemSize = blockSizeToDynamicSMemSize(blockSizeToTry)
    status = cudaOccMaxActiveBlocksPerMultiprocessor(addr(res), properties,
        attributes, state, blockSizeToTry, dynamicSMemSize)
    if status != CUDA_OCC_SUCCESS:
      return status
    occupancyInBlocks = res.activeBlocksPerMultiprocessor
    occupancyInThreads = blockSizeToTry * occupancyInBlocks
    if occupancyInThreads > maxOccupancy:
      maxBlockSize = blockSizeToTry
      numBlocks = occupancyInBlocks
      maxOccupancy = occupancyInThreads
    if occupancyLimit == maxOccupancy:
      break
    dec(blockSizeToTryAligned, granularity)
  ## /////////////////////////
  ##  Return best available
  ## /////////////////////////
  ##  Suggested min grid size to achieve a full machine launch
  ##
  minGridSize[] = numBlocks * properties.numSms
  blockSize[] = maxBlockSize
  return status
