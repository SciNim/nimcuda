# Link against the cuBLAS and CUDA runtime libraries

import
  std / [strformat],
  ../../src/nimcuda/cuda12_5/[cuda_runtime_api, cublas_api,
                               driver_types, check]



proc main() =
  var handle: cublasHandle_t

  # Initialize cuBLAS library
  check cublasCreate_v2(addr handle)

  # Matrix dimensions
  const m = 2  # Rows of A and C
  const n = 2  # Columns of B and C
  const k = 2  # Columns of A and rows of B

  # Host matrices (column-major order)
  var h_A: array[0..(m*k)-1, cfloat] = [1.0, 2.0,
                                        3.0, 4.0]

  var h_B: array[0..(k*n)-1, cfloat] = [5.0, 6.0,
                                        7.0, 8.0]

  var h_C: array[0..(m*n)-1, cfloat] = [0.0, 0.0,
                                        0.0, 0.0]

  # Device pointers
  var d_A, d_B, d_C: pointer

  # Allocate device memory
  check cudaMalloc(addr d_A, culong(m*k*sizeof(cfloat)))
  check cudaMalloc(addr d_B, culong(k*n*sizeof(cfloat)))
  check cudaMalloc(addr d_C, culong(m*n*sizeof(cfloat)))

  # Copy host data to device
  check cudaMemcpy(d_A, addr h_A[0], culong(m*k*sizeof(cfloat)),
    cudaMemcpyHostToDevice)
  check cudaMemcpy(d_B, addr h_B[0], culong(k*n*sizeof(cfloat)),
    cudaMemcpyHostToDevice)

  # Scalars for the operation
  var alpha: cfloat = 1.0
  var beta: cfloat = 0.0

  # Perform matrix multiplication: C = alpha * A * B + beta * C
  check cublasSgemm_v2(handle, CUBLAS_OP_N #[No transpose for A]#,
    CUBLAS_OP_N #[No transpose for B]#, m, n, k, addr alpha,
    cast[ptr cfloat](d_A), m, cast[ptr cfloat](d_B), k, addr beta,
    cast[ptr cfloat](d_C), m)

  # Copy result back to host
  check cudaMemcpy(addr h_C[0], d_C, culong(m*n*sizeof(cfloat)),
    cudaMemcpyDeviceToHost)

  # Display the result
  echo "Result matrix C:"
  for i in 0..<m:
    var rowStr = ""
    for j in 0..<n:
      rowStr.add fmt"{h_C[i + j*m]:^6.1f} "
    echo rowStr

  # Clean up resources
  check cudaFree(d_A)
  check cudaFree(d_B)
  check cudaFree(d_C)
  check cublasDestroy_v2(handle)

main()

