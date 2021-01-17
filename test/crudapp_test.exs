defmodule CrudappTest do
  use ExUnit.Case
  doctest Crudapp

  test "greets the world" do
    assert Crudapp.hello() == :world
  end
end
