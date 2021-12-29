module Main where

import Data.List (intercalate)
import Data.Maybe
import Lib

main :: IO ()
main = do
  let userRepository = MockUserRepository
  let userNames = ["Milan", "Peter", "Alena", "Kokot"]
  userPasswords <- listUserPasswords userRepository userNames
  putStrLn $ intercalate "\n" $ map (fromMaybe "Password not found") userPasswords
