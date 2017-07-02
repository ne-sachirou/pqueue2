defmodule EnumerableTest do
  import PQueue2Test.PList2

  use ExUnit.Case, async: true
  use PropCheck

  test "Enum.count/1", do: assert 2 == [{:a, 2}, {:b, 1}] |> Enum.into(PQueue2.new) |> Enum.count

  test "Enum.member?/2 Detect it's a member", do: assert PQueue2.new |> PQueue2.put(:a) |> Enum.member?(:a)

  test "Enum.member?/2 Detect it isn't a member", do: refute PQueue2.new |> PQueue2.put(:a) |> Enum.member?(:b)

  property "into |> to_list sort collectly" do
    forall items <- list {binary(), non_neg_integer()} do
      assert items |> sort |> Enum.map(&elem(&1, 0)) == items |> Enum.into(PQueue2.new) |> Enum.to_list
    end
  end
end
