-- Yesod uses a few extensions. You need to include the following in every file.
{-# LANGUAGE QuasiQuotes, TypeFamilies, MultiParamTypeClasses, TemplateHaskell #-}

-- Now let's import the main module.

-- In reality, the Yesod module is just a convenience module that re-exports
-- the contents from a number of other modules. If you ever want to go for a
-- more light-weight approach, you can import those directly.
import Yesod

-- Now we create our foundation datatype. This is central to all Yesod
-- applications. We don't really see its power in this example, though we will
-- in others.
data Hello = Hello

-- The following line performs some Yesod-specific magic: it creates a datatype
-- (HelloRoute) that represents all routes in our application and sets up
-- rendering and dispatch functions. In Yesod, every requested route has a
-- corresponding data value, which we call type-safe URLs.
--
-- This defines a single route in our application, which is only available for
-- GET requests.
mkYesod "Hello" [$parseRoutes|

/ RootR GET

|]

-- Every Yesod application needs a Yesod instance for storing basic settings.
-- To make changes to the defaults, just override the appropriate method.
instance Yesod Hello where
    -- approot is used in constructing URLs. It is the only method that must be
    -- defined in the Yesod typeclass.
    approot _ = ""

-- Now we define the handler function for our route. defaultLayout applies a
-- standard set of HTML to your content. You can override defaultLayout to
-- apply your own themes in the Yesod instance above.
getRootR = defaultLayout [$hamlet|Hello World|]

-- And finally run the whole thing. Yesod is built on top of WAI, so any WAI
-- handler will work, such as FastCGI or devel-server. For now, we'll use Warp
-- in debug mode.
main = warpDebug 3000 Hello
