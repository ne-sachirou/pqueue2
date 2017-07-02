PQueue2
==
Priority queue that wraps [pqueue2](https://hex.pm/packages/pqueue).

[![Hex.pm](https://img.shields.io/hexpm/v/pqueue2.svg)](https://hex.pm/packages/pqueue2)
[![Build Status](https://travis-ci.org/ne-sachirou/pqueue2.svg?branch=master)](https://travis-ci.org/ne-sachirou/pqueue2)

```elixir
q = PQueue2.new |> PQueue2.put(:a, 2) |> PQueue2.put(:b, 1) |> PQueue2.put(:c, 1)
{:b, q} = PQueue2.pop
```

PQueue2 implements Collectable & Enumerable.

```elixir
[:b, :c, :a, :d] == [{:a, 2}, {:b, 1}, {:c, 1}, {:d, 2}] |> Enum.into(PQueue2.new) |> Enum.to_list
```

For more details please read the [Doc](https://hexdocs.pm/pqueue2).

Installation
--
Add `pqueue2` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:pqueue2, "~> 0.1"}]
end
```
