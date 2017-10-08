defmodule CollectableTest do
  use ExUnit.Case, async: true

  test "Collect values",
    do: assert [:b, :c, :a, :d] == [{:a, 2}, {:b, 1}, {:c, 1}, {:d, 2}] |> Enum.into(PQueue2.new) |> Enum.to_list

  test "Collect values into the queue" do
    queue = PQueue2.put PQueue2.new, :a, 2
    assert [:b, :c, :a, :d] == [{:b, 1}, {:c, 1}, {:d, 2}] |> Enum.into(queue) |> Enum.to_list
  end
end
