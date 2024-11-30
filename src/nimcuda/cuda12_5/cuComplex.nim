from std/math import sqrt

template sqrtf(x: cfloat): cfloat = sqrt(x)

template fabsf(x: cfloat): cfloat = abs(x)

template fabs(x: float): float = abs(x)

template `div`(a: static[float64], b: cfloat): cfloat = cfloat(a) / b

template `div`(a: cfloat, b: cfloat): cfloat = a / b
##
##  Copyright 1993-2012 NVIDIA Corporation.  All rights reserved.
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
import ./libpaths
tellCompilerToUseCuda()

when not defined(CUDACC_RTC):
  when defined(GNUC):
    when defined(clang) or
        (not defined(PGIC) and
        (GNUC > 4 or (GNUC == 4 and GNUC_MINOR >= 2))):
      discard
##  When trying to include C header file in C++ Code extern "C" is required
##  But the Standard QNX headers already have ifdef extern in them when compiling C++ Code
##  extern "C" cannot be nested
##  Hence keep the header out of extern "C" block
##

when not defined(CUDACC):
  discard
import
  vector_types

type
  cuFloatComplex* = float2

proc cuCrealf*(x: cuFloatComplex): cfloat =
  return x.x

proc cuCimagf*(x: cuFloatComplex): cfloat =
  return x.y

proc make_cuFloatComplex*(r: cfloat; i: cfloat): cuFloatComplex =
  var res: cuFloatComplex
  res.x = r
  res.y = i
  return res

proc cuConjf*(x: cuFloatComplex): cuFloatComplex =
  return make_cuFloatComplex(cuCrealf(x), -cuCimagf(x))

proc cuCaddf*(x: cuFloatComplex; y: cuFloatComplex): cuFloatComplex =
  return make_cuFloatComplex(cuCrealf(x) + cuCrealf(y), cuCimagf(x) + cuCimagf(y))

proc cuCsubf*(x: cuFloatComplex; y: cuFloatComplex): cuFloatComplex =
  return make_cuFloatComplex(cuCrealf(x) - cuCrealf(y), cuCimagf(x) - cuCimagf(y))

##  This implementation could suffer from intermediate overflow even though
##  the final resultNotKeyWord would be in range. However, various implementations do
##  not guard against this (presumably to avoid losing performance), so we
##  don't do it either to stay competitive.
##

proc cuCmulf*(x: cuFloatComplex; y: cuFloatComplex): cuFloatComplex =
  var prod: cuFloatComplex
  prod = make_cuFloatComplex((cuCrealf(x) * cuCrealf(y)) -
      (cuCimagf(x) * cuCimagf(y)), (cuCrealf(x) * cuCimagf(y)) +
      (cuCimagf(x) * cuCrealf(y)))
  return prod

##  This implementation guards against intermediate underflow and overflow
##  by scaling. Such guarded implementations are usually the default for
##  complex library implementations, with some also offering an unguarded,
##  faster version.
##

proc cuCdivf*(x: cuFloatComplex; y: cuFloatComplex): cuFloatComplex =
  var quot: cuFloatComplex
  var s: cfloat = fabsf(cuCrealf(y)) + fabsf(cuCimagf(y))
  var oos: cfloat = 1.0f div s
  var ars: cfloat = cuCrealf(x) * oos
  var ais: cfloat = cuCimagf(x) * oos
  var brs: cfloat = cuCrealf(y) * oos
  var bis: cfloat = cuCimagf(y) * oos
  s = (brs * brs) + (bis * bis)
  oos = 1.0f div s
  quot = make_cuFloatComplex(((ars * brs) + (ais * bis)) * oos,
                           ((ais * brs) - (ars * bis)) * oos)
  return quot

##
##  We would like to call hypotf(), but it's not available on all platforms.
##  This discrete implementation guards against intermediate underflow and
##  overflow by scaling. Otherwise we would lose half the exponent range.
##  There are various ways of doing guarded computation. For now chose the
##  simplest and fastest solution, however this may suffer from inaccuracies
##  if sqrt and division are not IEEE compliant.
##

proc cuCabsf*(x: cuFloatComplex): cfloat =
  var a: cfloat = cuCrealf(x)
  var b: cfloat = cuCimagf(x)
  var
    v: cfloat
    w: cfloat
    t: cfloat
  a = fabsf(a)
  b = fabsf(b)
  if a > b:
    v = a
    w = b
  else:
    v = b
    w = a
  t = w div v
  t = 1.0f + t * t
  t = v * sqrtf(t)
  if (v == 0.0f) or (v > 3.402823466e38f) or (w > 3.402823466e38f):
    t = v + w
  return t

##  Double precision

type
  cuDoubleComplex* = double2

proc cuCreal*(x: cuDoubleComplex): cdouble =
  return x.x

proc cuCimag*(x: cuDoubleComplex): cdouble =
  return x.y

proc make_cuDoubleComplex*(r: cdouble; i: cdouble): cuDoubleComplex =
  var res: cuDoubleComplex
  res.x = r
  res.y = i
  return res

