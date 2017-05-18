import nimcuda/[cuda_runtime_api, cusparse, driver_types]

type
  CudaError = object of IOError
  CusparseError = object of IOError

proc raiseCudaError(x: cudaError_t) {.noinline.} =
  raise newException(CudaError, $x & " " & $int(x))

proc raiseCusparseError(x: cusparseStatus_t) {.noinline.} =
  raise newException(CusparseError, $x & " " & $int(x))

template check(a: cudaError_t) =
  let y = a
  if y != cudaSuccess: raiseCudaError(y)

template check(a: cusparseStatus_t) =
  let y = a
  if y != CUSPARSE_STATUS_SUCCESS: raiseCusparseError(y)

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

  check cudaMalloc(cast[ptr pointer](addr gpuRows), sizeof(rows))
  check cudaMalloc(cast[ptr pointer](addr gpuCols), sizeof(cols))
  check cudaMalloc(cast[ptr pointer](addr gpuVals), sizeof(vals))
  check cudaMalloc(cast[ptr pointer](addr gpuCsrRows), sizeof(csrRows))

  check cudaMemcpy(gpuRows, rows.first, sizeof(rows), cudaMemcpyHostToDevice)
  check cudaMemcpy(gpuCols, cols.first, sizeof(cols), cudaMemcpyHostToDevice)
  check cudaMemcpy(gpuVals, vals.first, sizeof(vals), cudaMemcpyHostToDevice)

  check cusparseCreate(addr handle)
  check cusparseXcoo2csr(handle, gpuRows, nnz, n, gpuCsrRows,CUSPARSE_INDEX_BASE_ZERO)

  check cudaMemcpy(csrRows.first, gpuCsrRows, sizeof(csrRows), cudaMemcpyDeviceToHost)

  check cusparseDestroy(handle) 
  check cudaFree(gpuRows)
  check cudaFree(gpuCols)
  check cudaFree(gpuVals)
  check cudaFree(gpuCsrRows)

  echo @csrRows

when isMainModule:
  main()