{-# LANGUAGE QuasiQuotes, TypeFamilies, MultiParamTypeClasses, TemplateHaskell #-}
import Yesod

data Fib = Fib

mkYesod "Fib" [$parseRoutes|
/ RootR GET
/fib/#Int FibR GET
|]

instance Yesod Fib where
    approot _ = ""

getRootR = defaultLayout [$hamlet|
<p>
    Welcome to the Fibonacci number web site. Why not start off with #
    <a href=@{FibR 5}>number 5
|]

getFibR num
    | num <= 0 = invalidArgs ["Parameter must be a natural number"]
    | num > 100 = invalidArgs ["Let's not get ahead of ourselves here"]
    | otherwise = defaultLayout [$hamlet|
<p>The Fibonacci number at position #{show num} is #{show $ fib num}.
<p>
    $if (>) num 1
        <a href=@{FibR $ (-) num 1}>Previous
        \ #
    <a href=@{FibR $ (+) num 1}>Next
|]

fib i = fibs !! (i - 1)
fibs = 1 : 1 : zipWith (+) fibs (tail fibs)

main = warpDebug 3000 Fib
