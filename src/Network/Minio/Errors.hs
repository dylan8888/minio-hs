--
-- Minio Haskell SDK, (C) 2017 Minio, Inc.
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
--

module Network.Minio.Errors where

import           Control.Exception
import qualified Network.HTTP.Conduit as NC

import           Lib.Prelude


---------------------------------
-- Errors
---------------------------------
-- | Various validation errors
data MErrV = MErrVSinglePUTSizeExceeded Int64
           | MErrVPutSizeExceeded Int64
           | MErrVETagHeaderNotFound
           | MErrVInvalidObjectInfoResponse
           | MErrVInvalidSrcObjSpec Text
           | MErrVInvalidSrcObjByteRange (Int64, Int64)
           | MErrVCopyObjSingleNoRangeAccepted
           | MErrVRegionNotSupported Text
           | MErrXmlParse Text
  deriving (Show, Eq)

instance Exception MErrV

-- | Errors returned by S3 compatible service
data ServiceErr = BucketAlreadyExists
                | NoSuchBucket
  deriving (Show, Eq)

instance Exception ServiceErr

-- | Errors thrown by the library
data MinioErr = MErrHTTP NC.HttpException
              | MErrIO IOException
              | MErrService ServiceErr
              | MErrValidation MErrV
  deriving (Show)

instance Eq MinioErr where
  MErrHTTP _       == MErrHTTP _        = True
  MErrHTTP _       ==  _                = False
  MErrIO _         == MErrIO _          = True
  MErrIO _         == _                 = False
  MErrService a    == MErrService b     = a == b
  MErrService _    == _                 = False
  MErrValidation a == MErrValidation b  = a == b
  MErrValidation _ == _                 = False

instance Exception MinioErr
