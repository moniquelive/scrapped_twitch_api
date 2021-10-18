defmodule TwitchApi.ApiJson.Template.Method.Args.Params.Query do
  @moduledoc """
  Provides the query params arguments methods template for a twitch api item module
  """
  alias TwitchApi.ApiJson.Item

  @reject_values ["", "App AccessOAuth Token", "User OAuth Token", "App Access OAuth Token"]

  @spec parse_query_params([Item.Request.Param.t()]) :: [parsed_params]
  def parse_query_params(params) when length(params) > 0, do: get_params(params)
  def parse_query_params(_), do: []

  @type parsed_params ::
          {param :: String.t(), parsed_type :: String.t(), parsed_map :: String.t()}

  @doc """
  Provides the twitch api Elixir query params for a twitch api request param item
  """
  @spec get_params([Item.Request.Param.t()]) :: [parsed_params]
  def get_params(params) do
    params
    |> Enum.reject(&(&1.param in @reject_values))
    |> Enum.map(
      &{&1, parse_param_type(&1.type),
       Map.put(%{}, &1.param, parse_query_param_type(&1.param))
       |> Jason.encode!()
       |> String.replace(~r/\"/, "")
       |> String.replace(~r/:/, ": ")}
    )
  end

  defp parse_param_type("string"), do: "String.t()"
  defp parse_param_type("integer"), do: "integer"
  defp parse_param_type("Boolean"), do: "boolean"
  defp parse_param_type("boolean"), do: "boolean"
  defp parse_param_type("array"), do: "list"
  defp parse_param_type(param), do: raise("Unexpected type:" <> param)

  @doc """
  Parses the twitch api Elixir query params from an item
  """
  @spec get_types([parsed_params]) :: [String.t()]
  def get_types(query_params) do
    Enum.map(query_params, fn {query_param, type, _} ->
      parsed_query_param = parse_query_param_type(query_param.param)

      "@type #{parsed_query_param} :: %{required(:#{parsed_query_param}) => #{type}} \# #{query_param.description}"
    end)
  end

  @doc """
  Parses Elixir after reserved keyword
  """
  @spec parse_query_param_type(String.t()) :: String.t()
  def parse_query_param_type("after"), do: "after_query_param"
  def parse_query_param_type(query_param), do: query_param
end
