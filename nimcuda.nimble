# Package

version       = "0.2.0"
author        = "Andrea Ferretti"
description   = "Nim binding for CUDA"
license       = "Apache2"
skipDirs      = @["headers", "include", "c2nim", "examples", "htmldocs"]
srcDir        = "src"

# Dependencies

requires "nim >= 0.16.0"

import
  std / [strscans, strformat, os, enumutils, sequtils, strutils, pegs]

type CudaVersion = enum
  cuda8_0, cuda12_5

const DefaultVersion = cuda8_0

const
  ModifiedHeadersDir = "include"
  NimCodeDir = "src"
  UtilitiesDir = "utils"
  DocumentationDir = "htmldocs"
  ExamplesDir = "examples"
  C2nimDirectivesDir = "c2nim"
  TemporaryHeadersDir = "headers"

const Libs = [
  # "library_types",
  # "vector_types",
  # "driver_types", # do not decomment - the nim file is manually adjusted
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

func systemCudaName(v: CudaVersion): string =
  ## Returns the name used for cuda directories on linux.
  var captures: array[2, string]
  assert ($v).match(peg" 'cuda' {\d+} '_' {\d+} ", captures)
  fmt"cuda-{captures[0]}.{captures[1]}"

proc systemCudaInclude(version: CudaVersion): string =
  when hostOS == "windows":
    getEnv("CUDA_PATH") / "include"
  else:
    "/usr/local" / version.systemCudaName / "include"

proc systemCudaCLib(version: CudaVersion): string =
  when hostOS == "windows":
    getEnv("CUDA_PATH") / "lib" / "x64"
  else:
    "/usr/local" / version.systemCudaName / "lib64"


func nimcudaSourceDir(version: CudaVersion): string =
  const dirThatHoldsVersions = NimCodeDir / "nimcuda"
  result = dirThatHoldsVersions / $version

func nimcudaExamplesDir(version: CudaVersion): string =
  const dirThatHoldsVersions = ExamplesDir
  result = dirThatHoldsVersions / $version


proc patch(libFileName: string; version: CudaVersion): string =
  let installedLib = systemCudaInclude(version) / libFileName

  let
    simpleLibPath = ModifiedHeadersDir / $version / libFileName
    patchPath = C2nimDirectivesDir / $version / libFileName
    outPath = TemporaryHeadersDir / libFileName
    libContent =
      if simpleLibPath.fileExists: readFile(simpleLibPath)
      else: readFile(installedLib)
    patchContent = readFile(patchPath)

  writeFile(outPath, patchContent & "\n" & libContent)
  return outPath


proc preprocess(filePath: string) =
  const preprocessorExe = UtilitiesDir / "preprocessor".toExe

  if not preprocessorExe.fileExists:
    # Compile preprocessor.
    const preprocessorSource = preprocessorExe.changeFileExt("nim")
    exec "nim c -d:release " & preprocessorSource

  exec preprocessorExe & " " & filePath


proc postprocess(filePath: string) =
  const postprocessorExe = UtilitiesDir / "postprocessor".toExe

  if not postprocessorExe.fileExists:
    # Compile preprocessor.
    const postprocessorSource = postprocessorExe.changeFileExt("nim")
    exec "nim c -d:release " & postprocessorSource

  exec postprocessorExe & " " & filePath


proc process(libName: string; version: CudaVersion) =
  let
    headerFileName = libName.addFileExt("h")
    outPath = nimcudaSourceDir(version) / headerFileName.changeFileExt("nim")
    headerPath = patch(headerFileName, version)
  preprocess headerPath
  exec("c2nim --debug --strict --prefix\"_\" --prefix\"__\" --suffix\"_\" " &
       "--suffix\"__\" " & headerPath & " -o:" & outPath)
  postprocess outPath

proc compile(filePath: string) =
  exec("nim c -c " & filePath)

proc compile(libName: string; version: CudaVersion) =
  let libPath = nimcudaSourceDir(version) / libName.addFileExt("nim")
  compile libPath


proc processAll(version: CudaVersion) =
  mkDir TemporaryHeadersDir

  for lib in Libs:
    process(lib, version)

  let allTemporaryFiles = TemporaryHeadersDir.listFiles()
  for file in allTemporaryFiles:
    rmFile file



proc compileAll(version: CudaVersion) =
  if version == DefaultVersion:
    compile NimCodeDir / "nimcuda".addFileExt("nim")
  for nimSourceFile in nimcudaSourceDir(version).listFiles:
    exec "nim c -c " & nimSourceFile


func parseCudaVersion(input: string): CudaVersion =
  ## Parses the passed cuda version, returning `DefaultVersion` if no match
  ## is found.
  func normalizer(s: string): string =
    var captures: array[2, string]
    if s.match(peg" y'cuda'? {\d+} ('_' / '.' / '-') {\d+} $ ", captures):
      fmt"cuda{captures[0]}_{captures[1]}"
    else:
      s

  CudaVersion.genEnumCaseStmt(commandLineParams()[^1], DefaultVersion,
                              CudaVersion.low.ord, CudaVersion.high.ord,
                              normalizer)


template taskWithCudaVersionArgument(name: untyped; description: string;
                                     body: untyped): untyped =
  ## Creates a nimble task that takes one command line argument: a cuda version.
  ## This argument is accessible as the symbol `cudaVersion`.
  task name, description:
    const NameOfThisTask = `name Task`.astToStr[0..^5] #removing "Task"

    let
      noVersionArgPassed = cmdline.commandLineParams()[^1] == NameOfThisTask
      oneVersionArgPassed = cmdline.commandLineParams()[^2] == NameOfThisTask
      tooManyArgs = not (noVersionArgPassed or oneVersionArgPassed)

    if tooManyArgs:
      echo "Too many arguments! Please only pass the cuda version to this task."
      echo "Example: 'nimble $1 12.5'" % NameOfThisTask
    else:
      # parseCudaVersion defaults to `DefaultVersion`, so if the task is the
      # last param, it returns the default.
      let cudaVersion {.inject.} = cmdline.commandLineParams()[^1].
                                                            parseCudaVersion()
      body



taskWithCudaVersionArgument headers, "generate bindings from headers":
  processAll(cudaVersion)

taskWithCudaVersionArgument checkcheck,
                          "check that bindings compile":
  compileAll(cudaVersion)

task docs, "generate documentation":
  # remove possibly outdated files:
  if DocumentationDir.dirExists:
    rmDir DocumentationDir
    mkDir DocumentationDir

  for cudaVersion in CudaVersion:
    let outDir = DocumentationDir / $cudaVersion

    for nimSourceFile in nimcudaSourceDir(cudaVersion).listFiles:
      exec fmt"nim doc2 --index:on --outDir:{outDir} {nimSourceFile}"

    let indexFile = outDir / "theindex".addFileExt("html")
    exec fmt"nim buildIndex -o:{indexFile} {outDir}"


proc exampleConfig(version: CudaVersion) =
  --hints: off
  --linedir: on
  --stacktrace: on
  --linetrace: on
  --debuginfo
  when hostos == "windows":
    switch("cincludes", systemCudaInclude(version))
    switch("clibdir", systemCudaCLib(version))
  else:
    switch("cincludes", systemCudaInclude(version))
    switch("cincludes", "/usr/include/x86_64-linux-gnu/")
    switch("clibdir", systemCudaCLib(version))
  switch("path", thisDir() / nimcudaSourceDir(version))
  --run

taskWithCudaVersionArgument fft, "run fft example":
  exampleConfig(cudaVersion)
  setCommand "c", nimcudaExamplesDir(cudaVersion) / "fft".addFileExt("nim")

taskWithCudaVersionArgument sparse, "run sparse example":
  exampleConfig(cudaVersion)
  setCommand "c", nimcudaExamplesDir(cudaVersion) / "sparse".addFileExt("nim")

taskWithCudaVersionArgument random, "run random example":
  exampleConfig(cudaVersion)
  setCommand "c", nimcudaExamplesDir(cudaVersion) / "random".addFileExt("nim")

task pagerank, "run pagerank example":
  # removed in cuda 11.0
  exampleConfig(cuda8_0)
  setCommand "c", nimcudaExamplesDir(cuda8_0) / "pagerank".addFileExt("nim")

task blas, "run cublas example":
  # TODO: implement and test for 8.0
  exampleConfig(cuda12_5)
  setCommand "c", nimcudaExamplesDir(cuda12_5) / "blas".addFileExt("nim")


task denseLinearSystem, "run cusolverDn example":
  # TODO: implement and test for 8.0
  exampleConfig(cuda12_5)
  setCommand "c", nimcudaExamplesDir(cuda12_5) / "denseLinearSystem".addFileExt("nim")
