defmodule Hoapa.Contract.Trace do
  @moduledoc "The checker-facing trace body: actors, conversations, events."
  @enforce_keys [:actor_ids, :conversations, :events]
  defstruct @enforce_keys

  @type t :: %__MODULE__{
          actor_ids: [String.t()],
          conversations: [Hoapa.Contract.Conversation.t()],
          events: [Hoapa.Contract.Event.t()]
        }
end
