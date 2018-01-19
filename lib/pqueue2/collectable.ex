defimpl Collectable, for: PQueue2 do
  def into(queue) do
    {
      queue,
      fn
        acc, {:cont, {value, priority}}
        when is_integer(priority) and priority >= 0 ->
          PQueue2.put(acc, value, priority)

        acc, {:cont, value} ->
          PQueue2.put(acc, value)

        acc, :done ->
          acc

        _acc, :halt ->
          :ok
      end
    }
  end
end
