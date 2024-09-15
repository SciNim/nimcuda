# NimCUDA

Nim bindings for the [CUDA](https://developer.nvidia.com/cuda-toolkit)
libraries. The versions currently in use are

* CUDA 8.0 + CuDNN 5.1
* CUDA 12.5

## Status

Most libraries have working bindings. Out of these:

* most bindings are generated using [c2nim](http://nim-lang.org/docs/c2nim.html)
  and suitable directives (see the files inside `/c2nim`)
* a preprocessor is used on the header files to help with common issues that
  c2nim has during parsing.
* a postprocessor is used on the nim files to help alleviate some common
  output problems that c2nim has.
* some headers files are manually edited before being passed to c2nim.
* some nim files are manually edited.

Ideally, once some improvements are available in c2nim, there should be no
need to manually modify any files.

## Usage

See a few examples under `/examples`. The examples can be run with the command
`nimble EXAMPLE_NAME CUDA_VERSION`, where `EXAMPLE_NAME` is one of the examples and
`CUDA_VERSION` is the version of cuda that you want it to run on - for
instance `nimble fft 12.5`.

API documentation lives under `/htmldocs`. Generate it by running `nimble docs`.

## Name mangling

c2nim supports name mangling, which could be useful to simplify a few names
(e.g. turn `CUBLAS_STATUS_ARCH_MISMATCH` into `ARCH_MISMATCH`, which can be
qualified as `cublasStatus_t.ARCH_MISMATCH` in case of ambiguity).

Right now, no unnecessary mangling is performed, because the API surface is large and
not always consistent, so it felt simpler to leave it as is. This may change
in a future release.

## Error handling

In each cuda version's library there is a file called `check.nim`.
In it are a few templates that turn CUDA errors
into Nim exceptions. They are all under the overloaded name `check`, so that
one can do, for instance

```nim
check cudaMalloc(cast[ptr pointer](addr gpuRows), sizeof(rows))
```

(here `cudaMalloc` is one of the many functions that fail by returning an
error code).
