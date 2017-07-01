defmodule EnumerableTest do
  use ExUnit.Case, async: true

  test "Enum.count/1", do: assert 2 == [{:a, 2}, {:b, 1}] |> Enum.into(PQueue2.new) |> Enum.count

  test "Enum.member?/2 Detect it's a member", do: assert PQueue2.new |> PQueue2.put(:a) |> Enum.member?(:a)

  test "Enum.member?/2 Detect it isn't a member", do: refute PQueue2.new |> PQueue2.put(:a) |> Enum.member?(:b)
end
