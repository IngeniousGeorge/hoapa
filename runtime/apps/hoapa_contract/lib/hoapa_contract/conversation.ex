defmodule Hoapa.Contract.Conversation do
  @moduledoc "A conversation / local view: its id, present actors, and session tag."
  @enforce_keys [:conversation_id, :actor_ids, :session_tag]
  defstruct @enforce_keys

  @type t :: %__MODULE__{
          conversation_id: String.t(),
          actor_ids: [String.t()],
          session_tag: String.t()
        }
end
