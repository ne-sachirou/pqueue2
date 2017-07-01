defimpl Inspect, for: PQueue2 do
  import Inspect.Algebra

  def inspect(queue, opts), do: to_doc queue.pq, opts
end
