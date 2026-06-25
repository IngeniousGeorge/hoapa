defmodule Hoapa.Contract.ManifestTest do
  @moduledoc """
  Internal integrity of the vendored contract: every source artifact under
  priv/runtime_contract matches its sha256 in manifest.json, with no extras or
  missing files. Self-contained — does NOT read ../../formal. (Cross-leg
  freshness, i.e. priv matches the formal source, is the top-level
  `make contract-fresh` gate.)
  """
  use ExUnit.Case, async: true

  defp priv, do: Path.join(:code.priv_dir(:hoapa_contract), "runtime_contract")

  test "priv artifacts match manifest hashes exactly" do
    p = priv()
    {:ok, manifest} = JSON.decode(File.read!(Path.join(p, "manifest.json")))

    expected = manifest["files"]
    assert is_map(expected) and map_size(expected) > 0

    actual =
      Path.join(p, "**/*")
      |> Path.wildcard()
      |> Enum.filter(&File.regular?/1)
      |> Enum.reject(&(Path.basename(&1) == "manifest.json"))
      |> Map.new(fn f ->
        rel = Path.relative_to(f, p)
        hash = :crypto.hash(:sha256, File.read!(f)) |> Base.encode16(case: :lower)
        {rel, hash}
      end)

    assert actual == expected
  end

  test "contract version is recorded" do
    p = priv()
    {:ok, manifest} = JSON.decode(File.read!(Path.join(p, "manifest.json")))
    assert manifest["contractVersion"] == "hoapa.trace/0"
  end
end
