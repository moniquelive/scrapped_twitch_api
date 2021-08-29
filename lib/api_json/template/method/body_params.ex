defmodule TwitchApi.ApiJson.Template.Method.BodyParams do
  @moduledoc """
  Provides the body params methods template for a twitch api item module
  """
  alias TwitchApi.ApiJson.Item
  alias TwitchApi.ApiJson.Template.Method.Args

  @typep body_params ::
           {specs :: String.t(), method_param :: String.t(), request_param :: String.t()}

  @doc """
  Provides the twitch api Elixir body_params method for a twitch api item
  """
  @spec set_body_params(Item.t()) :: body_params
  def set_body_params(item) do
    case Args.body_params(item) do
      "" -> {"", "", ", nil"}
      parsed_body -> configure_body_params(parsed_body)
    end
  end

  @spec configure_body_params(String.t()) :: body_params
  defp configure_body_params(parsed_body) do
    {"#{parsed_body}", "body_params", ", body_params"}
  end

  @doc """
  Parses the twitch api Elixir body_params method for a twitch api item
  """
  @spec parse_body_params(String.t(), body_params) :: body_params
  def parse_body_params("", body_params), do: body_params

  def parse_body_params(_, {spec, method_params, ", nil"}) do
    {spec, method_params, ", nil"}
  end

  def parse_body_params(_, {spec, method_params, body_params}) do
    {spec, ", " <> method_params, body_params}
  end

  @doc """
  Provides the twitch api Elixir body_params method specs for a twitch api item
  """
  @spec parse_body_specs(String.t()) :: [String.t()]
  def parse_body_specs(""), do: [""]
  def parse_body_specs(specs), do: ["@typep body_params :: " <> specs]
end
