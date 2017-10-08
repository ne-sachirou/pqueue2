defmodule PQueue2Test.PList2 do
  def sort(items), do: items |> Enum.group_by(&elem(&1, 1)) |> Enum.sort |> Enum.map(&elem(&1, 1)) |> Enum.concat

  def max_item(items, default \\ nil)
  def max_item([], default), do: default
  def max_item(items, _), do: items |> sort |> hd

  def max_value(items, default \\ nil) do
    case max_item items, default do
      {value, _} -> value
      value -> value
    end
  end

  def max_value_at(items, priority, default \\ nil),
    do: items |> Enum.filter(&(elem(&1, 1) == priority)) |> max_value(default)
end
