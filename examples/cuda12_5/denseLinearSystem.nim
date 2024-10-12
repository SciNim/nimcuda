
import
  std / [strformat],
  ../../src/nimcuda/cuda12_5/[driver_types, cusolver_common,
    cusolverDn, cuda_runtime_api, check, cublas_api]

proc main() =
  var status: cusolverStatus_t
  var handle: cusolverDnHandle_t

  # Initialize cuSOLVER library
  status = cusolverDnCreate(addr handle)
  if status != CUSOLVER_STATUS_SUCCESS:
    echo "CUSOLVER initialization failed"
    return

  # Matrix dimensions
  const n = 3  # Number of equations and variables

  # Host matrix A and right-hand side vector b (column-major order)
  var h_A: array[0..(n*n)-1, cfloat] = [
    3.0, 1.0, 1.0,  # First column
    2.0, 2.0, 1.0,  # Second column
    1.0, 1.0, 1.0  # Third column
    ]

  var h_b: array[0..n-1, cfloat] = [10, 8, 6]  # Right-hand side vector

  # Device pointers
  var d_A, d_b: pointer
  var devIpiv: pointer  # Pivot array
  var devInfo: pointer  # Info output

  # Allocate device memory
  check cudaMalloc(addr d_A, culong(n*n*sizeof(cfloat)))
  check cudaMalloc(addr d_b, culong(n*sizeof(cfloat)))
  check cudaMalloc(addr devIpiv, culong(n*sizeof(cint)))
  check cudaMalloc(addr devInfo, culong(sizeof(cint)))

  # Copy host data to device
  check cudaMemcpy(d_A, addr h_A[0], culong(n*n*sizeof(cfloat)),
                   cudaMemcpyHostToDevice)
  check cudaMemcpy(d_b, addr h_b[0], culong(n*sizeof(cfloat)),
                   cudaMemcpyHostToDevice)

  # Get the buffer size for LU decomposition
  var lwork: cint
  check cusolverDnSgetrf_bufferSize(handle, n, n, cast[ptr cfloat](d_A), n,
                                    addr lwork)

  # Allocate workspace
  var d_Workspace: pointer
  check cudaMalloc(addr d_Workspace, culong(lwork*sizeof(cfloat)))

  # Perform LU decomposition
  check cusolverDnSgetrf(handle, n, n, cast[ptr cfloat](d_A), n,
    cast[ptr cfloat](d_Workspace), cast[ptr cint](devIpiv),
    cast[ptr cint](devInfo))

  # Check devInfo after getrf
  var h_info: cint
  check cudaMemcpy(addr h_info, devInfo, culong(sizeof(cint)),
                   cudaMemcpyDeviceToHost)
  if h_info != 0:
    echo "LU decomposition failed, info = ", h_info
    return

  # Solve the system A*x = b
  check cusolverDnSgetrs(handle, CUBLAS_OP_N, n, 1, cast[ptr cfloat](d_A), n,
    cast[ptr cint](devIpiv), cast[ptr cfloat](d_b), n, cast[ptr cint](devInfo))

  # Check devInfo after getrs
  check cudaMemcpy(addr h_info, devInfo, culong(sizeof(cint)),
                   cudaMemcpyDeviceToHost)
  if h_info != 0:
    echo "Solving the linear system failed, info = ", h_info
    return

  # Copy result back to host
  check cudaMemcpy(addr h_b[0], d_b, culong(n*sizeof(cfloat)),
                   cudaMemcpyDeviceToHost)

  # Display the result
  echo "Solution vector x:"
  for i in 0..<n:
    echo fmt" x[{i}] = {h_b[i]:^6.4f}"

  # Clean up resources
  check cudaFree(d_A)
  check cudaFree(d_b)
  check cudaFree(d_Workspace)
  check cudaFree(devIpiv)
  check cudaFree(devInfo)
  check cusolverDnDestroy(handle)

main()
