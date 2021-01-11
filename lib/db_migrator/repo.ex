defmodule DbMigrator.Repo do
  use Ecto.Repo,
    otp_app: :db_migrator,
    adapter: Ecto.Adapters.Postgres
end
