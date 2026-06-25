defmodule Hoapa.Contract.Codec do
  @moduledoc """
  Decode/encode the raw Hoapa runtime trace wire shape.

  `decode/1` judges *schema* validity only (required keys, no unexpected keys,
  string/array-of-string types) and maps camelCase wire keys to snake_case
  structs. It does NOT judge *semantic* well-formedness — including format
  recognition: any string `traceFormat` is schema-valid here, and whether it is
  a recognized format is the formal checker's job. This is why
  `invalid-semantic/` fixtures (e.g. a wrong `traceFormat`) decode successfully.

  Zero deps: uses the standard-library `JSON` module (decode tuple form;
  `encode!/1`, since `JSON.encode/1` does not exist in Elixir 1.18).
  """
  alias Hoapa.Contract.{Run, Trace, Conversation, Event}

  @spec decode(binary()) :: {:ok, Run.t()} | {:error, term()}
  def decode(json) when is_binary(json) do
    case JSON.decode(json) do
      {:ok, data} -> decode_run(data)
      {:error, reason} -> {:error, {:json, reason}}
    end
  end

  @spec encode!(Run.t()) :: binary()
  def encode!(%Run{} = run), do: JSON.encode!(run_map(run))

  # ---- decode ----------------------------------------------------------

  defp decode_run(%{} = m) do
    with :ok <- exact_keys(m, ~w(traceFormat runId protocolId siblingProtocolIds trace)),
         {:ok, tf} <- str(m, "traceFormat"),
         {:ok, rid} <- str(m, "runId"),
         {:ok, pid} <- str(m, "protocolId"),
         {:ok, sib} <- str_list(m, "siblingProtocolIds"),
         {:ok, tr} <- decode_trace(Map.get(m, "trace")) do
      {:ok,
       %Run{
         trace_format: tf,
         run_id: rid,
         protocol_id: pid,
         sibling_protocol_ids: sib,
         trace: tr
       }}
    end
  end

  defp decode_run(_), do: {:error, {:not_object, :run}}

  defp decode_trace(%{} = m) do
    with :ok <- exact_keys(m, ~w(actorIds conversations events)),
         {:ok, acts} <- str_list(m, "actorIds"),
         {:ok, convs} <- decode_list(Map.get(m, "conversations"), &decode_conv/1),
         {:ok, evs} <- decode_list(Map.get(m, "events"), &decode_event/1) do
      {:ok, %Trace{actor_ids: acts, conversations: convs, events: evs}}
    end
  end

  defp decode_trace(_), do: {:error, {:not_object, :trace}}

  defp decode_conv(%{} = m) do
    with :ok <- exact_keys(m, ~w(conversationId actorIds sessionTag)),
         {:ok, cid} <- str(m, "conversationId"),
         {:ok, acts} <- str_list(m, "actorIds"),
         {:ok, st} <- str(m, "sessionTag") do
      {:ok, %Conversation{conversation_id: cid, actor_ids: acts, session_tag: st}}
    end
  end

  defp decode_conv(_), do: {:error, {:not_object, :conversation}}

  defp decode_event(%{} = m) do
    with :ok <- exact_keys(m, ~w(eventId conversationId touches causalParents contentTag provenanceToken)),
         {:ok, eid} <- str(m, "eventId"),
         {:ok, cid} <- str(m, "conversationId"),
         {:ok, touches} <- str_list(m, "touches"),
         {:ok, parents} <- str_list(m, "causalParents"),
         {:ok, ct} <- str(m, "contentTag"),
         {:ok, pt} <- str(m, "provenanceToken") do
      {:ok,
       %Event{
         event_id: eid,
         conversation_id: cid,
         touches: touches,
         causal_parents: parents,
         content_tag: ct,
         provenance_token: pt
       }}
    end
  end

  defp decode_event(_), do: {:error, {:not_object, :event}}

  # ---- decode helpers --------------------------------------------------

  defp exact_keys(m, allowed) do
    keys = Map.keys(m)
    missing = allowed -- keys
    extra = keys -- allowed

    cond do
      missing != [] -> {:error, {:missing_keys, missing}}
      extra != [] -> {:error, {:unexpected_keys, extra}}
      true -> :ok
    end
  end

  defp str(m, k) do
    case Map.get(m, k) do
      v when is_binary(v) -> {:ok, v}
      _ -> {:error, {:expected_string, k}}
    end
  end

  defp str_list(m, k) do
    case Map.get(m, k) do
      v when is_list(v) ->
        if Enum.all?(v, &is_binary/1), do: {:ok, v}, else: {:error, {:expected_string_list, k}}

      _ ->
        {:error, {:expected_list, k}}
    end
  end

  defp decode_list(v, f) when is_list(v) do
    result =
      Enum.reduce_while(v, {:ok, []}, fn item, {:ok, acc} ->
        case f.(item) do
          {:ok, x} -> {:cont, {:ok, [x | acc]}}
          err -> {:halt, err}
        end
      end)

    case result do
      {:ok, acc} -> {:ok, Enum.reverse(acc)}
      err -> err
    end
  end

  defp decode_list(_, _), do: {:error, :expected_list}

  # ---- encode ----------------------------------------------------------

  defp run_map(%Run{} = r) do
    %{
      "traceFormat" => r.trace_format,
      "runId" => r.run_id,
      "protocolId" => r.protocol_id,
      "siblingProtocolIds" => r.sibling_protocol_ids,
      "trace" => trace_map(r.trace)
    }
  end

  defp trace_map(%Trace{} = t) do
    %{
      "actorIds" => t.actor_ids,
      "conversations" => Enum.map(t.conversations, &conv_map/1),
      "events" => Enum.map(t.events, &event_map/1)
    }
  end

  defp conv_map(%Conversation{} = c) do
    %{"conversationId" => c.conversation_id, "actorIds" => c.actor_ids, "sessionTag" => c.session_tag}
  end

  defp event_map(%Event{} = e) do
    %{
      "eventId" => e.event_id,
      "conversationId" => e.conversation_id,
      "touches" => e.touches,
      "causalParents" => e.causal_parents,
      "contentTag" => e.content_tag,
      "provenanceToken" => e.provenance_token
    }
  end
end
