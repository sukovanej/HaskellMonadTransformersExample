{-# LANGUAGE ScopedTypeVariables #-}

module Lib
  ( fetchUserPassword,
    MockUserRepository (MockUserRepository),
    User (..),
    listUserPasswords,
  )
where

import Control.Monad.Trans.Maybe (MaybeT, hoistMaybe)
import Control.Monad.Trans.Reader (ReaderT, ask)
import Control.Monad (liftM)

data User = User
  { username :: String,
    password :: String,
    age :: Int
  }

class UserRepository r where
  getByUserName :: r -> String -> MaybeT IO User

data MockUserRepository = MockUserRepository

instance UserRepository MockUserRepository where
  getByUserName _ userName = hoistMaybe . return $ User userName (userName ++ "password") undefined

fetchUserPassword :: UserRepository r => String -> ReaderT r IO (Maybe String)
fetchUserPassword userName = do
  userRepository <- ask
  user <- getByUserName userRepository userName
  return . return $ password user

listUserPasswords :: UserRepository r => [String] -> ReaderT r IO [Maybe String]
listUserPasswords = mapM fetchUserPassword
