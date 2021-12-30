module Main where

import           Control.Monad.Reader
import           Data.List            (intercalate)
import           Data.Maybe
import           UserController       (listUserPasswords)
import           MockUserRepository   (MockUserRepository)

displayPasswords :: [Maybe String] -> String
displayPasswords = intercalate "\n" $ map (fromMaybe "Password not found")

main :: IO ()
main = do
  let userNames = ["Milan", "Peter", "Alena", "Kokot"]
  let userRepository = MockUserRepository

  maybePasswords <- runReaderT (listUserPasswords userNames) userRepository
  putStrLn $ displayPasswords maybePasswords
