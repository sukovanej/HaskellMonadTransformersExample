module MockUserRepository (MockUserRepository (MockUserRepository)) where

import Control.Monad.Trans.Maybe (hoistMaybe)
import UserRepository (User (..), UserRepository (..))

data MockUserRepository = MockUserRepository

instance UserRepository MockUserRepository where
  getByUserName _ userName = hoistMaybe . return $ User userName (userName ++ "password") undefined