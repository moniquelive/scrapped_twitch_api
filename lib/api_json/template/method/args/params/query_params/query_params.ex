defmodule TwitchApi.ApiJson.Template.Method.Args.Params.Query do
  @moduledoc """
  Provides the query params arguments methods template for a twitch api item module
  """
  alias TwitchApi.ApiJson.Item

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
    |> Enum.reject(&(&1.param == ""))
    |> Enum.map(
      &{&1, parse_param_type(&1.type),
       Map.put(%{}, &1.param, &1.param)
       |> Jason.encode!()
       |> String.replace(~r/\"/, "")
       |> String.replace(~r/:/, ": ")}
    )
  end

  @spec parse_param_type(binary) :: binary
  defp parse_param_type("string"), do: "String.t()"
  defp parse_param_type(_), do: raise("Unexpected type")

  @doc """
  Parses the twitch api Elixir query params from an item
  """
  @spec get_types([parsed_params]) :: [String.t()]
  def get_types(query_params) do
    Enum.map(query_params, fn {query_param, type, _} ->
      "@typep #{query_param.param} :: %{required(:#{query_param.param}) => #{type}} \# #{
        query_param.description
      }"
    end)
  end
end
