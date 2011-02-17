#!/usr/bin/env runhaskell
-- A github post-receive hook handler, runs some shell command on each HTTP POST to PORT.                                                                                                                                                  $
-- snap.hs -p PORT 'SOME SHELL COMMAND'                                                                                                                                                                                    $

import Control.Monad.Trans (liftIO)
import Snap.Http.Server (quickHttpServe)
import System.Environment (getArgs)
import System.Process (system)

post cmd = do
  liftIO $ do
    putStrLn $ "Received POST, running: " ++ cmd
    system cmd
  return ∅

main = do
  cmd ← getCmd
  quickHttpServe $ post cmd
    where
      getCmd = do
         args ← getArgs
         return $ case args of
                    "-p":_:cmd:_     → cmd
                    "--port":_:cmd:_ → cmd
                    otherwise        → case head args of
                                         '-':_ → args ‼ 1
                                         otherwise → head args
