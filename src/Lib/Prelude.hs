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

module Lib.Prelude
    ( module Exports
    , both

    , format
    , formatBS
    ) where

import           Protolude as Exports

import           Data.Time as Exports (UTCTime(..), diffUTCTime)
import           Control.Monad.Trans.Maybe as Exports (runMaybeT, MaybeT(..))

import           Control.Monad.Catch as Exports (throwM, MonadThrow, MonadCatch)

import           Data.Text.Format as Exports (Shown(..))
import qualified Data.Text.Format as TF
import           Data.Text.Format.Params (Params)

format :: Params ps => TF.Format -> ps -> Text
format f args = toS $ TF.format f args

formatBS :: Params ps => TF.Format -> ps -> ByteString
formatBS f args = toS $ TF.format f args

-- import Data.Tuple as Exports (uncurry)

-- | Apply a function on both elements of a pair
both :: (a -> b) -> (a, a) -> (b, b)
both f (a, b) = (f a, f b)
