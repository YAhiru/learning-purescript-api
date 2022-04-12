module Main where

import Prelude
import App.User.Action (showUsers)
import Data.Posix.Signal (Signal(..))
import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Class (liftEffect)
import Effect.Console (log)
import HTTPure (Request, ResponseM, notFound, serve)
import Infrastructure.Database.SqliteUserRepository (mkUserRepository)
import Node.Process (onSignal)
import SQLite3 (DBConnection, closeDB, newDB)

router :: DBConnection -> Request -> ResponseM
router conn { path: [ "users" ] } = showUsers $ mkUserRepository conn

router _ _
  | otherwise = notFound

main :: Effect Unit
main =
  launchAff_ do
    conn <- newDB "./var/db.sqlite3"
    liftEffect do
      closingHandler <- serve 8080 (router conn) $ log "Server now up on port 8080"
      onSignal SIGINT $ closingHandler
        $ do
            launchAff_ do
              closeDB conn
            log "Received SIGINT, stopping service now."
      onSignal SIGTERM $ closingHandler
        $ do
            launchAff_ do
              closeDB conn
            log "Received SIGTERM, stopping service now."
