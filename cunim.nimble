# Package

version       = "0.1.0"
author        = "Andrea Ferretti"
description   = "Nim binding for CUDA"
license       = "Apache2"
skipDirs      = @["headers", "include", "c2nim"]

# Dependencies

requires "nim >= 0.16.0"

import ospaths, strutils

proc patch(libName: string): string =
  let
    simpleLibPath = "include" / libName
    libPath = "/usr/local/cuda/include" / libName
    patchPath = "c2nim" / libName
    outPath = "headers" / libName
    libContent =
      if fileExists(simpleLibPath): readFile(simpleLibPath)
      else: readFile(libPath) #.replace("#if defined(__cplusplus)", "#ifdef __cplusplus")
    patchContent = readFile(patchPath)
  writeFile(outPath, patchContent & libContent)
  return outPath

proc process(libName: string) =
  let
    headerName = libName.addFileExt("h")
    outPath = "cunim" / libName.addFileExt("nim")
    headerPath = patch(headerName)
  exec("c2nim " & headerPath & " -o:" & outPath)

proc compile(libName: string) =
  let libPath = "cunim" / libName.addFileExt("nim")
  exec("nim c -c " & libPath)

let libs = [
  "library_types",
  "vector_types",
  # "driver_types", # do not decomment - the nim file is manually adjusted
  "surface_types",
  "texture_types",
  "cuda_runtime_api",
  "cuComplex",
  "cublas_api",
  "cublas_v2",
  # "cublas",
  # "cudnn",
  "cufft",
  # "curand",
  "cusolver_common",
  "cusolverDn",
  "cusolverRf",
  "cusolverSp",
  "cusparse",
  "nvblas",
  "nvgraph"
]

proc processAll() =
  exec("mkdir -p cunim")
  exec("mkdir -p headers")
  for lib in libs:
    process(lib)
  exec("rm headers/*")

proc compileAll() =
  for lib in libs:
    compile(lib)

task headers, "generate bindings from headers":
  processAll()

task check, "check that generated bindings do compile":
  compileAll()