defmodule Pqueue2.Mixfile do
  use Mix.Project

  def project do
    [
      app: :pqueue2,
      version: "0.1.0",
      elixir: "~> 1.4",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      aliases: aliases(),
      deps: deps(),
    ]
  end

  def application do
    [extra_applications: []]
  end

  defp aliases do
    [
      "lint": ["credo --strict", "dialyzer --halt-exit-status"],
    ]
  end

  defp deps do
    [
      {:credo, "~> 0.8", only: :dev, runtime: false},
      {:dialyxir, "~> 0.5", only: :dev, runtime: false},
      {:ex_doc, "~> 0.16", only: :dev, runtime: false},
      {:pqueue, "~> 1.7"},
    ]
  end
end
