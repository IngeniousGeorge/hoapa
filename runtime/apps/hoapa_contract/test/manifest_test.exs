defmodule Hoapa.Contract.ManifestTest do
  @moduledoc """
  Internal integrity of the vendored contract: every source artifact under
  priv/runtime_contract matches its sha256 in manifest.json, with no extras or
  missing files. Self-contained — does NOT read ../../formal. (Cross-leg
  freshness, i.e. priv matches the formal source, is the top-level
  `make contract-fresh` gate.)
  """
  use ExUnit.Case, async: true

  alias Hoapa.Contract.Corpus

  test "priv artifacts match manifest hashes exactly" do
    {:ok, manifest} = JSON.decode(File.read!(Corpus.manifest_path()))

    expected = manifest["files"]
    assert is_map(expected) and map_size(expected) > 0

    actual =
      Map.new(Corpus.artifact_paths(), fn f ->
        rel = Path.relative_to(f, Corpus.dir())
        hash = :crypto.hash(:sha256, File.read!(f)) |> Base.encode16(case: :lower)
        {rel, hash}
      end)

    assert actual == expected
  end

  test "contract version is recorded" do
    {:ok, manifest} = JSON.decode(File.read!(Corpus.manifest_path()))
    assert manifest["contractVersion"] == "hoapa.trace/0"
  end
end
