defmodule Hoapa.Contract.Corpus do
  @moduledoc """
  Locates the vendored contract corpus under `priv/runtime_contract` — the single
  source of truth for its on-disk layout.

  Path helpers only. Callers do their own reading and assertions. Deliberately no
  semantic helpers (e.g. no `valid_fixture/0`): well-formedness is the formal
  checker's authority, and a `valid/` category name here is a directory name, not
  a verdict this module issues. Resolves only the vendored `priv/` artifact,
  never `../../formal`.

  This lives in `lib/` rather than `test/support` because Mix does not share a
  test build across umbrella apps: `hoapa_core`'s tests need the same layout, and
  one owner for it is worth the small public surface. The alternative — a private
  copy of these paths in each app's test tree — puts the layout in two places
  just as the corpus is growing.
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
