-- | NOTE: requires optional package happstack-hsp >= 6.0.1
{-# LANGUAGE ScopedTypeVariables #-}
{-# OPTIONS_GHC -F -pgmFtrhsx #-}
module Main where

import Happstack.Server
import Happstack.Server.HSP.HTML

bigTable :: ServerPart XML
bigTable =
    defaultTemplate "BigTable" ()
     <table>
      <% [ <tr>
             <th><% row %></th>
             <% [<td><% col %></td> | col <- cols ] %>
           </tr> 
           | row <- rows ] 
       %>
     </table>
    where
      rows, cols :: [Int]
      rows = [1..10]
      cols = [1..10]

main = simpleHTTP nullConf bigTable