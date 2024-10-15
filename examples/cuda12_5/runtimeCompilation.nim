
# this example is from https://docs.nvidia.com/cuda/nvrtc/index.html#basic-usage

import
  std / [strformat],
  ../../src/nimcuda/cuda12_5/[nvrtc, check, cuda]

const
  NumThreads = 128
  NumBlocks = 32

const Saxpy = cstring"""
extern "C" __global__
void saxpy(float a, float *x, float *y, float *out, size_t n)
{
   size_t tid = blockIdx.x * blockDim.x + threadIdx.x;
   if (tid < n) {
      out[tid] = a * x[tid] + y[tid];
   }
}
"""

proc main =
  # Create an instance of nvrtcProgram with the SAXPY code string.
  var prog: nvrtcProgram
  check nvrtcCreateProgram(addr(prog), Saxpy, "saxpy.cu", 0, nil, nil)

  # Compile the program with fmad disabled.
  # Note: Can specify GPU target architecture explicitly with '-arch' flag.
  const
    Options = [cstring "--fmad=false"]
    NumberOfOptions = cint Options.len
  let compileResult =  nvrtcCompileProgram(prog, NumberOfOptions,
                                           cast[cstringArray](addr Options[0]))

  block obtainLog: # Obtain compilation log from the program.
    var logSize: csize_t
    check nvrtcGetProgramLogSize(prog, addr logSize)

    var log = cstring newString(Natural logSize)

    check nvrtcGetProgramLog(prog, log)

    echo fmt"log = '{log}'" # usually empty if no issues found by the compiler

  check compileResult


  var ptx: cstring
  block obtainPtx: # Obtain PTX from the program.
    var ptxSize: csize_t
    check nvrtcGetPTXSize(prog, addr ptxSize)

    ptx = cstring newString(Natural ptxSize)
    check nvrtcGetPTX(prog, ptx)

    check nvrtcDestroyProgram(addr prog) # Destroy the program.

  block execution:
    # Load the generated PTX and get a handle to the SAXPY kernel.
    var
      cuDevice: CUdevice
      context: CUcontext
      module: CUmodule
      kernel: CUfunction

    check cuInit(0)
    check cuDeviceGet(addr cuDevice, 0)
    check cuCtxCreate(addr context, 0, cuDevice)
    check cuModuleLoadDataEx(addr module, ptx, 0, nil, nil)
    check cuModuleGetFunction(addr kernel, module, "saxpy")

    let
      n = csize_t(NumThreads * NumBlocks)
      bufferSize = n * csize_t(sizeOf cfloat)
    let a = cfloat 5.1
    var
      hX = newSeqUninit[cfloat](n)
      hY = newSeqUninit[cfloat](n)
      hOut = newSeqUninit[cfloat](n)
    for i in 0 ..< n: # Initialize host data (fill hX and hY with ur data)
      hX[i] = cfloat(i)
      hY[i] = cfloat(i * 2)

    var
      dX: CUdeviceptr
      dY: CUdeviceptr
      dOut: CUdeviceptr
    check cuMemAlloc(addr dX, bufferSize)
    check cuMemAlloc(addr dY, bufferSize)
    check cuMemAlloc(addr dOut, bufferSize)

    check cuMemcpyHtoD(dX, addr hX[0], bufferSize)
    check cuMemcpyHtoD(dY, addr hY[0], bufferSize)

    # Execute SAXPY.
    let args: array[5, pointer] = [pointer(addr a), addr dX, addr dY,
      addr dOut, addr n]
    check cuLaunchKernel(kernel,
                         NumBlocks, 1, 1,  # grid dim
                         NumThreads, 1, 1, # block dim
                         0, nil,           # shared mem and stream
                         addr args[0],      # arguments,
                         nil)

    check cuCtxSynchronize()
    check cuMemcpyDtoH(addr hOut[0], dOut, bufferSize)

    for i in 0 ..< n:
      echo fmt"{a} * {hX[i]} + {hY[i]} = {hOut[i]}"

    check cuMemFree(dX)
    check cuMemFree(dY)
    check cuMemFree(dOut)

    check cuModuleUnload module
    check cuCtxDestroy context


main()
