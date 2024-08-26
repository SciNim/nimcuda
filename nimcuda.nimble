# Package

version       = "0.1.9"
author        = "Andrea Ferretti"
description   = "Nim binding for CUDA"
license       = "Apache2"
skipDirs      = @["headers", "include", "c2nim", "examples", "htmldocs"]

# Dependencies

requires "nim >= 0.16.0"

import os, strutils, pegs

proc fExists(f: string): bool =
  when (NimMajor, NimMinor) < (1, 4):
    result = os.fileExists(f)
  else:
    result = fileExists(f)

func renameUint64(code: string): string =
  ## C2nim has trouble with the `unsigned long long int` type.
  ## This func replaces it with something that it can handle.
  result = code.replace(peg"'unsigned long long' ' int'?", "culonglong")

func renameInt64(code: string): string =
  ## C2nim has trouble with the `unsigned long long int` type.
  ## This func replaces it with something that it can handle.
  result = code.replace("int64_t", "clonglong")

func renameCuchar(code: string): string =
  ## `cuchar` is depreciated.
  ## This func replaces it.
  result = code.replace("cuchar", "uint8")

func rearrangeConstPtrTypeDefs(code: string): string =
  ## C2nim has trouble with the a certain arrangement of `const*` typedefs.
  ## This func replaces it with something that it can handle.
  result = code.replacef(peg"'typedef struct ' {\ident} ' const* ' {\ident}[;]",
                         "typedef const struct $1* $2;")


proc patch(libName: string): string =
  when defined(windows):
    let libpath = getEnv("CUDA_PATH") / "include" / libName
  else:
    let libpath = if libName == "cudnn_v9.h": "/usr/include/x86_64-linux-gnu" / libName
                  else: "/usr/local/cuda/include" / libName

  let
    simpleLibPath = "include" / libName
    patchPath = "c2nim" / libName
    outPath = "headers" / libName
    libContent =
      if fExists(simpleLibPath): readFile(simpleLibPath)
      else: readFile(libPath) #.replace("#if defined(__cplusplus)", "#ifdef __cplusplus")
    patchContent = readFile(patchPath)
    unmodified = patchContent & libContent
    modified = unmodified.renameUint64.renameInt64.renameCuchar.rearrangeConstPtrTypeDefs()
  # typedef struct cusparseSpVecDescr const* cusparseConstSpVecDescr_t; c2nim doesnt understand
  # typedef const struct cusparseSpVecDescr* cusparseConstSpVecDescr_t; c2nim does understand


  writeFile(outPath, modified)
  return outPath

proc process(libName: string) =
  let
    headerName = libName.addFileExt("h")
    outPath = "nimcuda" / libName.addFileExt("nim")
    headerPath = patch(headerName)
  exec("c2nim --debug --strict --prefix\"_\" --prefix\"__\" --suffix\"_\" --suffix\"__\" " & headerPath & " -o:" & outPath)

proc compile(libName: string) =
  let libPath = "nimcuda" / libName.addFileExt("nim")
  exec("nim c -c " & libPath)

let libs = [
  "library_types",
  "vector_types",
  # "driver_types", # do not decomment - the nim file is manually adjusted
  "surface_types",
  "texture_types",
  "cuda_runtime_api",
  # "cuda_occupancy", # do not decomment - the nim file is manually adjusted
  "cuComplex",
  "cublas_api",
  "cublas_v2",
  "cudnn_v9",
  "cufft",
  "curand",
  "cusolver_common",
  "cusolverDn",
  "cusolverRf",
  "cusolverSp",
  "cusparse",
  "nvblas"
  #"nvgraph" <- removed in cuda 11.0, adopted into cugraph
]

proc processAll() =
  exec("mkdir -p nimcuda")
  exec("mkdir -p headers")
  for lib in libs:
    process(lib)

  exec("rm headers/*")

proc compileAll() =
  compile("nimcuda")
  for lib in libs:
    compile(lib)

task headers, "generate bindings from headers":
  processAll()

task checkcheck, "check that generated bindings do compile":
  compileAll()

task docs, "generate documentation":
  exec("nim doc2 --project nimcuda/nimcuda.nim")

proc exampleConfig() =
  --hints: off
  --linedir: on
  --stacktrace: on
  --linetrace: on
  --debuginfo
  when defined(windows):
    switch("cincludes", getenv("CUDA_PATH") / "include")
    switch("clibdir", getenv("CUDA_PATH") / "lib/x64")
  else:
    --cincludes: "/usr/local/cuda/include"
    --cincludes: "/usr/include/x86_64-linux-gnu/"
    --clibdir: "/usr/local/cuda/lib64"
  --path: "."
  --run

task pagerank, "run pagerank example":
  exampleConfig()
  setCommand "c", "examples/pagerank.nim"

task fft, "run fft example":
  exampleConfig()
  setCommand "c", "examples/fft.nim"

task sparse, "run sparse example":
  exampleConfig()
  setCommand "c", "examples/sparse.nim"

task random, "run random example":
  exampleConfig()
  setCommand "c", "examples/random.nim"
