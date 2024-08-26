##
##  Copyright 1993-2014 NVIDIA Corporation.  All rights reserved.
##
##  NOTICE TO LICENSEE:
##
##  This source code and/or documentation ("Licensed Deliverables") are
##  subject to NVIDIA intellectual property rights under U.S. and
##  international Copyright laws.
##
##  These Licensed Deliverables contained herein is PROPRIETARY and
##  CONFIDENTIAL to NVIDIA and is being provided under the terms and
##  conditions of a form of NVIDIA software license agreement by and
##  between NVIDIA and Licensee ("License Agreement") or electronically
##  accepted by Licensee.  Notwithstanding any terms or conditions to
##  the contrary in the License Agreement, reproduction or disclosure
##  of the Licensed Deliverables to any third party without the express
##  written consent of NVIDIA is prohibited.
##
##  NOTWITHSTANDING ANY TERMS OR CONDITIONS TO THE CONTRARY IN THE
##  LICENSE AGREEMENT, NVIDIA MAKES NO REPRESENTATION ABOUT THE
##  SUITABILITY OF THESE LICENSED DELIVERABLES FOR ANY PURPOSE.  IT IS
##  PROVIDED "AS IS" WITHOUT EXPRESS OR IMPLIED WARRANTY OF ANY KIND.
##  NVIDIA DISCLAIMS ALL WARRANTIES WITH REGARD TO THESE LICENSED
##  DELIVERABLES, INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY,
##  NONINFRINGEMENT, AND FITNESS FOR A PARTICULAR PURPOSE.
##  NOTWITHSTANDING ANY TERMS OR CONDITIONS TO THE CONTRARY IN THE
##  LICENSE AGREEMENT, IN NO EVENT SHALL NVIDIA BE LIABLE FOR ANY
##  SPECIAL, INDIRECT, INCIDENTAL, OR CONSEQUENTIAL DAMAGES, OR ANY
##  DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS,
##  WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS
##  ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE
##  OF THESE LICENSED DELIVERABLES.
##
##  U.S. Government End Users.  These Licensed Deliverables are a
##  "commercial item" as that term is defined at 48 C.F.R. 2.101 (OCT
##  1995), consisting of "commercial computer software" and "commercial
##  computer software documentation" as such terms are used in 48
##  C.F.R. 12.212 (SEPT 1995) and is provided to the U.S. Government
##  only as a commercial end item.  Consistent with 48 C.F.R.12.212 and
##  48 C.F.R. 227.7202-1 through 227.7202-4 (JUNE 1995), all
##  U.S. Government End Users acquire the Licensed Deliverables with
##  only those rights set forth herein.
##
##  Any use of the Licensed Deliverables in individual and commercial
##  software must include, in the user documentation and internal
##  comments to the code, the above Disclaimer and U.S. Government End
##  Users Notice.
##

