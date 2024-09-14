#ifdef C2NIM
  #assumendef CU_COMPLEX_H_

  #mangle __GNUC__ GNUC
  #mangle __GNUC_MINOR__ GNUC_MINOR

  #def __host__
  #def __device__
  #def __inline__

#@
from std/math import sqrt

template sqrtf(x: cfloat): cfloat = sqrt(x)

template fabsf(x: cfloat): cfloat = abs(x)

template fabs(x: float): float = abs(x)

template `div`(a: static[float64], b: cfloat): cfloat = cfloat(a) / b

template `div`(a: cfloat, b: cfloat): cfloat = a / b
@#

#endif