proc cuConj*(x: cuDoubleComplex): cuDoubleComplex =
  return make_cuDoubleComplex(cuCreal(x), -cuCimag(x))

proc cuCadd*(x: cuDoubleComplex; y: cuDoubleComplex): cuDoubleComplex =
  return make_cuDoubleComplex(cuCreal(x) + cuCreal(y), cuCimag(x) + cuCimag(y))

proc cuCsub*(x: cuDoubleComplex; y: cuDoubleComplex): cuDoubleComplex =
  return make_cuDoubleComplex(cuCreal(x) - cuCreal(y), cuCimag(x) - cuCimag(y))

##  This implementation could suffer from intermediate overflow even though
##  the final resultNotKeyWord would be in range. However, various implementations do
##  not guard against this (presumably to avoid losing performance), so we
##  don't do it either to stay competitive.
##

proc cuCmul*(x: cuDoubleComplex; y: cuDoubleComplex): cuDoubleComplex =
  var prod: cuDoubleComplex
  prod = make_cuDoubleComplex((cuCreal(x) * cuCreal(y)) - (cuCimag(x) * cuCimag(y)), (
      cuCreal(x) * cuCimag(y)) + (cuCimag(x) * cuCreal(y)))
  return prod

##  This implementation guards against intermediate underflow and overflow
##  by scaling. Such guarded implementations are usually the default for
##  complex library implementations, with some also offering an unguarded,
##  faster version.
##

proc cuCdiv*(x: cuDoubleComplex; y: cuDoubleComplex): cuDoubleComplex =
  var quot: cuDoubleComplex
  var s: cdouble = (fabs(cuCreal(y))) + (fabs(cuCimag(y)))
  var oos: cdouble = 1.0 div s
  var ars: cdouble = cuCreal(x) * oos
  var ais: cdouble = cuCimag(x) * oos
  var brs: cdouble = cuCreal(y) * oos
  var bis: cdouble = cuCimag(y) * oos
  s = (brs * brs) + (bis * bis)
  oos = 1.0 div s
  quot = make_cuDoubleComplex(((ars * brs) + (ais * bis)) * oos,
                            ((ais * brs) - (ars * bis)) * oos)
  return quot

##  This implementation guards against intermediate underflow and overflow
##  by scaling. Otherwise we would lose half the exponent range. There are
##  various ways of doing guarded computation. For now chose the simplest
##  and fastest solution, however this may suffer from inaccuracies if sqrt
##  and division are not IEEE compliant.
##

proc cuCabs*(x: cuDoubleComplex): cdouble =
  var a: cdouble = cuCreal(x)
  var b: cdouble = cuCimag(x)
  var
    v: cdouble
    w: cdouble
    t: cdouble
  a = fabs(a)
  b = fabs(b)
  if a > b:
    v = a
    w = b
  else:
    v = b
    w = a
  t = w div v
  t = 1.0 + t * t
  t = v * sqrt(t)
  if (v == 0.0) or (v > 1.79769313486231570e+308) or (w > 1.79769313486231570e+308):
    t = v + w
  return t

##  aliases

type
  cuComplex* = cuFloatComplex

proc make_cuComplex*(x: cfloat; y: cfloat): cuComplex =
  return make_cuFloatComplex(x, y)

##  float-to-double promotion

proc cuComplexFloatToDouble*(c: cuFloatComplex): cuDoubleComplex =
  return make_cuDoubleComplex(cast[cdouble](cuCrealf(c)),
                             cast[cdouble](cuCimagf(c)))

proc cuComplexDoubleToFloat*(c: cuDoubleComplex): cuFloatComplex =
  return make_cuFloatComplex(cast[cfloat](cuCreal(c)), cast[cfloat](cuCimag(c)))

proc cuCfmaf*(x: cuComplex; y: cuComplex; d: cuComplex): cuComplex =
  var real_res: cfloat
  var imag_res: cfloat
  real_res = (cuCrealf(x) * cuCrealf(y)) + cuCrealf(d)
  imag_res = (cuCrealf(x) * cuCimagf(y)) + cuCimagf(d)
  real_res = -(cuCimagf(x) * cuCimagf(y)) + real_res
  imag_res = (cuCimagf(x) * cuCrealf(y)) + imag_res
  return make_cuComplex(real_res, imag_res)

proc cuCfma*(x: cuDoubleComplex; y: cuDoubleComplex; d: cuDoubleComplex): cuDoubleComplex =
  var real_res: cdouble
  var imag_res: cdouble
  real_res = (cuCreal(x) * cuCreal(y)) + cuCreal(d)
  imag_res = (cuCreal(x) * cuCimag(y)) + cuCimag(d)
  real_res = -(cuCimag(x) * cuCimag(y)) + real_res
  imag_res = (cuCimag(x) * cuCreal(y)) + imag_res
  return make_cuDoubleComplex(real_res, imag_res)