when not defined(VECTOR_TYPES_H):
  type
    char1* {.importc: "char1", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: cchar

  type
    uchar1* {.importc: "uchar1", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: cuchar

  type
    char2* {.importc: "char2", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: cchar
      y* {.importc: "y".}: cchar

  type
    uchar2* {.importc: "uchar2", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: cuchar
      y* {.importc: "y".}: cuchar

  type
    char3* {.importc: "char3", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: cchar
      y* {.importc: "y".}: cchar
      z* {.importc: "z".}: cchar

  type
    uchar3* {.importc: "uchar3", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: cuchar
      y* {.importc: "y".}: cuchar
      z* {.importc: "z".}: cuchar

  type
    char4* {.importc: "char4", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: cchar
      y* {.importc: "y".}: cchar
      z* {.importc: "z".}: cchar
      w* {.importc: "w".}: cchar

  type
    uchar4* {.importc: "uchar4", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: cuchar
      y* {.importc: "y".}: cuchar
      z* {.importc: "z".}: cuchar
      w* {.importc: "w".}: cuchar

  type
    short1* {.importc: "short1", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: cshort

  type
    ushort1* {.importc: "ushort1", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: cushort

  type
    short2* {.importc: "short2", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: cshort
      y* {.importc: "y".}: cshort

  type
    ushort2* {.importc: "ushort2", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: cushort
      y* {.importc: "y".}: cushort

  type
    short3* {.importc: "short3", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: cshort
      y* {.importc: "y".}: cshort
      z* {.importc: "z".}: cshort

  type
    ushort3* {.importc: "ushort3", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: cushort
      y* {.importc: "y".}: cushort
      z* {.importc: "z".}: cushort

  type
    short4* {.importc: "short4", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: cshort
      y* {.importc: "y".}: cshort
      z* {.importc: "z".}: cshort
      w* {.importc: "w".}: cshort

  type
    ushort4* {.importc: "ushort4", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: cushort
      y* {.importc: "y".}: cushort
      z* {.importc: "z".}: cushort
      w* {.importc: "w".}: cushort

  type
    int1* {.importc: "int1", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: cint

  type
    uint1* {.importc: "uint1", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: cuint

  type
    int2* {.importc: "int2", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: cint
      y* {.importc: "y".}: cint

  type
    uint2* {.importc: "uint2", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: cuint
      y* {.importc: "y".}: cuint

  type
    int3* {.importc: "int3", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: cint
      y* {.importc: "y".}: cint
      z* {.importc: "z".}: cint

  type
    uint3* {.importc: "uint3", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: cuint
      y* {.importc: "y".}: cuint
      z* {.importc: "z".}: cuint

  type
    int4* {.importc: "int4", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: cint
      y* {.importc: "y".}: cint
      z* {.importc: "z".}: cint
      w* {.importc: "w".}: cint

  type
    uint4* {.importc: "uint4", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: cuint
      y* {.importc: "y".}: cuint
      z* {.importc: "z".}: cuint
      w* {.importc: "w".}: cuint

  type
    long1* {.importc: "long1", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: clong

  type
    ulong1* {.importc: "ulong1", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: culong

  type
    long2* {.importc: "long2", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: clong
      y* {.importc: "y".}: clong

  type
    ulong2* {.importc: "ulong2", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: culong
      y* {.importc: "y".}: culong

  type
    long3* {.importc: "long3", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: clong
      y* {.importc: "y".}: clong
      z* {.importc: "z".}: clong

  type
    ulong3* {.importc: "ulong3", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: culong
      y* {.importc: "y".}: culong
      z* {.importc: "z".}: culong

  type
    long4* {.importc: "long4", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: clong
      y* {.importc: "y".}: clong
      z* {.importc: "z".}: clong
      w* {.importc: "w".}: clong

  type
    ulong4* {.importc: "ulong4", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: culong
      y* {.importc: "y".}: culong
      z* {.importc: "z".}: culong
      w* {.importc: "w".}: culong

  type
    float1* {.importc: "float1", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: cfloat

  type
    float2* {.importc: "float2", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: cfloat
      y* {.importc: "y".}: cfloat

  type
    float3* {.importc: "float3", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: cfloat
      y* {.importc: "y".}: cfloat
      z* {.importc: "z".}: cfloat

  type
    float4* {.importc: "float4", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: cfloat
      y* {.importc: "y".}: cfloat
      z* {.importc: "z".}: cfloat
      w* {.importc: "w".}: cfloat

  type
    longlong1* {.importc: "longlong1", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: clonglong

  type
    ulonglong1* {.importc: "ulonglong1", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: culonglong

  type
    longlong2* {.importc: "longlong2", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: clonglong
      y* {.importc: "y".}: clonglong

  type
    ulonglong2* {.importc: "ulonglong2", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: culonglong
      y* {.importc: "y".}: culonglong

  type
    longlong3* {.importc: "longlong3", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: clonglong
      y* {.importc: "y".}: clonglong
      z* {.importc: "z".}: clonglong

  type
    ulonglong3* {.importc: "ulonglong3", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: culonglong
      y* {.importc: "y".}: culonglong
      z* {.importc: "z".}: culonglong

  type
    longlong4* {.importc: "longlong4", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: clonglong
      y* {.importc: "y".}: clonglong
      z* {.importc: "z".}: clonglong
      w* {.importc: "w".}: clonglong

  type
    ulonglong4* {.importc: "ulonglong4", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: culonglong
      y* {.importc: "y".}: culonglong
      z* {.importc: "z".}: culonglong
      w* {.importc: "w".}: culonglong

  type
    double1* {.importc: "double1", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: cdouble

  type
    double2* {.importc: "double2", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: cdouble
      y* {.importc: "y".}: cdouble

  type
    double3* {.importc: "double3", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: cdouble
      y* {.importc: "y".}: cdouble
      z* {.importc: "z".}: cdouble

  type
    double4* {.importc: "double4", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: cdouble
      y* {.importc: "y".}: cdouble
      z* {.importc: "z".}: cdouble
      w* {.importc: "w".}: cdouble

  ## *****************************************************************************
  ##                                                                               *
  ##                                                                               *
  ##                                                                               *
  ## *****************************************************************************
  ## *****************************************************************************
  ##                                                                               *
  ##                                                                               *
  ##                                                                               *
  ## *****************************************************************************
  type
    dim3* {.importc: "dim3", header: "vector_types.h", bycopy.} = object
      x* {.importc: "x".}: cuint
      y* {.importc: "y".}: cuint
      z* {.importc: "z".}: cuint
