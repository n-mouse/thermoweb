defmodule Thermoweb.MixProject do
  use Mix.Project

  def project do
    [
      app: :thermoweb,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Thermoweb.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.0"},
      {:tortoise, "~> 0.9.4"},
      {:jason, "~> 1.1"}
    ]
  end
end
