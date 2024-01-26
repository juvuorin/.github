-------------------------
-- src/MyBlog/Database.hs

{-# LANGUAGE DerivingVia #-}  
module Database where

import Interface
import Control.Monad.Reader

--newtype SqliteDb a = SqliteDb (Database.SQLite.Connection -> IO a)
newtype SqliteDb a = SqliteDb (String -> IO a)

--  deriving (Functor, Applicative, Monad) via ReaderT Database.SQLite.Connection IO
    deriving (Functor, Applicative, Monad) via ReaderT String IO

instance Database SqliteDb where
--    newUser formData = SqliteDb $ \conn -> do
--      return () 
--        ... you have the connection in scope, so now write how you'd grab a user
    getUser userId = SqliteDb $ \conn -> do
       print conn
       return (Just User {name=conn})
--        ... ditto
--    ...
--runSqlite :: Database.SQLite.Connection -> SqliteDb a -> IO a

runSqlite :: String -> SqliteDb a -> IO a
runSqlite conn (SqliteDb f) = f conn

--newtype PostgresDb a = PostgresDb (Database.PostreSQL.Connection -> IO a)
--    deriving (Functor, Applicative, Monad) via ReaderT Database.PostreSQL.Connection IO

--newtype PostgresDb a = PostgresDb (String -> IO a)
--    deriving (Functor, Applicative, Monad) via ReaderT String IO


{- instance Database SqliteDb where
    ... same deal as above

--runPostgres :: Database.PostgreSQL.Connection -> PostgresDb a -> IO a

runPostgres :: String -> PostgresDb a -> IO a
runPostgres conn (PostgresDb f) = f conn
  -}