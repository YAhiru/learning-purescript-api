# setup

```bash
$ npm ci
$ npx spago build
$ touch ./var/db.sqlite3
$ sqlite3 ./var/db.sqlite3 < ./sql/init.sql
```

# run

```bash
$ npx spago run
```

# endpoints

## all users

```bash
$ curl -X GET http://localhost:8080/users/
```

## add user

WIP

## update user

WIP

## delete user

WIP
