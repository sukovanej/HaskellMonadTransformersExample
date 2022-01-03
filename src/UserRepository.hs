{-# LANGUAGE RankNTypes #-}

module UserRepository (UserRepository (..), User (..), UserRepositoryReaderT) where

import Control.Monad.Trans.Maybe (MaybeT, hoistMaybe)
import Control.Monad.Trans.Reader (ReaderT)

data User = User {username :: String, password :: String, age :: Int}

class UserRepository r where
  getByUserName :: r -> String -> MaybeT IO User

type UserRepositoryReaderT m a = forall r. UserRepository r => ReaderT r m a