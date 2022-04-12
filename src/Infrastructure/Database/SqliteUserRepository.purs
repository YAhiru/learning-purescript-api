module Infrastructure.Database.SqliteUserRepository
  ( mkUserRepository
  ) where

import Prelude
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Domain.User.User (User)
import Domain.User.UserRepository (UserRepository)
import Effect.Aff (Aff)
import Foreign (unsafeToForeign)
import SQLite3 (DBConnection, queryDB)
import Simple.JSON (read)

mkUserRepository :: DBConnection -> UserRepository
mkUserRepository conn =
  { findAll: findAll conn
  , add: add conn
  }

type UserRow
  = { id :: Int
    , firstName :: String
    , lastName :: String
    }

type ErrorMessage
  = String

findAll :: DBConnection -> Aff (Either String (Array User))
findAll conn = do
  result <- read <$> queryDB conn "SELECT id, firstName, lastName FROM users ORDER BY id;" []
  pure
    $ case result of
        Right (rows :: Array UserRow) -> Right $ (\r -> r) <$> rows
        Left e -> Left $ show e

add :: DBConnection -> User -> Aff (Maybe ErrorMessage)
add conn u = do
  _ <- queryDB conn "INSERT INTO `users` (`id`, `firstName`, `lastName`) VALUES (?, ?, ?))" $ unsafeToForeign <$> [ (show u.id), u.firstName, u.lastName ]
  pure Nothing
