module Main where

import           Control.Monad.Reader
import           Data.List            (intercalate)
import           Data.Maybe
import           Lib

main :: IO ()
main = do
  let userNames = ["Milan", "Peter", "Alena", "Kokot"]
  let userRepository = MockUserRepository

  maybePasswords <- runReaderT (listUserPasswords userNames) userRepository
  putStrLn $ intercalate "\n" $ map (fromMaybe "Password not found") maybePasswords
