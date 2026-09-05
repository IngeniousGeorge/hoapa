defmodule Hoapa.Core.MixProject do
  use Mix.Project

  def project do
    [
      app: :hoapa_core,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # No `mod:` entry: this app has no supervision tree at v0. The event log is a
  # plain GenServer started by its caller, so nothing needs supervising yet.
  def application do
    [extra_applications: [:logger]]
  end

  # hoapa_core exports %Hoapa.Contract.Run{}, so it depends on the contract app.
  # The dependency runs core -> contract and must not be reversed: the contract
  # structs are the serialization boundary and know nothing about the runtime.
  defp deps do
    [{:hoapa_contract, in_umbrella: true}]
  end
end
