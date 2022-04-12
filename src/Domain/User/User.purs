module Domain.User.User where

import Prelude

type User
  = { id :: Int
    , firstName :: String
    , lastName :: String
    }

fullName :: User -> String
fullName u = u.firstName <> " " <> u.lastName
