defmodule Hoapa.Runtime.MixProject do
  use Mix.Project

  # Umbrella for the Hoapa runtime. v0 holds a single app, hoapa_contract
  # (the codec against the vendored formal contract). No Phoenix, no OTP
  # event log yet; those arrive in later passes.
  def project do
    [
      apps_path: "apps",
      version: "0.1.0",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  defp deps, do: []
end
