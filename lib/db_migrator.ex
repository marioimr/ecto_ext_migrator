defmodule DbMigrator do
  @moduledoc """
  Documentation for DbMigrator.
  """

  def main(args \\ []) do
    {direction, opts} =
      args
      |> parse_args()
      |> Keyword.pop(:direction)

    {step, db_opts} =
      opts
      |> Keyword.pop(:step)

    case start_db(db_opts) do
      {:ok, _} ->
        migrate(direction, step)
        System.stop(0)

      _ ->
        System.stop(1)
    end
  end

  def parse_args(args) do
    {opts, _, _} =
      args
      |> OptionParser.parse(
        strict: [
          database: :string,
          user: :string,
          password: :string,
          host: :string,
          port: :string,
          priv: :string,
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

  def start_db(opts) do
    Application.put_env(:db_migrator, DbMigrator.Repo, opts)
    DbMigrator.Repo.start_link()
  end

  def migrate("down", arg) do
    opts =
      case arg do
        nil -> [step: 1]
        step -> [step: step]
      end

    Ecto.Migrator.with_repo(DbMigrator.Repo, &Ecto.Migrator.run(&1, :down, opts))
  end

  def migrate("up", arg) do
    opts =
      case arg do
        nil -> [all: true]
        step -> [step: step]
      end

    Ecto.Migrator.with_repo(DbMigrator.Repo, &Ecto.Migrator.run(&1, :up, opts))
  end

  def migrate(_, _) do
    raise(~s/Invalid direction, pass "-d up" or "-d down"/)
  end
end
