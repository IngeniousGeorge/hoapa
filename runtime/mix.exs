defmodule Hoapa.Runtime.MixProject do
  use Mix.Project

  # Umbrella for the Hoapa runtime. v0 holds two apps: hoapa_contract (the
  # structs and codec for the vendored formal contract) and hoapa_core (the
  # append-only event log that emits a run through it). No synthetic generator,
  # no hoapa_store/Pijul, no hoapa_checker, no Phoenix; those arrive in later
  # passes, each behind its gate in workflow/status_implementation.md.
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
