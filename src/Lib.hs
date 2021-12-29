module Lib
    ( fetchUserPassword
    , MockUserRepository (MockUserRepository)
    , User (..)
    , listUserPasswords
    ) where

data User = User { username :: String
                 , password :: String
                 , age      :: Int
                 }

class UserRepository r where
  getByUserName :: r -> String -> IO (Maybe User)

data MockUserRepository = MockUserRepository

instance UserRepository MockUserRepository where
  getByUserName _ userName = (return . return) $ User userName (userName ++ "password") undefined

fetchUserPassword :: UserRepository r => r -> String -> IO (Maybe String)
fetchUserPassword userRepository userName = do
  maybeUser <- getByUserName userRepository userName
  return $ case maybeUser of
    Just user -> Just $ password user
    Nothing -> Nothing

listUserPasswords :: UserRepository r => r -> [String] -> IO [Maybe String]
listUserPasswords userRepository = mapM $ fetchUserPassword userRepository