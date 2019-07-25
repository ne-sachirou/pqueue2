defmodule EnumerableTest do
  import PQueue2Test.PList2

  use ExUnit.Case, async: true
  use ExUnitProperties

  test "Enum.count/1",
    do: assert(2 == [{:a, 2}, {:b, 1}] |> Enum.into(PQueue2.new()) |> Enum.count())

  test "Enum.member?/2 Detect it's a member",
    do: assert(PQueue2.new() |> PQueue2.put(:a) |> Enum.member?(:a))

  test "Enum.member?/2 Detect it isn't a member",
    do: refute(PQueue2.new() |> PQueue2.put(:a) |> Enum.member?(:b))

  test "Enum.slice/3" do
    assert [:b] == [{:a, 2}, {:b, 1}] |> Enum.into(PQueue2.new()) |> Enum.slice(0, 1)
    assert [:a] == [{:a, 2}, {:b, 1}] |> Enum.into(PQueue2.new()) |> Enum.slice(1, 1)
    assert [:b, :a] == [{:a, 2}, {:b, 1}] |> Enum.into(PQueue2.new()) |> Enum.slice(0, 2)
  end

  property "into |> to_list sort collectly" do
    check all(items <- list_of({binary(), integer(0..10_000)})) do
      assert items |> sort |> Enum.map(&elem(&1, 0)) ==
               items |> Enum.into(PQueue2.new()) |> Enum.to_list()
    end
  end
end
