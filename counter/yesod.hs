{-# LANGUAGE QuasiQuotes, TypeFamilies, MultiParamTypeClasses, TemplateHaskell #-}
import Yesod

-- We can use IORef instead of MVar if we stick to the atomic operations.
import Data.IORef

data Counter = Counter (IORef Int)

mkYesod "Counter" [$parseRoutes|
/ RootR GET
|]

instance Yesod Counter where
    approot _ = ""

getRootR = do
    Counter inum <- getYesod
    current <- liftIO $ atomicModifyIORef inum (\i -> (i + 1, i + 1))
    defaultLayout [$hamlet|<p>You are visitor number #{show current}|]

main = newIORef 0 >>= warpDebug 3000 . Counter
