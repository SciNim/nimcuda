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
import nimcuda/[cuda_runtime_api, cusparse, driver_types, nimcuda]

proc first[T](a: var openarray[T]): ptr T {.inline.} = addr(a[0])

proc main() =
  let
    n = 4.cint
    nnz = 9.cint
  var
    rows = [0.cint, 0, 0, 1, 2, 2, 2, 3, 3]
    cols = [0.cint, 2, 3, 1, 0, 2, 3, 1, 3]
    vals = [1'f32, 2, 3, 4, 5, 6, 7, 8, 9]
    csrRows = [0.cint, 0, 0, 0]

    handle: cusparseHandle_t
    gpuRows: ptr cint
    gpuCols: ptr cint
    gpuVals: ptr cfloat
    gpuCsrRows: ptr cint

  check cudaMalloc(cast[ptr pointer](addr gpuRows), sizeof(rows).csize_t)
  check cudaMalloc(cast[ptr pointer](addr gpuCols), sizeof(cols).csize_t)
  check cudaMalloc(cast[ptr pointer](addr gpuVals), sizeof(vals).csize_t)
  check cudaMalloc(cast[ptr pointer](addr gpuCsrRows), sizeof(csrRows).csize_t)

  check cudaMemcpy(gpuRows, rows.first, sizeof(rows).csize_t, cudaMemcpyHostToDevice)
  check cudaMemcpy(gpuCols, cols.first, sizeof(cols).csize_t, cudaMemcpyHostToDevice)
  check cudaMemcpy(gpuVals, vals.first, sizeof(vals).csize_t, cudaMemcpyHostToDevice)

  check cusparseCreate(addr handle)
  check cusparseXcoo2csr(handle, gpuRows, nnz, n, gpuCsrRows,CUSPARSE_INDEX_BASE_ZERO)

  check cudaMemcpy(csrRows.first, gpuCsrRows, sizeof(csrRows).csize_t, cudaMemcpyDeviceToHost)

  check cusparseDestroy(handle)
  check cudaFree(gpuRows)
  check cudaFree(gpuCols)
  check cudaFree(gpuVals)
  check cudaFree(gpuCsrRows)

  echo @csrRows

when isMainModule:
  main()
