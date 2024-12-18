# Package

version       = "0.2.2"
author        = "Andrea Ferretti"
description   = "Nim binding for CUDA"
license       = "Apache2"
skipDirs      = @["headers", "include", "c2nim", "examples", "htmldocs"]
srcDir        = "src"

# Dependencies

requires "nim >= 1.4.0"

import
  std / [strscans, strformat, os, sequtils, strutils, pegs]

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
  "nvblas",
  #"nvgraph" <- removed in cuda 11.0, adopted into cugraph
  "nvrtc",
  "cuda",
]

proc systemCudaName(v: CudaVersion): string =
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
  # proc normalizer(s: string): string =
  #   var captures: array[2, string]
  #   if s.match(peg" y'cuda'? {\d+} ('_' / '.' / '-') {\d+} $ ", captures):
  #     fmt"cuda{captures[0]}_{captures[1]}"
  #   else:
  #     s
  var index = 0
  var
    major = ""
    minor = ""
  let success = input.scanp(index, ?"cuda", +(`Digits` -> major.add($_)),
    {'.', '-', '_'}, +(`Digits` -> minor.add($_)))
  if success:
    case fmt"{major}.{minor}"
    of "8.0":
      cuda8_0
    of "12.5":
      cuda12_5
    else:
      DefaultVersion
  else:
    DefaultVersion


const args = when NimMajor >= 2:
  cmdline.commandLineParams()
else:
  os.commandLineParams()

template taskWithCudaVersionArgument(name: untyped; description: string;
                                     body: untyped): untyped =
  ## Creates a nimble task that takes one command line argument: a cuda version.
  ## This argument is accessible as the symbol `cudaVersion`.
  task name, description:
    const NameOfThisTask = `name Task`.astToStr[0..^5] #removing "Task"

    let
      noVersionArgPassed = args[^1] == NameOfThisTask
      oneVersionArgPassed = args[^2] == NameOfThisTask
      tooManyArgs = not (noVersionArgPassed or oneVersionArgPassed)

    if tooManyArgs:
      echo "Too many arguments! Please only pass the cuda version to this task."
      echo "Example: 'nimble $1 12.5'" % NameOfThisTask
    else:
      # parseCudaVersion defaults to `DefaultVersion`, so if the task is the
      # last param, it returns the default.
      let cudaVersion {.inject.} = args[^1].parseCudaVersion()
      body

template taskWithCertainVersions(name: untyped; description: string;
                                 versions: set[CudaVersion];
                                 body: untyped): untyped =
  ## Creates a nimble task that takes one command line argument: a cuda version.
  ## This argument is accessible as the symbol `cudaVersion`.
  ## The task can only be run on some versions of cuda, specified by `versions`.
  taskWithCudaVersionArgument name, description:
    if cudaVersion in versions:
      body
    else:
      echo "This task is only available for version(s) $1." % [$versions]


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

taskWithCertainVersions pagerank, "run pagerank example", {cuda8_0}:
  # removed in cuda 11.0
  exampleConfig(cudaVersion)
  setCommand "c", nimcudaExamplesDir(cudaVersion) / "pagerank".addFileExt("nim")

taskWithCertainVersions blas, "run cublas example", {cuda12_5}:
  # TODO: implement and test for 8.0
  exampleConfig(cudaVersion)
  setCommand "c", nimcudaExamplesDir(cudaVersion) / "blas".addFileExt("nim")

taskWithCertainVersions denseLinearSystem, "run cusolverDn example", {cuda12_5}:
  # TODO: implement and test for 8.0
  exampleConfig(cudaVersion)
  setCommand "c", nimcudaExamplesDir(cudaVersion) /
                                           "denseLinearSystem".addFileExt("nim")

taskWithCertainVersions sparseLinearSystem, "run cusolverSp example",
    {cuda12_5}:
  # TODO: implement and test for 8.0
  exampleConfig(cudaVersion)
  setCommand "c", nimcudaExamplesDir(cudaVersion) /
                                          "sparseLinearSystem".addFileExt("nim")

taskWithCertainVersions runtimeCompilation, "run nvrtc example",
    {cuda12_5}:
  # TODO: implement and test for 8.0
  exampleConfig(cudaVersion)
  setCommand "c", nimcudaExamplesDir(cudaVersion) /
                                          "runtimeCompilation".addFileExt("nim")
