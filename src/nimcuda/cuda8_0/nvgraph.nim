##  #prefix nvgraph
##  #prefix NVGRAPH_

{.deadCodeElim: on.}
when defined(windows):
  import os
  {.passL: "\"" & os.getEnv("CUDA_PATH") / "lib/x64" / "nvgraph.lib" & "\"".}
  {.pragma: dyn.}
elif defined(macosx):
  const
    libName = "libnvgraph.dylib"
  {.pragma: dyn, dynlib: libName.}
else:
  const
    libName = "libnvgraph.so"
  {.pragma: dyn, dynlib: libName.}
import
  library_types

##
##  Copyright (c) 2016, NVIDIA CORPORATION.  All rights reserved.
##
##  NVIDIA CORPORATION and its licensors retain all intellectual property
##  and proprietary rights in and to this software, related documentation
##  and any modifications thereto.  Any use, reproduction, disclosure or
##  distribution of this software and related documentation without an express
##  license agreement from NVIDIA CORPORATION is strictly prohibited.
##
##

##  nvGRAPH status type returns

type
  nvgraphStatus_t* {.size: sizeof(cint).} = enum
    NVGRAPH_STATUS_SUCCESS = 0, NVGRAPH_STATUS_NOT_INITIALIZED = 1,
    NVGRAPH_STATUS_ALLOC_FAILED = 2, NVGRAPH_STATUS_INVALID_VALUE = 3,
    NVGRAPH_STATUS_ARCH_MISMATCH = 4, NVGRAPH_STATUS_MAPPING_ERROR = 5,
    NVGRAPH_STATUS_EXECUTION_FAILED = 6, NVGRAPH_STATUS_INTERNAL_ERROR = 7,
    NVGRAPH_STATUS_TYPE_NOT_SUPPORTED = 8, NVGRAPH_STATUS_NOT_CONVERGED = 9


proc nvgraphStatusGetString*(status: nvgraphStatus_t): cstring {.cdecl,
    importc: "nvgraphStatusGetString", dyn.}
##  Opaque structure holding nvGRAPH library context

type
  nvgraphContext* = object

  nvgraphHandle_t* = ptr nvgraphContext

##  Opaque structure holding the graph descriptor

type
  nvgraphGraphDescr* = object

  nvgraphGraphDescr_t* = ptr nvgraphGraphDescr

##  Semi-ring types

type
  nvgraphSemiring_t* {.size: sizeof(cint).} = enum
    NVGRAPH_PLUS_TIMES_SR = 0, NVGRAPH_MIN_PLUS_SR = 1, NVGRAPH_MAX_MIN_SR = 2,
    NVGRAPH_OR_AND_SR = 3


##  Topology types

type
  nvgraphTopologyType_t* {.size: sizeof(cint).} = enum
    NVGRAPH_CSR_32 = 0, NVGRAPH_CSC_32 = 1, NVGRAPH_COO_32 = 2
  nvgraphTag_t* {.size: sizeof(cint).} = enum
    NVGRAPH_DEFAULT = 0,        ##  Default is unsorted.
    NVGRAPH_UNSORTED = 1,       ##
    NVGRAPH_SORTED_BY_SOURCE = 2, ##  CSR
    NVGRAPH_SORTED_BY_DESTINATION = 3



type
  nvgraphCSRTopology32I_st* = object
    nvertices*: cint           ##  n+1
    nedges*: cint              ##  nnz
    source_offsets*: ptr cint   ##  rowPtr
    destination_indices*: ptr cint ##  colInd

  nvgraphCSRTopology32I_t* = ptr nvgraphCSRTopology32I_st
  nvgraphCSCTopology32I_st* = object
    nvertices*: cint           ##  n+1
    nedges*: cint              ##  nnz
    destination_offsets*: ptr cint ##  colPtr
    source_indices*: ptr cint   ##  rowInd

  nvgraphCSCTopology32I_t* = ptr nvgraphCSCTopology32I_st
  nvgraphCOOTopology32I_st* = object
    nvertices*: cint           ##  n+1
    nedges*: cint              ##  nnz
    source_indices*: ptr cint   ##  rowInd
    destination_indices*: ptr cint ##  colInd
    tag*: nvgraphTag_t

  nvgraphCOOTopology32I_t* = ptr nvgraphCOOTopology32I_st

