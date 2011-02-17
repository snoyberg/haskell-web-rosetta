#!/usr/bin/env runhaskell
-- A github post-receive hook handler, runs some shell command on each HTTP POST to PORT.                                                                                                                                                   
-- happstack.hs PORT 'SOME SHELL COMMAND'                                                                                                                                                                                             

import Control.Monad.Trans (liftIO)
import System.Environment (getArgs)
import System.Process (system)
import Happstack.Server

post cmd = do
  methodM POST
  liftIO $ do putStrLn $ "Received POST, running: " ++ cmd
              system cmd
  ok "ok"

main = do
  port:cmd:_ ← getArgs
  simpleHTTP nullConf {port=read port} (post cmd)
