 
##[
  This helper executable preprocesses the c header files before they get
  passed to c2nim.
  ]##

import
  std / [pegs, cmdline, paths, files, strformat, strutils]

func renameUint64(code: sink string): string =
  ## C2nim has trouble with the `unsigned long long int` type.
  ## This func replaces it with something that it can handle.
  result = code.replace(peg"'unsigned long long' ' int'?", "culonglong")

func renameInt64(code: sink string): string =
  ## C2nim has trouble with the `unsigned long long int` type.
  ## This func replaces it with something that it can handle.
  result = code.replace("int64_t", "clonglong")

func renameCuchar(code: sink string): string =
  ## `cuchar` is depreciated.
  ## This func replaces it.
  result = code.replace("cuchar", "uint8")

func rearrangeConstPtrTypeDefs(code: string): string =
  ## C2nim has trouble with the a certain arrangement of `const*` typedefs.
  ## This func replaces it with something that it can handle.
  result = code.replacef(peg"'typedef struct ' {\ident} ' const* ' {\ident}[;]",
                         "typedef const struct $1* $2;")





func preprocess*(code: sink string): string =
  ## Does some nice formatting to Cuda library code before it gets passed to
  ## c2Nim.
  result = code.rearrangeConstPtrTypeDefs.renameUint64.renameInt64.
                renameCuchar()




proc main =
  for arg in commandLineParams():
    assert (Path arg).fileExists, fmt "Bad argument! '{arg}' doesn't exist."

    let
      input = readFile(arg)
      preprocessed = input.preprocess()

    writeFile arg, preprocessed
    echo fmt"Preprocessed '{arg}'"



when isMainModule:
  main()
