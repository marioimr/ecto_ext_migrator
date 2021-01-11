import Config

config :db_migrator, DbMigrator.Repo,
  database: "db_migrator_repo",
  username: "user",
  password: "pass",
  hostname: "localhost"
