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

when not defined(SURFACE_TYPES_H):
  const
    SURFACE_TYPES_H* = true
  ## ******************************************************************************
  ##                                                                               *
  ##                                                                               *
  ##                                                                               *
  ## *****************************************************************************
  import
    driver_types

  ## *
  ##  \addtogroup CUDART_TYPES
  ## 
  ##  @{
  ## 
  ## ******************************************************************************
  ##                                                                               *
  ##                                                                               *
  ##                                                                               *
  ## *****************************************************************************
  const
    cudaSurfaceType1D* = 0x00000001
    cudaSurfaceType2D* = 0x00000002
    cudaSurfaceType3D* = 0x00000003
    cudaSurfaceTypeCubemap* = 0x0000000C
    cudaSurfaceType1DLayered* = 0x000000F1
    cudaSurfaceType2DLayered* = 0x000000F2
    cudaSurfaceTypeCubemapLayered* = 0x000000FC
  ## *
  ##  CUDA Surface boundary modes
  ## 
  type
    cudaSurfaceBoundaryMode* = enum
      cudaBoundaryModeZero = 0, ## *< Zero boundary mode
      cudaBoundaryModeClamp = 1, ## *< Clamp boundary mode
      cudaBoundaryModeTrap = 2
  ## *
  ##  CUDA Surface format modes
  ## 
  type
    cudaSurfaceFormatMode* = enum
      cudaFormatModeForced = 0, ## *< Forced format mode
      cudaFormatModeAuto = 1
  ## *
  ##  CUDA Surface reference
  ## 
  type
    surfaceReference* = object
      channelDesc*: cudaChannelFormatDesc ## *
                                        ##  Channel descriptor for surface reference
                                        ## 
    
  ## *
  ##  An opaque value that represents a CUDA Surface object
  ## 
  type
    cudaSurfaceObject_t* = culonglong
  ## * @}
  ## * @}
  ##  END CUDART_TYPES