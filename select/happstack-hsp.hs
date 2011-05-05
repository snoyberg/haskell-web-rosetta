{-# OPTIONS_GHC -F -pgmFtrhsx #-}
{-# LANGUAGE FlexibleContexts #-}
-- | demo of creating a select boxes using happstack+HSP+digestive-functors
--
-- requires libraries:
-- 
--  digestive-functors-hsp        >= 0.4.1
--  digestive-functors-happstack  >= 0.1
--  happstack-hsp                 >= 6.0
--  happstack-server              >= 6.0
--
module Main where

import Control.Applicative
import Happstack.Server
import Happstack.Server.HSP.HTML
import HSP.ServerPartT
import Text.Digestive
import Text.Digestive.Forms.Happstack
import Text.Digestive.HSP.Html4
import qualified HSX.XMLGenerator as HSX

type ServerPartForm a = HappstackForm (ServerPartT IO) String [XMLGenT (ServerPartT IO) XML] a

data Color = Red | Orange | Yellow | Green | Blue | Purple
    deriving (Show, Read, Eq, Enum, Bounded)

-- |a 'Form' (using digestive-functors) which returns a 'Color'
colorForm :: ServerPartForm Color
colorForm =
    label "Favorite Color" ++> 
          inputSelect Red [ (c, show c) | c <- [minBound .. maxBound]] <*
    submit "Tell me your favorite color"

-- |a handler which uses 'colorForm'
select :: ServerPart XML
select =
    do r <- eitherHappstackForm colorForm "color-form" 
       case r of
         -- display the form (including validation errors, if any)
         (Left xml) -> 
             defaultTemplate "Favorite Color" () (form "/" xml)
         -- use the result of the form
         (Right color) ->
             defaultTemplate "Favorite Color" () 
               <h1>Your favorite color is <% show color %></h1>

main :: IO ()
main = simpleHTTP nullConf $ do decodeBody (defaultBodyPolicy "/tmp/" 0 1000 1000)
                                select
