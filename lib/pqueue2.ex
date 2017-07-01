defmodule PQueue2 do
  @moduledoc """
  Priority queue that wraps pqueue2.

      iex> [{:a, 2}, {:b, 1}, {:c, 1}, {:d, 2}] |> Enum.into(PQueue2.new) |> Enum.to_list
      [:b, :c, :a, :d]
  """

  @type t :: %__MODULE__{pq: :pqueue2.pqueue2}

  @default_priority 0
  @default_value nil

  defstruct pq: :empty

  @doc """
  """
  @spec new :: t
  def new, do: %__MODULE__{pq: :pqueue2.new}

  @doc """
  """
  @spec empty?(t) :: boolean
  def empty?(%{pq: pq}), do: :pqueue2.is_empty pq

  @doc """
  """
  @spec count(t) :: integer
  def count(%{pq: pq}), do: :pqueue2.len pq

  @doc """
  """
  @spec put(t, term, integer) :: t
  def put(queue, value, priority \\ @default_priority), do: update_in queue.pq, &:pqueue2.in(value, priority, &1)

  @doc """
  pop

      iex> PQueue2.new |> PQueue2.pop |> elem(0)
      nil

      iex> PQueue2.new |> PQueue2.put(:a, 2) |> PQueue2.put(:b, 1) |> PQueue2.pop |> elem(0)
      :b
  """
  @spec pop(t, term) :: {term, t}
  def pop(queue, default \\ @default_value) do
    case :pqueue2.out queue.pq do
      {:empty, _pq} -> {default, queue}
      {{:value, value}, pq} -> {value, put_in(queue.pq, pq)}
    end
  end

  @doc """
  """
  @spec pop_with_priority(t, term) :: {{term, integer}, t}
  def pop_with_priority(queue, default \\ @default_value) do
    case :pqueue2.pout queue.pq do
      {:empty, _pq} -> {{default, @default_priority}, queue}
      {{:value, value, priority}, pq} ->
        {{value, priority}, put_in(queue.pq, pq)}
    end
  end

  @doc """
  pop_at

      iex> PQueue2.new |> PQueue2.put(:a, 2) |> PQueue2.put(:b, 1) |> PQueue2.pop_at(1) |> elem(0)
      :b

      iex> PQueue2.new |> PQueue2.put(:a, 2) |> PQueue2.put(:b, 1) |> PQueue2.pop_at(2) |> elem(0)
      :a

      iex> PQueue2.new |> PQueue2.put(:a, 2) |> PQueue2.put(:b, 1) |> PQueue2.pop_at(3) |> elem(0)
      nil
  """
  @spec pop_at(t, integer, term) :: term
  def pop_at(queue, priority, default \\ @default_value) do
    case :pqueue2.out priority, queue.pq do
      {:empty, _pq} -> {default, queue}
      {{:value, value}, pq} -> {value, put_in(queue.pq, pq)}
    end
  end
end
