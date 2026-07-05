defmodule Hoapa.Contract.TinyRunTest do
  @moduledoc """
  Construction seam plus corpus anchor.

  This is NOT a second copy of the codec round-trip test. Its distinct job is to
  show that runtime code can *originate* a `Run` from the contract structs and
  that the originated value reconstructs the vendored, Agda-accepted tiny run —
  the emission seam every later emitter (event log, generator) will build through.

  It does not judge validity: `WellFormed` / `valid?` is the formal checker's
  authority. This test only matches a corpus item that the formal suite accepts,
  by decoded-struct equality (never byte-for-byte JSON). It reads only the
  vendored `priv/runtime_contract` artifact, never `../../formal`.
  """
  use ExUnit.Case, async: true

  alias Hoapa.Contract.{Codec, Run, Trace, Conversation, Event, TestCorpus}

  # Dumb by design: a single literal. No normalization, sorting, validation, or
  # invariant logic — that would either fake behavior or duplicate Agda's valid?.
  defp build_tiny_run do
    %Run{
      trace_format: "hoapa.trace/0",
      run_id: "run-0",
      protocol_id: "proto-0",
      sibling_protocol_ids: [],
      trace: %Trace{
        actor_ids: ["a0", "a1"],
        conversations: [
          %Conversation{conversation_id: "c0", actor_ids: ["a0", "a1"], session_tag: "session.ping/0"}
        ],
        events: [
          %Event{
            event_id: "e0",
            conversation_id: "c0",
            touches: ["a0"],
            causal_parents: [],
            content_tag: "content.synthetic.0",
            provenance_token: "prov.synthetic.0"
          },
          %Event{
            event_id: "e1",
            conversation_id: "c0",
            touches: ["a1"],
            causal_parents: ["e0"],
            content_tag: "content.synthetic.0",
            provenance_token: "prov.synthetic.0"
          }
        ]
      }
    }
  end

  test "reconstructs the vendored Agda-accepted tiny run from structs" do
    assert {:ok, fixture_run} = Codec.decode(File.read!(TestCorpus.fixture_path("valid", "tiny_trace.json")))
    assert build_tiny_run() == fixture_run
  end

  test "the reconstructed run is stable under codec round-trip" do
    built_run = build_tiny_run()
    assert {:ok, round_tripped} = Codec.decode(Codec.encode!(built_run))
    assert round_tripped == built_run
  end
end
