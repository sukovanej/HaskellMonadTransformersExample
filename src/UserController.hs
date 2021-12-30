{-# LANGUAGE ScopedTypeVariables #-}

module UserController ( fetchUserPassword, listUserPasswords) where

import Control.Monad.Trans.Reader (ReaderT, ask)
import UserRepository (UserRepository(..), User(..))

fetchUserPassword :: UserRepository r => String -> ReaderT r (MaybeT IO) String
fetchUserPassword userName = do
  userRepository <- ask
  user <- getByUserName userRepository userName
  return . return $ password user

listUserPasswords :: UserRepository r => [String] -> ReaderT r IO [Maybe String]
listUserPasswords = mapM fetchUserPassword
