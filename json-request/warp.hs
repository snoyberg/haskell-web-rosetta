{-# LANGUAGE OverloadedStrings #-}
import Network.Wai
import Network.Wai.Handler.Warp
import Data.Enumerator.List (consume)
import qualified Data.ByteString.Lazy as L
import Data.Maybe (fromMaybe)

main = run 8000 app

app req = do
    bss <- consume
    let ct = fromMaybe "application/json" $ lookup "content-type" $ requestHeaders req
    return $ responseLBS status200 [("Content-Type", ct)] $ L.fromChunks bss
