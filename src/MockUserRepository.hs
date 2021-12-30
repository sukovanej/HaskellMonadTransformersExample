module MockUserRepository (MockUserRepository (MockUserRepository)) where

import UserRepository (UserRepository)

data MockUserRepository = MockUserRepository

instance UserRepository MockUserRepository where
  getByUserName _ userName = hoistMaybe . return $ User userName (userName ++ "password") undefined