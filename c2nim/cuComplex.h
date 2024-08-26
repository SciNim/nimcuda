#ifdef C2NIM
  #mangle CU_COMPLEX_H_ CU_COMPLEX_H

  #assumedef __CUDACC_RTC__
  #assumedef __CUDACC__

  #def __host__
  #def __device__
  #def __inline__

#@
from math import sqrt

template sqrtf(x: cfloat): cfloat = sqrt(x)

template fabsf(x: cfloat): cfloat = abs(x)

template fabs(x: float): float = abs(x)

template `div`(a: static[float64], b: cfloat): cfloat = cfloat(a) / b

template `div`(a: cfloat, b: cfloat): cfloat = a / b
@#

#endif
