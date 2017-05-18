import nimcuda/[cufft, cuda_runtime_api, driver_types, vector_types]

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

proc first[T](a: var openarray[T]): ptr T {.inline.} = addr(a[0])

proc main() =
  const
    NX = 256
    NY = 128
    N = NX * NY
  let size = sizeof(cufftComplex) * N
  var
    plan: cufftHandle
    idata: ptr cufftComplex
    odata: ptr cufftComplex

  check cudaMalloc(cast[ptr pointer](addr idata), size)
  check cudaMalloc(cast[ptr pointer](addr odata), size)

  var
    input = newSeq[cufftComplex](N)
    output = newSeq[cufftComplex](N)

  for i in 0 ..< input.len:
    input[i].x = cfloat(i) / cfloat(N)
    input[i].y = cfloat(N - i) / cfloat(N)

  check cudaMemcpy(idata, input.first, size, cudaMemcpyHostToDevice)

  check cufftPlan2d(addr plan, NX, NY, CUFFT_C2C)
  check cufftExecC2C(plan, idata, odata, CUFFT_FORWARD)
  check cufftExecC2C(plan, odata, odata, CUFFT_INVERSE)

  check cudaMemcpy(output.first, odata, size, cudaMemcpyDeviceToHost)

  check cufftDestroy(plan)
  check cudaFree(idata)
  check cudaFree(odata)

  echo "original : ", input[0..10]
  echo "transform: ", output[0..10]

when isMainModule:
  main()