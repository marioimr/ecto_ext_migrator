defmodule DbMigrator do
  @moduledoc """
  Documentation for DbMigrator.
  """

  def main(args \\ []) do
    {path, db_opts} =
      args
      |> parse_args()
      |> Keyword.pop(:path)

    case start_db(db_opts) do
      {:ok, _} ->
        migrate(path)
        System.stop(0)

      _ ->
        System.stop(1)
    end
  end

  defp parse_args(args) do
    {opts, _, _} =
      args
      |> OptionParser.parse(
        switches: [
          database: :string,
          user: :string,
          password: :string,
          host: :string,
          port: :string,
          path: :string
        ],
        aliases: [d: :database, u: :user, p: :password, h: :host, P: :port]
      )

    opts
  end

  defp start_db(opts) do
    Application.put_env(:db_migrator, DbMigrator.Repo, opts)
    DbMigrator.Repo.start_link()
  end

  defp migrate(path) do
    Ecto.Migrator.run(DbMigrator.Repo, path, :up, all: true)
  end
end
