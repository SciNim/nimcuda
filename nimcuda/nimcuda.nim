
##[
  This main module exports a few of cuda 8.0's modules.
  If you need a different version or a module not exported here, try something
  like:

  .. code-block:: Nim
    import nimcuda/12.5/library_name
  ]##

import
  ./8.0/[check, cuda_runtime_api, library_types, driver_types, vector_types]


export check, cuda_runtime_api, library_types, driver_types, vector_types
