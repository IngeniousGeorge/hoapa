defmodule Hoapa.Contract.Run do
  @moduledoc """
  One serialized runtime execution: the `hoapa.trace/0` wire shape.

  Struct field names are snake_case; the wire (JSON) uses camelCase. The codec
  maps between them. Meaning (well-formedness) is the formal checker's job, not
  this struct's.
  """
  @enforce_keys [:trace_format, :run_id, :protocol_id, :sibling_protocol_ids, :trace]
  defstruct @enforce_keys

  @type t :: %__MODULE__{}
end