##  Open the library and create the handle

proc nvgraphCreate*(handle: ptr nvgraphHandle_t): nvgraphStatus_t {.cdecl,
    importc: "nvgraphCreate", dyn.}
##   Close the library and destroy the handle

proc nvgraphDestroy*(handle: nvgraphHandle_t): nvgraphStatus_t {.cdecl,
    importc: "nvgraphDestroy", dyn.}
##  Create an empty graph descriptor

proc nvgraphCreateGraphDescr*(handle: nvgraphHandle_t;
                             descrG: ptr nvgraphGraphDescr_t): nvgraphStatus_t {.
    cdecl, importc: "nvgraphCreateGraphDescr", dyn.}
##  Destroy a graph descriptor

proc nvgraphDestroyGraphDescr*(handle: nvgraphHandle_t; descrG: nvgraphGraphDescr_t): nvgraphStatus_t {.
    cdecl, importc: "nvgraphDestroyGraphDescr", dyn.}
##  Set size, topology data in the graph descriptor

proc nvgraphSetGraphStructure*(handle: nvgraphHandle_t;
                              descrG: nvgraphGraphDescr_t; topologyData: pointer;
                              TType: nvgraphTopologyType_t): nvgraphStatus_t {.
    cdecl, importc: "nvgraphSetGraphStructure", dyn.}
##  Query size and topology information from the graph descriptor

proc nvgraphGetGraphStructure*(handle: nvgraphHandle_t;
                              descrG: nvgraphGraphDescr_t; topologyData: pointer;
                              TType: ptr nvgraphTopologyType_t): nvgraphStatus_t {.
    cdecl, importc: "nvgraphGetGraphStructure", dyn.}
##  Allocate numsets vectors of size V reprensenting Vertex Data and attached them the graph.
##  settypes[i] is the type of vector #i, currently all Vertex and Edge data should have the same type

proc nvgraphAllocateVertexData*(handle: nvgraphHandle_t;
                               descrG: nvgraphGraphDescr_t; numsets: csize_t;
                               settypes: ptr cudaDataType): nvgraphStatus_t {.cdecl,
    importc: "nvgraphAllocateVertexData", dyn.}
##  Allocate numsets vectors of size E reprensenting Edge Data and attached them the graph.
##  settypes[i] is the type of vector #i, currently all Vertex and Edge data should have the same type

proc nvgraphAllocateEdgeData*(handle: nvgraphHandle_t; descrG: nvgraphGraphDescr_t;
                             numsets: csize_t; settypes: ptr cudaDataType): nvgraphStatus_t {.
    cdecl, importc: "nvgraphAllocateEdgeData", dyn.}
##  `Update the vertex set #setnum with the data in *vertexData, sets have 0-based index`
##   Conversions are not sopported so nvgraphTopologyType_t should match the graph structure

proc nvgraphSetVertexData*(handle: nvgraphHandle_t; descrG: nvgraphGraphDescr_t;
                          vertexData: pointer; setnum: csize_t): nvgraphStatus_t {.
    cdecl, importc: "nvgraphSetVertexData", dyn.}
##  `Copy the edge set #setnum in *edgeData, sets have 0-based index`
##   Conversions are not sopported so nvgraphTopologyType_t should match the graph structure

proc nvgraphGetVertexData*(handle: nvgraphHandle_t; descrG: nvgraphGraphDescr_t;
                          vertexData: pointer; setnum: csize_t): nvgraphStatus_t {.
    cdecl, importc: "nvgraphGetVertexData", dyn.}
##  Convert the edge data to another topology
##

proc nvgraphConvertTopology*(handle: nvgraphHandle_t;
                            srcTType: nvgraphTopologyType_t; srcTopology: pointer;
                            srcEdgeData: pointer; dataType: ptr cudaDataType;
                            dstTType: nvgraphTopologyType_t; dstTopology: pointer;
                            dstEdgeData: pointer): nvgraphStatus_t {.cdecl,
    importc: "nvgraphConvertTopology", dyn.}
