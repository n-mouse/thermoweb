defmodule ThermowebTest do
  use ExUnit.Case
  doctest Thermoweb

  test "greets the world" do
    assert Thermoweb.hello() == :world
  end
end
