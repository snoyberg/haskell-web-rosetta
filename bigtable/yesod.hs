{-# LANGUAGE QuasiQuotes, TypeFamilies, MultiParamTypeClasses, TemplateHaskell #-}
import Yesod

data BigTable = BigTable

mkYesod "BigTable" [$parseRoutes|
/ RootR GET
|]

instance Yesod BigTable where
    approot _ = ""

getRootR = defaultLayout [$hamlet|
<table
    $forall row <- rows
        <tr
            <th>#{show row}
            $forall col <- cols
                <td>#{show col}
|]
  where
    rows = [1..10]
    cols = [1..10]

main = warpDebug 3000 BigTable
