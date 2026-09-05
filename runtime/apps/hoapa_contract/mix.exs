defmodule Hoapa.Contract.MixProject do
  use Mix.Project

  def project do
    [
      app: :hoapa_contract,
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

  # JSON is in the Elixir standard library (1.18); :crypto is used by the
  # manifest-integrity test. No external deps.
  def application do
    [extra_applications: [:logger, :crypto]]
  end

  defp deps, do: []
end
