This repository is intended to hold a number of examples of simple web
programming tasks using different libraries and frameworks in Haskell. This
serves a dual purpose:

* A nice place to get quick tutorials.

* An easy way to compare different approaches.

Each folder should be a separate type of sample, and each file in that folder
should perform the same task in the specified framework. For example,
hello-world/yesod.hs will be Yesod's Hello World.

In general, favor comprehension over terseness: we're not playing golf here.
And the more comments, the better. Whenever possible, each sample should be a
stand-alone file which launches a web server on port 8000.

For now, don't bother with cabal files, though if there are uncommon
dependencies, mention the package they come from.
