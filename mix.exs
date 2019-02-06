defmodule PQueue2.Mixfile do
  use Mix.Project

  def project do
    [
      app: :pqueue2,
      build_embedded: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      dialyzer: [
        flags: [:no_undefined_callbacks],
        remove_defaults: [:unknown]
      ],
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      aliases: aliases(),
      package: package(),
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.travis": :test,
        "coveralls.html": :test
      ],
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      version: "0.3.0",

      # Docs
      docs: [
        main: "PQueue2",
        extras: ["README.md"]
      ],
      homepage_url: "https://github.com/ne-sachirou/pqueue2",
      name: "PQueue2",
      source_url: "https://github.com/ne-sachirou/pqueue2"
    ]
  end

  def application, do: [extra_applications: []]

  defp aliases, do: []

  defp description do
    """
    Priority queue that wraps pqueue2.
    """
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

  defp package do
    [
      files: ["LICENSE", "README.md", "mix.exs", "lib"],
      licenses: ["MIT"],
      links: %{
        GitHub: "https://github.com/ne-sachirou/pqueue2"
      },
      maintainers: ["ne_Sachirou <utakata.c4se@gmail.com>"],
      name: :pqueue2
    ]
  end
end
