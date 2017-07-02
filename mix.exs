defmodule PQueue2.Mixfile do
  use Mix.Project

  def project do
    [
      app: :pqueue2,
      version: "0.1.0",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env),
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      aliases: aliases(),
      deps: deps(),
      description: description(),
      package: package(),
      # Docs
      name: "PQueue2",
      source_url: "https://github.com/ne-sachirou/pqueue2",
      homepage_url: "https://github.com/ne-sachirou/pqueue2",
      docs: [
        main: "PQueue2",
        extras: ["README.md"],
      ],
    ]
  end

  def application do
    [extra_applications: []]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  defp deps do
    [
      {:credo, "~> 0.8", only: :dev, runtime: false},
      {:dialyxir, "~> 0.5", only: :dev, runtime: false},
      {:ex_doc, "~> 0.16", only: :dev, runtime: false},
      # {:excheck, "~> 0.5", only: :test},
      {:pqueue, "~> 1.7"},
      {:propcheck, "~> 0.0", only: :test},
      # {:triq, github: "triqng/triq", only: :test},
    ]
  end

  defp aliases do
    [
      "lint": ["credo --strict", "dialyzer --halt-exit-status"],
    ]
  end

  defp description do
    """
    Priority queue that wraps pqueue2.
    """
  end

  defp package do
    [
      licenses: ["MIT"],
      name: :pqueue2,
      maintainers: ["ne_Sachirou <utakata.c4se@gmail.com>"],
      links: %{
        "GitHub": "https://github.com/ne-sachirou/pqueue2",
      },
      files: ["LICENSE", "README.md", "mix.exs", "lib"]
    ]
  end
end
