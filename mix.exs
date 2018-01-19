defmodule PQueue2.Mixfile do
  use Mix.Project

  def project do
    [
      app: :pqueue2,
      version: "0.1.0",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
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
        extras: ["README.md"]
      ]
    ]
  end

  def application do
    [extra_applications: []]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:ex_doc, "~> 0.18", only: :dev, runtime: false},
      {:inner_cotton, github: "ne-sachirou/inner_cotton", only: [:dev, :test]},
      {:pqueue, "~> 1.7"}
    ]
  end

  defp aliases do
    []
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
        GitHub: "https://github.com/ne-sachirou/pqueue2"
      },
      files: ["LICENSE", "README.md", "mix.exs", "lib"]
    ]
  end
end
