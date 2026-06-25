defmodule Hoapa.Contract.Event do
  @moduledoc "An event: its id, conversation, touched actors, causal parents, and opaque tags."
  @enforce_keys [:event_id, :conversation_id, :touches, :causal_parents, :content_tag, :provenance_token]
  defstruct @enforce_keys
end
