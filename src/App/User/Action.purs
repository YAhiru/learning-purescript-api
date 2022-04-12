module App.User.Action
  ( showUsers
  ) where

import Prelude
import Data.Either (Either(..))
import Domain.User.UserRepository (UserRepository)
import Domain.User.User (User)
import HTTPure (ResponseM, internalServerError, ok)
import Simple.JSON (writeJSON)

showUsers :: UserRepository -> ResponseM
showUsers userRepository = userRepository.findAll >>= responseShowUsers

responseShowUsers :: Either String (Array User) -> ResponseM
responseShowUsers result = case result of
  Right users -> ok $ writeJSON users
  Left e -> internalServerError $ show e
