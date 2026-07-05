defmodule Hoapa.Contract.TestCorpus do
  @moduledoc """
  Locates the vendored contract corpus under `priv/runtime_contract` — the single
  source of truth for its on-disk layout, shared by the contract tests.

  Path helpers only: tests do their own reading and assertions. Deliberately no
  semantic helpers (e.g. no `valid_fixture/0`) — well-formedness is the formal
  checker's authority, not this module's. Resolves only the vendored `priv/`
  artifact, never `../../formal`.
  """

  @spec dir() :: String.t()
  def dir, do: Path.join(:code.priv_dir(:hoapa_contract), "runtime_contract")

  @spec manifest_path() :: String.t()
  def manifest_path, do: Path.join(dir(), "manifest.json")

  @doc "Every vendored artifact except the manifest itself (for integrity checks)."
  @spec artifact_paths() :: [String.t()]
  def artifact_paths do
    Path.join(dir(), "**/*")
    |> Path.wildcard()
    |> Enum.filter(&File.regular?/1)
    |> Enum.reject(&(&1 == manifest_path()))
  end

  @doc "The JSON fixtures in one category directory, e.g. `fixture_paths(\"valid\")`."
  @spec fixture_paths(String.t()) :: [String.t()]
  def fixture_paths(category), do: Path.wildcard(Path.join([dir(), "fixtures", category, "*.json"]))

  @doc "One named fixture, e.g. `fixture_path(\"valid\", \"tiny_trace.json\")`."
  @spec fixture_path(String.t(), String.t()) :: String.t()
  def fixture_path(category, filename), do: Path.join([dir(), "fixtures", category, filename])
end
