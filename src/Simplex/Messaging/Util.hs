module Simplex.Messaging.Util where

import Control.Monad (void)
import Control.Monad.IO.Unlift
import UnliftIO.Async

raceAny_ :: MonadUnliftIO m => [m a] -> m ()
raceAny_ = r []
  where
    r as (m : ms) = withAsync m $ \a -> r (a : as) ms
    r as [] = void $ waitAnyCancel as
