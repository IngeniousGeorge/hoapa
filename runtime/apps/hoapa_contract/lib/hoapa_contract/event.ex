defmodule Hoapa.Contract.Event do
  @moduledoc "An event: its id, conversation, touched actors, causal parents, and opaque tags."
  @enforce_keys [:event_id, :conversation_id, :touches, :causal_parents, :content_tag, :provenance_token]
  defstruct @enforce_keys

  @type t :: %__MODULE__{
          event_id: String.t(),
          conversation_id: String.t(),
          touches: [String.t()],
          causal_parents: [String.t()],
          content_tag: String.t(),
          provenance_token: String.t()
        }
end
