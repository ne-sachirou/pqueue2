defmodule InspectTest do
  use ExUnit.Case, async: true

  test "Inspect", do: assert PQueue2.new |> PQueue2.put(:value) |> inspect

  test "Inspect a new queue", do: assert inspect PQueue2.new
end
