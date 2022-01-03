module Main where

import Control.Monad.Trans.Reader (ReaderT (runReaderT))
import Data.List (intercalate)
import Data.Maybe (fromMaybe)
import MockUserRepository (MockUserRepository (..))
import UserController (listUserPasswords)

displayPasswords :: [Maybe String] -> String
displayPasswords = intercalate "\n" . map (fromMaybe "Password not found")

main :: IO ()
main = do
  let userNames = ["Milan", "Peter", "Alena", "Kokot"]
  let userRepository = MockUserRepository

  maybePasswords <- runReaderT (listUserPasswords userNames) userRepository
  putStrLn $ displayPasswords maybePasswords
