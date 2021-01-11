defmodule DbMigratorTest do
  use ExUnit.Case
  doctest DbMigrator

  test "greets the world" do
    assert DbMigrator.hello() == :world
  end
end
