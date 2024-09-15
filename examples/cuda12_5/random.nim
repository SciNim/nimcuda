# Copyright 2017 UniCredit S.p.A.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
import cuda_runtime_api, curand, check, driver_types

proc first[T](a: var openarray[T]): ptr T {.inline.} = addr(a[0])

proc main() =
  const n = 30
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

  echo "Random numbers genedated on device: ", @host

  # curand can be used to generate random numbers directly on host
  var
    hostGen: curandGenerator_t

  check curandCreateGeneratorHost(addr hostGen, CURAND_RNG_PSEUDO_DEFAULT)
  check curandGenerateNormal(hostGen, host.first, n, mean = 0, stddev = 1)
  check curandDestroyGenerator(hostGen)

  echo "Random numbers genedated on host: ", @host

when isMainModule:
  main()
