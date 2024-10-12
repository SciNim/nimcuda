 
# Link against the cuSOLVER, cuSPARSE, and CUDA runtime libraries
{.passL: "-lcusolver -lcusparse -lcudart".}

import
  std / [strformat],
  ../../src/nimcuda/cuda12_5/[cuda_runtime_api, driver_types, cusolverSp,
    check, cusparse]


proc main() =
  var handle: cusolverSpHandle_t
  var descrA: cusparseMatDescr_t

  # Initialize cuSOLVER Sparse library
  check cusolverSpCreate(addr handle)

  # Create matrix descriptor
  check cusparseCreateMatDescr(addr descrA)

  # Matrix dimensions and number of non-zero elements
  const m = 3    # Number of rows
  const n = 3    # Number of columns
  const nnz = 7  # Number of non-zero elements

  # Host representation of the sparse matrix A in CSR format
  # A = [ 10  0   0
  #        3  9   0
  #        0  7   8 ]

  # Row pointers
  var h_csrRowPtrA: array[0..m, cint] = [0, 1, 3, 7]

  # Column indices
  var h_csrColIndA: array[0..nnz-1, cint] = [0, 0, 1, 1, 2, 1, 2]

  # Non-zero values
  var h_csrValA: array[0..nnz-1, cfloat] = [10.0, 3.0, 9.0, 7.0, 8.0, 7.0, 8.0]

  # Right-hand side vector b
  var h_b: array[0..m-1, cfloat] = [10.0, 21.0, 38.0]

  # Solution vector x
  var h_x: array[0..m-1, cfloat] = [0.0, 0.0, 0.0]

  # Device pointers
  var d_csrRowPtrA, d_csrColIndA, d_csrValA, d_b, d_x: pointer

  # Allocate device memory
  check cudaMalloc(addr d_csrRowPtrA, culong((m+1)*sizeof(cint)))
  check cudaMalloc(addr d_csrColIndA, culong(nnz*sizeof(cint)))
  check cudaMalloc(addr d_csrValA, culong(nnz*sizeof(cfloat)))
  check cudaMalloc(addr d_b, culong(m*sizeof(cfloat)))
  check cudaMalloc(addr d_x, culong(n*sizeof(cfloat)))

  # Copy host data to device
  check cudaMemcpy(d_csrRowPtrA, addr h_csrRowPtrA[0],
                   culong((m+1)*sizeof(cint)), cudaMemcpyHostToDevice)
  check cudaMemcpy(d_csrColIndA, addr h_csrColIndA[0], culong(nnz*sizeof(cint)),
                   cudaMemcpyHostToDevice)
  check cudaMemcpy(d_csrValA, addr h_csrValA[0], culong(nnz*sizeof(cfloat)),
                   cudaMemcpyHostToDevice)
  check cudaMemcpy(d_b, addr h_b[0], culong(m*sizeof(cfloat)),
                   cudaMemcpyHostToDevice)

  # Tolerance for the solver and reorder parameter
  const tol: cfloat = 1e-6
  const reorder: cint = 0  # No reordering

  # Variable to hold the position of zero pivot (if any)
  var singularity: cint

  # Solve the sparse linear system A*x = b
  check cusolverSpScsrlsvQr(handle, m, nnz, descrA, cast[ptr cfloat](d_csrValA),
    cast[ptr cint](d_csrRowPtrA), cast[ptr cint](d_csrColIndA),
    cast[ptr cfloat](d_b), tol, reorder, cast[ptr cfloat](d_x),
    addr singularity)

  if singularity >= 0:
    echo "A is singular at row ", singularity
    return

  # Copy result back to host
  check cudaMemcpy(addr h_x[0], d_x, culong(n*sizeof(cfloat)),
                   cudaMemcpyDeviceToHost)

  # Display the result
  echo "Solution vector x:"
  for i in 0..<n:
    echo fmt" x[{i}] = {h_x[i]:^6.4f}"

  # Clean up resources
  check cudaFree(d_csrRowPtrA)
  check cudaFree(d_csrColIndA)
  check cudaFree(d_csrValA)
  check cudaFree(d_b)
  check cudaFree(d_x)
  check cusparseDestroyMatDescr(descrA)
  check cusolverSpDestroy(handle)

main()
