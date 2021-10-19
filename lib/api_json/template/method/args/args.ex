defmodule TwitchApi.ApiJson.Template.Method.Args do
  @moduledoc """
  Provides the arguments methods template for a twitch api item module
  """
  alias TwitchApi.ApiJson.Item
  alias TwitchApi.ApiJson.Template.Method.Args.{Authorization, Authentication}
  alias TwitchApi.ApiJson.Template.Method.Args.Params.{Query, Body}

  @doc """
  Provides the twitch api Elixir query_params for a twitch api item
  """
  @spec query_params(Item.t()) :: [Query.parsed_params()]
  def query_params(item) do
    query_params = item.request.query_params ++ item.request.optional_query_params
    Query.parse_query_params(query_params)
  end

  @doc """
  Provides the twitch api Elixir body_params for a twitch api item
  """
  @spec body_params(Item.t()) :: String.t()
  def body_params(item) do
    Body.parse_body_params(item.request.body_params)
  end

  @doc """
  Provides the twitch api Elixir authorization for a twitch api item
  """
  @spec authorization(Item.t()) :: boolean | :not_supported
  def authorization(item) do
    Authorization.parse_authorization(item.request.authorization)
  end

  @doc """
  Provides the twitch api Elixir authentication for a twitch api item
  """
  @spec authentication(Item.t()) :: boolean | :not_supported
  def authentication(item) do
    Authentication.parse_authentication(item.request.authentication)
  end
end
