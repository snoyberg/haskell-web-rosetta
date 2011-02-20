{-# LANGUAGE QuasiQuotes, TypeFamilies, MultiParamTypeClasses, TemplateHaskell #-}
{-# LANGUAGE OverloadedStrings #-}
import Yesod
import Yesod.Form

data Select = Select

mkYesod "Select" [$parseRoutes|
/ RootR GET POST
|]

instance Yesod Select where
    approot _ = ""

data Color = Red | Orange | Yellow | Green | Blue | Purple
    deriving (Show, Read, Eq, Enum, Bounded)

myForm = runFormDivs RootR "Tell me your favorite color" $ selectField
    (map (\x -> (x, show x)) [Red .. Purple])
    "Favorite color"
    Nothing

getRootR = do
    (_, form) <- myForm
    defaultLayout form

postRootR = do
    (res, form) <- myForm
    case res of
        FormSuccess res -> defaultLayout [$hamlet|
<h1>Your favorite color is #{show res}
|]
        _ -> defaultLayout form

main = warpDebug 8000 Select
