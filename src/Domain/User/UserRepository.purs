module Domain.User.UserRepository where

import Data.Either (Either)
import Data.Maybe (Maybe)
import Domain.User.User (User)
import Effect.Aff (Aff)

type UserRepository
  = { findAll :: Aff (Either String (Array User))
    , add :: User -> Aff (Maybe String)
    }
