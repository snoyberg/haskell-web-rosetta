module Main where

import Control.Monad.Trans (MonadIO(liftIO))
import Data.IORef
import Happstack.Server

counter :: IORef Int -> ServerPart String
counter ctr =
    do methodM GET -- only respond if it is a GET to /
       i <- liftIO $ atomicModifyIORef ctr (\i -> (i + 1, i + 1))
       ok $ "You are visitor number " ++ show i

main = 
    do ctr <- newIORef 0 
       simpleHTTP nullConf (counter ctr)
