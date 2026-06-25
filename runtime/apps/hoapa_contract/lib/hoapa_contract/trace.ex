defmodule Hoapa.Contract.Trace do
  @moduledoc "The checker-facing trace body: actors, conversations, events."
  @enforce_keys [:actor_ids, :conversations, :events]
  defstruct @enforce_keys
end
