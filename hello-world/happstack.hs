module Main where

import Happstack.Server

-- start the server on port 8000
-- respond to any incoming request with: 200 OK, "Hello World"
main = simpleHTTP nullConf (ok "Hello World")
