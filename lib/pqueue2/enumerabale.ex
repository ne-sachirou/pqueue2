defimpl Enumerable, for: PQueue2 do
  def count(queue), do: {:ok, PQueue2.count(queue)}

  def member?(queue, value), do: {:ok, Enum.member?(:pqueue2.to_list(queue.pq), value)}

  def reduce(_queue, {:halt, acc}, _reducer), do: {:halt, acc}
  def reduce(queue, {:suspend, acc}, reducer), do: {:suspend, acc, &reduce(queue, &1, reducer)}

  def reduce(queue, {:cont, acc}, reducer) do
    ref = make_ref()

    case PQueue2.pop(queue, ref) do
      {^ref, _} -> {:done, acc}
      {value, queue} -> reduce(queue, reducer.(value, acc), reducer)
    end
  end

  def slice(queue), do: {:error, __MODULE__}
end
