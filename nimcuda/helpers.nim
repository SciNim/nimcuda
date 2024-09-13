
##[
  This module helps with some differences between C and Nim that C2Nim misses.
  ]##


converter toCSize_t*(self: cint): csize_t {.inline.} =
  csize_t(self)

converter toBool*(self: cint): bool {.inline.} =
  bool(self)

converter toBool*(self: uint): bool {.inline.} =
  bool(self)

converter toCint*(self: bool): cint {.inline.} =
  cint(self)


const INT_MAX * = cint.high


func `or`*(a: bool; b: cint): bool {.inline.} =
  a or b.toBool

func `or`*(a: cint; b: bool): bool {.inline.} =
  a.toBool or b

func `and`*(a: bool; b: cint): bool {.inline.} =
  a and b.toBool

func `and`*(a: cint; b: bool): bool {.inline.} =
  a.toBool and b


converter toBool*[T: ptr|pointer|proc](self: T): bool {.inline.} =
  not self.isNil


converter toCUInt*[U: enum](self: U): cuint {.inline.} =
  cuint(self)

converter toCInt*[U: enum](self: U): cint {.inline.} =
  cint(self)
