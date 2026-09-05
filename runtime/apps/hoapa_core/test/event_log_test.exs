defmodule Hoapa.Core.EventLogTest do
  @moduledoc """
  The event log is a recorder, and these tests judge recorder fidelity only.
  None of them claims that a run is formally valid: `WellFormed` / `valid?` is
  the formal checker's authority, and every claim about acceptance lives in the
  authoritative formal corpus with an expected verdict. Where a run here is
  compared against a fixture, the test is matching a corpus item, not judging it.

  Reads only the vendored `priv/runtime_contract` artifact, never `../../formal`.
  """
  use ExUnit.Case, async: true

  alias Hoapa.Contract.{Codec, Conversation, Corpus, Event, Run}
  alias Hoapa.Core.EventLog

  # start_link + explicit stop, rather than start_supervised!: hoapa_core has no
  # supervision tree at v0, and borrowing ExUnit's supervisor would make the app
  # read as more supervised than it is. Linking still fails the test loudly if
  # the log crashes.
  defp start_log(opts) do
    {:ok, log} = EventLog.start_link(opts)
    log
  end

  # ---- origination -----------------------------------------------------
  #
  # The distinct job of this group: show that a *running process* can originate
  # the Agda-accepted tiny run through recording calls, not merely replay one.

  describe "origination of the tiny run" do
    setup do
      log = start_log(run_id: "run-0", protocol_id: "proto-0")

      :ok = EventLog.record_actor(log, "a0")
      :ok = EventLog.record_actor(log, "a1")

      :ok =
        EventLog.record_conversation(log, %Conversation{
          conversation_id: "c0",
          actor_ids: ["a0", "a1"],
          session_tag: "session.ping/0"
        })

      :ok =
        EventLog.append_event(log, %Event{
          event_id: "e0",
          conversation_id: "c0",
          touches: ["a0"],
          causal_parents: [],
          content_tag: "content.synthetic.0",
          provenance_token: "prov.synthetic.0"
        })

      :ok =
        EventLog.append_event(log, %Event{
          event_id: "e1",
          conversation_id: "c0",
          touches: ["a1"],
          causal_parents: ["e0"],
          content_tag: "content.synthetic.0",
          provenance_token: "prov.synthetic.0"
        })

      exported = EventLog.export_run(log)
      :ok = GenServer.stop(log)

      {:ok, exported: exported}
    end

    test "the exported run reconstructs the vendored tiny run", %{exported: exported} do
      assert {:ok, fixture_run} =
               Codec.decode(File.read!(Corpus.fixture_path("valid", "tiny_trace.json")))

      assert exported == fixture_run
    end

    test "the exported run is stable under codec round-trip", %{exported: exported} do
      assert {:ok, round_tripped} = Codec.decode(Codec.encode!(exported))
      assert round_tripped == exported
    end
  end

  # ---- corpus replay ---------------------------------------------------
  #
  # Every schema-decodable fixture is pushed back through a fresh log and must
  # come out identical. Enumerated by wildcard, like codec_test.exs, so a fixture
  # added to the corpus is exercised against the recorder without a test change.
  #
  # What the current corpus catches here:
  #   dup_event.json          duplicate event IDs survive; no deduplication.
  #   forward_parent.json     a parent naming a later event survives; no
  #                           backward-parent validation, rejection, or parent
  #                           inference that changes the record. It does not rule
  #                           out an internal resolution that leaves the exported
  #                           IDs unchanged — the dangling-parent assertion below
  #                           is the stronger observable check.
  #   wrong_trace_format.json an unrecognized format string is copied unchanged.
  #
  # Replaying a fixture is not a claim about its verdict; the categories are
  # directory names here, and only the formal suite judges them.

  defp replay(%Run{} = run) do
    log =
      start_log(
        run_id: run.run_id,
        protocol_id: run.protocol_id,
        sibling_protocol_ids: run.sibling_protocol_ids,
        trace_format: run.trace_format
      )

    Enum.each(run.trace.actor_ids, &(:ok = EventLog.record_actor(log, &1)))
    Enum.each(run.trace.conversations, &(:ok = EventLog.record_conversation(log, &1)))
    Enum.each(run.trace.events, &(:ok = EventLog.append_event(log, &1)))

    exported = EventLog.export_run(log)
    :ok = GenServer.stop(log)
    exported
  end

  test "every schema-decodable fixture replays through the log unchanged" do
    paths = Corpus.fixture_paths("valid") ++ Corpus.fixture_paths("invalid-semantic")
    assert paths != []

    for path <- paths do
      assert {:ok, decoded} = Codec.decode(File.read!(path)), "expected #{path} to decode"
      assert replay(decoded) == decoded, "replay through the event log changed #{path}"
    end
  end

  # ---- recorder fidelity -----------------------------------------------
  #
  # One deliberately-not-valid run, asserted property by property so a failure
  # names which fidelity property broke. It is not a fixture and nothing here
  # claims it would be accepted: `e1` has a dangling parent, which is exactly the
  # point — a recorder must carry a reference the checker will reject.
  #
  # Its shape is chosen so that each plausible normalization is observable:
  #   actors a1, a0, a2, a1  non-lexical; a2 joins no conversation; the repeated
  #                          a1 is last, so dropping it is distinguishable from
  #                          a keep-first or keep-last deduplication
  #   conversations c1, c0,  non-lexical, more than one, and c1 repeated — the
  #                 c1       recorder stores no map keyed by conversation ID
  #   events e2, e0, e1      non-lexical, and in conversations c1, c0, c1 — so
  #                          grouping by conversation would yield [e2, e1, e0]
  #                          and is distinguishable from a sort or a reorder
  #   e0, e1 parents         cross-conversation, and e1's includes a dangling e9
  #
  # The duplicate actor and conversation are here because the moduledoc promises
  # no deduplication of actor, conversation, or event IDs, and the corpus's
  # dup_event.json covers only the event third of that promise.

  defp record_conversation_c1(log) do
    EventLog.record_conversation(log, %Conversation{
      conversation_id: "c1",
      actor_ids: ["a1"],
      session_tag: "session.ping/0"
    })
  end

  defp record_fidelity_run do
    log = start_log(run_id: "run-fidelity", protocol_id: "proto-0")

    Enum.each(["a1", "a0", "a2", "a1"], &(:ok = EventLog.record_actor(log, &1)))

    :ok = record_conversation_c1(log)

    :ok =
      EventLog.record_conversation(log, %Conversation{
        conversation_id: "c0",
        actor_ids: ["a0", "a1"],
        session_tag: "session.ping/0"
      })

    :ok = record_conversation_c1(log)

    :ok =
      EventLog.append_event(log, %Event{
        event_id: "e2",
        conversation_id: "c1",
        touches: ["a1"],
        causal_parents: [],
        content_tag: "content.synthetic.0",
        provenance_token: "prov.synthetic.0"
      })

    :ok =
      EventLog.append_event(log, %Event{
        event_id: "e0",
        conversation_id: "c0",
        touches: ["a0"],
        causal_parents: ["e2"],
        content_tag: "content.synthetic.0",
        provenance_token: "prov.synthetic.0"
      })

    :ok =
      EventLog.append_event(log, %Event{
        event_id: "e1",
        conversation_id: "c1",
        touches: ["a1"],
        causal_parents: ["e0", "e9"],
        content_tag: "content.synthetic.0",
        provenance_token: "prov.synthetic.0"
      })

    exported = EventLog.export_run(log)
    :ok = GenServer.stop(log)
    exported
  end

  describe "recorder fidelity" do
    setup do: {:ok, trace: record_fidelity_run().trace}

    test "actors keep arrival order; one in no conversation and a repeat are kept",
         %{trace: trace} do
      assert trace.actor_ids == ["a1", "a0", "a2", "a1"]
    end

    test "conversations keep arrival order, unmerged, and a repeat is kept", %{trace: trace} do
      assert Enum.map(trace.conversations, & &1.conversation_id) == ["c1", "c0", "c1"]
    end

    test "events keep arrival order: not sorted, not grouped by conversation", %{trace: trace} do
      assert Enum.map(trace.events, & &1.event_id) == ["e2", "e0", "e1"]
      assert Enum.map(trace.events, & &1.conversation_id) == ["c1", "c0", "c1"]
    end

    test "a causal parent in another conversation is kept verbatim", %{trace: trace} do
      assert %Event{conversation_id: "c0", causal_parents: ["e2"]} = Enum.at(trace.events, 1)
    end

    test "a dangling causal parent is neither dropped nor resolved", %{trace: trace} do
      assert %Event{causal_parents: ["e0", "e9"]} = Enum.at(trace.events, 2)
    end
  end

  # ---- run metadata ----------------------------------------------------

  describe "run metadata" do
    test "trace_format defaults to the v0 tag" do
      log = start_log(run_id: "run-0", protocol_id: "proto-0")
      assert %Run{trace_format: "hoapa.trace/0"} = EventLog.export_run(log)
      :ok = GenServer.stop(log)
    end

    test "an explicit trace_format is copied through unchanged, not inspected" do
      log = start_log(run_id: "run-0", protocol_id: "proto-0", trace_format: "hoapa.trace/9")
      assert %Run{trace_format: "hoapa.trace/9"} = EventLog.export_run(log)
      :ok = GenServer.stop(log)
    end

    test "sibling protocol IDs default to none and are kept when given" do
      log = start_log(run_id: "run-0", protocol_id: "proto-0")
      assert %Run{sibling_protocol_ids: []} = EventLog.export_run(log)
      :ok = GenServer.stop(log)

      sibling_log =
        start_log(run_id: "run-0", protocol_id: "proto-0", sibling_protocol_ids: ["proto-1"])

      assert %Run{sibling_protocol_ids: ["proto-1"]} = EventLog.export_run(sibling_log)
      :ok = GenServer.stop(sibling_log)
    end

    test "run_id and protocol_id are required, and raise in the caller" do
      assert_raise KeyError, fn -> EventLog.start_link(protocol_id: "proto-0") end
      assert_raise KeyError, fn -> EventLog.start_link(run_id: "run-0") end
    end
  end
end
