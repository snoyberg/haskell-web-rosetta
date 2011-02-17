-- WAI is the Web Application Interface. It is a generic interface for writing
-- application which will run on numerous backends. It is designed for speed:
-- as such, it is built on top of enumerator and blaze-builder.
--
-- However, it also provides some convenience functions. To make the most of
-- WAI, it's easiest to enable OverloadedStrings.
{-# LANGUAGE OverloadedStrings #-}

-- Next we'll import WAI itself, plus Warp, the handler we will be using for
-- this example.
import Network.Wai
import Network.Wai.Handler.Warp (run)

-- And we also need to get the IsString intance for lazy ByteStrings.
import Data.ByteString.Lazy.Char8 ()

-- An application takes a request and returns a response. For this example,
-- we're going to return the same response for all requests, so we can just
-- ignore the request argument. And for simplicity, we'll use the responseLBS
-- helper function, which takes three arguments: the status, headers and body.
app _ = return $ responseLBS
    statusOK
    [("Content-Type", "text/plain")]
    "Hello World"

-- main is simply going to pass our application to Warp
main = run 8000 app
