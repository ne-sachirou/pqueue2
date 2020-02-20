[![Actions Status](https://github.com/ne-sachirou/pqueue2/workflows/test/badge.svg)](https://github.com/ne-sachirou/pqueue2/actions)
[![Coverage Status](https://coveralls.io/repos/github/ne-sachirou/pqueue2/badge.svg)](https://coveralls.io/github/ne-sachirou/pqueue2)
[![Hex.pm](https://img.shields.io/hexpm/v/pqueue2.svg)](https://hex.pm/packages/pqueue2)

# PQueue2

Priority queue that wraps [pqueue2](https://hex.pm/packages/pqueue).

```elixir
q = PQueue2.new |> PQueue2.put(:a, 2) |> PQueue2.put(:b, 1) |> PQueue2.put(:c, 1)
{:b, q} = PQueue2.pop(q)
{:c, q} = PQueue2.pop(q)
{:a, q} = PQueue2.pop(q)
```

PQueue2 implements Collectable & Enumerable.

```elixir
[:b, :c, :a, :d] == [{:a, 2}, {:b, 1}, {:c, 1}, {:d, 2}] |> Enum.into(PQueue2.new) |> Enum.to_list()
```

For more details please read the [Doc](https://hexdocs.pm/pqueue2).

## Installation

Add `pqueue2` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:pqueue2, "~> 0.4"}]
end
```
