# DbMigrator

**Execute Ecto migrations from an external executable**

## Compile

```bash
mix deps.get
MIX_ENV=prod mix escript.build
```

## Use

```bash
./db_migrator -d DATABASE_NAME -u USER_NAME -p PASSWORD -h HOST -P PORT_NUMBER --path PATH_TO_THE_MIGRATIONS -D [up|down] [-s 1]
```

e.g.

```bash
./db_migrator -d qsi_search_service_dev -u postgres -p postgres -h localhost -P 5432 --path /Users/imr/work/inSite_DB_Migrations/priv/repo/ -D up
```

### Fields

**Required**

-d, --database:  database name

-u, --user:      username

-p, --password:  password

-h, --host:      host

-P, --port:      port

--path:         path to migrations (without the directory "migrations")

-D, --direction: "up" for migration, "down" for rollback


**Optional**

-s, --step:      number of migrations to execute, defaults to all for up and 1 for down