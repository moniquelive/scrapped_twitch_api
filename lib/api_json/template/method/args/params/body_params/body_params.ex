defmodule TwitchApi.ApiJson.Template.Method.Args.Params.Body do
  @moduledoc """
  Provides the body params arguments methods template for a twitch api item module
  """
  alias TwitchApi.ApiJson.Item

  @doc """
  Provides the twitch api Elixir body params for a twitch api request param item
  """
  @spec parse_body_params([Item.Request.Param.t()]) :: String.t()
  def parse_body_params(params) when length(params) > 0, do: get_params(params)
  def parse_body_params(_), do: ""

  @type parsed_params ::
          {param :: String.t(), parsed_type :: String.t(), parsed_map :: String.t()}

  @spec get_params([Item.Request.Param.t()]) :: String.t()
  defp get_params(params) do
    params
    |> Enum.reject(&(&1.param == ""))
    |> Enum.reduce(%{}, &Map.put(&2, &1.param, &1))
    |> parse_body_params_key_objects()
    |> parse_body_params_map()
    |> Jason.encode!()
    |> String.replace(~r/{/, "%{")
    |> String.replace(~r/\"/, "")
    |> String.replace(~r/,/, "")
    |> String.replace(~r/coma_replace/, ",")
    |> String.replace(~r/end_line/, "\n    ")
    |> String.replace(~r/description:/, "")
    |> String.replace(~r/}/, "},\n    ")
    |> String.replace(~r/:/, " => ")
    |> String.replace(~r/two_dots_replace/, ":")
    |> Kernel.<>("| nil")
    |> String.replace("},\n    | nil", "} | nil")
  end

  @spec parse_body_params_key_objects(map) :: map
  defp parse_body_params_key_objects(body_params_map) do
    keys = Map.keys(body_params_map)

    keys_to_add =
      Enum.reduce(keys, [], fn key_item, acc ->
        case String.split(key_item, ".") do
          [key, new_key] -> [{key, new_key, key_item} | acc]
          _ -> acc
        end
      end)

    keys
    |> Enum.filter(
      &Enum.any?(keys_to_add, fn {old_key, _, _} ->
        String.contains?(&1, old_key) and not String.contains?(&1, ".")
      end)
    )
    |> Enum.reduce(body_params_map, fn key_to_delete, acc_delete ->
      Enum.reduce(keys_to_add, acc_delete, fn {_, new_key, key_item}, acc_update ->
        value = Map.get(acc_update, key_item)
        map = Map.get(acc_update, key_to_delete)
        merged_map = Map.merge(map, %{new_key => value})
        updated_map = Map.put(acc_update, key_to_delete, merged_map)
        Map.delete(updated_map, key_item)
      end)
    end)
  end

  @spec parse_body_params_map(map) :: map
  defp parse_body_params_map(body_params_map) do
    for {k, v} <- body_params_map, into: %{}, do: {parse_spec_key(k), parse_spec_value(v)}
  end

  @spec parse_spec_key(String.t()) :: String.t()
  defp parse_spec_key(param), do: "required(two_dots_replace" <> param <> ")"

  @spec parse_spec_value(Item.Request.Param.t()) :: String.t()
  defp parse_spec_value(%{description: description, type: "object"} = map) do
    parsed_value = %{description: "# " <> description <> "end_line"}
    values = Map.drop(map, [:__struct__, :description, :param, :type])
    parsed_map = for {k, v} <- values, into: %{}, do: {parse_spec_key(k), parse_spec_value(v)}
    Map.merge(parsed_map, parsed_value)
  end

  defp parse_spec_value(%{description: description, type: type}) do
    parse_param_type(type) <> "coma_replace # " <> description <> "end_line"
  end

  @spec parse_param_type(binary) :: String.t() | map
  defp parse_param_type("String"), do: "String.t()"
  defp parse_param_type("string"), do: "String.t()"
  defp parse_param_type("integer"), do: "integer"
  defp parse_param_type("boolean"), do: "boolean"
  defp parse_param_type("array"), do: "list"
  defp parse_param_type("condition"), do: "String.t()"
  defp parse_param_type("transport"), do: "String.t()"
  defp parse_param_type("object[]"), do: "list(map)"
end
