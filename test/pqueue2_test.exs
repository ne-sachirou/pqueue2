defmodule PQueue2Test do
  import PQueue2Test.PList2

  use ExUnit.Case, async: true
  use ExUnitProperties

  doctest PQueue2

  describe "new/0" do
    test "Create a queue", do: assert(%PQueue2{} = PQueue2.new())
  end

  describe "empty?/1" do
    test "Is empty a new queue", do: assert(PQueue2.empty?(PQueue2.new()))

    test "Isn't empty after put",
      do: refute(PQueue2.new() |> PQueue2.put(:value) |> PQueue2.empty?())

    test "Is empty after pop" do
      {_, queue} = PQueue2.new() |> PQueue2.put(:value) |> PQueue2.pop()
      assert PQueue2.empty?(queue)
    end
  end

  describe "count/1" do
    test "Is 0 for a new queue", do: assert(0 == PQueue2.count(PQueue2.new()))

    test "Is 1 after put",
      do: assert(1 == PQueue2.new() |> PQueue2.put(:value) |> PQueue2.count())
  end

  describe "put/3" do
    test "Put", do: assert(%PQueue2{} = PQueue2.put(PQueue2.new(), :value, 0))

    test "Put with a default priority",
      do: assert(%PQueue2{} = PQueue2.put(PQueue2.new(), :value))
  end

  describe "pop/2" do
    test "Pop",
      do: assert({:value, %PQueue2{}} = PQueue2.new() |> PQueue2.put(:value) |> PQueue2.pop())

    test "Pop from an empty queue",
      do: assert({:empty, %PQueue2{}} = PQueue2.pop(PQueue2.new(), :empty))

    test "Pop from an empty queue a with default value",
      do: assert({nil, %PQueue2{}} = PQueue2.pop(PQueue2.new()))
  end

  describe "pop_with_priority/2" do
    test "Pop",
      do:
        assert(
          {{:value, 1}, %PQueue2{}} =
            PQueue2.new() |> PQueue2.put(:value, 1) |> PQueue2.pop_with_priority()
        )

    test "Pop from an empty queue",
      do: assert({:empty, %PQueue2{}} = PQueue2.pop_with_priority(PQueue2.new(), :empty))

    test "Pop from an empty queue with a dafault value",
      do: assert({nil, %PQueue2{}} = PQueue2.pop_with_priority(PQueue2.new()))
  end

  describe "pop_at/3" do
    test "Pop at the priority",
      do: {:value, %PQueue2{}} = PQueue2.new() |> PQueue2.put(:value, 1) |> PQueue2.pop_at(1)

    test "Pop at the priority from an empty priority",
      do:
        {:empty, %PQueue2{}} =
          PQueue2.new() |> PQueue2.put(:value, 1) |> PQueue2.pop_at(0, :empty)

    test "Pop at the priority from an empty priority with a default value",
      do: {nil, %PQueue2{}} = PQueue2.new() |> PQueue2.put(:value, 1) |> PQueue2.pop_at(0)
  end

  property "Pop the same value" do
    check all {value, priority} <- {binary(), integer()}, priority >= 0 do
      assert {value, PQueue2.new()} ==
               PQueue2.new() |> PQueue2.put(value, priority) |> PQueue2.pop()
    end
  end

  property "Pop the max value" do
    check all items <- list_of({binary(), integer(0..10000)}) do
      assert max_value(items, :empty) ==
               items |> Enum.into(PQueue2.new()) |> PQueue2.pop(:empty) |> elem(0)
    end
  end

  property "Pop the max value & priority" do
    check all items <- list_of({binary(), integer(0..10000)}) do
      assert max_item(items, :empty) ==
               items |> Enum.into(PQueue2.new()) |> PQueue2.pop_with_priority(:empty) |> elem(0)
    end
  end

  property "Pop the max value at the priority" do
    check all {items, priority} <- {list_of({binary(), integer(0..10000)}), integer()},
              priority >= 0 do
      assert max_value_at(items, priority, :empty) ==
               items |> Enum.into(PQueue2.new()) |> PQueue2.pop_at(priority, :empty) |> elem(0)
    end
  end
end
