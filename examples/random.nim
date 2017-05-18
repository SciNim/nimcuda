import nimcuda/[cuda_runtime_api, curand, nimcuda, driver_types]

proc first[T](a: var openarray[T]): ptr T {.inline.} = addr(a[0])

proc main() =
  const n = 100
  var
    host: array[n, cfloat]
    device: ptr cfloat
    gen: curandGenerator_t

  check cudaMalloc(cast[ptr pointer](addr device), n * sizeof(cfloat))
  check curandCreateGenerator(addr gen, CURAND_RNG_PSEUDO_DEFAULT)
  check curandSetPseudoRandomGeneratorSeed(gen, 1234.culonglong)
  check curandGenerateUniform(gen, device, n)
  check cudaMemcpy(host.first, device, n * sizeof(cfloat), cudaMemcpyDeviceToHost)
  check curandDestroyGenerator(gen)
  check cudaFree(device)

  echo @host

when isMainModule:
  main()