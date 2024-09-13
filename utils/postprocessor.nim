
##[
  This helper executable postprocesses the nim files after they get
  spit out by c2nim.
  ]##

import
  std / [pegs, cmdline, paths, files, strformat, strutils, sugar, sets]



func mangleDefines(code: sink string): string =
  ## C2nim struggles with mangling code that looks like this:
  ## `defined(__MY_CONST__)`. This proc mangles it to normal Nim style.
  result = code.replacef(peg"'defined(__' { (!('__' / [)]) .)+ } '__'? [)]",
                         "defined($1)")

func handleForwardDecls(code: sink string): string =
  ## C2nim handles forward declarations by outputing the following:
  ## `discard "forward decl of {typeDesc}"`
  ## This proc replaces it with `type {typeDesc} = object`.
  result = code.replacef(peg""" 'discard "forward decl of ' {\ident} ["] """,
                         "type $1 {.importc, nodecl.} = object")


func removeUnusedVariableSilencing(code: sink string): string =
  let matcher = peg" {\n '  '*} 'cast[nil](' \s* {\ident} \s* ')' {@\n} "

  result = code.replacef(matcher, "$1discard $2$3")


proc makeProcsDiscardable(code: sink string): string =
  ## This proc makes some procs discardable that should be.
  ## Currently this is any proc returning an error code.

  let procDecls = peg"""procDecls <- (@procDecl)*
    procDecl <- 'proc ' procName '*(' \s* argDecls '):' \s+ returnType \s+ pragmas? \s* '='
    procName <- \ident
    notLastProcArg <- procArgName ': ' procArgType ';'
    lastProcArg <- procArgName ': ' procArgType !';'
    argDecls <- (notLastProcArg \s*)* lastProcArg
    returnType <- \ident
    pragmas <- '{.' \s* (notLastPragma \s+)* lastPragma \s* '.}'
    notLastPragma <- pragmaName ','
    lastPragma <- pragmaName !','

    pragmaName <- \ident

    procArgName <- \ident
    procArgType <- 'ptr '? \ident
    """

  var procsThatShouldBeDiscardable: seq[tuple[start, length: int]] = @[]

  const DiscardableReturnTypes = ["CudaOccError"]

  type ProcDeclarationParsingContext = object
    currentProc: string
    shouldBeDiscardable: bool

  func reset(self: var ProcDeclarationParsingContext) =
    self.currentProc.setLen 0
    self.shouldBeDiscardable = false

  var context = ProcDeclarationParsingContext()


  let parseProcDecls = procDecls.eventParser:
    pkNonTerminal:
      leave:
        template thisMatch(): string =
          code[start .. start + length - 1]

        if length > 0:
          # Succesful match on a nonterminal (named) peg.
          case p.nt.name
          of "procName":
            context.currentProc = thisMatch()


          of "returnType":
            let returnType = thisMatch()
            for discardableType in DiscardableReturnTypes:
              if returnType.cmpIgnoreStyle(discardableType) == 0:
                context.shouldBeDiscardable = true


          of "pragmaName":
            if thisMatch().cmpIgnoreStyle("discardable") == 0:
              # Proc is already discardable.
              context.shouldBeDiscardable = false

          of "procDecl":
            # Success parsing a proc declaration.
            if context.shouldBeDiscardable:
              procsThatShouldBeDiscardable.add (start, length)

            reset context

          else: discard

        else:
          case p.nt.name
          of "procDecl":
            # Failure parsing; not a proc declaration.
            reset context
          else: discard

  assert parseProcDecls(code) != -1

  func makeDiscardable(decl: string): string =
    const
      PragmaStart = "{."
      NotFound = -1
    let
      foundPragmaStart = decl.rfind("{.")
      alreadyHasPragmas = foundPragmaStart != NotFound
    if alreadyHasPragmas:
      let
        firstPart = decl[0 .. foundPragmaStart + PragmaStart.high]
        lastPart = decl[foundPragmaStart + PragmaStart.high + 1 .. ^1]
      result = fmt"{firstPart}discardable, {lastPart}"
    else:
      assert decl[^1] == '='
      result = fmt"{decl[0..^2]} {{.discardable.}} ="

  let replacePairs = collect:
    for (start, length) in procsThatShouldBeDiscardable:
      template thisMatch(): string =
        code[start .. start + length - 1]
      let
        original = thisMatch()
        discardable = original.makeDiscardable
      (original, discardable)

  result = code.multiReplace(replacePairs)




func doSimpleSwaps(code: sink string): string =
  ## Corrects some types that c2nim doesn't get right.
  let
    renameCuchar = ("cuchar", "char")
    fixCastToInt = ("(int)", "(cint)")
    renameMemCopy = ("memcpy", "copyMem")
  result = code.multiReplace(renameCuchar, fixCastToInt, renameMemCopy)


func escapeKeyWords(code: sink string): string =
  ## C2nim outputs variables named Nim keywords as-is.
  ## This proc escapes them.
  # TODO: add more keywords
  let someKeyWord = peg" { \s+ / '(' } {'result'} !\w"
  result = code.replacef(someKeyWord, "$1$2NotKeyWord")




proc postprocess*(code: sink string): string =
  result = code.mangleDefines.doSimpleSwaps.handleForwardDecls.
                makeProcsDiscardable.escapeKeyWords.
                removeUnusedVariableSilencing()






proc main =
  for arg in commandLineParams():
    assert (Path arg).fileExists, fmt "Bad argument! '{arg}' doesn't exist."

    let
      input = readFile(arg)
      postprocessed = input.postprocess()

    writeFile arg, postprocessed
    echo fmt"Postprocessed '{arg}'"



when isMainModule:
  main()

