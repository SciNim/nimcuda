#ifdef C2NIM
  #def CURANDAPI

  #mangle CURAND_H_ CURAND_H

  #assumedef __CUDACC_RTC__

  #dynlib libName
  #private libName
  #cdecl
  #if defined(windows)
  #  define libName "curand.dll"
  #elif defined(macosx)
  #  define libName "libcurand.dylib"
  #else
  #  define libName "libcurand.so"
  #endif

  #private curandDistributionShift_st
  #private curandDistributionM2Shift_st
  #private curandHistogramM2_st
  #private curandDiscreteDistribution_st

  struct curandDistributionShift_st {};
  struct curandDistributionM2Shift_st {};
  struct curandHistogramM2_st {};
  struct curandDiscreteDistribution_st {};

  #include "library_types.h"
  #include "driver_types.h"
  #skipinclude
#endif
