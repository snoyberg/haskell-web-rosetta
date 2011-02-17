#!/usr/bin/env runhaskell
{-# LANGUAGE TypeFamilies, QuasiQuotes #-}
-- A github post-receive hook handler, runs some shell command on each HTTP POST to PORT.                                                                                                                                                   
-- yesod.hs PORT 'SOME SHELL COMMAND'                                                                                                                                                                                             

import System.Environment (getArgs)
import System.Process (system)
import Yesod

data App = App {cmd∷String}
mkYesod "App" [$parseRoutes|
/ Home POST
|]
instance Yesod App where approot _ = ""

postHome = do
  app ← getYesod
  liftIO $ do
    putStrLn $ "Received POST, running: " ++ cmd app
    system $ cmd app
  defaultLayout [$hamlet|ok|]

main = do
  port:cmd:_ ← getArgs
  basicHandler (read port) App{cmd=cmd}
