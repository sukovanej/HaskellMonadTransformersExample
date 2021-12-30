{-# LANGUAGE ScopedTypeVariables #-}

module Lib
    ( fetchUserPassword
    , MockUserRepository (MockUserRepository)
    , User (..)
    , listUserPasswords
    ) where

import           Control.Monad.Reader

data User = User { username :: String
                 , password :: String
                 , age      :: Int
                 }

class UserRepository r where
  getByUserName :: r -> String -> IO (Maybe User)

data MockUserRepository = MockUserRepository

instance UserRepository MockUserRepository where
  getByUserName _ userName = (return . return) $ User userName (userName ++ "password") undefined

fetchUserPassword :: UserRepository r => String -> ReaderT r IO (Maybe String)
fetchUserPassword userName = do
  userRepository <- ask
  maybeUser :: Maybe User <- lift $ getByUserName userRepository userName
  return $ case maybeUser of
    Just user -> Just $ password user
    Nothing   -> Nothing

listUserPasswords :: UserRepository r => [String] -> ReaderT r IO [Maybe String]
listUserPasswords = mapM fetchUserPassword
