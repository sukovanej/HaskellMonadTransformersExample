module UserRepository (UserRepository(..), User (..)) where

import Control.Monad.Trans.Maybe (MaybeT, hoistMaybe)

data User = User
  { username :: String,
    password :: String,
    age :: Int
  }

class UserRepository r where
  getByUserName :: r -> String -> MaybeT IO User