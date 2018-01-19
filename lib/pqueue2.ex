defmodule PQueue2 do
  @moduledoc """
  Priority queue that wraps [pqueue2](https://hex.pm/packages/pqueue).

      iex> {value, _} = PQueue2.new
      iex> |> PQueue2.put(:a, 2)
      iex> |> PQueue2.put(:b, 1)
      iex> |> PQueue2.put(:c, 1)
      iex> |> PQueue2.pop
      iex> value
      :b

  PQueue2 implements Collectable & Enumerable.

      iex> [{:a, 2}, {:b, 1}, {:c, 1}, {:d, 2}] |> Enum.into(PQueue2.new) |> Enum.to_list
      [:b, :c, :a, :d]
  """

  # @type t :: %__MODULE__{pq: :pqueue2.pqueue2}
  @type pqueue2 ::
          :empty
          | {integer, pqueue2, pqueue2, :element, term}
          | {integer, pqueue2, pqueue2, :queue, :queue.queue()}
  @type t :: %__MODULE__{pq: pqueue2}

  @default_priority 0
  @default_value nil

  defstruct pq: :empty

  @doc """
  Create a new priority queue.
  """
  @spec new :: t
  def new, do: %__MODULE__{pq: :pqueue2.new()}

  @doc """
  """
  @spec empty?(t) :: boolean
  def empty?(queue)
  def empty?(%{pq: pq}), do: :pqueue2.is_empty(pq)

  @doc """
  """
  @spec count(t) :: non_neg_integer
  def count(queue)
  def count(%{pq: pq}), do: :pqueue2.len(pq)

  @doc """
  Put the value.
  """
  @spec put(t, term, non_neg_integer) :: t
  def put(queue, value, priority \\ @default_priority),
    do: update_in(queue.pq, &:pqueue2.in(value, priority, &1))

  @doc """
  Pop the max value.

      iex> PQueue2.new |> PQueue2.put(:a, 2) |> PQueue2.put(:b, 1) |> PQueue2.pop
      {:b, %PQueue2{pq: {2, :empty, :empty, :element, :a}}}

      iex> PQueue2.pop PQueue2.new
      {nil, %PQueue2{pq: :empty}}

      iex> PQueue2.pop PQueue2.new, :empty
      {:empty, %PQueue2{pq: :empty}}
  """
  @spec pop(t, term) :: {term, t}
  def pop(queue, default \\ @default_value) do
    case :pqueue2.out(queue.pq) do
      {:empty, _pq} -> {default, queue}
      {{:value, value}, pq} -> {value, put_in(queue.pq, pq)}
    end
  end

  @doc """
  Pop the max value & priority.

      iex> PQueue2.new |> PQueue2.put(:a, 2) |> PQueue2.put(:b, 1) |> PQueue2.pop_with_priority
      {{:b, 1}, %PQueue2{pq: {2, :empty, :empty, :element, :a}}}
  """
  @spec pop_with_priority(t, term) :: {{term, non_neg_integer} | term, t}
  def pop_with_priority(queue, default \\ @default_value) do
    case :pqueue2.pout(queue.pq) do
      {:empty, _pq} ->
        {default, queue}

      {{:value, value, priority}, pq} ->
        {{value, priority}, put_in(queue.pq, pq)}
    end
  end

  @doc """
  Pop the first value at the priority.

      iex> PQueue2.new |> PQueue2.put(:a, 2) |> PQueue2.put(:b, 1) |> PQueue2.pop_at(2)
      {:a, %PQueue2{pq: {1, :empty, :empty, :element, :b}}}

      iex> PQueue2.new |> PQueue2.put(:a, 2) |> PQueue2.put(:b, 1) |> PQueue2.pop_at(3)
      {nil, %PQueue2{pq: {1, :empty, {2, :empty, :empty, :element, :a}, :element, :b}}}
  """
  @spec pop_at(t, non_neg_integer, term) :: {term, t}
  def pop_at(queue, priority, default \\ @default_value) do
    case :pqueue2.out(priority, queue.pq) do
      {:empty, _pq} -> {default, queue}
      {{:value, value}, pq} -> {value, put_in(queue.pq, pq)}
    end
  end
end
