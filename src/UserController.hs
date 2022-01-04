{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}

module UserController (fetchUserPassword, listUserPasswords) where

import Control.Monad.Trans.Class (lift)
import Control.Monad.Trans.Maybe (MaybeT (runMaybeT))
import Control.Monad.Trans.Reader (ReaderT, ask, asks)
import Data.Functor ((<&>))
import UserRepository (User (..), UserRepository (..), UserRepositoryReaderT)

fetchUserPassword :: String -> UserRepositoryReaderT IO (Maybe String)
fetchUserPassword userName = do
  userRepository <- ask
  user <- lift $ getByUserName userRepository userName
  return $ user <&> password

listUserPasswords :: [String] -> UserRepositoryReaderT IO [Maybe String]
listUserPasswords = mapM fetchUserPassword