##  Convert graph to another structure
##

proc nvgraphConvertGraph*(handle: nvgraphHandle_t; srcDescrG: nvgraphGraphDescr_t;
                         dstDescrG: nvgraphGraphDescr_t;
                         dstTType: nvgraphTopologyType_t): nvgraphStatus_t {.cdecl,
    importc: "nvgraphConvertGraph", dyn.}
##  `Update the edge set #setnum with the data in *edgeData, sets have 0-based index`
##   Conversions are not sopported so nvgraphTopologyType_t should match the graph structure

proc nvgraphSetEdgeData*(handle: nvgraphHandle_t; descrG: nvgraphGraphDescr_t;
                        edgeData: pointer; setnum: csize_t): nvgraphStatus_t {.cdecl,
    importc: "nvgraphSetEdgeData", dyn.}
##  `Copy the edge set #setnum in *edgeData, sets have 0-based index`
##  Conversions are not sopported so nvgraphTopologyType_t should match the graph structure

proc nvgraphGetEdgeData*(handle: nvgraphHandle_t; descrG: nvgraphGraphDescr_t;
                        edgeData: pointer; setnum: csize_t): nvgraphStatus_t {.cdecl,
    importc: "nvgraphGetEdgeData", dyn.}
##  create a new graph by extracting a subgraph given a list of vertices
##

proc nvgraphExtractSubgraphByVertex*(handle: nvgraphHandle_t;
                                    descrG: nvgraphGraphDescr_t;
                                    subdescrG: nvgraphGraphDescr_t;
                                    subvertices: ptr cint; numvertices: csize_t): nvgraphStatus_t {.
    cdecl, importc: "nvgraphExtractSubgraphByVertex", dyn.}
##  create a new graph by extracting a subgraph given a list of edges
##

proc nvgraphExtractSubgraphByEdge*(handle: nvgraphHandle_t;
                                  descrG: nvgraphGraphDescr_t;
                                  subdescrG: nvgraphGraphDescr_t;
                                  subedges: ptr cint; numedges: csize_t): nvgraphStatus_t {.
    cdecl, importc: "nvgraphExtractSubgraphByEdge", dyn.}
##  nvGRAPH Semi-ring sparse matrix vector multiplication
##

proc nvgraphSrSpmv*(handle: nvgraphHandle_t; descrG: nvgraphGraphDescr_t;
                   weight_index: csize_t; alpha: pointer; x_index: csize_t; beta: pointer;
                   y_index: csize_t; SR: nvgraphSemiring_t): nvgraphStatus_t {.cdecl,
    importc: "nvgraphSrSpmv", dyn.}
##  nvGRAPH Single Source Shortest Path (SSSP)
##  Calculate the shortest path distance from a single vertex in the graph to all other vertices.
##

proc nvgraphSssp*(handle: nvgraphHandle_t; descrG: nvgraphGraphDescr_t;
                 weight_index: csize_t; source_vert: ptr cint; sssp_index: csize_t): nvgraphStatus_t {.
    cdecl, importc: "nvgraphSssp", dyn.}
##  nvGRAPH WidestPath
##  Find widest path potential from source_index to every other vertices.
##

proc nvgraphWidestPath*(handle: nvgraphHandle_t; descrG: nvgraphGraphDescr_t;
                       weight_index: csize_t; source_vert: ptr cint;
                       widest_path_index: csize_t): nvgraphStatus_t {.cdecl,
    importc: "nvgraphWidestPath", dyn.}
##  nvGRAPH PageRank
##  Find PageRank for each vertex of a graph with a given transition probabilities, a bookmark vector of dangling vertices, and the damping factor.
##

proc nvgraphPagerank*(handle: nvgraphHandle_t; descrG: nvgraphGraphDescr_t;
                     weight_index: csize_t; alpha: pointer; bookmark_index: csize_t;
                     has_guess: cint; pagerank_index: csize_t; tolerance: cfloat;
                     max_iter: cint): nvgraphStatus_t {.cdecl,
    importc: "nvgraphPagerank", dyn.}
