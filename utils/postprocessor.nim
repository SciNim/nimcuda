
##[
  This helper executable postprocesses the nim files after they get
  spit out by c2nim.
  ]##

import
  std / [pegs, cmdline, paths, files, strformat, strutils, sugar, sets]



func mangleDefines(code: sink string): string =
  ## C2nim struggles with mangling code that looks like this:
  ## `defined(__MY_CONST__)`. This proc mangles it to normal Nim style.
  let pegAst = peg"""definedExpr <- 'defined(' \s* middle \s* endOfDefined

    middle <- leading / trailing

    leading <- '_'+ identifer '_'*
    trailing <- '_'* identifer '_'+

    identifer <- { ( !(endOfIdentifier / endOfDefined) .)+ }

    endOfIdentifier <- '_'+ !(\a / \d)
    endOfDefined <- ')'
    """

  result = code.replacef(pegAst,
                         "defined($1)")
  # result = code.replacef(peg"'defined(__' { (!('__' / [)]) .)+ } '__'? [)]",
  #                        "defined($1)")

func handleForwardDecls(code: sink string): string =
  ## C2nim handles forward declarations by outputing the following:
  ## `discard "forward decl of {typeDesc}"`
  ## This proc replaces it with `type {typeDesc} = object`.
  result = code.replacef(peg""" 'discard "forward decl of ' {\ident} ["] """,
                         "type $1 {.nodecl.} = object")


func removeUnusedVariableSilencing(code: sink string): string =
  let matcher = peg" {\n '  '*} 'cast[nil](' \s* {\ident} \s* ')' {@\n} "

  result = code.replacef(matcher, "$1discard $2$3")


func fixTrailingUnderscoreProcName(name: string): string =
  let nameNoTrailing = name.strip(chars={'_'}, leading=false, trailing=true)
  result = fmt"{nameNoTrailing}UnderScore"


proc fixProcsDecls(code: sink string): string =
  ## This proc makes some procs discardable that should be.
  ## Currently this is any proc returning an error code.
  ## It also fixes trailing underscores in the name.

  let procDecls = peg"""procDecls <- (@procDecl)*
    procDecl <- 'proc ' procName '*(' \s* argDecls ')' (':' \s+ returnType)? (\s+ pragmas)? (\s+ '=')? @\n
    procName <- \ident
    notLastProcArg <- procArgName ': ' procArgType ';'
    lastProcArg <- procArgName ': ' procArgType !';'
    argDecls <- (notLastProcArg \s*)* lastProcArg
    returnType <- \ident
    pragmas <- '{.' \s* (notLastPragma \s+)* lastPragma \s* '.}'
    notLastPragma <- singlePragma ','
    lastPragma <- singlePragma !','


    singlePragma <- pragmaName (':' \s+ ["] \ident ["])?
    pragmaName <- \ident

    procArgName <- \ident
    procArgType <- 'ptr '? \ident
    """

  type ProcToReplace = object
    startF, lengthF: int # template confusion later on requires the 'F'.
    oldName, newName: string
    makeDiscardable: bool

  var needsChanged: seq[ProcToReplace] = @[]

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
            if context.shouldBeDiscardable or context.currentProc.endsWith('_'):
              let found = ProcToReplace(startF: start, lengthF: length,
                newName: context.currentProc.fixTrailingUnderscoreProcName,
                oldName: context.currentProc,
                makeDiscardable: context.shouldBeDiscardable)
              needsChanged.add found

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
    for procedure in needsChanged:

      template thisMatch(): string =
        code[procedure.startF .. procedure.startF + procedure.lengthF - 1]

      let original = thisMatch()
      var modified = original

      if procedure.makeDiscardable:
        modified = modified.makeDiscardable
      if procedure.newName != procedure.oldName:
        modified = modified.replace(fmt"proc {procedure.oldName}",
                                    fmt"proc {procedure.newName}")
      (original, modified)

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
                fixProcsDecls.escapeKeyWords.
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

