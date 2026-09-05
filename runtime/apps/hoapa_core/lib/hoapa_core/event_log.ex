defmodule Hoapa.Core.EventLog do
  @moduledoc """
  An append-only recorder of one runtime execution, exported as a
  `%Hoapa.Contract.Run{}`.

  ## It is a recorder, not a checker

  Well-formedness is the formal checker's authority. This module therefore does
  none of the following, and each omission is deliberate rather than pending:

    * no deduplication of actor, conversation, or event IDs
    * no sorting or normalization on export
    * no resolution or rejection of dangling or forward references
    * no inference of causal parents from arrival order — callers supply them
    * no inference of `touches`
    * no auto-creation of missing conversations
    * no grouping of events by conversation
    * no derivation of the global actor list from conversation membership
    * no generated IDs — callers supply every ID
    * no inspection of `trace_format`, which is copied through unchanged

  Recording the mandatory opaque `session_tag` carried on a conversation is not
  session-type assignment. There is no tag vocabulary here to invent one from.

  A run that declares an actor who joins no conversation is legal evidence and is
  recorded as given: actors are registered independently of conversation
  membership. Whether every declared actor is covered by a conversation is a
  separate downstream property (`actorsCovered?` on the formal side), not a
  condition this recorder enforces.

  ## What the export's order means

  Export preserves the order in which the server handles recording calls. This is
  evidence order, not actor-execution order or causal order. The server
  serializing arrivals says nothing about actors executing synchronously, and
  `GenServer.call/2` does not impose a wall-clock order across concurrent
  callers — it only acknowledges that an operation has been processed. Causality
  is carried solely by each event's explicit `causal_parents`; arrival order is
  the evidence order that the contract's backward-parent discipline is stated
  against.

  Records accumulate reversed and are reversed once on export. That restores
  arrival order; it is not normalization.

  ## API shape discipline

  `record_conversation/2` and `append_event/2` match `%Conversation{}` and
  `%Event{}` in the function head, and `record_actor/2` requires a binary. That
  constrains the outer record type of an argument only. Field contents are not
  validated — deliberately, since judging them is the checker's job, not this
  module's.
  """
  use GenServer

  alias Hoapa.Contract.{Conversation, Event, Run, Trace}

  @default_trace_format "hoapa.trace/0"

  @typep state :: %{
           run_id: String.t(),
           protocol_id: String.t(),
           sibling_protocol_ids: [String.t()],
           trace_format: String.t(),
           # Reversed accumulators; see "What the export's order means".
           actor_ids: [String.t()],
           conversations: [Conversation.t()],
           events: [Event.t()]
         }

  @doc """
  Starts an unnamed event log for one run.

  Required options: `:run_id`, `:protocol_id`. Optional: `:sibling_protocol_ids`
  (default `[]`) and `:trace_format` (default `#{@default_trace_format}`, copied
  unchanged when supplied).

  The required options are fetched here, before the process is spawned, so a
  missing one raises `KeyError` in the caller rather than failing inside `init/1`.

  Deliberately unnamed: independent logs must be able to run side by side.
  """
  @spec start_link(keyword()) :: GenServer.on_start()
  def start_link(opts) when is_list(opts) do
    initial = %{
      run_id: Keyword.fetch!(opts, :run_id),
      protocol_id: Keyword.fetch!(opts, :protocol_id),
      sibling_protocol_ids: Keyword.get(opts, :sibling_protocol_ids, []),
      trace_format: Keyword.get(opts, :trace_format, @default_trace_format),
      actor_ids: [],
      conversations: [],
      events: []
    }

    GenServer.start_link(__MODULE__, initial)
  end

  @doc "Records one actor ID, independently of any conversation membership."
  @spec record_actor(GenServer.server(), String.t()) :: :ok
  def record_actor(log, actor_id) when is_binary(actor_id),
    do: GenServer.call(log, {:record_actor, actor_id})

  @doc """
  Records one conversation. Callable repeatedly: a run may hold many
  conversations, and a later event may name any of them.
  """
  @spec record_conversation(GenServer.server(), Conversation.t()) :: :ok
  def record_conversation(log, %Conversation{} = conversation),
    do: GenServer.call(log, {:record_conversation, conversation})

  @doc """
  Appends one event. The event carries its own `conversation_id` and
  `causal_parents`, so both stay explicitly caller-supplied; a parent may name an
  event in a different conversation.
  """
  @spec append_event(GenServer.server(), Event.t()) :: :ok
  def append_event(log, %Event{} = event), do: GenServer.call(log, {:append_event, event})

  @doc "Exports everything recorded so far as a contract run. Does not stop the log."
  @spec export_run(GenServer.server()) :: Run.t()
  def export_run(log), do: GenServer.call(log, :export_run)

  # ---- server ----------------------------------------------------------

  @impl GenServer
  @spec init(state()) :: {:ok, state()}
  def init(initial), do: {:ok, initial}

  @impl GenServer
  def handle_call({:record_actor, actor_id}, _from, state),
    do: {:reply, :ok, %{state | actor_ids: [actor_id | state.actor_ids]}}

  def handle_call({:record_conversation, conversation}, _from, state),
    do: {:reply, :ok, %{state | conversations: [conversation | state.conversations]}}

  def handle_call({:append_event, event}, _from, state),
    do: {:reply, :ok, %{state | events: [event | state.events]}}

  def handle_call(:export_run, _from, state), do: {:reply, export(state), state}

  defp export(state) do
    %Run{
      trace_format: state.trace_format,
      run_id: state.run_id,
      protocol_id: state.protocol_id,
      sibling_protocol_ids: state.sibling_protocol_ids,
      trace: %Trace{
        actor_ids: Enum.reverse(state.actor_ids),
        conversations: Enum.reverse(state.conversations),
        events: Enum.reverse(state.events)
      }
    }
  end
end
