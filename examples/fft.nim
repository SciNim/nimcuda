import sequtils
import cunim/cufft

proc main() =
  var
    plan: cufftHandle
    idata: cufftComplex
    odata: cufftComplex

  echo "FFT: "


when isMainModule:
  main()