
--------------------
-- src/MyBlog/App.hs
module App where

import Interface

app :: (Database m, Monad m) => m ()
app = do
    user <- getUser 1 
    return ()

  
--    ... whatever your app logic needs to do

 