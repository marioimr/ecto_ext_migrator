# DbMigrator

**Execute Ecto migrations from an external executable**

## Installation

Simply run:

```bash
mix escript.build
```

## Use

```bash
./db_migrator -d DATABASE_NAME -u USER_NAME -p PASSWORD -h HOST -P PORT_NUMBER --path PATH_TO_THE_MIGRATIONS
```