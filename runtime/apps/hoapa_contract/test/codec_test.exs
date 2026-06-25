defmodule Hoapa.Contract.CodecTest do
  @moduledoc """
  Conformance of the codec against the vendored contract corpus. Reads ONLY
  priv/runtime_contract — never ../../formal.

  The three fixture categories map to codec behaviour:
    valid/            decode :ok  (and the formal checker says yes)
    invalid-schema/   decode :error (codec rejects; never reaches the checker)
    invalid-semantic/ decode :ok  (schema-valid; the formal checker says no)
  """
  use ExUnit.Case, async: true

  alias Hoapa.Contract.Codec

  defp priv, do: Path.join(:code.priv_dir(:hoapa_contract), "runtime_contract")

  defp fixtures(category), do: Path.wildcard(Path.join(priv(), "fixtures/#{category}/*.json"))

  test "valid fixtures decode and round-trip (struct equality, not JSON bytes)" do
    files = fixtures("valid")
    assert files != []

    for f <- files do
      assert {:ok, run} = Codec.decode(File.read!(f)), "expected #{f} to decode"
      assert {:ok, ^run} = Codec.decode(Codec.encode!(run)), "round-trip changed #{f}"
    end
  end

  test "invalid-semantic fixtures are schema-valid: they decode and round-trip" do
    files = fixtures("invalid-semantic")
    assert files != []

    for f <- files do
      assert {:ok, run} = Codec.decode(File.read!(f)), "expected #{f} to decode (schema-valid)"
      assert {:ok, ^run} = Codec.decode(Codec.encode!(run)), "round-trip changed #{f}"
    end
  end

  test "invalid-schema fixtures are rejected by the codec" do
    files = fixtures("invalid-schema")
    assert files != []

    for f <- files do
      assert {:error, _} = Codec.decode(File.read!(f)), "expected #{f} to be rejected"
    end
  end
end
