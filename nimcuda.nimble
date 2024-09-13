# Package

version       = "0.1.9"
author        = "Andrea Ferretti"
description   = "Nim binding for CUDA"
license       = "Apache2"
skipDirs      = @["headers", "include", "c2nim", "examples", "htmldocs"]

# Dependencies

requires "nim >= 0.16.0"

import os

proc fExists(f: string): bool =
  when (NimMajor, NimMinor) < (1, 4):
    result = os.fileExists(f)
  else:
    result = fileExists(f)

func makeExe(name: string): string =
  when defined(windows):
    result = name.addFileExt("exe")
  else:
    result = name



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

  writeFile(outPath, patchContent & "\n" & libContent)
  return outPath


proc preprocess(libName: string) =
  const preprocessorExe = "utils" / "preprocessor".makeExe

  if not fExists(preprocessorExe):
    # Compile preprocessor.
    const preprocessorSource = "utils" / "preprocessor".addFileExt("nim")
    exec "nim c -d:release " & preprocessorSource

  let libPath = "headers" / libName.addFileExt("h")

  exec preprocessorExe & " " & libPath


proc postprocess(libName: string) =
  const postprocessorExe = "utils" / "postprocessor".makeExe

  if not fExists(postprocessorExe):
    # Compile postprocessor.
    const postprocessorSource = "utils" / "postprocessor".addFileExt("nim")
    exec "nim c -d:release " & postprocessorSource

  let libPath = "nimcuda" / libName.addFileExt("nim")

  exec postprocessorExe & " " & libPath

proc process(libName: string) =
  let
    headerName = libName.addFileExt("h")
    outPath = "nimcuda" / libName.addFileExt("nim")
    headerPath = patch(headerName)
  preprocess libName
  exec("c2nim --debug --strict --prefix\"_\" --prefix\"__\" --suffix\"_\" --suffix\"__\" " & headerPath & " -o:" & outPath)
  postprocess libname

proc compile(libName: string) =
  let libPath = "nimcuda" / libName.addFileExt("nim")
  exec("nim c -c " & libPath)

let libs = [
  # "library_types",
  "vector_types",
  "driver_types", # do not decomment - the nim file is manually adjusted
  "surface_types",
  "texture_types",
  "cuda_runtime_api",
  # "cuda_occupancy", # do not decomment - the nim file is manually adjusted
  "cuComplex",
  "cublas_api",
  # "cublas_v2",
  # "cudnn_v9",
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
  # --run

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
