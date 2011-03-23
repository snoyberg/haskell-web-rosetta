{-# LANGUAGE QuasiQuotes, TypeFamilies, MultiParamTypeClasses, TemplateHaskell #-}
import Yesod
import qualified Data.ByteString.Lazy as L
import Data.Enumerator.List (consume)

data App = App

mkYesod "App" [$parseRoutes|
/ RootR PUT
|]

instance Yesod App where
    approot _ = ""

putRootR = do
    bss <- lift consume
    return $ RepJson $ toContent $ L.fromChunks bss

main = warpDebug 8000 App
