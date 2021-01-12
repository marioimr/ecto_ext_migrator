defmodule DbMigrator do
  @moduledoc """
  Documentation for DbMigrator.
  """

  def main(args \\ []) do
    {path, opts} =
      args
      |> parse_args()
      |> Keyword.pop(:path)

    {direction, opts} =
      opts
      |> Keyword.pop(:direction)

    {step, db_opts} =
      opts
      |> Keyword.pop(:step)

    case start_db(db_opts) do
      {:ok, _} ->
        migrate(path, direction, step)
        System.stop(0)

      _ ->
        System.stop(1)
    end
  end

  defp parse_args(args) do
    {opts, _, _} =
      args
      |> OptionParser.parse(
        strict: [
          database: :string,
          user: :string,
          password: :string,
          host: :string,
          port: :string,
          path: :string,
          direction: :string,
          step: :integer
        ],
        aliases: [
          d: :database,
          u: :user,
          p: :password,
          h: :host,
          P: :port,
          D: :direction,
          s: :step
        ]
      )

    opts
  end

  defp start_db(opts) do
    Application.put_env(:db_migrator, DbMigrator.Repo, opts)
    DbMigrator.Repo.start_link()
  end

  defp migrate(path, "down", arg) do
    opts =
      case arg do
        nil -> [step: 1]
        step -> [step: step]
      end

    Ecto.Migrator.with_repo(DbMigrator.Repo, &Ecto.Migrator.run(&1, path, :down, opts))
  end

  defp migrate(path, "up", arg) do
    opts =
      case arg do
        nil -> [all: true]
        step -> [step: step]
      end

    IO.inspect({path, "up", opts})

    # Ecto.Migrator.run(DbMigrator.Repo, path, :up, opts)
    Ecto.Migrator.with_repo(DbMigrator.Repo, &Ecto.Migrator.run(&1, path, :up, opts))
  end

  defp migrate(_, _, _) do
    raise(~s/Invalid direction, type "up" or "down"/)
  end
end
