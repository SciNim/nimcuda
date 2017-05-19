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
import nimcuda/[cufft, cuda_runtime_api, driver_types, vector_types, nimcuda]

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