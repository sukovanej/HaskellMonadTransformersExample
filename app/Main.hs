module Main where

import Data.Maybe
import Lib

main :: IO ()
main = do
  let userRepository = MockUserRepository
  userPassword <- fetchUserPassword userRepository "Milan"
  putStrLn $ fromMaybe "Password not found" userPassword
