import cunim/cufft, cunim/cuda_runtime_api, cunim/driver_types, cunim/vector_types

type
  CArray{.unchecked.}[T] = array[1, T]
  CPointer[T] = ptr CArray[T]

proc first[T](p: CPointer[T]): ptr T {.inline.} = addr(p[0])

type
  CudaError = object of IOError
  CufftError = object of IOError

proc raiseCudaError(x: cudaError_t) {.noinline.} =
  raise newException(CudaError, $x & " " & $int(x))

proc raiseCufftError(x: cufftResult) {.noinline.} =
  raise newException(CufftError, $x & " " & $int(x))

template check(a: cudaError_t) =
  let y = a
  if y != cudaSuccess: raiseCudaError(y)

template check(a: cufftResult) =
  let y = a
  if y != CUFFT_SUCCESS: raiseCufftError(y)

proc main() =
  const
    NX = 256
    NY = 128
    N = NX * NY
  var
    plan: cufftHandle
    idata: CPointer[cufftComplex]
    odata: CPointer[cufftComplex]

  check cudaMalloc(cast[ptr pointer](addr idata), sizeof(cufftComplex) * N)
  check cudaMalloc(cast[ptr pointer](addr odata), sizeof(cufftComplex) * N)

  for i in 0 ..< N:
    idata[i].x = cfloat(i) / cfloat(N)
    idata[i].y = cfloat(N - i) / cfloat(N)

  check cufftPlan2d(addr plan, NX, NY, CUFFT_C2C)
  check cufftExecC2C(plan, idata.first, odata.first, CUFFT_FORWARD)
  check cufftExecC2C(plan, odata.first, odata.first, CUFFT_INVERSE)

  echo "FFT: "

  check cufftDestroy(plan)
  check cudaFree(idata)
  check cudaFree(odata)


when isMainModule:
  main()