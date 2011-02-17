module Main where

import Happstack.Server

-- | start the server on port 8000
-- respond to any incoming request with: 200 OK, "Hello World"
--
-- This example is explained in detail here:
--
--   <http://www.happstack.com/docs/crashcourse/HelloWorld.html>
--
main = simpleHTTP nullConf $ ok "Hello World"

-- brief overview:
-- 
-- > ok         :: (FilterMonad Response m) => a -> m a
--
-- 'ok' is a similar to 'return', except it also adds a filter 
-- which will set the http response code to 200 OK. There are similar 
-- functions for other responses such as 'notFound', 'seeOther', etc.
--
-- > simpleHTTP :: (ToMessage a) => Conf -> ServerPartT IO a -> IO ()
-- 
-- The 'ToMessage' class turns a value into a 'Response'. This
-- includes setting the 'Content-Type'. For 'String' the content-type
-- is 'text/plain; charset=UTF-8'. There are instances for many other 
-- types including Text, blaze-html, and more.

