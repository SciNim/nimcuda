##  #pp cudaDevicePropDontCare

##
##  Copyright 1993-2023 NVIDIA Corporation.  All rights reserved.
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

##  #ifndef __DOXYGEN_ONLY__
##  #include "crt/host_defines.h"
##  #endif

import
  vector_types

import ./libpaths
tellCompilerToUseCuda()

when not defined(CUDACC_RTC_MINIMAL):
  ##
  ##  \defgroup CUDART_TYPES Data types used by CUDA Runtime
  ##  \ingroup CUDART
  ##
  ##  @{
  ##
  ## *****************************************************************************
  ##                                                                               *
  ##   TYPE DEFINITIONS USED BY RUNTIME API                                        *
  ##                                                                               *
  ## *****************************************************************************
  when not defined(CUDA_INTERNAL_COMPILATION):
    when not defined(CUDACC_RTC):
      discard
    const
      cudaHostAllocDefault* = 0x00
      cudaHostAllocPortable* = 0x01
      cudaHostAllocMapped* = 0x02
      cudaHostAllocWriteCombined* = 0x04
      cudaHostRegisterDefault* = 0x00
      cudaHostRegisterPortable* = 0x01
      cudaHostRegisterMapped* = 0x02
      cudaHostRegisterIoMemory* = 0x04
      cudaHostRegisterReadOnly* = 0x08
      cudaPeerAccessDefault* = 0x00
      cudaStreamDefault* = 0x00
      cudaStreamNonBlocking* = 0x01
      cudaEventDefault* = 0x00
      cudaEventBlockingSync* = 0x01
      cudaEventDisableTiming* = 0x02
      cudaEventInterprocess* = 0x04
      cudaEventRecordDefault* = 0x00
      cudaEventRecordExternal* = 0x01
      cudaEventWaitDefault* = 0x00
      cudaEventWaitExternal* = 0x01
      cudaDeviceScheduleAuto* = 0x00
      cudaDeviceScheduleSpin* = 0x01
      cudaDeviceScheduleYield* = 0x02
      cudaDeviceScheduleBlockingSync* = 0x04
      cudaDeviceBlockingSync* = 0x04
      cudaDeviceScheduleMask* = 0x07
      cudaDeviceMapHost* = 0x08
      cudaDeviceLmemResizeToMax* = 0x10
      cudaDeviceSyncMemops* = 0x80
      cudaDeviceMask* = 0xff
      cudaArrayDefault* = 0x00
      cudaArrayLayered* = 0x01
      cudaArraySurfaceLoadStore* = 0x02
      cudaArrayCubemap* = 0x04
      cudaArrayTextureGather* = 0x08
      cudaArrayColorAttachment* = 0x20
      cudaArraySparse* = 0x40
      cudaArrayDeferredMapping* = 0x80
      cudaIpcMemLazyEnablePeerAccess* = 0x01
      cudaMemAttachGlobal* = 0x01
      cudaMemAttachHost* = 0x02
      cudaMemAttachSingle* = 0x04
      cudaOccupancyDefault* = 0x00
      cudaOccupancyDisableCachingOverride* = 0x01
      cudaCpuDeviceId* = (cint)(-1) ## < Device id that represents the CPU
      cudaInvalidDeviceId* = (cint)(-2) ## < Device id that represents an invalid device
      cudaInitDeviceFlagsAreValid* = 0x01
    ##
    ##  If set, each kernel launched as part of ::cudaLaunchCooperativeKernelMultiDevice only
    ##  waits for prior work in the stream corresponding to that GPU to complete before the
    ##  kernel begins execution.
    ##
    const
      cudaCooperativeLaunchMultiDeviceNoPreSync* = 0x01
    ##
    ##  If set, any subsequent work pushed in a stream that participated in a call to
    ##  ::cudaLaunchCooperativeKernelMultiDevice will only wait for the kernel launched on
    ##  the GPU corresponding to that stream to complete before it begins execution.
    ##
    const
      cudaCooperativeLaunchMultiDeviceNoPostSync* = 0x02
  ##  \cond impl_private
  ## #if defined(DOXYGEN_ONLY) || defined(CUDA_ENABLE_DEPRECATED)
  ## #define __CUDA_DEPRECATED
  ## #elif defined(MSC_VER)
  ## #define __CUDA_DEPRECATED __declspec(deprecated)
  ## #elif defined(GNUC)
  ## #define __CUDA_DEPRECATED __attribute__((deprecated))
  ## #else
  ##  #endif
  ##  \endcond impl_private
  ## *****************************************************************************
  ##                                                                               *
  ##                                                                               *
  ##                                                                               *
  ## *****************************************************************************
  ##
  ##  CUDA error types
  ##
  type
    cudaError* = enum ##
                   ##  The API call returned with no errors. In the case of query calls, this
                   ##  also means that the operation being queried is complete (see
                   ##  ::cudaEventQuery() and ::cudaStreamQuery()).
                   ##
      cudaSuccess = 0, ##
                    ##  This indicates that one or more of the parameters passed to the API call
                    ##  is not within an acceptable range of values.
                    ##
      cudaErrorInvalidValue = 1, ##
                              ##  The API call failed because it was unable to allocate enough memory or
                              ##  other resources to perform the requested operation.
                              ##
      cudaErrorMemoryAllocation = 2, ##
                                  ##  The API call failed because the CUDA driver and runtime could not be
                                  ##  initialized.
                                  ##
      cudaErrorInitializationError = 3, ##
                                     ##  This indicates that a CUDA Runtime API call cannot be executed because
                                     ##  it is being called during process shut down, at a point in time after
                                     ##  CUDA driver has been unloaded.
                                     ##
      cudaErrorCudartUnloading = 4, ##
                                 ##  This indicates profiler is not initialized for this run. This can
                                 ##  happen when the application is running with external profiling tools
                                 ##  like visual profiler.
                                 ##
      cudaErrorProfilerDisabled = 5, ##
                                  ##  \deprecated
                                  ##  This error return is deprecated as of CUDA 5.0. It is no longer an error
                                  ##  to attempt to enable/disable the profiling via ::cudaProfilerStart or
                                  ##  ::cudaProfilerStop without initialization.
                                  ##
      cudaErrorProfilerNotInitialized = 6, ##
                                        ##  \deprecated
                                        ##  This error return is deprecated as of CUDA 5.0. It is no longer an error
                                        ##  to call cudaProfilerStart() when profiling is already enabled.
                                        ##
      cudaErrorProfilerAlreadyStarted = 7, ##
                                        ##  \deprecated
                                        ##  This error return is deprecated as of CUDA 5.0. It is no longer an error
                                        ##  to call cudaProfilerStop() when profiling is already disabled.
                                        ##
      cudaErrorProfilerAlreadyStopped = 8, ##
                                        ##  This indicates that a kernel launch is requesting resources that can
                                        ##  never be satisfied by the current device. Requesting more shared memory
                                        ##  per block than the device supports will trigger this error, as will
                                        ##  requesting too many threads or blocks. See ::cudaDeviceProp for more
                                        ##  device limitations.
                                        ##
      cudaErrorInvalidConfiguration = 9, ##
                                      ##  This indicates that one or more of the pitch-related parameters passed
                                      ##  to the API call is not within the acceptable range for pitch.
                                      ##
      cudaErrorInvalidPitchValue = 12, ##
                                    ##  This indicates that the symbol name/identifier passed to the API call
                                    ##  is not a valid name or identifier.
                                    ##
      cudaErrorInvalidSymbol = 13, ##
                                ##  This indicates that at least one host pointer passed to the API call is
                                ##  not a valid host pointer.
                                ##  \deprecated
                                ##  This error return is deprecated as of CUDA 10.1.
                                ##
      cudaErrorInvalidHostPointer = 16, ##
                                     ##  This indicates that at least one device pointer passed to the API call is
                                     ##  not a valid device pointer.
                                     ##  \deprecated
                                     ##  This error return is deprecated as of CUDA 10.1.
                                     ##
      cudaErrorInvalidDevicePointer = 17, ##
                                       ##  This indicates that the texture passed to the API call is not a valid
                                       ##  texture.
                                       ##
      cudaErrorInvalidTexture = 18, ##
                                 ##  This indicates that the texture binding is not valid. This occurs if you
                                 ##  call ::cudaGetTextureAlignmentOffset() with an unbound texture.
                                 ##
      cudaErrorInvalidTextureBinding = 19, ##
                                        ##  This indicates that the channel descriptor passed to the API call is not
                                        ##  valid. This occurs if the format is not one of the formats specified by
                                        ##  ::cudaChannelFormatKind, or if one of the dimensions is invalid.
                                        ##
      cudaErrorInvalidChannelDescriptor = 20, ##
                                           ##  This indicates that the direction of the copyMem passed to the API call is
                                           ##  not one of the types specified by ::cudaMemcpyKind.
                                           ##
      cudaErrorInvalidMemcpyDirection = 21, ##
                                         ##  This indicated that the user has taken the address of a constant variable,
                                         ##  which was forbidden up until the CUDA 3.1 release.
                                         ##  \deprecated
                                         ##  This error return is deprecated as of CUDA 3.1. Variables in constant
                                         ##  memory may now have their address taken by the runtime via
                                         ##  ::cudaGetSymbolAddress().
                                         ##
      cudaErrorAddressOfConstant = 22, ##
                                    ##  This indicated that a texture fetch was not able to be performed.
                                    ##  This was previously used for device emulation of texture operations.
                                    ##  \deprecated
                                    ##  This error return is deprecated as of CUDA 3.1. Device emulation mode was
                                    ##  removed with the CUDA 3.1 release.
                                    ##
      cudaErrorTextureFetchFailed = 23, ##
                                     ##  This indicated that a texture was not bound for access.
                                     ##  This was previously used for device emulation of texture operations.
                                     ##  \deprecated
                                     ##  This error return is deprecated as of CUDA 3.1. Device emulation mode was
                                     ##  removed with the CUDA 3.1 release.
                                     ##
      cudaErrorTextureNotBound = 24, ##
                                  ##  This indicated that a synchronization operation had failed.
                                  ##  This was previously used for some device emulation functions.
                                  ##  \deprecated
                                  ##  This error return is deprecated as of CUDA 3.1. Device emulation mode was
                                  ##  removed with the CUDA 3.1 release.
                                  ##
      cudaErrorSynchronizationError = 25, ##
                                       ##  This indicates that a non-float texture was being accessed with linear
                                       ##  filtering. This is not supported by CUDA.
                                       ##
      cudaErrorInvalidFilterSetting = 26, ##
                                       ##  This indicates that an attempt was made to read a non-float texture as a
                                       ##  normalized float. This is not supported by CUDA.
                                       ##
      cudaErrorInvalidNormSetting = 27, ##
                                     ##  Mixing of device and device emulation code was not allowed.
                                     ##  \deprecated
                                     ##  This error return is deprecated as of CUDA 3.1. Device emulation mode was
                                     ##  removed with the CUDA 3.1 release.
                                     ##
      cudaErrorMixedDeviceExecution = 28, ##
                                       ##  This indicates that the API call is not yet implemented. Production
                                       ##  releases of CUDA will never return this error.
                                       ##  \deprecated
                                       ##  This error return is deprecated as of CUDA 4.1.
                                       ##
      cudaErrorNotYetImplemented = 31, ##
                                    ##  This indicated that an emulated device pointer exceeded the 32-bit address
                                    ##  range.
                                    ##  \deprecated
                                    ##  This error return is deprecated as of CUDA 3.1. Device emulation mode was
                                    ##  removed with the CUDA 3.1 release.
                                    ##
      cudaErrorMemoryValueTooLarge = 32, ##
                                      ##  This indicates that the CUDA driver that the application has loaded is a
                                      ##  stub library. Applications that run with the stub rather than a real
                                      ##  driver loaded will resultNotKeyWord in CUDA API returning this error.
                                      ##
      cudaErrorStubLibrary = 34, ##
                              ##  This indicates that the installed NVIDIA CUDA driver is older than the
                              ##  CUDA runtime library. This is not a supported configuration. Users should
                              ##  install an updated NVIDIA display driver to allow the application to run.
                              ##
      cudaErrorInsufficientDriver = 35, ##
                                     ##  This indicates that the API call requires a newer CUDA driver than the one
                                     ##  currently installed. Users should install an updated NVIDIA CUDA driver
                                     ##  to allow the API call to succeed.
                                     ##
      cudaErrorCallRequiresNewerDriver = 36, ##
                                          ##  This indicates that the surface passed to the API call is not a valid
                                          ##  surface.
                                          ##
      cudaErrorInvalidSurface = 37, ##
                                 ##  This indicates that multiple global or constant variables (across separate
                                 ##  CUDA source files in the application) share the same string name.
                                 ##
      cudaErrorDuplicateVariableName = 43, ##
                                        ##  This indicates that multiple textures (across separate CUDA source
                                        ##  files in the application) share the same string name.
                                        ##
      cudaErrorDuplicateTextureName = 44, ##
                                       ##  This indicates that multiple surfaces (across separate CUDA source
                                       ##  files in the application) share the same string name.
                                       ##
      cudaErrorDuplicateSurfaceName = 45, ##
                                       ##  This indicates that all CUDA devices are busy or unavailable at the current
                                       ##  time. Devices are often busy/unavailable due to use of
                                       ##  ::cudaComputeModeProhibited, ::cudaComputeModeExclusiveProcess, or when long
                                       ##  running CUDA kernels have filled up the GPU and are blocking new work
                                       ##  from starting. They can also be unavailable due to memory constraints
                                       ##  on a device that already has active CUDA work being performed.
                                       ##
      cudaErrorDevicesUnavailable = 46, ##
                                     ##  This indicates that the current context is not compatible with this
                                     ##  the CUDA Runtime. This can only occur if you are using CUDA
                                     ##  Runtime/Driver interoperability and have created an existing Driver
                                     ##  context using the driver API. The Driver context may be incompatible
                                     ##  either because the Driver context was created using an older version
                                     ##  of the API, because the Runtime API call expects a primary driver
                                     ##  context and the Driver context is not primary, or because the Driver
                                     ##  context has been destroyed. Please see \ref CUDART_DRIVER "Interactions
                                     ##  with the CUDA Driver API" for more information.
                                     ##
      cudaErrorIncompatibleDriverContext = 49, ##
                                            ##  The device function being invoked (usually via ::cudaLaunchKernel()) was not
                                            ##  previously configured via the ::cudaConfigureCall() function.
                                            ##
      cudaErrorMissingConfiguration = 52, ##
                                       ##  This indicated that a previous kernel launch failed. This was previously
                                       ##  used for device emulation of kernel launches.
                                       ##  \deprecated
                                       ##  This error return is deprecated as of CUDA 3.1. Device emulation mode was
                                       ##  removed with the CUDA 3.1 release.
                                       ##
      cudaErrorPriorLaunchFailure = 53, ##
                                     ##  This error indicates that a device runtime grid launch did not occur
                                     ##  because the depth of the child grid would exceed the maximum supported
                                     ##  number of nested grid launches.
                                     ##
      cudaErrorLaunchMaxDepthExceeded = 65, ##
                                         ##  This error indicates that a grid launch did not occur because the kernel
                                         ##  uses file-scoped textures which are unsupported by the device runtime.
                                         ##  Kernels launched via the device runtime only support textures created with
                                         ##  the Texture Object API's.
                                         ##
      cudaErrorLaunchFileScopedTex = 66, ##
                                      ##  This error indicates that a grid launch did not occur because the kernel
                                      ##  uses file-scoped surfaces which are unsupported by the device runtime.
                                      ##  Kernels launched via the device runtime only support surfaces created with
                                      ##  the Surface Object API's.
                                      ##
      cudaErrorLaunchFileScopedSurf = 67, ##
                                       ##  This error indicates that a call to ::cudaDeviceSynchronize made from
                                       ##  the device runtime failed because the call was made at grid depth greater
                                       ##  than than either the default (2 levels of grids) or user specified device
                                       ##  limit ::cudaLimitDevRuntimeSyncDepth. To be able to synchronize on
                                       ##  launched grids at a greater depth successfully, the maximum nested
                                       ##  depth at which ::cudaDeviceSynchronize will be called must be specified
                                       ##  with the ::cudaLimitDevRuntimeSyncDepth limit to the ::cudaDeviceSetLimit
                                       ##  api before the host-side launch of a kernel using the device runtime.
                                       ##  Keep in mind that additional levels of sync depth require the runtime
                                       ##  to reserve large amounts of device memory that cannot be used for
                                       ##  user allocations. Note that ::cudaDeviceSynchronize made from device
                                       ##  runtime is only supported on devices of compute capability < 9.0.
                                       ##
      cudaErrorSyncDepthExceeded = 68, ##
                                    ##  This error indicates that a device runtime grid launch failed because
                                    ##  the launch would exceed the limit ::cudaLimitDevRuntimePendingLaunchCount.
                                    ##  For this launch to proceed successfully, ::cudaDeviceSetLimit must be
                                    ##  called to set the ::cudaLimitDevRuntimePendingLaunchCount to be higher
                                    ##  than the upper bound of outstanding launches that can be issued to the
                                    ##  device runtime. Keep in mind that raising the limit of pending device
                                    ##  runtime launches will require the runtime to reserve device memory that
                                    ##  cannot be used for user allocations.
                                    ##
      cudaErrorLaunchPendingCountExceeded = 69, ##
                                             ##  The requested device function does not exist or is not compiled for the
                                             ##  proper device architecture.
                                             ##
      cudaErrorInvalidDeviceFunction = 98, ##
                                        ##  This indicates that no CUDA-capable devices were detected by the installed
                                        ##  CUDA driver.
                                        ##
      cudaErrorNoDevice = 100, ##
                            ##  This indicates that the device ordinal supplied by the user does not
                            ##  correspond to a valid CUDA device or that the action requested is
                            ##  invalid for the specified device.
                            ##
      cudaErrorInvalidDevice = 101, ##
                                 ##  This indicates that the device doesn't have a valid Grid License.
                                 ##
      cudaErrorDeviceNotLicensed = 102, ##
                                     ##  By default, the CUDA runtime may perform a minimal set of self-tests,
                                     ##  as well as CUDA driver tests, to establish the validity of both.
                                     ##  Introduced in CUDA 11.2, this error return indicates that at least one
                                     ##  of these tests has failed and the validity of either the runtime
                                     ##  or the driver could not be established.
                                     ##
      cudaErrorSoftwareValidityNotEstablished = 103, ##
                                                  ##  This indicates an internal startup failure in the CUDA runtime.
                                                  ##
      cudaErrorStartupFailure = 127, ##
                                  ##  This indicates that the device kernel image is invalid.
                                  ##
      cudaErrorInvalidKernelImage = 200, ##
                                      ##  This most frequently indicates that there is no context bound to the
                                      ##  current thread. This can also be returned if the context passed to an
                                      ##  API call is not a valid handle (such as a context that has had
                                      ##  ::cuCtxDestroy() invoked on it). This can also be returned if a user
                                      ##  mixes different API versions (i.e. 3010 context with 3020 API calls).
                                      ##  See ::cuCtxGetApiVersion() for more details.
                                      ##
      cudaErrorDeviceUninitialized = 201, ##
                                       ##  This indicates that the buffer object could not be mapped.
                                       ##
      cudaErrorMapBufferObjectFailed = 205, ##
                                         ##  This indicates that the buffer object could not be unmapped.
                                         ##
      cudaErrorUnmapBufferObjectFailed = 206, ##
                                           ##  This indicates that the specified array is currently mapped and thus
                                           ##  cannot be destroyed.
                                           ##
      cudaErrorArrayIsMapped = 207, ##
                                 ##  This indicates that the resource is already mapped.
                                 ##
      cudaErrorAlreadyMapped = 208, ##
                                 ##  This indicates that there is no kernel image available that is suitable
                                 ##  for the device. This can occur when a user specifies code generation
                                 ##  options for a particular CUDA source file that do not include the
                                 ##  corresponding device configuration.
                                 ##
      cudaErrorNoKernelImageForDevice = 209, ##
                                          ##  This indicates that a resource has already been acquired.
                                          ##
      cudaErrorAlreadyAcquired = 210, ##
                                   ##  This indicates that a resource is not mapped.
                                   ##
      cudaErrorNotMapped = 211, ##
                             ##  This indicates that a mapped resource is not available for access as an
                             ##  array.
                             ##
      cudaErrorNotMappedAsArray = 212, ##
                                    ##  This indicates that a mapped resource is not available for access as a
                                    ##  pointer.
                                    ##
      cudaErrorNotMappedAsPointer = 213, ##
                                      ##  This indicates that an uncorrectable ECC error was detected during
                                      ##  execution.
                                      ##
      cudaErrorECCUncorrectable = 214, ##
                                    ##  This indicates that the ::cudaLimit passed to the API call is not
                                    ##  supported by the active device.
                                    ##
      cudaErrorUnsupportedLimit = 215, ##
                                    ##  This indicates that a call tried to access an exclusive-thread device that
                                    ##  is already in use by a different thread.
                                    ##
      cudaErrorDeviceAlreadyInUse = 216, ##
                                      ##  This error indicates that P2P access is not supported across the given
                                      ##  devices.
                                      ##
      cudaErrorPeerAccessUnsupported = 217, ##
                                         ##  A PTX compilation failed. The runtime may fall back to compiling PTX if
                                         ##  an application does not contain a suitable binary for the current device.
                                         ##
      cudaErrorInvalidPtx = 218, ##
                              ##  This indicates an error with the OpenGL or DirectX context.
                              ##
      cudaErrorInvalidGraphicsContext = 219, ##
                                          ##  This indicates that an uncorrectable NVLink error was detected during the
                                          ##  execution.
                                          ##
      cudaErrorNvlinkUncorrectable = 220, ##
                                       ##  This indicates that the PTX JIT compiler library was not found. The JIT Compiler
                                       ##  library is used for PTX compilation. The runtime may fall back to compiling PTX
                                       ##  if an application does not contain a suitable binary for the current device.
                                       ##
      cudaErrorJitCompilerNotFound = 221, ##
                                       ##  This indicates that the provided PTX was compiled with an unsupported toolchain.
                                       ##  The most common reason for this, is the PTX was generated by a compiler newer
                                       ##  than what is supported by the CUDA driver and PTX JIT compiler.
                                       ##
      cudaErrorUnsupportedPtxVersion = 222, ##
                                         ##  This indicates that the JIT compilation was disabled. The JIT compilation compiles
                                         ##  PTX. The runtime may fall back to compiling PTX if an application does not contain
                                         ##  a suitable binary for the current device.
                                         ##
      cudaErrorJitCompilationDisabled = 223, ##
                                          ##  This indicates that the provided execution affinity is not supported by the device.
                                          ##
      cudaErrorUnsupportedExecAffinity = 224, ##
                                           ##  This indicates that the code to be compiled by the PTX JIT contains
                                           ##  unsupported call to cudaDeviceSynchronize.
                                           ##
      cudaErrorUnsupportedDevSideSync = 225, ##
                                          ##  This indicates that the device kernel source is invalid.
                                          ##
      cudaErrorInvalidSource = 300, ##
                                 ##  This indicates that the file specified was not found.
                                 ##
      cudaErrorFileNotFound = 301, ##
                                ##  This indicates that a link to a shared object failed to resolve.
                                ##
      cudaErrorSharedObjectSymbolNotFound = 302, ##
                                              ##  This indicates that initialization of a shared object failed.
                                              ##
      cudaErrorSharedObjectInitFailed = 303, ##
                                          ##  This error indicates that an OS call failed.
                                          ##
      cudaErrorOperatingSystem = 304, ##
                                   ##  This indicates that a resource handle passed to the API call was not
                                   ##  valid. Resource handles are opaque types like ::cudaStream_t and
                                   ##  ::cudaEvent_t.
                                   ##
      cudaErrorInvalidResourceHandle = 400, ##
                                         ##  This indicates that a resource required by the API call is not in a
                                         ##  valid state to perform the requested operation.
                                         ##
      cudaErrorIllegalState = 401, ##
                                ##  This indicates an attempt was made to introspect an object in a way that
                                ##  would discard semantically important information. This is either due to
                                ##  the object using funtionality newer than the API version used to
                                ##  introspect it or omission of optional return arguments.
                                ##
      cudaErrorLossyQuery = 402, ##
                              ##  This indicates that a named symbol was not found. Examples of symbols
                              ##  are global/constant variable names, driver function names, texture names,
                              ##  and surface names.
                              ##
      cudaErrorSymbolNotFound = 500, ##
                                  ##  This indicates that asynchronous operations issued previously have not
                                  ##  completed yet. This resultNotKeyWord is not actually an error, but must be indicated
                                  ##  differently than ::cudaSuccess (which indicates completion). Calls that
                                  ##  may return this value include ::cudaEventQuery() and ::cudaStreamQuery().
                                  ##
      cudaErrorNotReady = 600, ##
                            ##  The device encountered a load or store instruction on an invalid memory address.
                            ##  This leaves the process in an inconsistent state and any further CUDA work
                            ##  will return the same error. To continue using CUDA, the process must be terminated
                            ##  and relaunched.
                            ##
      cudaErrorIllegalAddress = 700, ##
                                  ##  This indicates that a launch did not occur because it did not have
                                  ##  appropriate resources. Although this error is similar to
                                  ##  ::cudaErrorInvalidConfiguration, this error usually indicates that the
                                  ##  user has attempted to pass too many arguments to the device kernel, or the
                                  ##  kernel launch specifies too many threads for the kernel's register count.
                                  ##
      cudaErrorLaunchOutOfResources = 701, ##
                                        ##  This indicates that the device kernel took too long to execute. This can
                                        ##  only occur if timeouts are enabled - see the device property
                                        ##  \ref
                                        ## ::cudaDeviceProp::kernelExecTimeoutEnabled "kernelExecTimeoutEnabled"
                                        ##  for more information.
                                        ##  This leaves the process in an inconsistent state and any further CUDA work
                                        ##  will return the same error. To continue using CUDA, the process must be terminated
                                        ##  and relaunched.
                                        ##
      cudaErrorLaunchTimeout = 702, ##
                                 ##  This error indicates a kernel launch that uses an incompatible texturing
                                 ##  mode.
                                 ##
      cudaErrorLaunchIncompatibleTexturing = 703, ##
                                               ##  This error indicates that a call to ::cudaDeviceEnablePeerAccess() is
                                               ##  trying to re-enable peer addressing on from a context which has already
                                               ##  had peer addressing enabled.
                                               ##
      cudaErrorPeerAccessAlreadyEnabled = 704, ##
                                            ##  This error indicates that ::cudaDeviceDisablePeerAccess() is trying to
                                            ##  disable peer addressing which has not been enabled yet via
                                            ##  ::cudaDeviceEnablePeerAccess().
                                            ##
      cudaErrorPeerAccessNotEnabled = 705, ##
                                        ##  This indicates that the user has called ::cudaSetValidDevices(),
                                        ##  ::cudaSetDeviceFlags(), ::cudaD3D9SetDirect3DDevice(),
                                        ##  ::cudaD3D10SetDirect3DDevice, ::cudaD3D11SetDirect3DDevice(), or
                                        ##  ::cudaVDPAUSetVDPAUDevice() after initializing the CUDA runtime by
                                        ##  calling non-device management operations (allocating memory and
                                        ##  launching kernels are examples of non-device management operations).
                                        ##  This error can also be returned if using runtime/driver
                                        ##  interoperability and there is an existing ::CUcontext active on the
                                        ##  host thread.
                                        ##
      cudaErrorSetOnActiveProcess = 708, ##
                                      ##  This error indicates that the context current to the calling thread
                                      ##  has been destroyed using ::cuCtxDestroy, or is a primary context which
                                      ##  has not yet been initialized.
                                      ##
      cudaErrorContextIsDestroyed = 709, ##
                                      ##  An assert triggered in device code during kernel execution. The device
                                      ##  cannot be used again. All existing allocations are invalid. To continue
                                      ##  using CUDA, the process must be terminated and relaunched.
                                      ##
      cudaErrorAssert = 710, ##
                          ##  This error indicates that the hardware resources required to enable
                          ##  peer access have been exhausted for one or more of the devices
                          ##  passed to ::cudaEnablePeerAccess().
                          ##
      cudaErrorTooManyPeers = 711, ##
                                ##  This error indicates that the memory range passed to ::cudaHostRegister()
                                ##  has already been registered.
                                ##
      cudaErrorHostMemoryAlreadyRegistered = 712, ##
                                               ##  This error indicates that the pointer passed to ::cudaHostUnregister()
                                               ##  does not correspond to any currently registered memory region.
                                               ##
      cudaErrorHostMemoryNotRegistered = 713, ##
                                           ##  Device encountered an error in the call stack during kernel execution,
                                           ##  possibly due to stack corruption or exceeding the stack size limit.
                                           ##  This leaves the process in an inconsistent state and any further CUDA work
                                           ##  will return the same error. To continue using CUDA, the process must be terminated
                                           ##  and relaunched.
                                           ##
      cudaErrorHardwareStackError = 714, ##
                                      ##  The device encountered an illegal instruction during kernel execution
                                      ##  This leaves the process in an inconsistent state and any further CUDA work
                                      ##  will return the same error. To continue using CUDA, the process must be terminated
                                      ##  and relaunched.
                                      ##
      cudaErrorIllegalInstruction = 715, ##
                                      ##  The device encountered a load or store instruction
                                      ##  on a memory address which is not aligned.
                                      ##  This leaves the process in an inconsistent state and any further CUDA work
                                      ##  will return the same error. To continue using CUDA, the process must be terminated
                                      ##  and relaunched.
                                      ##
      cudaErrorMisalignedAddress = 716, ##
                                     ##  While executing a kernel, the device encountered an instruction
                                     ##  which can only operate on memory locations in certain address spaces
                                     ##  (global, shared, or local), but was supplied a memory address not
                                     ##  belonging to an allowed address space.
                                     ##  This leaves the process in an inconsistent state and any further CUDA work
                                     ##  will return the same error. To continue using CUDA, the process must be terminated
                                     ##  and relaunched.
                                     ##
      cudaErrorInvalidAddressSpace = 717, ##
                                       ##  The device encountered an invalid program counter.
                                       ##  This leaves the process in an inconsistent state and any further CUDA work
                                       ##  will return the same error. To continue using CUDA, the process must be terminated
                                       ##  and relaunched.
                                       ##
      cudaErrorInvalidPc = 718, ##
                             ##  An exception occurred on the device while executing a kernel. Common
                             ##  causes include dereferencing an invalid device pointer and accessing
                             ##  out of bounds shared memory. Less common cases can be system specific - more
                             ##  information about these cases can be found in the system specific user guide.
                             ##  This leaves the process in an inconsistent state and any further CUDA work
                             ##  will return the same error. To continue using CUDA, the process must be terminated
                             ##  and relaunched.
                             ##
      cudaErrorLaunchFailure = 719, ##
                                 ##  This error indicates that the number of blocks launched per grid for a kernel that was
                                 ##  launched via either ::cudaLaunchCooperativeKernel or ::cudaLaunchCooperativeKernelMultiDevice
                                 ##  exceeds the maximum number of blocks as allowed by ::cudaOccupancyMaxActiveBlocksPerMultiprocessor
                                 ##  or
                                 ## ::cudaOccupancyMaxActiveBlocksPerMultiprocessorWithFlags times the number of multiprocessors
                                 ##  as specified by the device attribute ::cudaDevAttrMultiProcessorCount.
                                 ##
      cudaErrorCooperativeLaunchTooLarge = 720, ##
                                             ##  This error indicates the attempted operation is not permitted.
                                             ##
      cudaErrorNotPermitted = 800, ##
                                ##  This error indicates the attempted operation is not supported
                                ##  on the current system or device.
                                ##
      cudaErrorNotSupported = 801, ##
                                ##  This error indicates that the system is not yet ready to start any CUDA
                                ##  work.  To continue using CUDA, verify the system configuration is in a
                                ##  valid state and all required driver daemons are actively running.
                                ##  More information about this error can be found in the system specific
                                ##  user guide.
                                ##
      cudaErrorSystemNotReady = 802, ##
                                  ##  This error indicates that there is a mismatch between the versions of
                                  ##  the display driver and the CUDA driver. Refer to the compatibility documentation
                                  ##  for supported versions.
                                  ##
      cudaErrorSystemDriverMismatch = 803, ##
                                        ##  This error indicates that the system was upgraded to run with forward compatibility
                                        ##  but the visible hardware detected by CUDA does not support this configuration.
                                        ##  Refer to the compatibility documentation for the supported hardware matrix or ensure
                                        ##  that only supported hardware is visible during initialization via the CUDA_VISIBLE_DEVICES
                                        ##  environment variable.
                                        ##
      cudaErrorCompatNotSupportedOnDevice = 804, ##
                                              ##  This error indicates that the MPS client failed to connect to the MPS control daemon or the MPS server.
                                              ##
      cudaErrorMpsConnectionFailed = 805, ##
                                       ##  This error indicates that the remote procedural call between the MPS server and the MPS client failed.
                                       ##
      cudaErrorMpsRpcFailure = 806, ##
                                 ##  This error indicates that the MPS server is not ready to accept new MPS client requests.
                                 ##  This error can be returned when the MPS server is in the process of recovering from a fatal failure.
                                 ##
      cudaErrorMpsServerNotReady = 807, ##
                                     ##  This error indicates that the hardware resources required to create MPS client have been exhausted.
                                     ##
      cudaErrorMpsMaxClientsReached = 808, ##
                                        ##  This error indicates the the hardware resources required to device connections have been exhausted.
                                        ##
      cudaErrorMpsMaxConnectionsReached = 809, ##
                                            ##  This error indicates that the MPS client has been terminated by the server. To continue using CUDA, the process must be terminated and relaunched.
                                            ##
      cudaErrorMpsClientTerminated = 810, ##
                                       ##  This error indicates, that the program is using CUDA Dynamic Parallelism, but the current configuration, like MPS, does not support it.
                                       ##
      cudaErrorCdpNotSupported = 811, ##
                                   ##  This error indicates, that the program contains an unsupported interaction between different versions of CUDA Dynamic Parallelism.
                                   ##
      cudaErrorCdpVersionMismatch = 812, ##
                                      ##  The operation is not permitted when the stream is capturing.
                                      ##
      cudaErrorStreamCaptureUnsupported = 900, ##
                                            ##  The current capture sequence on the stream has been invalidated due to
                                            ##  a previous error.
                                            ##
      cudaErrorStreamCaptureInvalidated = 901, ##
                                            ##  The operation would have resulted in a merge of two independent capture
                                            ##  sequences.
                                            ##
      cudaErrorStreamCaptureMerge = 902, ##
                                      ##  The capture was not initiated in this stream.
                                      ##
      cudaErrorStreamCaptureUnmatched = 903, ##
                                          ##  The capture sequence contains a fork that was not joined to the primary
                                          ##  stream.
                                          ##
      cudaErrorStreamCaptureUnjoined = 904, ##
                                         ##  A dependency would have been created which crosses the capture sequence
                                         ##  boundary. Only implicit in-stream ordering dependencies are allowed to
                                         ##  cross the boundary.
                                         ##
      cudaErrorStreamCaptureIsolation = 905, ##
                                          ##  The operation would have resulted in a disallowed implicit dependency on
                                          ##  a current capture sequence from cudaStreamLegacy.
                                          ##
      cudaErrorStreamCaptureImplicit = 906, ##
                                         ##  The operation is not permitted on an event which was last recorded in a
                                         ##  capturing stream.
                                         ##
      cudaErrorCapturedEvent = 907, ##
                                 ##  A stream capture sequence not initiated with the ::cudaStreamCaptureModeRelaxed
                                 ##  argument to ::cudaStreamBeginCapture was passed to ::cudaStreamEndCapture in a
                                 ##  different thread.
                                 ##
      cudaErrorStreamCaptureWrongThread = 908, ##
                                            ##  This indicates that the wait operation has timed out.
                                            ##
      cudaErrorTimeout = 909, ##
                           ##  This error indicates that the graph update was not performed because it included
                           ##  changes which violated constraints specific to instantiated graph update.
                           ##
      cudaErrorGraphExecUpdateFailure = 910, ##
                                          ##  This indicates that an async error has occurred in a device outside of CUDA.
                                          ##  If CUDA was waiting for an external device's signal before consuming shared data,
                                          ##  the external device signaled an error indicating that the data is not valid for
                                          ##  consumption. This leaves the process in an inconsistent state and any further CUDA
                                          ##  work will return the same error. To continue using CUDA, the process must be
                                          ##  terminated and relaunched.
                                          ##
      cudaErrorExternalDevice = 911, ##
                                  ##  This indicates that a kernel launch error has occurred due to cluster
                                  ##  misconfiguration.
                                  ##
      cudaErrorInvalidClusterSize = 912, ##
                                      ##  This indicates that an unknown internal error has occurred.
                                      ##
      cudaErrorUnknown = 999, ##
                           ##  Any unhandled CUDA driver error is added to this value and returned via
                           ##  the runtime. Production releases of CUDA should not return such errors.
                           ##  \deprecated
                           ##  This error return is deprecated as of CUDA 4.1.
                           ##
      cudaErrorApiFailureBase = 10000
  ##
  ##  Channel format kind
  ##
  type
    cudaChannelFormatKind* = enum
      cudaChannelFormatKindSigned = 0, ## < Signed channel format
      cudaChannelFormatKindUnsigned = 1, ## < Unsigned channel format
      cudaChannelFormatKindFloat = 2, ## < Float channel format
      cudaChannelFormatKindNone = 3, ## < No channel format
      cudaChannelFormatKindNV12 = 4, ## < Unsigned 8-bit integers, planar 4:2:0 YUV format
      cudaChannelFormatKindUnsignedNormalized8X1 = 5, ## < 1 channel unsigned 8-bit normalized integer
      cudaChannelFormatKindUnsignedNormalized8X2 = 6, ## < 2 channel unsigned 8-bit normalized integer
      cudaChannelFormatKindUnsignedNormalized8X4 = 7, ## < 4 channel unsigned 8-bit normalized integer
      cudaChannelFormatKindUnsignedNormalized16X1 = 8, ## < 1 channel unsigned 16-bit normalized integer
      cudaChannelFormatKindUnsignedNormalized16X2 = 9, ## < 2 channel unsigned 16-bit normalized integer
      cudaChannelFormatKindUnsignedNormalized16X4 = 10, ## < 4 channel unsigned 16-bit normalized integer
      cudaChannelFormatKindSignedNormalized8X1 = 11, ## < 1 channel signed 8-bit normalized integer
      cudaChannelFormatKindSignedNormalized8X2 = 12, ## < 2 channel signed 8-bit normalized integer
      cudaChannelFormatKindSignedNormalized8X4 = 13, ## < 4 channel signed 8-bit normalized integer
      cudaChannelFormatKindSignedNormalized16X1 = 14, ## < 1 channel signed 16-bit normalized integer
      cudaChannelFormatKindSignedNormalized16X2 = 15, ## < 2 channel signed 16-bit normalized integer
      cudaChannelFormatKindSignedNormalized16X4 = 16, ## < 4 channel signed 16-bit normalized integer
      cudaChannelFormatKindUnsignedBlockCompressed1 = 17, ## < 4 channel unsigned normalized block-compressed (BC1 compression) format
      cudaChannelFormatKindUnsignedBlockCompressed1SRGB = 18, ## < 4 channel unsigned normalized block-compressed (BC1 compression) format with sRGB encoding
      cudaChannelFormatKindUnsignedBlockCompressed2 = 19, ## < 4 channel unsigned normalized block-compressed (BC2 compression) format
      cudaChannelFormatKindUnsignedBlockCompressed2SRGB = 20, ## < 4 channel unsigned normalized block-compressed (BC2 compression) format with sRGB encoding
      cudaChannelFormatKindUnsignedBlockCompressed3 = 21, ## < 4 channel unsigned normalized block-compressed (BC3 compression) format
      cudaChannelFormatKindUnsignedBlockCompressed3SRGB = 22, ## < 4 channel unsigned normalized block-compressed (BC3 compression) format with sRGB encoding
      cudaChannelFormatKindUnsignedBlockCompressed4 = 23, ## < 1 channel unsigned normalized block-compressed (BC4 compression) format
      cudaChannelFormatKindSignedBlockCompressed4 = 24, ## < 1 channel signed normalized block-compressed (BC4 compression) format
      cudaChannelFormatKindUnsignedBlockCompressed5 = 25, ## < 2 channel unsigned normalized block-compressed (BC5 compression) format
      cudaChannelFormatKindSignedBlockCompressed5 = 26, ## < 2 channel signed normalized block-compressed (BC5 compression) format
      cudaChannelFormatKindUnsignedBlockCompressed6H = 27, ## < 3 channel unsigned half-float block-compressed (BC6H compression) format
      cudaChannelFormatKindSignedBlockCompressed6H = 28, ## < 3 channel signed half-float block-compressed (BC6H compression) format
      cudaChannelFormatKindUnsignedBlockCompressed7 = 29, ## < 4 channel unsigned normalized block-compressed (BC7 compression) format
      cudaChannelFormatKindUnsignedBlockCompressed7SRGB = 30 ## < 4 channel unsigned normalized block-compressed (BC7 compression) format with sRGB encoding
  ##
  ##  CUDA Channel format descriptor
  ##
  type
    cudaChannelFormatDesc* {.bycopy.} = object
      x*: cint
      ## < x
      y*: cint
      ## < y
      z*: cint
      ## < z
      w*: cint
      ## < w
      f*: cudaChannelFormatKind
      ## < Channel format kind

  type cudaArray {.nodecl.} = object
  type
    cudaArray_t* = ptr cudaArray
  ##
  ##  CUDA array (as source copy argument)
  ##
  type
    cudaArray_const_t* = ptr cudaArray
  type cudaMipmappedArray {.nodecl.} = object
  type
    cudaMipmappedArray_t* = ptr cudaMipmappedArray
  ##
  ##  CUDA mipmapped array (as source argument)
  ##
  type
    cudaMipmappedArray_const_t* = ptr cudaMipmappedArray
  ##
  ##  Indicates that the layered sparse CUDA array or CUDA mipmapped array has a single mip tail region for all layers
  ##
  const
    cudaArraySparsePropertiesSingleMipTail* = 0x1
  ##
  ##  Sparse CUDA array and CUDA mipmapped array properties
  ##
  type
    INNER_C_STRUCT_driver_types_0* {.bycopy.} = object
      width*: cuint
      ## < Tile width in elements
      height*: cuint
      ## < Tile height in elements
      depth*: cuint
      ## < Tile depth in elements

  type
    cudaArraySparseProperties* {.bycopy.} = object
      tileExtent*: INNER_C_STRUCT_driver_types_0
      miptailFirstLevel*: cuint
      ## < First mip level at which the mip tail begins
      miptailSize*: culonglong
      ## < Total size of the mip tail.
      flags*: cuint
      ## < Flags will either be zero or ::cudaArraySparsePropertiesSingleMipTail
      reserved*: array[4, cuint]

  ##
  ##  CUDA array and CUDA mipmapped array memory requirements
  ##
  type
    cudaArrayMemoryRequirements* {.bycopy.} = object
      size*: csize_t
      ## < Total size of the array.
      alignment*: csize_t
      ## < Alignment necessary for mapping the array.
      reserved*: array[4, cuint]

  ##
  ##  CUDA memory types
  ##
  type
    cudaMemoryType* = enum
      cudaMemoryTypeUnregistered = 0, ## < Unregistered memory
      cudaMemoryTypeHost = 1,   ## < Host memory
      cudaMemoryTypeDevice = 2, ## < Device memory
      cudaMemoryTypeManaged = 3 ## < Managed memory
  ##
  ##  CUDA memory copy types
  ##
  type
    cudaMemcpyKind* = enum
      cudaMemcpyHostToHost = 0, ## < Host   -> Host
      cudaMemcpyHostToDevice = 1, ## < Host   -> Device
      cudaMemcpyDeviceToHost = 2, ## < Device -> Host
      cudaMemcpyDeviceToDevice = 3, ## < Device -> Device
      cudaMemcpyDefault = 4     ## < Direction of the transfer is inferred from the pointer values. Requires unified virtual addressing
  ##
  ##  CUDA Pitched memory pointer
  ##
  ##  \sa ::make_cudaPitchedPtr
  ##
  type
    cudaPitchedPtr* {.bycopy.} = object
      `ptr`*: pointer
      ## < Pointer to allocated memory
      pitch*: csize_t
      ## < Pitch of allocated memory in bytes
      xsize*: csize_t
      ## < Logical width of allocation in elements
      ysize*: csize_t
      ## < Logical height of allocation in elements

  ##
  ##  CUDA extent
  ##
  ##  \sa ::make_cudaExtent
  ##
  type
    cudaExtent* {.bycopy.} = object
      width*: csize_t
      ## < Width in elements when referring to array memory, in bytes when referring to linear memory
      height*: csize_t
      ## < Height in elements
      depth*: csize_t
      ## < Depth in elements

  ##
  ##  CUDA 3D position
  ##
  ##  \sa ::make_cudaPos
  ##
  type
    cudaPos* {.bycopy.} = object
      x*: csize_t
      ## < x
      y*: csize_t
      ## < y
      z*: csize_t
      ## < z

  ##
  ##  CUDA 3D memory copying parameters
  ##
  type
    cudaMemcpy3DParms* {.bycopy.} = object
      srcArray*: cudaArray_t
      ## < Source memory address
      srcPos*: cudaPos
      ## < Source position offset
      srcPtr*: cudaPitchedPtr
      ## < Pitched source memory address
      dstArray*: cudaArray_t
      ## < Destination memory address
      dstPos*: cudaPos
      ## < Destination position offset
      dstPtr*: cudaPitchedPtr
      ## < Pitched destination memory address
      extent*: cudaExtent
      ## < Requested memory copy size
      kind*: cudaMemcpyKind
      ## < Type of transfer

  ##
  ##  Memcpy node parameters
  ##
  type
    cudaMemcpyNodeParams* {.bycopy.} = object
      flags*: cint
      ## < Must be zero
      reserved*: array[3, cint]
      ## < Must be zero
      copyParams*: cudaMemcpy3DParms
      ## < Parameters for the memory copy

  ##
  ##  CUDA 3D cross-device memory copying parameters
  ##
  type
    cudaMemcpy3DPeerParms* {.bycopy.} = object
      srcArray*: cudaArray_t
      ## < Source memory address
      srcPos*: cudaPos
      ## < Source position offset
      srcPtr*: cudaPitchedPtr
      ## < Pitched source memory address
      srcDevice*: cint
      ## < Source device
      dstArray*: cudaArray_t
      ## < Destination memory address
      dstPos*: cudaPos
      ## < Destination position offset
      dstPtr*: cudaPitchedPtr
      ## < Pitched destination memory address
      dstDevice*: cint
      ## < Destination device
      extent*: cudaExtent
      ## < Requested memory copy size

  ##
  ##  CUDA Memset node parameters
  ##
  type
    cudaMemsetParams* {.bycopy.} = object
      dst*: pointer
      ## < Destination device pointer
      pitch*: csize_t
      ## < Pitch of destination device pointer. Unused if height is 1
      value*: cuint
      ## < Value to be set
      elementSize*: cuint
      ## < Size of each element in bytes. Must be 1, 2, or 4.
      width*: csize_t
      ## < Width of the row in elements
      height*: csize_t
      ## < Number of rows

  ##
  ##  CUDA Memset node parameters
  ##
  type
    cudaMemsetParamsV2* {.bycopy.} = object
      dst*: pointer
      ## < Destination device pointer
      pitch*: csize_t
      ## < Pitch of destination device pointer. Unused if height is 1
      value*: cuint
      ## < Value to be set
      elementSize*: cuint
      ## < Size of each element in bytes. Must be 1, 2, or 4.
      width*: csize_t
      ## < Width of the row in elements
      height*: csize_t
      ## < Number of rows

  ##
  ##  Specifies performance hint with ::cudaAccessPolicyWindow for hitProp and missProp members.
  ##
  type
    cudaAccessProperty* = enum
      cudaAccessPropertyNormal = 0, ## < Normal cache persistence.
      cudaAccessPropertyStreaming = 1, ## < Streaming access is less likely to persit from cache.
      cudaAccessPropertyPersisting = 2 ## < Persisting access is more likely to persist in cache.
  ##
  ##  Specifies an access policy for a window, a contiguous extent of memory
  ##  beginning at base_ptr and ending at base_ptr + num_bytes.
  ##  Partition into many segments and assign segments such that.
  ##  sum of "hit segments" / window == approx. ratio.
  ##  sum of "miss segments" / window == approx 1-ratio.
  ##  Segments and ratio specifications are fitted to the capabilities of
  ##  the architecture.
  ##  Accesses in a hit segment apply the hitProp access policy.
  ##  Accesses in a miss segment apply the missProp access policy.
  ##
  type
    cudaAccessPolicyWindow* {.bycopy.} = object
      base_ptr*: pointer
      ## < Starting address of the access policy window. CUDA driver may align it.
      num_bytes*: csize_t
      ## < Size in bytes of the window policy. CUDA driver may restrict the maximum size and alignment.
      hitRatio*: cfloat
      ## < hitRatio specifies percentage of lines assigned hitProp, rest are assigned missProp.
      hitProp*: cudaAccessProperty
      ## < ::CUaccessProperty set for hit.
      missProp*: cudaAccessProperty
      ## < ::CUaccessProperty set for miss. Must be either NORMAL or STREAMING.

  when defined(WIN32):
    discard
  else:
    discard
  ##
  ##  CUDA host function
  ##  \param userData Argument value passed to the function
  ##
  type
    cudaHostFn_t* = proc (userData: pointer)
  ##
  ##  CUDA host node parameters
  ##
  type
    cudaHostNodeParams* {.bycopy.} = object
      fn*: cudaHostFn_t
      ## < The function to call when the node executes
      userData*: pointer
      ## < Argument to pass to the function

  ##
  ##  CUDA host node parameters
  ##
  type
    cudaHostNodeParamsV2* {.bycopy.} = object
      fn*: cudaHostFn_t
      ## < The function to call when the node executes
      userData*: pointer
      ## < Argument to pass to the function

  ##
  ##  Possible stream capture statuses returned by ::cudaStreamIsCapturing
  ##
  type
    cudaStreamCaptureStatus* = enum
      cudaStreamCaptureStatusNone = 0, ## < Stream is not capturing
      cudaStreamCaptureStatusActive = 1, ## < Stream is actively capturing
      cudaStreamCaptureStatusInvalidated = 2 ## < Stream is part of a capture sequence that
                                          ##                                                    has been invalidated, but not terminated
  ##
  ##  Possible modes for stream capture thread interactions. For more details see
  ##  ::cudaStreamBeginCapture and ::cudaThreadExchangeStreamCaptureMode
  ##
  type
    cudaStreamCaptureMode* = enum
      cudaStreamCaptureModeGlobal = 0, cudaStreamCaptureModeThreadLocal = 1,
      cudaStreamCaptureModeRelaxed = 2
  type
    cudaSynchronizationPolicy* = enum
      cudaSyncPolicyAuto = 1, cudaSyncPolicySpin = 2, cudaSyncPolicyYield = 3,
      cudaSyncPolicyBlockingSync = 4
  ##
  ##  Cluster scheduling policies. These may be passed to ::cudaFuncSetAttribute
  ##
  type
    cudaClusterSchedulingPolicy* = enum
      cudaClusterSchedulingPolicyDefault = 0, ## < the default policy
      cudaClusterSchedulingPolicySpread = 1, ## < spread the blocks within a cluster to the SMs
      cudaClusterSchedulingPolicyLoadBalancing = 2 ## < allow the hardware to load-balance the blocks in a cluster to the SMs
  ##
  ##  Flags for ::cudaStreamUpdateCaptureDependencies
  ##
  type
    cudaStreamUpdateCaptureDependenciesFlags* = enum
      cudaStreamAddCaptureDependencies = 0x0, ## < Add new nodes to the dependency set
      cudaStreamSetCaptureDependencies = 0x1 ## < Replace the dependency set with the new nodes
  ##
  ##  Flags for user objects for graphs
  ##
  type
    cudaUserObjectFlags* = enum
      cudaUserObjectNoDestructorSync = 0x1 ## < Indicates the destructor execution is not synchronized by any CUDA handle.
  ##
  ##  Flags for retaining user object references for graphs
  ##
  type
    cudaUserObjectRetainFlags* = enum
      cudaGraphUserObjectMove = 0x1 ## < Transfer references from the caller rather than creating new references.
  ##
  ##  CUDA graphics interop resource
  ##
  type cudaGraphicsResource {.nodecl.} = object
  type
    cudaGraphicsRegisterFlags* = enum
      cudaGraphicsRegisterFlagsNone = 0, ## < Default
      cudaGraphicsRegisterFlagsReadOnly = 1, ## < CUDA will not write to this resource
      cudaGraphicsRegisterFlagsWriteDiscard = 2, ## < CUDA will only write to and will not read from this resource
      cudaGraphicsRegisterFlagsSurfaceLoadStore = 4, ## < CUDA will bind this resource to a surface reference
      cudaGraphicsRegisterFlagsTextureGather = 8 ## < CUDA will perform texture gather operations on this resource
  ##
  ##  CUDA graphics interop map flags
  ##
  type
    cudaGraphicsMapFlags* = enum
      cudaGraphicsMapFlagsNone = 0, ## < Default; Assume resource can be read/written
      cudaGraphicsMapFlagsReadOnly = 1, ## < CUDA will not write to this resource
      cudaGraphicsMapFlagsWriteDiscard = 2 ## < CUDA will only write to and will not read from this resource
  ##
  ##  CUDA graphics interop array indices for cube maps
  ##
  type
    cudaGraphicsCubeFace* = enum
      cudaGraphicsCubeFacePositiveX = 0x00, ## < Positive X face of cubemap
      cudaGraphicsCubeFaceNegativeX = 0x01, ## < Negative X face of cubemap
      cudaGraphicsCubeFacePositiveY = 0x02, ## < Positive Y face of cubemap
      cudaGraphicsCubeFaceNegativeY = 0x03, ## < Negative Y face of cubemap
      cudaGraphicsCubeFacePositiveZ = 0x04, ## < Positive Z face of cubemap
      cudaGraphicsCubeFaceNegativeZ = 0x05 ## < Negative Z face of cubemap
  ##
  ##  CUDA resource types
  ##
  type
    cudaResourceType* = enum
      cudaResourceTypeArray = 0x00, ## < Array resource
      cudaResourceTypeMipmappedArray = 0x01, ## < Mipmapped array resource
      cudaResourceTypeLinear = 0x02, ## < Linear resource
      cudaResourceTypePitch2D = 0x03 ## < Pitch 2D resource
  ##
  ##  CUDA texture resource view formats
  ##
  type
    cudaResourceViewFormat* = enum
      cudaResViewFormatNone = 0x00, ## < No resource view format (use underlying resource format)
      cudaResViewFormatUnsignedChar1 = 0x01, ## < 1 channel unsigned 8-bit integers
      cudaResViewFormatUnsignedChar2 = 0x02, ## < 2 channel unsigned 8-bit integers
      cudaResViewFormatUnsignedChar4 = 0x03, ## < 4 channel unsigned 8-bit integers
      cudaResViewFormatSignedChar1 = 0x04, ## < 1 channel signed 8-bit integers
      cudaResViewFormatSignedChar2 = 0x05, ## < 2 channel signed 8-bit integers
      cudaResViewFormatSignedChar4 = 0x06, ## < 4 channel signed 8-bit integers
      cudaResViewFormatUnsignedShort1 = 0x07, ## < 1 channel unsigned 16-bit integers
      cudaResViewFormatUnsignedShort2 = 0x08, ## < 2 channel unsigned 16-bit integers
      cudaResViewFormatUnsignedShort4 = 0x09, ## < 4 channel unsigned 16-bit integers
      cudaResViewFormatSignedShort1 = 0x0a, ## < 1 channel signed 16-bit integers
      cudaResViewFormatSignedShort2 = 0x0b, ## < 2 channel signed 16-bit integers
      cudaResViewFormatSignedShort4 = 0x0c, ## < 4 channel signed 16-bit integers
      cudaResViewFormatUnsignedInt1 = 0x0d, ## < 1 channel unsigned 32-bit integers
      cudaResViewFormatUnsignedInt2 = 0x0e, ## < 2 channel unsigned 32-bit integers
      cudaResViewFormatUnsignedInt4 = 0x0f, ## < 4 channel unsigned 32-bit integers
      cudaResViewFormatSignedInt1 = 0x10, ## < 1 channel signed 32-bit integers
      cudaResViewFormatSignedInt2 = 0x11, ## < 2 channel signed 32-bit integers
      cudaResViewFormatSignedInt4 = 0x12, ## < 4 channel signed 32-bit integers
      cudaResViewFormatHalf1 = 0x13, ## < 1 channel 16-bit floating point
      cudaResViewFormatHalf2 = 0x14, ## < 2 channel 16-bit floating point
      cudaResViewFormatHalf4 = 0x15, ## < 4 channel 16-bit floating point
      cudaResViewFormatFloat1 = 0x16, ## < 1 channel 32-bit floating point
      cudaResViewFormatFloat2 = 0x17, ## < 2 channel 32-bit floating point
      cudaResViewFormatFloat4 = 0x18, ## < 4 channel 32-bit floating point
      cudaResViewFormatUnsignedBlockCompressed1 = 0x19, ## < Block compressed 1
      cudaResViewFormatUnsignedBlockCompressed2 = 0x1a, ## < Block compressed 2
      cudaResViewFormatUnsignedBlockCompressed3 = 0x1b, ## < Block compressed 3
      cudaResViewFormatUnsignedBlockCompressed4 = 0x1c, ## < Block compressed 4 unsigned
      cudaResViewFormatSignedBlockCompressed4 = 0x1d, ## < Block compressed 4 signed
      cudaResViewFormatUnsignedBlockCompressed5 = 0x1e, ## < Block compressed 5 unsigned
      cudaResViewFormatSignedBlockCompressed5 = 0x1f, ## < Block compressed 5 signed
      cudaResViewFormatUnsignedBlockCompressed6H = 0x20, ## < Block compressed 6 unsigned half-float
      cudaResViewFormatSignedBlockCompressed6H = 0x21, ## < Block compressed 6 signed half-float
      cudaResViewFormatUnsignedBlockCompressed7 = 0x22 ## < Block compressed 7
  ##
  ##  CUDA resource descriptor
  ##
  type
    INNER_C_STRUCT_driver_types_2* {.bycopy.} = object
      array*: cudaArray_t
      ## < CUDA array

  type
    INNER_C_STRUCT_driver_types_3* {.bycopy.} = object
      mipmap*: cudaMipmappedArray_t
      ## < CUDA mipmapped array

  type
    INNER_C_STRUCT_driver_types_4* {.bycopy.} = object
      devPtr*: pointer
      ## < Device pointer
      desc*: cudaChannelFormatDesc
      ## < Channel descriptor
      sizeInBytes*: csize_t
      ## < Size in bytes

  type
    INNER_C_STRUCT_driver_types_5* {.bycopy.} = object
      devPtr*: pointer
      ## < Device pointer
      desc*: cudaChannelFormatDesc
      ## < Channel descriptor
      width*: csize_t
      ## < Width of the array in elements
      height*: csize_t
      ## < Height of the array in elements
      pitchInBytes*: csize_t
      ## < Pitch between two rows in bytes

  type
    INNER_C_UNION_driver_types_1* {.bycopy, union.} = object
      array*: INNER_C_STRUCT_driver_types_2
      mipmap*: INNER_C_STRUCT_driver_types_3
      linear*: INNER_C_STRUCT_driver_types_4
      pitch2D*: INNER_C_STRUCT_driver_types_5

  type
    cudaResourceDesc* {.bycopy.} = object
      resType*: cudaResourceType
      ## < Resource type
      res*: INNER_C_UNION_driver_types_1

  ##
  ##  CUDA resource view descriptor
  ##
  type
    cudaResourceViewDesc* {.bycopy.} = object
      format*: cudaResourceViewFormat
      ## < Resource view format
      width*: csize_t
      ## < Width of the resource view
      height*: csize_t
      ## < Height of the resource view
      depth*: csize_t
      ## < Depth of the resource view
      firstMipmapLevel*: cuint
      ## < First defined mipmap level
      lastMipmapLevel*: cuint
      ## < Last defined mipmap level
      firstLayer*: cuint
      ## < First layer index
      lastLayer*: cuint
      ## < Last layer index

  ##
  ##  CUDA pointer attributes
  ##
  type
    cudaPointerAttributes* {.bycopy.} = object
      ##
      ##  The type of memory - ::cudaMemoryTypeUnregistered, ::cudaMemoryTypeHost,
      ##  ::cudaMemoryTypeDevice or ::cudaMemoryTypeManaged.
      ##
      `type`*: cudaMemoryType
      ##
      ##  The device against which the memory was allocated or registered.
      ##  If the memory type is ::cudaMemoryTypeDevice then this identifies
      ##  the device on which the memory referred physically resides.  If
      ##  the memory type is ::cudaMemoryTypeHost or::cudaMemoryTypeManaged then
      ##  this identifies the device which was current when the memory was allocated
      ##  or registered (and if that device is deinitialized then this allocation
      ##  will vanish with that device's state).
      ##
      device*: cint
      ##
      ##  The address which may be dereferenced on the current device to access
      ##  the memory or NULL if no such address exists.
      ##
      devicePointer*: pointer
      ##
      ##  The address which may be dereferenced on the host to access the
      ##  memory or NULL if no such address exists.
      ##
      ##  \note CUDA doesn't check if unregistered memory is allocated so this field
      ##  may contain invalid pointer if an invalid pointer has been passed to CUDA.
      ##
      hostPointer*: pointer

  ##
  ##  CUDA function attributes
  ##
  type
    cudaFuncAttributes* {.bycopy.} = object
      ##
      ##  The size in bytes of statically-allocated shared memory per block
      ##  required by this function. This does not include dynamically-allocated
      ##  shared memory requested by the user at runtime.
      ##
      sharedSizeBytes*: csize_t
      ##
      ##  The size in bytes of user-allocated constant memory required by this
      ##  function.
      ##
      constSizeBytes*: csize_t
      ##
      ##  The size in bytes of local memory used by each thread of this function.
      ##
      localSizeBytes*: csize_t
      ##
      ##  The maximum number of threads per block, beyond which a launch of the
      ##  function would fail. This number depends on both the function and the
      ##  device on which the function is currently loaded.
      ##
      maxThreadsPerBlock*: cint
      ##
      ##  The number of registers used by each thread of this function.
      ##
      numRegs*: cint
      ##
      ##  The PTX virtual architecture version for which the function was
      ##  compiled. This value is the major PTX version * 10 + the minor PTX
      ##  version, so a PTX version 1.3 function would return the value 13.
      ##
      ptxVersion*: cint
      ##
      ##  The binary architecture version for which the function was compiled.
      ##  This value is the major binary version * 10 + the minor binary version,
      ##  so a binary version 1.3 function would return the value 13.
      ##
      binaryVersion*: cint
      ##
      ##  The attribute to indicate whether the function has been compiled with
      ##  user specified option "-Xptxas --dlcm=ca" set.
      ##
      cacheModeCA*: cint
      ##
      ##  The maximum size in bytes of dynamic shared memory per block for
      ##  this function. Any launch must have a dynamic shared memory size
      ##  smaller than this value.
      ##
      maxDynamicSharedSizeBytes*: cint
      ##
      ##  On devices where the L1 cache and shared memory use the same hardware resources,
      ##  this sets the shared memory carveout preference, in percent of the maximum shared memory.
      ##  Refer to ::cudaDevAttrMaxSharedMemoryPerMultiprocessor.
      ##  This is only a hint, and the driver can choose a different ratio if required to execute the function.
      ##  See ::cudaFuncSetAttribute
      ##
      preferredShmemCarveout*: cint
      ##
      ##  If this attribute is set, the kernel must launch with a valid cluster dimension
      ##  specified.
      ##
      clusterDimMustBeSet*: cint
      ##
      ##  The required cluster width/height/depth in blocks. The values must either
      ##  all be 0 or all be positive. The validity of the cluster dimensions is
      ##  otherwise checked at launch time.
      ##
      ##  If the value is set during compile time, it cannot be set at runtime.
      ##  Setting it at runtime should return cudaErrorNotPermitted.
      ##  See ::cudaFuncSetAttribute
      ##
      requiredClusterWidth*: cint
      requiredClusterHeight*: cint
      requiredClusterDepth*: cint
      ##
      ##  The block scheduling policy of a function.
      ##  See ::cudaFuncSetAttribute
      ##
      clusterSchedulingPolicyPreference*: cint
      ##
      ##  Whether the function can be launched with non-portable cluster size. 1 is
      ##  allowed, 0 is disallowed. A non-portable cluster size may only function
      ##  on the specific SKUs the program is tested on. The launch might fail if
      ##  the program is run on a different hardware platform.
      ##
      ##  CUDA API provides ::cudaOccupancyMaxActiveClusters to assist with checking
      ##  whether the desired size can be launched on the current device.
      ##
      ##  Portable Cluster Size
      ##
      ##  A portable cluster size is guaranteed to be functional on all compute
      ##  capabilities higher than the target compute capability. The portable
      ##  cluster size for sm_90 is 8 blocks per cluster. This value may increase
      ##  for future compute capabilities.
      ##
      ##  The specific hardware unit may support higher cluster sizes that’s not
      ##  guaranteed to be portable.
      ##  See ::cudaFuncSetAttribute
      ##
      nonPortableClusterSizeAllowed*: cint
      ##
      ##  Reserved for future use.
      ##
      reserved*: array[16, cint]

  ##
  ##  CUDA function attributes that can be set using ::cudaFuncSetAttribute
  ##
  type
    cudaFuncAttribute* = enum
      cudaFuncAttributeMaxDynamicSharedMemorySize = 8, ## < Maximum dynamic shared memory size
      cudaFuncAttributePreferredSharedMemoryCarveout = 9, ## < Preferred shared memory-L1 cache split
      cudaFuncAttributeClusterDimMustBeSet = 10, ## < Indicator to enforce valid cluster dimension specification on kernel launch
      cudaFuncAttributeRequiredClusterWidth = 11, ## < Required cluster width
      cudaFuncAttributeRequiredClusterHeight = 12, ## < Required cluster height
      cudaFuncAttributeRequiredClusterDepth = 13, ## < Required cluster depth
      cudaFuncAttributeNonPortableClusterSizeAllowed = 14, ## < Whether non-portable cluster scheduling policy is supported
      cudaFuncAttributeClusterSchedulingPolicyPreference = 15, ## < Required cluster scheduling policy preference
      cudaFuncAttributeMax
  ##
  ##  CUDA function cache configurations
  ##
  type
    cudaFuncCache* = enum
      cudaFuncCachePreferNone = 0, ## < Default function cache configuration, no preference
      cudaFuncCachePreferShared = 1, ## < Prefer larger shared memory and smaller L1 cache
      cudaFuncCachePreferL1 = 2, ## < Prefer larger L1 cache and smaller shared memory
      cudaFuncCachePreferEqual = 3 ## < Prefer equal size L1 cache and shared memory
  ##
  ##  CUDA shared memory configuration
  ##  \deprecated
  ##
  type
    cudaSharedMemConfig* = enum
      cudaSharedMemBankSizeDefault = 0, cudaSharedMemBankSizeFourByte = 1,
      cudaSharedMemBankSizeEightByte = 2
  ##
  ##  Shared memory carveout configurations. These may be passed to cudaFuncSetAttribute
  ##
  type
    cudaSharedCarveout* = enum
      cudaSharedmemCarveoutDefault = -1, ## < No preference for shared memory or L1 (default)
      cudaSharedmemCarveoutMaxL1 = 0, ## < Prefer maximum available L1 cache, minimum shared memory
      cudaSharedmemCarveoutMaxShared = 100 ## < Prefer maximum available shared memory, minimum L1 cache
  ##
  ##  CUDA device compute modes
  ##
  type
    cudaComputeMode* = enum
      cudaComputeModeDefault = 0, ## < Default compute mode (Multiple threads can use ::cudaSetDevice() with this device)
      cudaComputeModeExclusive = 1, ## < Compute-exclusive-thread mode (Only one thread in one process will be able to use ::cudaSetDevice() with this device)
      cudaComputeModeProhibited = 2, ## < Compute-prohibited mode (No threads can use ::cudaSetDevice() with this device)
      cudaComputeModeExclusiveProcess = 3 ## < Compute-exclusive-process mode (Many threads in one process will be able to use ::cudaSetDevice() with this device)
  ##
  ##  CUDA Limits
  ##
  type
    cudaLimit* = enum
      cudaLimitStackSize = 0x00, ## < GPU thread stack size
      cudaLimitPrintfFifoSize = 0x01, ## < GPU printf FIFO size
      cudaLimitMallocHeapSize = 0x02, ## < GPU malloc heap size
      cudaLimitDevRuntimeSyncDepth = 0x03, ## < GPU device runtime synchronize depth
      cudaLimitDevRuntimePendingLaunchCount = 0x04, ## < GPU device runtime pending launch count
      cudaLimitMaxL2FetchGranularity = 0x05, ## < A value between 0 and 128 that indicates the maximum fetch granularity of L2 (in Bytes). This is a hint
      cudaLimitPersistingL2CacheSize = 0x06 ## < A size in bytes for L2 persisting lines cache size
  ##
  ##  CUDA Memory Advise values
  ##
  type
    cudaMemoryAdvise* = enum
      cudaMemAdviseSetReadMostly = 1, ## < Data will mostly be read and only occassionally be written to
      cudaMemAdviseUnsetReadMostly = 2, ## < Undo the effect of ::cudaMemAdviseSetReadMostly
      cudaMemAdviseSetPreferredLocation = 3, ## < Set the preferred location for the data as the specified device
      cudaMemAdviseUnsetPreferredLocation = 4, ## < Clear the preferred location for the data
      cudaMemAdviseSetAccessedBy = 5, ## < Data will be accessed by the specified device, so prevent page faults as much as possible
      cudaMemAdviseUnsetAccessedBy = 6 ## < Let the Unified Memory subsystem decide on the page faulting policy for the specified device
  ##
  ##  CUDA range attributes
  ##
  type
    cudaMemRangeAttribute* = enum
      cudaMemRangeAttributeReadMostly = 1, ## < Whether the range will mostly be read and only occassionally be written to
      cudaMemRangeAttributePreferredLocation = 2, ## < The preferred location of the range
      cudaMemRangeAttributeAccessedBy = 3, ## < Memory range has ::cudaMemAdviseSetAccessedBy set for specified device
      cudaMemRangeAttributeLastPrefetchLocation = 4, ## < The last location to which the range was prefetched
      cudaMemRangeAttributePreferredLocationType = 5, ## < The preferred location type of the range
      cudaMemRangeAttributePreferredLocationId = 6, ## < The preferred location id of the range
      cudaMemRangeAttributeLastPrefetchLocationType = 7, ## < The last location type to which the range was prefetched
      cudaMemRangeAttributeLastPrefetchLocationId = 8 ## < The last location id to which the range was prefetched
  ##
  ##  CUDA GPUDirect RDMA flush writes APIs supported on the device
  ##
  type
    cudaFlushGPUDirectRDMAWritesOptions* = enum
      cudaFlushGPUDirectRDMAWritesOptionHost = 1 shl 0, ## <
                                                   ## ::cudaDeviceFlushGPUDirectRDMAWrites() and its CUDA Driver API counterpart are supported on the device.
      cudaFlushGPUDirectRDMAWritesOptionMemOps = 1 shl 1
  ##
  ##  CUDA GPUDirect RDMA flush writes ordering features of the device
  ##
  type
    cudaGPUDirectRDMAWritesOrdering* = enum
      cudaGPUDirectRDMAWritesOrderingNone = 0, ## < The device does not natively support ordering of GPUDirect RDMA writes. ::cudaFlushGPUDirectRDMAWrites() can be leveraged if supported.
      cudaGPUDirectRDMAWritesOrderingOwner = 100, ## < Natively, the device can consistently consume GPUDirect RDMA writes, although other CUDA devices may not.
      cudaGPUDirectRDMAWritesOrderingAllDevices = 200 ## < Any CUDA device in the system can consistently consume GPUDirect RDMA writes to this device.
  ##
  ##  CUDA GPUDirect RDMA flush writes scopes
  ##
  type
    cudaFlushGPUDirectRDMAWritesScope* = enum
      cudaFlushGPUDirectRDMAWritesToOwner = 100, ## < Blocks until remote writes are visible to the CUDA device context owning the data.
      cudaFlushGPUDirectRDMAWritesToAllDevices = 200 ## < Blocks until remote writes are visible to all CUDA device contexts.
  ##
  ##  CUDA GPUDirect RDMA flush writes targets
  ##
  type
    cudaFlushGPUDirectRDMAWritesTarget* = enum
      cudaFlushGPUDirectRDMAWritesTargetCurrentDevice ## < Sets the target for
                                                     ## ::cudaDeviceFlushGPUDirectRDMAWrites() to the currently active CUDA device context.
  ##
  ##  CUDA device attributes
  ##
  type
    cudaDeviceAttr* = enum
      cudaDevAttrMaxThreadsPerBlock = 1, ## < Maximum number of threads per block
      cudaDevAttrMaxBlockDimX = 2, ## < Maximum block dimension X
      cudaDevAttrMaxBlockDimY = 3, ## < Maximum block dimension Y
      cudaDevAttrMaxBlockDimZ = 4, ## < Maximum block dimension Z
      cudaDevAttrMaxGridDimX = 5, ## < Maximum grid dimension X
      cudaDevAttrMaxGridDimY = 6, ## < Maximum grid dimension Y
      cudaDevAttrMaxGridDimZ = 7, ## < Maximum grid dimension Z
      cudaDevAttrMaxSharedMemoryPerBlock = 8, ## < Maximum shared memory available per block in bytes
      cudaDevAttrTotalConstantMemory = 9, ## < Memory available on device for __constant__ variables in a CUDA C kernel in bytes
      cudaDevAttrWarpSize = 10, ## < Warp size in threads
      cudaDevAttrMaxPitch = 11, ## < Maximum pitch in bytes allowed by memory copies
      cudaDevAttrMaxRegistersPerBlock = 12, ## < Maximum number of 32-bit registers available per block
      cudaDevAttrClockRate = 13, ## < Peak clock frequency in kilohertz
      cudaDevAttrTextureAlignment = 14, ## < Alignment requirement for textures
      cudaDevAttrGpuOverlap = 15, ## < Device can possibly copy memory and execute a kernel concurrently
      cudaDevAttrMultiProcessorCount = 16, ## < Number of multiprocessors on device
      cudaDevAttrKernelExecTimeout = 17, ## < Specifies whether there is a run time limit on kernels
      cudaDevAttrIntegrated = 18, ## < Device is integrated with host memory
      cudaDevAttrCanMapHostMemory = 19, ## < Device can map host memory into CUDA address space
      cudaDevAttrComputeMode = 20, ## < Compute mode (See ::cudaComputeMode for details)
      cudaDevAttrMaxTexture1DWidth = 21, ## < Maximum 1D texture width
      cudaDevAttrMaxTexture2DWidth = 22, ## < Maximum 2D texture width
      cudaDevAttrMaxTexture2DHeight = 23, ## < Maximum 2D texture height
      cudaDevAttrMaxTexture3DWidth = 24, ## < Maximum 3D texture width
      cudaDevAttrMaxTexture3DHeight = 25, ## < Maximum 3D texture height
      cudaDevAttrMaxTexture3DDepth = 26, ## < Maximum 3D texture depth
      cudaDevAttrMaxTexture2DLayeredWidth = 27, ## < Maximum 2D layered texture width
      cudaDevAttrMaxTexture2DLayeredHeight = 28, ## < Maximum 2D layered texture height
      cudaDevAttrMaxTexture2DLayeredLayers = 29, ## < Maximum layers in a 2D layered texture
      cudaDevAttrSurfaceAlignment = 30, ## < Alignment requirement for surfaces
      cudaDevAttrConcurrentKernels = 31, ## < Device can possibly execute multiple kernels concurrently
      cudaDevAttrEccEnabled = 32, ## < Device has ECC support enabled
      cudaDevAttrPciBusId = 33, ## < PCI bus ID of the device
      cudaDevAttrPciDeviceId = 34, ## < PCI device ID of the device
      cudaDevAttrTccDriver = 35, ## < Device is using TCC driver model
      cudaDevAttrMemoryClockRate = 36, ## < Peak memory clock frequency in kilohertz
      cudaDevAttrGlobalMemoryBusWidth = 37, ## < Global memory bus width in bits
      cudaDevAttrL2CacheSize = 38, ## < Size of L2 cache in bytes
      cudaDevAttrMaxThreadsPerMultiProcessor = 39, ## < Maximum resident threads per multiprocessor
      cudaDevAttrAsyncEngineCount = 40, ## < Number of asynchronous engines
      cudaDevAttrUnifiedAddressing = 41, ## < Device shares a unified address space with the host
      cudaDevAttrMaxTexture1DLayeredWidth = 42, ## < Maximum 1D layered texture width
      cudaDevAttrMaxTexture1DLayeredLayers = 43, ## < Maximum layers in a 1D layered texture
      cudaDevAttrMaxTexture2DGatherWidth = 45, ## < Maximum 2D texture width if cudaArrayTextureGather is set
      cudaDevAttrMaxTexture2DGatherHeight = 46, ## < Maximum 2D texture height if cudaArrayTextureGather is set
      cudaDevAttrMaxTexture3DWidthAlt = 47, ## < Alternate maximum 3D texture width
      cudaDevAttrMaxTexture3DHeightAlt = 48, ## < Alternate maximum 3D texture height
      cudaDevAttrMaxTexture3DDepthAlt = 49, ## < Alternate maximum 3D texture depth
      cudaDevAttrPciDomainId = 50, ## < PCI domain ID of the device
      cudaDevAttrTexturePitchAlignment = 51, ## < Pitch alignment requirement for textures
      cudaDevAttrMaxTextureCubemapWidth = 52, ## < Maximum cubemap texture width/height
      cudaDevAttrMaxTextureCubemapLayeredWidth = 53, ## < Maximum cubemap layered texture width/height
      cudaDevAttrMaxTextureCubemapLayeredLayers = 54, ## < Maximum layers in a cubemap layered texture
      cudaDevAttrMaxSurface1DWidth = 55, ## < Maximum 1D surface width
      cudaDevAttrMaxSurface2DWidth = 56, ## < Maximum 2D surface width
      cudaDevAttrMaxSurface2DHeight = 57, ## < Maximum 2D surface height
      cudaDevAttrMaxSurface3DWidth = 58, ## < Maximum 3D surface width
      cudaDevAttrMaxSurface3DHeight = 59, ## < Maximum 3D surface height
      cudaDevAttrMaxSurface3DDepth = 60, ## < Maximum 3D surface depth
      cudaDevAttrMaxSurface1DLayeredWidth = 61, ## < Maximum 1D layered surface width
      cudaDevAttrMaxSurface1DLayeredLayers = 62, ## < Maximum layers in a 1D layered surface
      cudaDevAttrMaxSurface2DLayeredWidth = 63, ## < Maximum 2D layered surface width
      cudaDevAttrMaxSurface2DLayeredHeight = 64, ## < Maximum 2D layered surface height
      cudaDevAttrMaxSurface2DLayeredLayers = 65, ## < Maximum layers in a 2D layered surface
      cudaDevAttrMaxSurfaceCubemapWidth = 66, ## < Maximum cubemap surface width
      cudaDevAttrMaxSurfaceCubemapLayeredWidth = 67, ## < Maximum cubemap layered surface width
      cudaDevAttrMaxSurfaceCubemapLayeredLayers = 68, ## < Maximum layers in a cubemap layered surface
      cudaDevAttrMaxTexture1DLinearWidth = 69, ## < Maximum 1D linear texture width
      cudaDevAttrMaxTexture2DLinearWidth = 70, ## < Maximum 2D linear texture width
      cudaDevAttrMaxTexture2DLinearHeight = 71, ## < Maximum 2D linear texture height
      cudaDevAttrMaxTexture2DLinearPitch = 72, ## < Maximum 2D linear texture pitch in bytes
      cudaDevAttrMaxTexture2DMipmappedWidth = 73, ## < Maximum mipmapped 2D texture width
      cudaDevAttrMaxTexture2DMipmappedHeight = 74, ## < Maximum mipmapped 2D texture height
      cudaDevAttrComputeCapabilityMajor = 75, ## < Major compute capability version number
      cudaDevAttrComputeCapabilityMinor = 76, ## < Minor compute capability version number
      cudaDevAttrMaxTexture1DMipmappedWidth = 77, ## < Maximum mipmapped 1D texture width
      cudaDevAttrStreamPrioritiesSupported = 78, ## < Device supports stream priorities
      cudaDevAttrGlobalL1CacheSupported = 79, ## < Device supports caching globals in L1
      cudaDevAttrLocalL1CacheSupported = 80, ## < Device supports caching locals in L1
      cudaDevAttrMaxSharedMemoryPerMultiprocessor = 81, ## < Maximum shared memory available per multiprocessor in bytes
      cudaDevAttrMaxRegistersPerMultiprocessor = 82, ## < Maximum number of 32-bit registers available per multiprocessor
      cudaDevAttrManagedMemory = 83, ## < Device can allocate managed memory on this system
      cudaDevAttrIsMultiGpuBoard = 84, ## < Device is on a multi-GPU board
      cudaDevAttrMultiGpuBoardGroupID = 85, ## < Unique identifier for a group of devices on the same multi-GPU board
      cudaDevAttrHostNativeAtomicSupported = 86, ## < Link between the device and the host supports native atomic operations
      cudaDevAttrSingleToDoublePrecisionPerfRatio = 87, ## < Ratio of single precision performance (in floating-point operations per second) to double precision performance
      cudaDevAttrPageableMemoryAccess = 88, ## < Device supports coherently accessing pageable memory without calling cudaHostRegister on it
      cudaDevAttrConcurrentManagedAccess = 89, ## < Device can coherently access managed memory concurrently with the CPU
      cudaDevAttrComputePreemptionSupported = 90, ## < Device supports Compute Preemption
      cudaDevAttrCanUseHostPointerForRegisteredMem = 91, ## < Device can access host registered memory at the same virtual address as the CPU
      cudaDevAttrReserved92 = 92, cudaDevAttrReserved93 = 93,
      cudaDevAttrReserved94 = 94, cudaDevAttrCooperativeLaunch = 95, ## < Device supports launching cooperative kernels via
                                                               ## ::cudaLaunchCooperativeKernel
      cudaDevAttrCooperativeMultiDeviceLaunch = 96, ## < Deprecated,
                                                 ## cudaLaunchCooperativeKernelMultiDevice is deprecated.
      cudaDevAttrMaxSharedMemoryPerBlockOptin = 97, ## < The maximum optin shared memory per block. This value may vary by chip. See ::cudaFuncSetAttribute
      cudaDevAttrCanFlushRemoteWrites = 98, ## < Device supports flushing of outstanding remote writes.
      cudaDevAttrHostRegisterSupported = 99, ## < Device supports host memory registration via ::cudaHostRegister.
      cudaDevAttrPageableMemoryAccessUsesHostPageTables = 100, ## < Device accesses pageable memory via the host's page tables.
      cudaDevAttrDirectManagedMemAccessFromHost = 101, ## < Host can directly access managed memory on the device without migration.
      cudaDevAttrMaxBlocksPerMultiprocessor = 106, ## < Maximum number of blocks per multiprocessor
      cudaDevAttrMaxPersistingL2CacheSize = 108, ## < Maximum L2 persisting lines capacity setting in bytes.
      cudaDevAttrMaxAccessPolicyWindowSize = 109, ## < Maximum value of
                                               ## cudaAccessPolicyWindow::num_bytes.
      cudaDevAttrReservedSharedMemoryPerBlock = 111, ## < Shared memory reserved by CUDA driver per block in bytes
      cudaDevAttrSparseCudaArraySupported = 112, ## < Device supports sparse CUDA arrays and sparse CUDA mipmapped arrays
      cudaDevAttrHostRegisterReadOnlySupported = 113, ## < Device supports using the ::cudaHostRegister flag cudaHostRegisterReadOnly to register memory that must be mapped as read-only to the GPU
      cudaDevAttrTimelineSemaphoreInteropSupported = 114, ## < External timeline semaphore interop is supported on the device
      cudaDevAttrMemoryPoolsSupported = 115, ## < Device supports using the ::cudaMallocAsync and ::cudaMemPool family of APIs
      cudaDevAttrGPUDirectRDMASupported = 116, ## < Device supports GPUDirect RDMA APIs, like nvidia_p2p_get_pages (see
                                            ## https://docs.nvidia.com/cuda/gpudirect-rdma for more information)
      cudaDevAttrGPUDirectRDMAFlushWritesOptions = 117, ## < The returned attribute shall be interpreted as a bitmask, where the individual bits are listed in the
                                                     ## ::cudaFlushGPUDirectRDMAWritesOptions enum
      cudaDevAttrGPUDirectRDMAWritesOrdering = 118, ## < GPUDirect RDMA writes to the device do not need to be flushed for consumers within the scope indicated by the returned attribute. See
                                                 ## ::cudaGPUDirectRDMAWritesOrdering for the numerical values returned here.
      cudaDevAttrMemoryPoolSupportedHandleTypes = 119, ## < Handle types supported with mempool based IPC
      cudaDevAttrClusterLaunch = 120, ## < Indicates device supports cluster launch
      cudaDevAttrDeferredMappingCudaArraySupported = 121, ## < Device supports deferred mapping CUDA arrays and CUDA mipmapped arrays
      cudaDevAttrReserved122 = 122, cudaDevAttrReserved123 = 123,
      cudaDevAttrReserved124 = 124, cudaDevAttrIpcEventSupport = 125, ## < Device supports IPC Events.
      cudaDevAttrMemSyncDomainCount = 126, ## < Number of memory synchronization domains the device supports.
      cudaDevAttrReserved127 = 127, cudaDevAttrReserved128 = 128,
      cudaDevAttrReserved129 = 129, cudaDevAttrNumaConfig = 130, ## < NUMA configuration of a device: value is of type
                                                           ## ::cudaDeviceNumaConfig enum
      cudaDevAttrNumaId = 131,  ## < NUMA node ID of the GPU memory
      cudaDevAttrReserved132 = 132, cudaDevAttrMpsEnabled = 133, ## < Contexts created on this device will be shared via MPS
      cudaDevAttrHostNumaId = 134, ## < NUMA ID of the host node closest to the device. Returns -1 when system does not support NUMA.
      cudaDevAttrD3D12CigSupported = 135, ## < Device supports CIG with D3D12.
      cudaDevAttrMax
  const
    cudaDevAttrMaxTimelineSemaphoreInteropSupported = cudaDevAttrTimelineSemaphoreInteropSupported
  ##
  ##  CUDA memory pool attributes
  ##
  type
    cudaMemPoolAttr* = enum ##
                         ##  (value type = int)
                         ##  Allow cuMemAllocAsync to use memory asynchronously freed
                         ##  in another streams as long as a stream ordering dependency
                         ##  of the allocating stream on the free action exists.
                         ##  Cuda events and null stream interactions can create the required
                         ##  stream ordered dependencies. (default enabled)
                         ##
      cudaMemPoolReuseFollowEventDependencies = 0x1, ##
                                                  ##  (value type = int)
                                                  ##  Allow reuse of already completed frees when there is no dependency
                                                  ##  between the free and allocation. (default enabled)
                                                  ##
      cudaMemPoolReuseAllowOpportunistic = 0x2, ##
                                             ##  (value type = int)
                                             ##  Allow cuMemAllocAsync to insert new stream dependencies
                                             ##  in order to establish the stream ordering required to reuse
                                             ##  a piece of memory released by cuFreeAsync (default enabled).
                                             ##
      cudaMemPoolReuseAllowInternalDependencies = 0x3, ##
                                                    ##  (value type = cuuclonglong)
                                                    ##  Amount of reserved memory in bytes to hold onto before trying
                                                    ##  to release memory back to the OS. When more than the release
                                                    ##  threshold bytes of memory are held by the memory pool, the
                                                    ##  allocator will try to release memory back to the OS on the
                                                    ##  next call to stream, event or context synchronize. (default 0)
                                                    ##
      cudaMemPoolAttrReleaseThreshold = 0x4, ##
                                          ##  (value type = cuuclonglong)
                                          ##  Amount of backing memory currently allocated for the mempool.
                                          ##
      cudaMemPoolAttrReservedMemCurrent = 0x5, ##
                                            ##  (value type = cuuclonglong)
                                            ##  High watermark of backing memory allocated for the mempool since the
                                            ##  last time it was reset. High watermark can only be reset to zero.
                                            ##
      cudaMemPoolAttrReservedMemHigh = 0x6, ##
                                         ##  (value type = cuuclonglong)
                                         ##  Amount of memory from the pool that is currently in use by the application.
                                         ##
      cudaMemPoolAttrUsedMemCurrent = 0x7, ##
                                        ##  (value type = cuuclonglong)
                                        ##  High watermark of the amount of memory from the pool that was in use by the application since
                                        ##  the last time it was reset. High watermark can only be reset to zero.
                                        ##
      cudaMemPoolAttrUsedMemHigh = 0x8
  ##
  ##  Specifies the type of location
  ##
  type
    cudaMemLocationType* = enum
      cudaMemLocationTypeInvalid = 0, cudaMemLocationTypeDevice = 1, ## < Location is a device location, thus id is a device ordinal
      cudaMemLocationTypeHost = 2, ## < Location is host, id is ignored
      cudaMemLocationTypeHostNuma = 3, ## < Location is a host NUMA node, thus id is a host NUMA node id
      cudaMemLocationTypeHostNumaCurrent = 4 ## < Location is the host NUMA node closest to the current thread's CPU, id is ignored
  ##
  ##  Specifies a memory location.
  ##
  ##  To specify a gpu, set type = ::cudaMemLocationTypeDevice and set id = the gpu's device ordinal.
  ##  To specify a cpu NUMA node, set type = ::cudaMemLocationTypeHostNuma and set id = host NUMA node id.
  ##
  type
    cudaMemLocation* {.bycopy.} = object
      `type`*: cudaMemLocationType
      ## < Specifies the location type, which modifies the meaning of id.
      id*: cint
      ## < identifier for a given this location's ::CUmemLocationType.

  ##
  ##  Specifies the memory protection flags for mapping.
  ##
  type
    cudaMemAccessFlags* = enum
      cudaMemAccessFlagsProtNone = 0, ## < Default, make the address range not accessible
      cudaMemAccessFlagsProtRead = 1, ## < Make the address range read accessible
      cudaMemAccessFlagsProtReadWrite = 3 ## < Make the address range read-write accessible
  ##
  ##  Memory access descriptor
  ##
  type
    cudaMemAccessDesc* {.bycopy.} = object
      location*: cudaMemLocation
      ## < Location on which the request is to change it's accessibility
      flags*: cudaMemAccessFlags
      ## < ::CUmemProt accessibility flags to set on the request

  ##
  ##  Defines the allocation types available
  ##
  type
    cudaMemAllocationType* = enum
      cudaMemAllocationTypeInvalid = 0x0, ##  This allocation type is 'pinned', i.e. cannot migrate from its current
                                       ##  location while the application is actively using it
                                       ##
      cudaMemAllocationTypePinned = 0x1, cudaMemAllocationTypeMax = 0x7FFFFFFF
  ##
  ##  Flags for specifying particular handle types
  ##
  type
    cudaMemAllocationHandleType* = enum
      cudaMemHandleTypeNone = 0x0, ## < Does not allow any export mechanism. >
      cudaMemHandleTypePosixFileDescriptor = 0x1, ## < Allows a file descriptor to be used for exporting. Permitted only on POSIX systems. (cint)
      cudaMemHandleTypeWin32 = 0x2, ## < Allows a Win32 NT handle to be used for exporting. (HANDLE)
      cudaMemHandleTypeWin32Kmt = 0x4, ## < Allows a Win32 KMT handle to be used for exporting. (D3DKMT_HANDLE)
      cudaMemHandleTypeFabric = 0x8 ## < Allows a fabric handle to be used for exporting. (cudaMemFabricHandle_t)
  ##
  ##  Specifies the properties of allocations made from the pool.
  ##
  type
    cudaMemPoolProps* {.bycopy.} = object
      allocType*: cudaMemAllocationType
      ## < Allocation type. Currently must be specified as cudaMemAllocationTypePinned
      handleTypes*: cudaMemAllocationHandleType
      ## < Handle types that will be supported by allocations from the pool.
      location*: cudaMemLocation
      ## < Location allocations should reside.
      ##
      ##  Windows-specific LPSECURITYATTRIBUTES required when
      ##  ::cudaMemHandleTypeWin32 is specified.  This security attribute defines
      ##  the scope of which exported allocations may be tranferred to other
      ##  processes.  In all other cases, this field is required to be zero.
      ##
      win32SecurityAttributes*: pointer
      maxSize*: csize_t
      ## < Maximum pool size. When set to 0, defaults to a system dependent value.
      reserved*: array[56, char]
      ## < reserved for future use, must be 0

  ##
  ##  Opaque data for exporting a pool allocation
  ##
  type
    cudaMemPoolPtrExportData* {.bycopy.} = object
      reserved*: array[64, char]

  ##
  ##  Memory allocation node parameters
  ##
  type
    cudaMemAllocNodeParams* {.bycopy.} = object
      ##
      ##  in: location where the allocation should reside (specified in ::location).
      ##  ::handleTypes must be ::cudaMemHandleTypeNone. IPC is not supported.
      ##
      poolProps*: cudaMemPoolProps
      ## < in: array of memory access descriptors. Used to describe peer GPU access
      accessDescs*: ptr cudaMemAccessDesc
      ## < in: number of memory access descriptors.  Must not exceed the number of GPUs.
      accessDescCount*: csize_t
      ## < in: Number of `accessDescs`s
      bytesize*: csize_t
      ## < in: size in bytes of the requested allocation
      dptr*: pointer
      ## < out: address of the allocation returned by CUDA

  ##
  ##  Memory allocation node parameters
  ##
  type
    cudaMemAllocNodeParamsV2* {.bycopy.} = object
      ##
      ##  in: location where the allocation should reside (specified in ::location).
      ##  ::handleTypes must be ::cudaMemHandleTypeNone. IPC is not supported.
      ##
      poolProps*: cudaMemPoolProps
      ## < in: array of memory access descriptors. Used to describe peer GPU access
      accessDescs*: ptr cudaMemAccessDesc
      ## < in: number of memory access descriptors.  Must not exceed the number of GPUs.
      accessDescCount*: csize_t
      ## < in: Number of `accessDescs`s
      bytesize*: csize_t
      ## < in: size in bytes of the requested allocation
      dptr*: pointer
      ## < out: address of the allocation returned by CUDA

  ##
  ##  Memory free node parameters
  ##
  type
    cudaMemFreeNodeParams* {.bycopy.} = object
      dptr*: pointer
      ## < in: the pointer to free

  ##
  ##  Graph memory attributes
  ##
  type
    cudaGraphMemAttributeType* = enum ##
                                   ##  (value type = cuuclonglong)
                                   ##  Amount of memory, in bytes, currently associated with graphs.
                                   ##
      cudaGraphMemAttrUsedMemCurrent = 0x0, ##
                                         ##  (value type = cuuclonglong)
                                         ##  High watermark of memory, in bytes, associated with graphs since the
                                         ##  last time it was reset.  High watermark can only be reset to zero.
                                         ##
      cudaGraphMemAttrUsedMemHigh = 0x1, ##
                                      ##  (value type = cuuclonglong)
                                      ##  Amount of memory, in bytes, currently allocated for use by
                                      ##  the CUDA graphs asynchronous allocator.
                                      ##
      cudaGraphMemAttrReservedMemCurrent = 0x2, ##
                                             ##  (value type = cuuclonglong)
                                             ##  High watermark of memory, in bytes, currently allocated for use by
                                             ##  the CUDA graphs asynchronous allocator.
                                             ##
      cudaGraphMemAttrReservedMemHigh = 0x3
  ##
  ##  CUDA device P2P attributes
  ##
  type
    cudaDeviceP2PAttr* = enum
      cudaDevP2PAttrPerformanceRank = 1, ## < A relative value indicating the performance of the link between two devices
      cudaDevP2PAttrAccessSupported = 2, ## < Peer access is enabled
      cudaDevP2PAttrNativeAtomicSupported = 3, ## < Native atomic operation over the link supported
      cudaDevP2PAttrCudaArrayAccessSupported = 4 ## < Accessing CUDA arrays over the link supported
  ##
  ##  CUDA UUID types
  ##
  type
    CUuuid_st* {.bycopy.} = object
      ## < CUDA definition of UUID
      bytes*: array[16, char]

  type
    CUuuid* = CUuuid_st
  type
    cudaUUID_t* = CUuuid_st
  ##
  ##  CUDA device properties
  ##
  type
    cudaDeviceProp* {.bycopy.} = object
      name*: array[256, char]
      ## < ASCII string identifying device
      uuid*: cudaUUID_t
      ## < 16-byte unique identifier
      luid*: array[8, char]
      ## < 8-byte locally unique identifier. Value is undefined on TCC and non-Windows platforms
      luidDeviceNodeMask*: cuint
      ## < LUID device node mask. Value is undefined on TCC and non-Windows platforms
      totalGlobalMem*: csize_t
      ## < Global memory available on device in bytes
      sharedMemPerBlock*: csize_t
      ## < Shared memory available per block in bytes
      regsPerBlock*: cint
      ## < 32-bit registers available per block
      warpSize*: cint
      ## < Warp size in threads
      memPitch*: csize_t
      ## < Maximum pitch in bytes allowed by memory copies
      maxThreadsPerBlock*: cint
      ## < Maximum number of threads per block
      maxThreadsDim*: array[3, cint]
      ## < Maximum size of each dimension of a block
      maxGridSize*: array[3, cint]
      ## < Maximum size of each dimension of a grid
      clockRate*: cint
      ## < Deprecated, Clock frequency in kilohertz
      totalConstMem*: csize_t
      ## < Constant memory available on device in bytes
      major*: cint
      ## < Major compute capability
      minor*: cint
      ## < Minor compute capability
      textureAlignment*: csize_t
      ## < Alignment requirement for textures
      texturePitchAlignment*: csize_t
      ## < Pitch alignment requirement for texture references bound to pitched memory
      deviceOverlap*: cint
      ## < Device can concurrently copy memory and execute a kernel. Deprecated. Use instead asyncEngineCount.
      multiProcessorCount*: cint
      ## < Number of multiprocessors on device
      kernelExecTimeoutEnabled*: cint
      ## < Deprecated, Specified whether there is a run time limit on kernels
      integrated*: cint
      ## < Device is integrated as opposed to discrete
      canMapHostMemory*: cint
      ## < Device can map host memory with cudaHostAlloc/cudaHostGetDevicePointer
      computeMode*: cint
      ## < Deprecated, Compute mode (See ::cudaComputeMode)
      maxTexture1D*: cint
      ## < Maximum 1D texture size
      maxTexture1DMipmap*: cint
      ## < Maximum 1D mipmapped texture size
      maxTexture1DLinear*: cint
      ## < Deprecated, do not use. Use cudaDeviceGetTexture1DLinearMaxWidth() or cuDeviceGetTexture1DLinearMaxWidth() instead.
      maxTexture2D*: array[2, cint]
      ## < Maximum 2D texture dimensions
      maxTexture2DMipmap*: array[2, cint]
      ## < Maximum 2D mipmapped texture dimensions
      maxTexture2DLinear*: array[3, cint]
      ## < Maximum dimensions (width, height, pitch) for 2D textures bound to pitched memory
      maxTexture2DGather*: array[2, cint]
      ## < Maximum 2D texture dimensions if texture gather operations have to be performed
      maxTexture3D*: array[3, cint]
      ## < Maximum 3D texture dimensions
      maxTexture3DAlt*: array[3, cint]
      ## < Maximum alternate 3D texture dimensions
      maxTextureCubemap*: cint
      ## < Maximum Cubemap texture dimensions
      maxTexture1DLayered*: array[2, cint]
      ## < Maximum 1D layered texture dimensions
      maxTexture2DLayered*: array[3, cint]
      ## < Maximum 2D layered texture dimensions
      maxTextureCubemapLayered*: array[2, cint]
      ## < Maximum Cubemap layered texture dimensions
      maxSurface1D*: cint
      ## < Maximum 1D surface size
      maxSurface2D*: array[2, cint]
      ## < Maximum 2D surface dimensions
      maxSurface3D*: array[3, cint]
      ## < Maximum 3D surface dimensions
      maxSurface1DLayered*: array[2, cint]
      ## < Maximum 1D layered surface dimensions
      maxSurface2DLayered*: array[3, cint]
      ## < Maximum 2D layered surface dimensions
      maxSurfaceCubemap*: cint
      ## < Maximum Cubemap surface dimensions
      maxSurfaceCubemapLayered*: array[2, cint]
      ## < Maximum Cubemap layered surface dimensions
      surfaceAlignment*: csize_t
      ## < Alignment requirements for surfaces
      concurrentKernels*: cint
      ## < Device can possibly execute multiple kernels concurrently
      ECCEnabled*: cint
      ## < Device has ECC support enabled
      pciBusID*: cint
      ## < PCI bus ID of the device
      pciDeviceID*: cint
      ## < PCI device ID of the device
      pciDomainID*: cint
      ## < PCI domain ID of the device
      tccDriver*: cint
      ## < 1 if device is a Tesla device using TCC driver, 0 otherwise
      asyncEngineCount*: cint
      ## < Number of asynchronous engines
      unifiedAddressing*: cint
      ## < Device shares a unified address space with the host
      memoryClockRate*: cint
      ## < Deprecated, Peak memory clock frequency in kilohertz
      memoryBusWidth*: cint
      ## < Global memory bus width in bits
      l2CacheSize*: cint
      ## < Size of L2 cache in bytes
      persistingL2CacheMaxSize*: cint
      ## < Device's maximum l2 persisting lines capacity setting in bytes
      maxThreadsPerMultiProcessor*: cint
      ## < Maximum resident threads per multiprocessor
      streamPrioritiesSupported*: cint
      ## < Device supports stream priorities
      globalL1CacheSupported*: cint
      ## < Device supports caching globals in L1
      localL1CacheSupported*: cint
      ## < Device supports caching locals in L1
      sharedMemPerMultiprocessor*: csize_t
      ## < Shared memory available per multiprocessor in bytes
      regsPerMultiprocessor*: cint
      ## < 32-bit registers available per multiprocessor
      managedMemory*: cint
      ## < Device supports allocating managed memory on this system
      isMultiGpuBoard*: cint
      ## < Device is on a multi-GPU board
      multiGpuBoardGroupID*: cint
      ## < Unique identifier for a group of devices on the same multi-GPU board
      hostNativeAtomicSupported*: cint
      ## < Link between the device and the host supports native atomic operations
      singleToDoublePrecisionPerfRatio*: cint
      ## < Deprecated, Ratio of single precision performance (in floating-point operations per second) to double precision performance
      pageableMemoryAccess*: cint
      ## < Device supports coherently accessing pageable memory without calling cudaHostRegister on it
      concurrentManagedAccess*: cint
      ## < Device can coherently access managed memory concurrently with the CPU
      computePreemptionSupported*: cint
      ## < Device supports Compute Preemption
      canUseHostPointerForRegisteredMem*: cint
      ## < Device can access host registered memory at the same virtual address as the CPU
      cooperativeLaunch*: cint
      ## < Device supports launching cooperative kernels via ::cudaLaunchCooperativeKernel
      cooperativeMultiDeviceLaunch*: cint
      ## < Deprecated, cudaLaunchCooperativeKernelMultiDevice is deprecated.
      sharedMemPerBlockOptin*: csize_t
      ## < Per device maximum shared memory per block usable by special opt in
      pageableMemoryAccessUsesHostPageTables*: cint
      ## < Device accesses pageable memory via the host's page tables
      directManagedMemAccessFromHost*: cint
      ## < Host can directly access managed memory on the device without migration.
      maxBlocksPerMultiProcessor*: cint
      ## < Maximum number of resident blocks per multiprocessor
      accessPolicyMaxWindowSize*: cint
      ## < The maximum value of ::cudaAccessPolicyWindow::num_bytes.
      reservedSharedMemPerBlock*: csize_t
      ## < Shared memory reserved by CUDA driver per block in bytes
      hostRegisterSupported*: cint
      ## < Device supports host memory registration via ::cudaHostRegister.
      sparseCudaArraySupported*: cint
      ## < 1 if the device supports sparse CUDA arrays and sparse CUDA mipmapped arrays, 0 otherwise
      hostRegisterReadOnlySupported*: cint
      ## < Device supports using the ::cudaHostRegister flag cudaHostRegisterReadOnly to register memory that must be mapped as read-only to the GPU
      timelineSemaphoreInteropSupported*: cint
      ## < External timeline semaphore interop is supported on the device
      memoryPoolsSupported*: cint
      ## < 1 if the device supports using the cudaMallocAsync and cudaMemPool family of APIs, 0 otherwise
      gpuDirectRDMASupported*: cint
      ## < 1 if the device supports GPUDirect RDMA APIs, 0 otherwise
      gpuDirectRDMAFlushWritesOptions*: cuint
      ## < Bitmask to be interpreted according to the ::cudaFlushGPUDirectRDMAWritesOptions enum
      gpuDirectRDMAWritesOrdering*: cint
      ## < See the ::cudaGPUDirectRDMAWritesOrdering enum for numerical values
      memoryPoolSupportedHandleTypes*: cuint
      ## < Bitmask of handle types supported with mempool-based IPC
      deferredMappingCudaArraySupported*: cint
      ## < 1 if the device supports deferred mapping CUDA arrays and CUDA mipmapped arrays
      ipcEventSupported*: cint
      ## < Device supports IPC Events.
      clusterLaunch*: cint
      ## < Indicates device supports cluster launch
      unifiedFunctionPointers*: cint
      ## < Indicates device supports unified pointers
      reserved2*: array[2, cint]
      reserved1*: array[1, cint]
      ## < Reserved for future use
      reserved*: array[60, cint]
      ## < Reserved for future use

  ##
  ##  CUDA IPC Handle Size
  ##
  const
    CUDA_IPC_HANDLE_SIZE* = 64
  ##
  ##  CUDA IPC event handle
  ##
  type
    cudaIpcEventHandle_t* {.bycopy.} = object
      reserved*: array[CUDA_IPC_HANDLE_SIZE, char]

  ##
  ##  CUDA IPC memory handle
  ##
  type
    cudaIpcMemHandle_t* {.bycopy.} = object
      reserved*: array[CUDA_IPC_HANDLE_SIZE, char]

  ##
  ##  CUDA Mem Fabric Handle
  ##
  type
    cudaMemFabricHandle_t* {.bycopy.} = object
      reserved*: array[CUDA_IPC_HANDLE_SIZE, char]

  ##
  ##  External memory handle types
  ##
  type
    cudaExternalMemoryHandleType* = enum ##
                                      ##  Handle is an opaque file descriptor
                                      ##
      cudaExternalMemoryHandleTypeOpaqueFd = 1, ##
                                             ##  Handle is an opaque shared NT handle
                                             ##
      cudaExternalMemoryHandleTypeOpaqueWin32 = 2, ##
                                                ##  Handle is an opaque, globally shared handle
                                                ##
      cudaExternalMemoryHandleTypeOpaqueWin32Kmt = 3, ##
                                                   ##  Handle is a D3D12 heap object
                                                   ##
      cudaExternalMemoryHandleTypeD3D12Heap = 4, ##
                                              ##  Handle is a D3D12 committed resource
                                              ##
      cudaExternalMemoryHandleTypeD3D12Resource = 5, ##
                                                  ##   Handle is a shared NT handle to a D3D11 resource
                                                  ##
      cudaExternalMemoryHandleTypeD3D11Resource = 6, ##
                                                  ##   Handle is a globally shared handle to a D3D11 resource
                                                  ##
      cudaExternalMemoryHandleTypeD3D11ResourceKmt = 7, ##
                                                     ##   Handle is an NvSciBuf object
                                                     ##
      cudaExternalMemoryHandleTypeNvSciBuf = 8
  ##
  ##  Indicates that the external memory object is a dedicated resource
  ##
  const
    cudaExternalMemoryDedicated* = 0x1
  ##  When the /p flags parameter of ::cudaExternalSemaphoreSignalParams
  ##  contains this flag, it indicates that signaling an external semaphore object
  ##  should skip performing appropriate memory synchronization operations over all
  ##  the external memory objects that are imported as ::cudaExternalMemoryHandleTypeNvSciBuf,
  ##  which otherwise are performed by default to ensure data coherency with other
  ##  importers of the same NvSciBuf memory objects.
  ##
  const
    cudaExternalSemaphoreSignalSkipNvSciBufMemSync* = 0x01
  ##  When the /p flags parameter of ::cudaExternalSemaphoreWaitParams
  ##  contains this flag, it indicates that waiting an external semaphore object
  ##  should skip performing appropriate memory synchronization operations over all
  ##  the external memory objects that are imported as ::cudaExternalMemoryHandleTypeNvSciBuf,
  ##  which otherwise are performed by default to ensure data coherency with other
  ##  importers of the same NvSciBuf memory objects.
  ##
  const
    cudaExternalSemaphoreWaitSkipNvSciBufMemSync* = 0x02
  ##
  ##  When /p flags of ::cudaDeviceGetNvSciSyncAttributes is set to this,
  ##  it indicates that application need signaler specific NvSciSyncAttr
  ##  to be filled by ::cudaDeviceGetNvSciSyncAttributes.
  ##
  const
    cudaNvSciSyncAttrSignal* = 0x1
  ##
  ##  When /p flags of ::cudaDeviceGetNvSciSyncAttributes is set to this,
  ##  it indicates that application need waiter specific NvSciSyncAttr
  ##  to be filled by ::cudaDeviceGetNvSciSyncAttributes.
  ##
  const
    cudaNvSciSyncAttrWait* = 0x2
  ##
  ##  External memory handle descriptor
  ##
  type
    INNER_C_STRUCT_driver_types_7* {.bycopy.} = object
      ##
      ##  Valid NT handle. Must be NULL if 'name' is non-NULL
      ##
      handle*: pointer
      ##
      ##  Name of a valid memory object.
      ##  Must be NULL if 'handle' is non-NULL.
      ##
      name*: pointer

  type
    INNER_C_UNION_driver_types_6* {.bycopy, union.} = object
      ##
      ##  File descriptor referencing the memory object. Valid
      ##  when type is
      ##  ::cudaExternalMemoryHandleTypeOpaqueFd
      ##
      fd*: cint
      ##
      ##  Win32 handle referencing the semaphore object. Valid when
      ##  type is one of the following:
      ##  - ::cudaExternalMemoryHandleTypeOpaqueWin32
      ##  - ::cudaExternalMemoryHandleTypeOpaqueWin32Kmt
      ##  - ::cudaExternalMemoryHandleTypeD3D12Heap
      ##  - ::cudaExternalMemoryHandleTypeD3D12Resource
      ##  - ::cudaExternalMemoryHandleTypeD3D11Resource
      ##  - ::cudaExternalMemoryHandleTypeD3D11ResourceKmt
      ##  Exactly one of 'handle' and 'name' must be non-NULL. If
      ##  type is one of the following:
      ##  ::cudaExternalMemoryHandleTypeOpaqueWin32Kmt
      ##  ::cudaExternalMemoryHandleTypeD3D11ResourceKmt
      ##  then 'name' must be NULL.
      ##
      win32*: INNER_C_STRUCT_driver_types_7
      ##
      ##  A handle representing NvSciBuf Object. Valid when type
      ##  is ::cudaExternalMemoryHandleTypeNvSciBuf
      ##
      nvSciBufObject*: pointer

  type
    cudaExternalMemoryHandleDesc* {.bycopy.} = object
      ##
      ##  Type of the handle
      ##
      `type`*: cudaExternalMemoryHandleType
      handle*: INNER_C_UNION_driver_types_6
      ##
      ##  Size of the memory allocation
      ##
      size*: culonglong
      ##
      ##  Flags must either be zero or ::cudaExternalMemoryDedicated
      ##
      flags*: cuint

  ##
  ##  External memory buffer descriptor
  ##
  type
    cudaExternalMemoryBufferDesc* {.bycopy.} = object
      ##
      ##  Offset into the memory object where the buffer's base is
      ##
      offset*: culonglong
      ##
      ##  Size of the buffer
      ##
      size*: culonglong
      ##
      ##  Flags reserved for future use. Must be zero.
      ##
      flags*: cuint

  ##
  ##  External memory mipmap descriptor
  ##
  type
    cudaExternalMemoryMipmappedArrayDesc* {.bycopy.} = object
      ##
      ##  Offset into the memory object where the base level of the
      ##  mipmap chain is.
      ##
      offset*: culonglong
      ##
      ##  Format of base level of the mipmap chain
      ##
      formatDesc*: cudaChannelFormatDesc
      ##
      ##  Dimensions of base level of the mipmap chain
      ##
      extent*: cudaExtent
      ##
      ##  Flags associated with CUDA mipmapped arrays.
      ##  See ::cudaMallocMipmappedArray
      ##
      flags*: cuint
      ##
      ##  Total number of levels in the mipmap chain
      ##
      numLevels*: cuint

  ##
  ##  External semaphore handle types
  ##
  type
    cudaExternalSemaphoreHandleType* = enum ##
                                         ##  Handle is an opaque file descriptor
                                         ##
      cudaExternalSemaphoreHandleTypeOpaqueFd = 1, ##
                                                ##  Handle is an opaque shared NT handle
                                                ##
      cudaExternalSemaphoreHandleTypeOpaqueWin32 = 2, ##
                                                   ##  Handle is an opaque, globally shared handle
                                                   ##
      cudaExternalSemaphoreHandleTypeOpaqueWin32Kmt = 3, ##
                                                      ##  Handle is a shared NT handle referencing a D3D12 fence object
                                                      ##
      cudaExternalSemaphoreHandleTypeD3D12Fence = 4, ##
                                                  ##  Handle is a shared NT handle referencing a D3D11 fence object
                                                  ##
      cudaExternalSemaphoreHandleTypeD3D11Fence = 5, ##
                                                  ##  Opaque handle to NvSciSync Object
                                                  ##
      cudaExternalSemaphoreHandleTypeNvSciSync = 6, ##
                                                 ##  Handle is a shared NT handle referencing a D3D11 keyed mutex object
                                                 ##
      cudaExternalSemaphoreHandleTypeKeyedMutex = 7, ##
                                                  ##  Handle is a shared KMT handle referencing a D3D11 keyed mutex object
                                                  ##
      cudaExternalSemaphoreHandleTypeKeyedMutexKmt = 8, ##
                                                     ##  Handle is an opaque handle file descriptor referencing a timeline semaphore
                                                     ##
      cudaExternalSemaphoreHandleTypeTimelineSemaphoreFd = 9, ##
                                                           ##  Handle is an opaque handle file descriptor referencing a timeline semaphore
                                                           ##
      cudaExternalSemaphoreHandleTypeTimelineSemaphoreWin32 = 10
  ##
  ##  External semaphore handle descriptor
  ##
  type
    INNER_C_STRUCT_driver_types_9* {.bycopy.} = object
      ##
      ##  Valid NT handle. Must be NULL if 'name' is non-NULL
      ##
      handle*: pointer
      ##
      ##  Name of a valid synchronization primitive.
      ##  Must be NULL if 'handle' is non-NULL.
      ##
      name*: pointer

  type
    INNER_C_UNION_driver_types_8* {.bycopy, union.} = object
      ##
      ##  File descriptor referencing the semaphore object. Valid when
      ##  type is one of the following:
      ##  - ::cudaExternalSemaphoreHandleTypeOpaqueFd
      ##  - ::cudaExternalSemaphoreHandleTypeTimelineSemaphoreFd
      ##
      fd*: cint
      ##
      ##  Win32 handle referencing the semaphore object. Valid when
      ##  type is one of the following:
      ##  - ::cudaExternalSemaphoreHandleTypeOpaqueWin32
      ##  - ::cudaExternalSemaphoreHandleTypeOpaqueWin32Kmt
      ##  - ::cudaExternalSemaphoreHandleTypeD3D12Fence
      ##  - ::cudaExternalSemaphoreHandleTypeD3D11Fence
      ##  - ::cudaExternalSemaphoreHandleTypeKeyedMutex
      ##  - ::cudaExternalSemaphoreHandleTypeTimelineSemaphoreWin32
      ##  Exactly one of 'handle' and 'name' must be non-NULL. If
      ##  type is one of the following:
      ##  ::cudaExternalSemaphoreHandleTypeOpaqueWin32Kmt
      ##  ::cudaExternalSemaphoreHandleTypeKeyedMutexKmt
      ##  then 'name' must be NULL.
      ##
      win32*: INNER_C_STRUCT_driver_types_9
      ##
      ##  Valid NvSciSyncObj. Must be non NULL
      ##
      nvSciSyncObj*: pointer

  type
    cudaExternalSemaphoreHandleDesc* {.bycopy.} = object
      ##
      ##  Type of the handle
      ##
      `type`*: cudaExternalSemaphoreHandleType
      handle*: INNER_C_UNION_driver_types_8
      ##
      ##  Flags reserved for the future. Must be zero.
      ##
      flags*: cuint

  ##
  ##  External semaphore signal parameters(deprecated)
  ##
  type
    INNER_C_STRUCT_driver_types_11* {.bycopy.} = object
      ##
      ##  Value of fence to be signaled
      ##
      value*: culonglong

  type
    INNER_C_UNION_driver_types_12* {.bycopy, union.} = object
      ##
      ##  Pointer to NvSciSyncFence. Valid if ::cudaExternalSemaphoreHandleType
      ##  is of type ::cudaExternalSemaphoreHandleTypeNvSciSync.
      ##
      fence*: pointer
      reserved*: culonglong

  type
    INNER_C_STRUCT_driver_types_13* {.bycopy.} = object
      ##
      ##  Value of key to release the mutex with
      ##
      key*: culonglong

  type
    INNER_C_STRUCT_driver_types_10* {.bycopy.} = object
      ##
      ##  Parameters for fence objects
      ##
      fence*: INNER_C_STRUCT_driver_types_11
      nvSciSync*: INNER_C_UNION_driver_types_12
      ##
      ##  Parameters for keyed mutex objects
      ##
      keyedMutex*: INNER_C_STRUCT_driver_types_13

  type
    cudaExternalSemaphoreSignalParams_v1* {.bycopy.} = object
      params*: INNER_C_STRUCT_driver_types_10
      ##
      ##  Only when ::cudaExternalSemaphoreSignalParams is used to
      ##  signal a ::cudaExternalSemaphore_t of type
      ##  ::cudaExternalSemaphoreHandleTypeNvSciSync, the valid flag is
      ##  ::cudaExternalSemaphoreSignalSkipNvSciBufMemSync: which indicates
      ##  that while signaling the ::cudaExternalSemaphore_t, no memory
      ##  synchronization operations should be performed for any external memory
      ##  object imported as ::cudaExternalMemoryHandleTypeNvSciBuf.
      ##  For all other types of ::cudaExternalSemaphore_t, flags must be zero.
      ##
      flags*: cuint

  ##
  ##  External semaphore wait parameters(deprecated)
  ##
  type
    INNER_C_STRUCT_driver_types_15* {.bycopy.} = object
      ##
      ##  Value of fence to be waited on
      ##
      value*: culonglong

  type
    INNER_C_UNION_driver_types_16* {.bycopy, union.} = object
      ##
      ##  Pointer to NvSciSyncFence. Valid if ::cudaExternalSemaphoreHandleType
      ##  is of type ::cudaExternalSemaphoreHandleTypeNvSciSync.
      ##
      fence*: pointer
      reserved*: culonglong

  type
    INNER_C_STRUCT_driver_types_17* {.bycopy.} = object
      ##
      ##  Value of key to acquire the mutex with
      ##
      key*: culonglong
      ##
      ##  Timeout in milliseconds to wait to acquire the mutex
      ##
      timeoutMs*: cuint

  type
    INNER_C_STRUCT_driver_types_14* {.bycopy.} = object
      ##
      ##  Parameters for fence objects
      ##
      fence*: INNER_C_STRUCT_driver_types_15
      nvSciSync*: INNER_C_UNION_driver_types_16
      ##
      ##  Parameters for keyed mutex objects
      ##
      keyedMutex*: INNER_C_STRUCT_driver_types_17

  type
    cudaExternalSemaphoreWaitParams_v1* {.bycopy.} = object
      params*: INNER_C_STRUCT_driver_types_14
      ##
      ##  Only when ::cudaExternalSemaphoreSignalParams is used to
      ##  signal a ::cudaExternalSemaphore_t of type
      ##  ::cudaExternalSemaphoreHandleTypeNvSciSync, the valid flag is
      ##  ::cudaExternalSemaphoreSignalSkipNvSciBufMemSync: which indicates
      ##  that while waiting for the ::cudaExternalSemaphore_t, no memory
      ##  synchronization operations should be performed for any external memory
      ##  object imported as ::cudaExternalMemoryHandleTypeNvSciBuf.
      ##  For all other types of ::cudaExternalSemaphore_t, flags must be zero.
      ##
      flags*: cuint

  ##
  ##  External semaphore signal parameters, compatible with driver type
  ##
  type
    INNER_C_STRUCT_driver_types_19* {.bycopy.} = object
      ##
      ##  Value of fence to be signaled
      ##
      value*: culonglong

  type
    INNER_C_UNION_driver_types_20* {.bycopy, union.} = object
      ##
      ##  Pointer to NvSciSyncFence. Valid if ::cudaExternalSemaphoreHandleType
      ##  is of type ::cudaExternalSemaphoreHandleTypeNvSciSync.
      ##
      fence*: pointer
      reserved*: culonglong

  type
    INNER_C_STRUCT_driver_types_21* {.bycopy.} = object
      ##
      ##  Value of key to release the mutex with
      ##
      key*: culonglong

  type
    INNER_C_STRUCT_driver_types_18* {.bycopy.} = object
      ##
      ##  Parameters for fence objects
      ##
      fence*: INNER_C_STRUCT_driver_types_19
      nvSciSync*: INNER_C_UNION_driver_types_20
      ##
      ##  Parameters for keyed mutex objects
      ##
      keyedMutex*: INNER_C_STRUCT_driver_types_21
      reserved*: array[12, cuint]

  type
    cudaExternalSemaphoreSignalParams* {.bycopy.} = object
      params*: INNER_C_STRUCT_driver_types_18
      ##
      ##  Only when ::cudaExternalSemaphoreSignalParams is used to
      ##  signal a ::cudaExternalSemaphore_t of type
      ##  ::cudaExternalSemaphoreHandleTypeNvSciSync, the valid flag is
      ##  ::cudaExternalSemaphoreSignalSkipNvSciBufMemSync: which indicates
      ##  that while signaling the ::cudaExternalSemaphore_t, no memory
      ##  synchronization operations should be performed for any external memory
      ##  object imported as ::cudaExternalMemoryHandleTypeNvSciBuf.
      ##  For all other types of ::cudaExternalSemaphore_t, flags must be zero.
      ##
      flags*: cuint
      reserved*: array[16, cuint]

  ##
  ##  External semaphore wait parameters, compatible with driver type
  ##
  type
    INNER_C_STRUCT_driver_types_23* {.bycopy.} = object
      ##
      ##  Value of fence to be waited on
      ##
      value*: culonglong

  type
    INNER_C_UNION_driver_types_24* {.bycopy, union.} = object
      ##
      ##  Pointer to NvSciSyncFence. Valid if ::cudaExternalSemaphoreHandleType
      ##  is of type ::cudaExternalSemaphoreHandleTypeNvSciSync.
      ##
      fence*: pointer
      reserved*: culonglong

  type
    INNER_C_STRUCT_driver_types_25* {.bycopy.} = object
      ##
      ##  Value of key to acquire the mutex with
      ##
      key*: culonglong
      ##
      ##  Timeout in milliseconds to wait to acquire the mutex
      ##
      timeoutMs*: cuint

  type
    INNER_C_STRUCT_driver_types_22* {.bycopy.} = object
      ##
      ##  Parameters for fence objects
      ##
      fence*: INNER_C_STRUCT_driver_types_23
      nvSciSync*: INNER_C_UNION_driver_types_24
      ##
      ##  Parameters for keyed mutex objects
      ##
      keyedMutex*: INNER_C_STRUCT_driver_types_25
      reserved*: array[10, cuint]

  type
    cudaExternalSemaphoreWaitParams* {.bycopy.} = object
      params*: INNER_C_STRUCT_driver_types_22
      ##
      ##  Only when ::cudaExternalSemaphoreSignalParams is used to
      ##  signal a ::cudaExternalSemaphore_t of type
      ##  ::cudaExternalSemaphoreHandleTypeNvSciSync, the valid flag is
      ##  ::cudaExternalSemaphoreSignalSkipNvSciBufMemSync: which indicates
      ##  that while waiting for the ::cudaExternalSemaphore_t, no memory
      ##  synchronization operations should be performed for any external memory
      ##  object imported as ::cudaExternalMemoryHandleTypeNvSciBuf.
      ##  For all other types of ::cudaExternalSemaphore_t, flags must be zero.
      ##
      flags*: cuint
      reserved*: array[16, cuint]

  ## *****************************************************************************
  ##                                                                               *
  ##   SHORTHAND TYPE DEFINITION USED BY RUNTIME API                               *
  ##                                                                               *
  ## *****************************************************************************
  ##
  ##  CUDA Error types
  ##
  type
    cudaError_t* = cudaError
  type CUstream_st = object
  type
    cudaStream_t* = ptr CUstream_st
  type CUevent_st = object
  type
    cudaEvent_t* = ptr CUevent_st
  ##
  ##  CUDA graphics resource types
  ##
  type
    cudaGraphicsResource_t* = ptr cudaGraphicsResource
  type CUexternalMemory_st = object
  type
    cudaExternalMemory_t* = ptr CUexternalMemory_st
  type CUexternalSemaphore_st = object
  type
    cudaExternalSemaphore_t* = ptr CUexternalSemaphore_st
  type CUgraph_st = object
  type
    cudaGraph_t* = ptr CUgraph_st
  type CUgraphNode_st = object
  type
    cudaGraphNode_t* = ptr CUgraphNode_st
  type CUuserObject_st = object
  type
    cudaUserObject_t* = ptr CUuserObject_st
  ##
  ##  CUDA handle for conditional graph nodes
  ##
  type
    cudaGraphConditionalHandle* = culonglong
  type CUfunc_st = object
  type
    cudaFunction_t* = ptr CUfunc_st
  type CUkern_st = object
  type
    cudaKernel_t* = ptr CUkern_st
  type CUmemPoolHandle_st = object
  type
    cudaMemPool_t* = ptr CUmemPoolHandle_st
  ##
  ##  CUDA cooperative group scope
  ##
  type
    cudaCGScope* = enum
      cudaCGScopeInvalid = 0,   ## < Invalid cooperative group scope
      cudaCGScopeGrid = 1,      ## < Scope represented by a grid_group
      cudaCGScopeMultiGrid = 2  ## < Scope represented by a multi_grid_group
  ##
  ##  Legacy stream handle
  ##
  ##  Stream handle that can be passed as a cudaStream_t to use an implicit stream
  ##  with legacy synchronization behavior.
  ##
  ##  See details of the \link_sync_behavior
  ##
  const
    cudaStreamLegacy* = (cast[cudaStream_t](0x1))
  ##
  ##  Per-thread stream handle
  ##
  ##  Stream handle that can be passed as a cudaStream_t to use an implicit stream
  ##  with per-thread synchronization behavior.
  ##
  ##  See details of the \link_sync_behavior
  ##
  const
    cudaStreamPerThread* = (cast[cudaStream_t](0x2))
  ##
  ##  CUDA launch parameters
  ##
  type
    cudaLaunchParams* {.bycopy.} = object
      `func`*: pointer
      ## < Device function symbol
      gridDim*: dim3
      ## < Grid dimentions
      blockDim*: dim3
      ## < Block dimentions
      args*: ptr pointer
      ## < Arguments
      sharedMem*: csize_t
      ## < Shared memory
      stream*: cudaStream_t
      ## < Stream identifier

  ##
  ##  CUDA GPU kernel node parameters
  ##
  type
    cudaKernelNodeParams* {.bycopy.} = object
      `func`*: pointer
      ## < Kernel to launch
      gridDim*: dim3
      ## < Grid dimensions
      blockDim*: dim3
      ## < Block dimensions
      sharedMemBytes*: cuint
      ## < Dynamic shared-memory size per thread block in bytes
      kernelParams*: ptr pointer
      ## < Array of pointers to individual kernel arguments
      extra*: ptr pointer
      ## < Pointer to kernel arguments in the "extra" format

  ##
  ##  CUDA GPU kernel node parameters
  ##
  type
    cudaKernelNodeParamsV2* {.bycopy.} = object
      `func`*: pointer
      ## < Kernel to launch
      ##  #if !defined(cplusplus) || __cplusplus >= 201103L
      gridDim*: dim3
      ## < Grid dimensions
      blockDim*: dim3
      ## < Block dimensions
      ##  #else
      ##  Union members cannot have nontrivial constructors until C++11.
      ##  uint3 gridDim;                  /**< Grid dimensions */
      ##  uint3 blockDim;                 /**< Block dimensions */
      sharedMemBytes*: cuint
      ## < Dynamic shared-memory size per thread block in bytes
      kernelParams*: ptr pointer
      ## < Array of pointers to individual kernel arguments
      extra*: ptr pointer
      ## < Pointer to kernel arguments in the "extra" format

  ##
  ##  External semaphore signal node parameters
  ##
  type
    cudaExternalSemaphoreSignalNodeParams* {.bycopy.} = object
      extSemArray*: ptr cudaExternalSemaphore_t
      ## < Array of external semaphore handles.
      paramsArray*: ptr cudaExternalSemaphoreSignalParams
      ## < Array of external semaphore signal parameters.
      numExtSems*: cuint
      ## < Number of handles and parameters supplied in extSemArray and paramsArray.

  ##
  ##  External semaphore signal node parameters
  ##
  type
    cudaExternalSemaphoreSignalNodeParamsV2* {.bycopy.} = object
      extSemArray*: ptr cudaExternalSemaphore_t
      ## < Array of external semaphore handles.
      paramsArray*: ptr cudaExternalSemaphoreSignalParams
      ## < Array of external semaphore signal parameters.
      numExtSems*: cuint
      ## < Number of handles and parameters supplied in extSemArray and paramsArray.

  ##
  ##  External semaphore wait node parameters
  ##
  type
    cudaExternalSemaphoreWaitNodeParams* {.bycopy.} = object
      extSemArray*: ptr cudaExternalSemaphore_t
      ## < Array of external semaphore handles.
      paramsArray*: ptr cudaExternalSemaphoreWaitParams
      ## < Array of external semaphore wait parameters.
      numExtSems*: cuint
      ## < Number of handles and parameters supplied in extSemArray and paramsArray.

  ##
  ##  External semaphore wait node parameters
  ##
  type
    cudaExternalSemaphoreWaitNodeParamsV2* {.bycopy.} = object
      extSemArray*: ptr cudaExternalSemaphore_t
      ## < Array of external semaphore handles.
      paramsArray*: ptr cudaExternalSemaphoreWaitParams
      ## < Array of external semaphore wait parameters.
      numExtSems*: cuint
      ## < Number of handles and parameters supplied in extSemArray and paramsArray.

  type
    cudaGraphConditionalHandleFlags* = enum
      cudaGraphCondAssignDefault = 1 ## < Apply default handle value when graph is launched.
  ##
  ##  CUDA conditional node types
  ##
  type
    cudaGraphConditionalNodeType* = enum
      cudaGraphCondTypeIf = 0,  ## < Conditional 'if' Node. Body executed once if condition value is non-zero.
      cudaGraphCondTypeWhile = 1 ## < Conditional 'while' Node. Body executed repeatedly while condition value is non-zero.
  ##
  ##  CUDA conditional node parameters
  ##
  type
    cudaConditionalNodeParams* {.bycopy.} = object
      handle*: cudaGraphConditionalHandle
      ## < Conditional node handle.
      ##                                                   Handles must be created in advance of creating the node
      ##                                                   using ::cudaGraphConditionalHandleCreate.
      `type`*: cudaGraphConditionalNodeType
      ## < Type of conditional node.
      size*: cuint
      ## < Size of graph output array.  Must be 1.
      phGraph_out*: ptr cudaGraph_t
      ## < CUDA-owned array populated with conditional node child graphs during creation of the node.
      ##                                                   Valid for the lifetime of the conditional node.
      ##                                                   The contents of the graph(s) are subject to the following constraints:
      ##
      ##                                                   - Allowed node types are kernel nodes, empty nodes, child graphs, memsets,
      ##                                                     memcopies, and conditionals. This applies recursively to child graphs and conditional bodies.
      ##                                                   - All kernels, including kernels in nested conditionals or child graphs at any level,
      ##                                                     must belong to the same CUDA context.
      ##
      ##                                                   These graphs may be populated using graph node creation APIs or ::cudaStreamBeginCaptureToGraph.

  ##
  ##  CUDA Graph node types
  ##
  type
    cudaGraphNodeType* = enum
      cudaGraphNodeTypeKernel = 0x00, ## < GPU kernel node
      cudaGraphNodeTypeMemcpy = 0x01, ## < Memcpy node
      cudaGraphNodeTypeMemset = 0x02, ## < Memset node
      cudaGraphNodeTypeHost = 0x03, ## < Host (executable) node
      cudaGraphNodeTypeGraph = 0x04, ## < Node which executes an embedded graph
      cudaGraphNodeTypeEmpty = 0x05, ## < Empty (no-op) node
      cudaGraphNodeTypeWaitEvent = 0x06, ## < External event wait node
      cudaGraphNodeTypeEventRecord = 0x07, ## < External event record node
      cudaGraphNodeTypeExtSemaphoreSignal = 0x08, ## < External semaphore signal node
      cudaGraphNodeTypeExtSemaphoreWait = 0x09, ## < External semaphore wait node
      cudaGraphNodeTypeMemAlloc = 0x0a, ## < Memory allocation node
      cudaGraphNodeTypeMemFree = 0x0b, ## < Memory free node
      cudaGraphNodeTypeConditional = 0x0d, ## < Conditional node
                                        ##
                                        ##                                               May be used to implement a conditional execution path or loop
                                        ##                                               inside of a graph. The graph(s) contained within the body of the conditional node
                                        ##                                               can be selectively executed or iterated upon based on the value of a conditional
                                        ##                                               variable.
                                        ##
                                        ##                                               Handles must be created in advance of creating the node
                                        ##                                               using ::cudaGraphConditionalHandleCreate.
                                        ##
                                        ##                                               The following restrictions apply to graphs which contain conditional nodes:
                                        ##                                                 The graph cannot be used in a child node.
                                        ##                                                 Only one instantiation of the graph may exist at any point in time.
                                        ##                                                 The graph cannot be cloned.
                                        ##
                                        ##                                               To set the control value, supply a default value when creating the handle and/or
                                        ##                                               call ::cudaGraphSetConditional from device code.
      cudaGraphNodeTypeCount
  ##
  ##  Child graph node parameters
  ##
  type
    cudaChildGraphNodeParams* {.bycopy.} = object
      graph*: cudaGraph_t
      ## < The child graph to clone into the node for node creation, or
      ##                             a handle to the graph owned by the node for node query

  ##
  ##  Event record node parameters
  ##
  type
    cudaEventRecordNodeParams* {.bycopy.} = object
      event*: cudaEvent_t
      ## < The event to record when the node executes

  ##
  ##  Event wait node parameters
  ##
  type
    cudaEventWaitNodeParams* {.bycopy.} = object
      event*: cudaEvent_t
      ## < The event to wait on from the node

  ##
  ##  Graph node parameters.  See ::cudaGraphAddNode.
  ##
  type
    INNER_C_UNION_driver_types_26* {.bycopy, union.} = object
      reserved1*: array[29, clonglong]
      ## < Padding. Unused bytes must be zero.
      kernel*: cudaKernelNodeParamsV2
      ## < Kernel node parameters.
      copyMem*: cudaMemcpyNodeParams
      ## < Memcpy node parameters.
      memset*: cudaMemsetParamsV2
      ## < Memset node parameters.
      host*: cudaHostNodeParamsV2
      ## < Host node parameters.
      graph*: cudaChildGraphNodeParams
      ## < Child graph node parameters.
      eventWait*: cudaEventWaitNodeParams
      ## < Event wait node parameters.
      eventRecord*: cudaEventRecordNodeParams
      ## < Event record node parameters.
      extSemSignal*: cudaExternalSemaphoreSignalNodeParamsV2
      ## < External semaphore signal node parameters.
      extSemWait*: cudaExternalSemaphoreWaitNodeParamsV2
      ## < External semaphore wait node parameters.
      alloc*: cudaMemAllocNodeParamsV2
      ## < Memory allocation node parameters.
      free*: cudaMemFreeNodeParams
      ## < Memory free node parameters.
      conditional*: cudaConditionalNodeParams
      ## < Conditional node parameters.

  type
    cudaGraphNodeParams* {.bycopy.} = object
      `type`*: cudaGraphNodeType
      ## < Type of the node
      reserved0*: array[3, cint]
      ## < Reserved.  Must be zero.
      ano_driver_types_27*: INNER_C_UNION_driver_types_26
      reserved2*: clonglong
      ## < Reserved bytes. Must be zero.

  ##
  ##  Type annotations that can be applied to graph edges as part of ::cudaGraphEdgeData.
  ##
  type
    cudaGraphDependencyType* = enum
      cudaGraphDependencyTypeDefault = 0, ## < This is an ordinary dependency.
      cudaGraphDependencyTypeProgrammatic = 1 ## < This dependency type allows the downstream node to
                                           ##                                                   use \c cudaGridDependencySynchronize(). It may only be used
                                           ##                                                   between kernel nodes, and must be used with either the
                                           ##                                                   ::cudaGraphKernelNodePortProgrammatic or
                                           ##
                                           ## ::cudaGraphKernelNodePortLaunchCompletion outgoing port.
  ##
  ##  Optional annotation for edges in a CUDA graph. Note, all edges implicitly have annotations and
  ##  default to a zero-initialized value if not specified. A zero-initialized struct indicates a
  ##  standard full serialization of two nodes with memory visibility.
  ##
  type
    cudaGraphEdgeData* {.bycopy.} = object
      from_port*: char
      ## < This indicates when the dependency is triggered from the upstream
      ##                                   node on the edge. The meaning is specfic to the node type. A value
      ##                                   of 0 in all cases means full completion of the upstream node, with
      ##                                   memory visibility to the downstream node or portion thereof
      ##                                   (indicated by \c to_port).
      ##                                   <br>
      ##                                   Only kernel nodes define non-zero ports. A kernel node
      ##                                   can use the following output port types:
      ##                                   ::cudaGraphKernelNodePortDefault, ::cudaGraphKernelNodePortProgrammatic,
      ##                                   or ::cudaGraphKernelNodePortLaunchCompletion.
      to_port*: char
      ## < This indicates what portion of the downstream node is dependent on
      ##                                 the upstream node or portion thereof (indicated by \c from_port). The
      ##                                 meaning is specific to the node type. A value of 0 in all cases means
      ##                                 the entirety of the downstream node is dependent on the upstream work.
      ##                                 <br>
      ##                                 Currently no node types define non-zero ports. Accordingly, this field
      ##                                 must be set to zero.
      `type`*: char
      ## < This should be populated with a value from ::cudaGraphDependencyType. (It
      ##                              is typed as char due to compiler-specific layout of bitfields.) See
      ##                              ::cudaGraphDependencyType.
      reserved*: array[5, char]
      ## < These bytes are unused and must be zeroed. This ensures
      ##                                     compatibility if additional fields are added in the future.

  ##
  ##  This port activates when the kernel has finished executing.
  ##
  const
    cudaGraphKernelNodePortDefault* = 0
  ##
  ##  This port activates when all blocks of the kernel have performed cudaTriggerProgrammaticLaunchCompletion()
  ##  or have terminated. It must be used with edge type ::cudaGraphDependencyTypeProgrammatic. See also
  ##  ::cudaLaunchAttributeProgrammaticEvent.
  ##
  const
    cudaGraphKernelNodePortProgrammatic* = 1
  ##
  ##  This port activates when all blocks of the kernel have begun execution. See also
  ##  ::cudaLaunchAttributeLaunchCompletionEvent.
  ##
  const
    cudaGraphKernelNodePortLaunchCompletion* = 2
  type CUgraphExec_st = object
  type
    cudaGraphExec_t* = ptr CUgraphExec_st
  ##
  ##  CUDA Graph Update error types
  ##
  type
    cudaGraphExecUpdateResult* = enum
      cudaGraphExecUpdateSuccess = 0x0, ## < The update succeeded
      cudaGraphExecUpdateError = 0x1, ## < The update failed for an unexpected reason which is described in the return value of the function
      cudaGraphExecUpdateErrorTopologyChanged = 0x2, ## < The update failed because the topology changed
      cudaGraphExecUpdateErrorNodeTypeChanged = 0x3, ## < The update failed because a node type changed
      cudaGraphExecUpdateErrorFunctionChanged = 0x4, ## < The update failed because the function of a kernel node changed (CUDA driver < 11.2)
      cudaGraphExecUpdateErrorParametersChanged = 0x5, ## < The update failed because the parameters changed in a way that is not supported
      cudaGraphExecUpdateErrorNotSupported = 0x6, ## < The update failed because something about the node is not supported
      cudaGraphExecUpdateErrorUnsupportedFunctionChange = 0x7, ## < The update failed because the function of a kernel node changed in an unsupported way
      cudaGraphExecUpdateErrorAttributesChanged = 0x8 ## < The update failed because the node attributes changed in a way that is not supported
  ##
  ##  Graph instantiation results
  ##
  type
    cudaGraphInstantiateResult* = enum
      cudaGraphInstantiateSuccess = 0, ## < Instantiation succeeded
      cudaGraphInstantiateError = 1, ## < Instantiation failed for an unexpected reason which is described in the return value of the function
      cudaGraphInstantiateInvalidStructure = 2, ## < Instantiation failed due to invalid structure, such as cycles
      cudaGraphInstantiateNodeOperationNotSupported = 3, ## < Instantiation for device launch failed because the graph contained an unsupported operation
      cudaGraphInstantiateMultipleDevicesNotSupported = 4 ## < Instantiation for device launch failed due to the nodes belonging to different contexts
  ##
  ##  Graph instantiation parameters
  ##
  type
    cudaGraphInstantiateParams* {.bycopy.} = object
      flags*: culonglong
      ## < Instantiation flags
      uploadStream*: cudaStream_t
      ## < Upload stream
      errNode_out*: cudaGraphNode_t
      ## < The node which caused instantiation to fail, if any
      result_out*: cudaGraphInstantiateResult
      ## < Whether instantiation was successful.  If it failed, the reason why

  ##
  ##  Result information returned by cudaGraphExecUpdate
  ##
  type
    cudaGraphExecUpdateResultInfo* {.bycopy.} = object
      ##
      ##  Gives more specific detail when a cuda graph update fails.
      ##
      resultNotKeyWord*: cudaGraphExecUpdateResult
      ##
      ##  The "to node" of the error edge when the topologies do not match.
      ##  The error node when the error is associated with a specific node.
      ##  NULL when the error is generic.
      ##
      errorNode*: cudaGraphNode_t
      ##
      ##  The from node of error edge when the topologies do not match. Otherwise NULL.
      ##
      errorFromNode*: cudaGraphNode_t

  type CUgraphDeviceUpdatableNode_st = object
  type
    cudaGraphDeviceNode_t* = ptr CUgraphDeviceUpdatableNode_st
  ##
  ##  Specifies the field to update when performing multiple node updates from the device
  ##
  type
    cudaGraphKernelNodeField* = enum
      cudaGraphKernelNodeFieldInvalid = 0, ## < Invalid field
      cudaGraphKernelNodeFieldGridDim, ## < Grid dimension update
      cudaGraphKernelNodeFieldParam, ## < Kernel parameter update
      cudaGraphKernelNodeFieldEnabled ## < Node enable/disable
  ##
  ##  Struct to specify a single node update to pass as part of a larger array to ::cudaGraphKernelNodeUpdatesApply
  ##
  type
    INNER_C_STRUCT_driver_types_29* {.bycopy.} = object
      pValue*: pointer
      ## < Kernel parameter data to write in
      offset*: csize_t
      ## < Offset into the parameter buffer at which to apply the update
      size*: csize_t
      ## < Number of bytes to update

  type
    INNER_C_UNION_driver_types_28* {.bycopy, union.} = object
      ##  #if !defined(cplusplus) || __cplusplus >= 201103L
      gridDim*: dim3
      ## < Grid dimensions
      ##  #else
      ##  Union members cannot have nontrivial constructors until C++11.
      ##  uint3 gridDim;              /**< Grid dimensions */
      ##  #endif
      param*: INNER_C_STRUCT_driver_types_29
      ## < Kernel parameter data
      isEnabled*: cuint
      ## < Node enable/disable data. Nonzero if the node should be enabled, 0 if it should be disabled

  type
    cudaGraphKernelNodeUpdate* {.bycopy.} = object
      node*: cudaGraphDeviceNode_t
      ## < Node to update
      field*: cudaGraphKernelNodeField
      ## < Which type of update to apply. Determines how updateData is interpreted
      updateData*: INNER_C_UNION_driver_types_28
      ## < Update data to apply. Which field is used depends on field's value

  ##
  ##  Flags to specify search options to be used with ::cudaGetDriverEntryPoint
  ##  For more details see ::cuGetProcAddress
  ##
  type
    cudaGetDriverEntryPointFlags* = enum
      cudaEnableDefault = 0x0,  ## < Default search mode for driver symbols.
      cudaEnableLegacyStream = 0x1, ## < Search for legacy versions of driver symbols.
      cudaEnablePerThreadDefaultStream = 0x2 ## < Search for per-thread versions of driver symbols.
  ##
  ##  Enum for status from obtaining driver entry points, used with ::cudaApiGetDriverEntryPoint
  ##
  type
    cudaDriverEntryPointQueryResult* = enum
      cudaDriverEntryPointSuccess = 0, ## < Search for symbol found a match
      cudaDriverEntryPointSymbolNotFound = 1, ## < Search for symbol was not found
      cudaDriverEntryPointVersionNotSufficent = 2 ## < Search for symbol was found but version wasn't great enough
  ##
  ##  CUDA Graph debug write options
  ##
  type
    cudaGraphDebugDotFlags* = enum
      cudaGraphDebugDotFlagsVerbose = 1 shl 0, ## < Output all debug data as if every debug flag is enabled
      cudaGraphDebugDotFlagsKernelNodeParams = 1 shl 2, ## < Adds cudaKernelNodeParams to output
      cudaGraphDebugDotFlagsMemcpyNodeParams = 1 shl 3, ## < Adds cudaMemcpy3DParms to output
      cudaGraphDebugDotFlagsMemsetNodeParams = 1 shl 4, ## < Adds cudaMemsetParams to output
      cudaGraphDebugDotFlagsHostNodeParams = 1 shl 5, ## < Adds cudaHostNodeParams to output
      cudaGraphDebugDotFlagsEventNodeParams = 1 shl 6, ## < Adds cudaEvent_t handle from record and wait nodes to output
      cudaGraphDebugDotFlagsExtSemasSignalNodeParams = 1 shl 7, ## < Adds
                                                           ## cudaExternalSemaphoreSignalNodeParams values to output
      cudaGraphDebugDotFlagsExtSemasWaitNodeParams = 1 shl 8, ## < Adds
                                                         ## cudaExternalSemaphoreWaitNodeParams to output
      cudaGraphDebugDotFlagsKernelNodeAttributes = 1 shl 9, ## < Adds cudaKernelNodeAttrID values to output
      cudaGraphDebugDotFlagsHandles = 1 shl 10, cudaGraphDebugDotFlagsConditionalNodeParams = 1 shl
          15                  ## < Adds cudaConditionalNodeParams to output
  ##
  ##  Flags for instantiating a graph
  ##
  type
    cudaGraphInstantiateFlags* = enum
      cudaGraphInstantiateFlagAutoFreeOnLaunch = 1, ## < Automatically free memory allocated in a graph before relaunching.
      cudaGraphInstantiateFlagUpload = 2, ## < Automatically upload the graph after instantiation. Only supported by
                                       ##                                                       ::cudaGraphInstantiateWithParams.  The upload will be performed using the
                                       ##                                                       stream provided in \p instantiateParams.
      cudaGraphInstantiateFlagDeviceLaunch = 4, ## < Instantiate the graph to be launchable from the device. This flag can only
                                             ##                                                       be used on platforms which support unified addressing. This flag cannot be
                                             ##                                                       used in conjunction with
                                             ## cudaGraphInstantiateFlagAutoFreeOnLaunch.
      cudaGraphInstantiateFlagUseNodePriority = 8 ## < Run the graph using the per-node priority attributes rather than the
                                               ##                                                       priority of the stream it is launched into.
  ##
  ##  Memory Synchronization Domain
  ##
  ##  A kernel can be launched in a specified memory synchronization domain that affects all memory operations issued by
  ##  that kernel. A memory barrier issued in one domain will only order memory operations in that domain, thus eliminating
  ##  latency increase from memory barriers ordering unrelated traffic.
  ##
  ##  By default, kernels are launched in domain 0. Kernel launched with ::cudaLaunchMemSyncDomainRemote will have a
  ##  different domain ID. User may also alter the domain ID with ::cudaLaunchMemSyncDomainMap for a specific stream /
  ##  graph node / kernel launch. See ::cudaLaunchAttributeMemSyncDomain, ::cudaStreamSetAttribute, ::cudaLaunchKernelEx,
  ##  ::cudaGraphKernelNodeSetAttribute.
  ##
  ##  Memory operations done in kernels launched in different domains are considered system-scope distanced. In other
  ##  words, a GPU scoped memory synchronization is not sufficient for memory order to be observed by kernels in another
  ##  memory synchronization domain even if they are on the same GPU.
  ##
  type
    cudaLaunchMemSyncDomain* = enum
      cudaLaunchMemSyncDomainDefault = 0, ## < Launch kernels in the default domain
      cudaLaunchMemSyncDomainRemote = 1 ## < Launch kernels in the remote domain
  ##
  ##  Memory Synchronization Domain map
  ##
  ##  See ::cudaLaunchMemSyncDomain.
  ##
  ##  By default, kernels are launched in domain 0. Kernel launched with ::cudaLaunchMemSyncDomainRemote will have a
  ##  different domain ID. User may also alter the domain ID with ::cudaLaunchMemSyncDomainMap for a specific stream /
  ##  graph node / kernel launch. See ::cudaLaunchAttributeMemSyncDomainMap.
  ##
  ##  Domain ID range is available through ::cudaDevAttrMemSyncDomainCount.
  ##
  type
    cudaLaunchMemSyncDomainMap* {.bycopy.} = object
      default*: char
      ## < The default domain ID to use for designated kernels
      remote*: char
      ## < The remote domain ID to use for designated kernels

  ##
  ##  Launch attributes enum; used as id field of ::cudaLaunchAttribute
  ##
  type
    cudaLaunchAttributeID* = enum
      cudaLaunchAttributeIgnore = 0, ## < Ignored entry, for convenient composition
      cudaLaunchAttributeAccessPolicyWindow = 1, ## < Valid for streams, graph nodes, launches. See
                                              ##
                                              ## ::cudaLaunchAttributeValue::accessPolicyWindow.
      cudaLaunchAttributeCooperative = 2, ## < Valid for graph nodes, launches. See
                                       ##                                                     ::cudaLaunchAttributeValue::cooperative.
      cudaLaunchAttributeSynchronizationPolicy = 3, ## < Valid for streams. See
                                                 ## ::cudaLaunchAttributeValue::syncPolicy.
      cudaLaunchAttributeClusterDimension = 4, ## < Valid for graph nodes, launches. See
                                            ##
                                            ## ::cudaLaunchAttributeValue::clusterDim.
      cudaLaunchAttributeClusterSchedulingPolicyPreference = 5, ## < Valid for graph nodes, launches. See
                                                             ##
                                                             ## ::cudaLaunchAttributeValue::clusterSchedulingPolicyPreference.
      cudaLaunchAttributeProgrammaticStreamSerialization = 6, ## < Valid for launches. Setting
                                                           ##
                                                           ## ::cudaLaunchAttributeValue::programmaticStreamSerializationAllowed
                                                           ##                                                                   to non-0 signals that the kernel will use programmatic
                                                           ##                                                                   means to resolve its stream dependency, so that the
                                                           ##                                                                   CUDA runtime should opportunistically allow the grid's
                                                           ##                                                                   execution to overlap with the previous kernel in the
                                                           ##                                                                   stream, if that kernel requests the overlap. The
                                                           ##                                                                   dependent launches can choose to wait on the
                                                           ##                                                                   dependency using the programmatic sync
                                                           ##
                                                           ## (cudaGridDependencySynchronize() or equivalent PTX
                                                           ##                                                                   instructions).
      cudaLaunchAttributeProgrammaticEvent = 7, ## < Valid for launches. Set
                                             ##
                                             ## ::cudaLaunchAttributeValue::programmaticEvent to
                                             ##                                                                   record the event. Event recorded through this launch
                                             ##                                                                   attribute is guaranteed to only trigger after all
                                             ##                                                                   block in the associated kernel trigger the event.  A
                                             ##                                                                   block can trigger the event programmatically in a
                                             ##                                                                   future CUDA release. A trigger can also be inserted at
                                             ##                                                                   the beginning of each block's execution if
                                             ##                                                                   triggerAtBlockStart is set to non-0. The dependent
                                             ##                                                                   launches can choose to wait on the dependency using
                                             ##                                                                   the programmatic sync (cudaGridDependencySynchronize()
                                             ##                                                                   or equivalent PTX instructions). Note that dependents
                                             ##                                                                   (including the CPU thread calling
                                             ##                                                                   cudaEventSynchronize()) are not guaranteed to observe
                                             ##                                                                   the release precisely when it is released. For
                                             ##                                                                   example, cudaEventSynchronize() may only observe the
                                             ##                                                                   event trigger long after the associated kernel has
                                             ##                                                                   completed. This recording type is primarily meant for
                                             ##                                                                   establishing programmatic dependency between device
                                             ##                                                                   tasks. Note also this type of dependency allows, but
                                             ##                                                                   does not guarantee, concurrent execution of tasks.
                                             ##                                                                   <br>
                                             ##                                                                   The event supplied must not be an interprocess or
                                             ##                                                                   interop event. The event must disable timing (i.e.
                                             ##                                                                   must be created with the ::cudaEventDisableTiming flag
                                             ##                                                                   set).
      cudaLaunchAttributePriority = 8, ## < Valid for streams, graph nodes, launches. See
                                    ##                                                     ::cudaLaunchAttributeValue::priority.
      cudaLaunchAttributeMemSyncDomainMap = 9, ## < Valid for streams, graph nodes, launches. See
                                            ##
                                            ## ::cudaLaunchAttributeValue::memSyncDomainMap.
      cudaLaunchAttributeMemSyncDomain = 10, ## < Valid for streams, graph nodes, launches. See
                                          ##
                                          ## ::cudaLaunchAttributeValue::memSyncDomain.
      cudaLaunchAttributeLaunchCompletionEvent = 12, ## < Valid for launches. Set
                                                  ##
                                                  ## ::cudaLaunchAttributeValue::launchCompletionEvent to record the
                                                  ##                                                        event.
                                                  ##                                                        <br>
                                                  ##                                                        Nominally, the event is triggered once all blocks of the kernel
                                                  ##                                                        have begun execution. Currently this is a best effort. If a kernel
                                                  ##                                                        B has a launch completion dependency on a kernel A, B may wait
                                                  ##                                                        until A is complete. Alternatively, blocks of B may begin before
                                                  ##                                                        all blocks of A have begun, for example if B can claim execution
                                                  ##                                                        resources unavailable to A (e.g. they run on different GPUs) or
                                                  ##                                                        if B is a higher priority than A.
                                                  ##                                                        Exercise caution if such an ordering inversion could lead
                                                  ##                                                        to deadlock.
                                                  ##                                                        <br>
                                                  ##                                                        A launch completion event is nominally similar to a programmatic
                                                  ##                                                        event with \c triggerAtBlockStart set except that it is not
                                                  ##                                                        visible to \c
                                                  ## cudaGridDependencySynchronize() and can be used with
                                                  ##                                                        compute capability less than 9.0.
                                                  ##                                                        <br>
                                                  ##                                                        The event supplied must not be an interprocess or interop event.
                                                  ##                                                        The event must disable timing (i.e. must be created with the
                                                  ##                                                        ::cudaEventDisableTiming flag set).
      cudaLaunchAttributeDeviceUpdatableKernelNode = 13, ## < Valid for graph nodes, launches. This attribute is graphs-only,
                                                      ##                                                            and passing it to a launch in a non-capturing stream will resultNotKeyWord
                                                      ##                                                            in an error.
                                                      ##                                                            <br>
                                                      ##
                                                      ## :cudaLaunchAttributeValue::deviceUpdatableKernelNode::deviceUpdatable can
                                                      ##                                                            only be set to 0 or 1. Setting the field to 1 indicates that the
                                                      ##                                                            corresponding kernel node should be device-updatable. On success, a handle
                                                      ##                                                            will be returned via
                                                      ##
                                                      ## ::cudaLaunchAttributeValue::deviceUpdatableKernelNode::devNode which can be
                                                      ##                                                            passed to the various device-side update functions to update the node's
                                                      ##                                                            kernel parameters from within another kernel. For more information on the
                                                      ##                                                            types of device updates that can be made, as well as the relevant limitations
                                                      ##                                                            thereof, see
                                                      ## ::cudaGraphKernelNodeUpdatesApply.
                                                      ##                                                            <br>
                                                      ##                                                            Nodes which are device-updatable have additional restrictions compared to
                                                      ##                                                            regular kernel nodes. Firstly, device-updatable nodes cannot be removed
                                                      ##                                                            from their graph via ::cudaGraphDestroyNode. Additionally, once opted-in
                                                      ##                                                            to this functionality, a node cannot opt out, and any attempt to set the
                                                      ##                                                            deviceUpdatable attribute to 0 will resultNotKeyWord in an error. Device-updatable
                                                      ##                                                            kernel nodes also cannot have their attributes copied to/from another kernel
                                                      ##                                                            node via
                                                      ## ::cudaGraphKernelNodeCopyAttributes. Graphs containing one or more
                                                      ##                                                            device-updatable nodes also do not allow multiple instantiation, and neither
                                                      ##                                                            the graph nor its instantiated version can be passed to ::cudaGraphExecUpdate.
                                                      ##                                                            <br>
                                                      ##                                                            If a graph contains device-updatable nodes and updates those nodes from the device
                                                      ##                                                            from within the graph, the graph must be uploaded with ::cuGraphUpload before it
                                                      ##                                                            is launched. For such a graph, if host-side executable graph updates are made to the
                                                      ##                                                            device-updatable nodes, the graph must be uploaded before it is launched again.
      cudaLaunchAttributePreferredSharedMemoryCarveout = 14 ## < Valid for launches. On devices where the L1 cache and shared memory use the
                                                         ##                                                                same hardware resources, setting
                                                         ## ::cudaLaunchAttributeValue::sharedMemCarveout
                                                         ##                                                                to a percentage between 0-100 signals sets the shared memory carveout
                                                         ##                                                                preference in percent of the total shared memory for that kernel launch.
                                                         ##                                                                This attribute takes precedence over
                                                         ## ::cudaFuncAttributePreferredSharedMemoryCarveout.
                                                         ##                                                                This is only a hint, and the driver can choose a different configuration if
                                                         ##                                                                required for the launch.
  ##
  ##  Launch attributes union; used as value field of ::cudaLaunchAttribute
  ##
  type
    INNER_C_STRUCT_driver_types_34* {.bycopy.} = object
      x*: cuint
      y*: cuint
      z*: cuint

  type
    INNER_C_STRUCT_driver_types_35* {.bycopy.} = object
      event*: cudaEvent_t
      ## < Event to fire when all blocks trigger it
      flags*: cint
      ## < Event record flags, see ::cudaEventRecordWithFlags. Does not accept
      ##                                     ::cudaEventRecordExternal.
      triggerAtBlockStart*: cint
      ## < If this is set to non-0, each block launch will automatically trigger the event

  type
    INNER_C_STRUCT_driver_types_36* {.bycopy.} = object
      event*: cudaEvent_t
      ## < Event to fire when the last block launches
      flags*: cint
      ## < Event record flags, see ::cudaEventRecordWithFlags. Does not accept
      ##                         ::cudaEventRecordExternal.

  type
    INNER_C_STRUCT_driver_types_37* {.bycopy.} = object
      deviceUpdatable*: cint
      ## < Whether or not the resulting kernel node should be device-updatable.
      devNode*: cudaGraphDeviceNode_t
      ## < Returns a handle to pass to the various device-side update functions.

  type
    cudaLaunchAttributeValue* {.bycopy, union.} = object
      pad*: array[64, char]
      ##  Pad to 64 bytes
      accessPolicyWindow*: cudaAccessPolicyWindow
      ## < Value of launch attribute ::cudaLaunchAttributeAccessPolicyWindow.
      cooperative*: cint
      ## < Value of launch attribute ::cudaLaunchAttributeCooperative. Nonzero indicates a cooperative
      ##                         kernel (see ::cudaLaunchCooperativeKernel).
      syncPolicy*: cudaSynchronizationPolicy
      ## < Value of launch attribute
      ##                                                   ::cudaLaunchAttributeSynchronizationPolicy. ::cudaSynchronizationPolicy
      ##                                                   for work queued up in this stream.
      ##
      ##  Value of launch attribute ::cudaLaunchAttributeClusterDimension that
      ##  represents the desired cluster dimensions for the kernel. Opaque type
      ##  with the following fields:
      ##      - \p x - The X dimension of the cluster, in blocks. Must be a divisor
      ##               of the grid X dimension.
      ##      - \p y - The Y dimension of the cluster, in blocks. Must be a divisor
      ##               of the grid Y dimension.
      ##      - \p z - The Z dimension of the cluster, in blocks. Must be a divisor
      ##               of the grid Z dimension.
      ##
      clusterDim*: INNER_C_STRUCT_driver_types_34
      clusterSchedulingPolicyPreference*: cudaClusterSchedulingPolicy
      ## < Value of launch attribute
      ##                                                                            ::cudaLaunchAttributeClusterSchedulingPolicyPreference. Cluster
      ##                                                                            scheduling policy preference for the kernel.
      programmaticStreamSerializationAllowed*: cint
      ## < Value of launch attribute
      ##                                                    ::cudaLaunchAttributeProgrammaticStreamSerialization.
      programmaticEvent*: INNER_C_STRUCT_driver_types_35
      ## < Value of launch attribute ::cudaLaunchAttributeProgrammaticEvent.
      priority*: cint
      ## < Value of launch attribute ::cudaLaunchAttributePriority. Execution priority of the kernel.
      memSyncDomainMap*: cudaLaunchMemSyncDomainMap
      ## < Value of launch attribute
      ##                                                     ::cudaLaunchAttributeMemSyncDomainMap. See
      ##                                                     ::cudaLaunchMemSyncDomainMap.
      memSyncDomain*: cudaLaunchMemSyncDomain
      ## < Value of launch attribute ::cudaLaunchAttributeMemSyncDomain. See
      ##                                                     ::cudaLaunchMemSyncDomain.
      launchCompletionEvent*: INNER_C_STRUCT_driver_types_36
      ## < Value of launch attribute ::cudaLaunchAttributeLaunchCompletionEvent.
      deviceUpdatableKernelNode*: INNER_C_STRUCT_driver_types_37
      ## < Value of launch attribute ::cudaLaunchAttributeDeviceUpdatableKernelNode.
      sharedMemCarveout*: cuint
      ## < Value of launch attribute ::cudaLaunchAttributePreferredSharedMemoryCarveout.

  ##
  ##  Launch attribute
  ##
  type
    cudaLaunchAttribute* {.bycopy.} = object
      id*: cudaLaunchAttributeID
      ## < Attribute to set
      pad*: array[8 - sizeof((cudaLaunchAttributeID)), char]
      val*: cudaLaunchAttributeValue
      ## < Value of the attribute

  ##
  ##  CUDA extensible launch configuration
  ##
  type
    cudaLaunchConfig_t* {.bycopy.} = object
      gridDim*: dim3
      ## < Grid dimensions
      blockDim*: dim3
      ## < Block dimensions
      dynamicSmemBytes*: csize_t
      ## < Dynamic shared-memory size per thread block in bytes
      stream*: cudaStream_t
      ## < Stream identifier
      attrs*: ptr cudaLaunchAttribute
      ## < List of attributes; nullable if ::cudaLaunchConfig_t::numAttrs == 0
      numAttrs*: cuint
      ## < Number of attributes populated in ::cudaLaunchConfig_t::attrs

  ##  #define cudaStreamAttrID cudaLaunchAttributeID
  type
    cudaStreamAttrID* = cudaLaunchAttributeID
  const
    cudaStreamAttributeAccessPolicyWindow* = cudaLaunchAttributeAccessPolicyWindow
    cudaStreamAttributeSynchronizationPolicy* = cudaLaunchAttributeSynchronizationPolicy
    cudaStreamAttributeMemSyncDomainMap* = cudaLaunchAttributeMemSyncDomainMap
    cudaStreamAttributeMemSyncDomain* = cudaLaunchAttributeMemSyncDomain
    cudaStreamAttributePriority* = cudaLaunchAttributePriority
  type
    cudaStreamAttrValue* = cudaLaunchAttributeValue
    cudaKernelNodeAttrID* = cudaLaunchAttributeID
  const
    cudaKernelNodeAttributeAccessPolicyWindow* = cudaLaunchAttributeAccessPolicyWindow
    cudaKernelNodeAttributeCooperative* = cudaLaunchAttributeCooperative
    cudaKernelNodeAttributePriority* = cudaLaunchAttributePriority
    cudaKernelNodeAttributeClusterDimension* = cudaLaunchAttributeClusterDimension
    cudaKernelNodeAttributeClusterSchedulingPolicyPreference* = cudaLaunchAttributeClusterSchedulingPolicyPreference
    cudaKernelNodeAttributeMemSyncDomainMap* = cudaLaunchAttributeMemSyncDomainMap
    cudaKernelNodeAttributeMemSyncDomain* = cudaLaunchAttributeMemSyncDomain
    cudaKernelNodeAttributePreferredSharedMemoryCarveout* = cudaLaunchAttributePreferredSharedMemoryCarveout
    cudaKernelNodeAttributeDeviceUpdatableKernelNode* = cudaLaunchAttributeDeviceUpdatableKernelNode
  type
    cudaKernelNodeAttrValue* = cudaLaunchAttributeValue
  ##
  ##  CUDA device NUMA config
  ##
  type
    cudaDeviceNumaConfig* = enum
      cudaDeviceNumaConfigNone = 0, ## < The GPU is not a NUMA node
      cudaDeviceNumaConfigNumaNode ## < The GPU is a NUMA node, cudaDevAttrNumaId contains its NUMA ID
  type cudaAsyncCallbackEntry {.nodecl.} = object
  type
    cudaAsyncCallbackHandle_t* = ptr cudaAsyncCallbackEntry
  ##
  ##  Types of async notification that can occur
  ##
  type
    cudaAsyncNotificationType* = enum
      cudaAsyncNotificationTypeOverBudget = 0x1
  ##
  ##  Information describing an async notification event
  ##
  type
    INNER_C_STRUCT_driver_types_41* {.bycopy.} = object
      bytesOverBudget*: culonglong

  type
    INNER_C_UNION_driver_types_40* {.bycopy, union.} = object
      overBudget*: INNER_C_STRUCT_driver_types_41

  type
    cudaAsyncNotificationInfo_t* {.bycopy.} = object
      `type`*: cudaAsyncNotificationType
      info*: INNER_C_UNION_driver_types_40

    cudaAsyncCallback* = proc (a1: ptr cudaAsyncNotificationInfo_t; a2: pointer;
                            a3: cudaAsyncCallbackHandle_t)
  ##  @}
  ##  @}
  ##  END CUDART_TYPES
