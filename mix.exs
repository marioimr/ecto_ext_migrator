defmodule DbMigrator.MixProject do
  use Mix.Project

  def project do
    [
      app: :db_migrator,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: escript()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto_sql, git: "https://github.com/marioanticoli/ecto_sql"},
      {:postgrex, ">= 0.0.0"},
      {:jason, "~> 1.2"}
    ]
  end

  defp escript do
    [main_module: DbMigrator]
  end
end
