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

when not defined(TEXTURE_TYPES_H):
  const
    TEXTURE_TYPES_H* = true
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
    cudaTextureType1D* = 0x00000001
    cudaTextureType2D* = 0x00000002
    cudaTextureType3D* = 0x00000003
    cudaTextureTypeCubemap* = 0x0000000C
    cudaTextureType1DLayered* = 0x000000F1
    cudaTextureType2DLayered* = 0x000000F2
    cudaTextureTypeCubemapLayered* = 0x000000FC
  ## *
  ##  CUDA texture address modes
  ## 
  type
    cudaTextureAddressMode* = enum
      cudaAddressModeWrap = 0,  ## *< Wrapping address mode
      cudaAddressModeClamp = 1, ## *< Clamp to edge address mode
      cudaAddressModeMirror = 2, ## *< Mirror address mode
      cudaAddressModeBorder = 3
  ## *
  ##  CUDA texture filter modes
  ## 
  type
    cudaTextureFilterMode* = enum
      cudaFilterModePoint = 0,  ## *< Point filter mode
      cudaFilterModeLinear = 1
  ## *
  ##  CUDA texture read modes
  ## 
  type
    cudaTextureReadMode* = enum
      cudaReadModeElementType = 0, ## *< Read texture as specified element type
      cudaReadModeNormalizedFloat = 1
  ## *
  ##  CUDA texture reference
  ## 
  type
    textureReference* = object
      normalized*: cint ## *
                      ##  Indicates whether texture reads are normalized or not
                      ## 
      ## *
      ##  Texture filter mode
      ## 
      filterMode*: cudaTextureFilterMode ## *
                                       ##  Texture address mode for up to 3 dimensions
                                       ## 
      addressMode*: array[3, cudaTextureAddressMode] ## *
                                                  ##  Channel descriptor for the texture reference
                                                  ## 
      channelDesc*: cudaChannelFormatDesc ## *
                                        ##  Perform sRGB->linear conversion during texture read
                                        ## 
      sRGB*: cint              ## *
                ##  Limit to the anisotropy ratio
                ## 
      maxAnisotropy*: cuint    ## *
                          ##  Mipmap filter mode
                          ## 
      mipmapFilterMode*: cudaTextureFilterMode ## *
                                             ##  Offset applied to the supplied mipmap level
                                             ## 
      mipmapLevelBias*: cfloat ## *
                             ##  Lower end of the mipmap level range to clamp access to
                             ## 
      minMipmapLevelClamp*: cfloat ## *
                                 ##  Upper end of the mipmap level range to clamp access to
                                 ## 
      maxMipmapLevelClamp*: cfloat
      cudaReserved*: array[15, cint]

  ## *
  ##  CUDA texture descriptor
  ## 
  type
    cudaTextureDesc* = object
      addressMode*: array[3, cudaTextureAddressMode] ## *
                                                  ##  Texture address mode for up to 3 dimensions
                                                  ## 
      ## *
      ##  Texture filter mode
      ## 
      filterMode*: cudaTextureFilterMode ## *
                                       ##  Texture read mode
                                       ## 
      readMode*: cudaTextureReadMode ## *
                                   ##  Perform sRGB->linear conversion during texture read
                                   ## 
      sRGB*: cint              ## *
                ##  Texture Border Color
                ## 
      borderColor*: array[4, cfloat] ## *
                                  ##  Indicates whether texture reads are normalized or not
                                  ## 
      normalizedCoords*: cint  ## *
                            ##  Limit to the anisotropy ratio
                            ## 
      maxAnisotropy*: cuint    ## *
                          ##  Mipmap filter mode
                          ## 
      mipmapFilterMode*: cudaTextureFilterMode ## *
                                             ##  Offset applied to the supplied mipmap level
                                             ## 
      mipmapLevelBias*: cfloat ## *
                             ##  Lower end of the mipmap level range to clamp access to
                             ## 
      minMipmapLevelClamp*: cfloat ## *
                                 ##  Upper end of the mipmap level range to clamp access to
                                 ## 
      maxMipmapLevelClamp*: cfloat

  ## *
  ##  An opaque value that represents a CUDA texture object
  ## 
  type
    cudaTextureObject_t* = culonglong
  ## * @}
  ## * @}
  ##  END CUDART_TYPES