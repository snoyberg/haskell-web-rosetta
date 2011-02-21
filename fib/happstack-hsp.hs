-- | NOTE: requires the optional happstack-hsp >= 6.0.1 package.
{-# LANGUAGE FlexibleContexts, TypeFamilies #-}
{-# OPTIONS_GHC -F -pgmFtrhsx #-}
module Main where

import Control.Monad    (msum)
import Happstack.Server (ServerPartT, ServerPart, badRequest, dir, nullConf, path, ok, simpleHTTP)
import Happstack.Server.HSP.HTML

fib :: Int -> Integer
fib i = fibs !! (i - 1)
    where
      fibs = 1 : 1 : zipWith (+) fibs (tail fibs)

homePage :: ServerPart XML
homePage =
    defaultTemplate "Fibonacci - Homepage" () 
         <p>Welcome to the Fibonacci number web site. 
            Why not start off with <a href="/fib/5">number 5</a></p>

fibPage :: Int -> ServerPart XML
fibPage num
    | num <= 0 = 
        badRequest =<< defaultTemplate ("Fibonacci - " ++ show num) ()
                       <p>Parameter must be a natural number</p>

    | num > 100 =
        badRequest =<< defaultTemplate ("Fibonacci - " ++ show num) ()
                       <p>Let's not get ahead of ourselves here</p>

    | otherwise =
        ok =<< defaultTemplate ("Fibonacci - " ++ show num) ()
               <div>
                <p>The Fibonacci number at position <% num %> is <% fib num %>.</p>
                <p><% if num > 1
                      then [<a href=("/fib/" ++ show (pred num))>Previous</a>]
                      else [] 
                    %> <a href=("/fib/" ++ show (succ num))>Next</a></p>
               </div>

routes :: ServerPartT IO XML
routes =
    msum [ dir "fib" $ path fibPage
         , homePage
         ]

main = simpleHTTP nullConf routes
