defmodule TwitchApi.Search.SearchCategories do
  @moduledoc """
  ⛔ This module is autogenerated please do not modify manually.

  ## Example request from twitch api docs:
  ### descriptions:
  This request queries for games and categories.

  ### requests:
  curl -X GET 'https://api.twitch.tv/helix/search/categories?query=fort'  
   -H'Authorization: Bearer 2gbdx6oar67tqtcmt49t3wpcgycthx'  
   -H'Client-Id: wbmytr93xzw8zbg0p1izqyzzc5mbiz'


  ## Example response from twitch api docs:
  ### descriptions:

  ### responses:
  {"data":[{"id":"33214","name":"Fortnite","box_art_url":"https://static-cdn.jtvnw.net/ttv-boxart/Fortnite-{width}x{height}.jpg"},...],"pagination":{"cursor":"eyJiIjpudWxsLCJhIjp7IkN"}}


  """

  alias TwitchApi.MyFinch
  alias TwitchApi.ApiJson.Template.Method.Headers

  @doc """
  ### Description:
  Returns a list of games or categories that match the query via name either entirely or partially.

  ### Required authentication:
  OAuth or App Access Token required

  ### Required authorization:

  """

  @typedoc """
  URl encoded search query
  """
  @type query :: %{required(:query) => String.t()}

  @typedoc """
  Maximum number of objects to return.Maximum: 100.Default: 20.
  """
  @type first :: %{required(:first) => integer}

  @typedoc """
  Cursor for forward pagination: tells the server where to start fetching the next set of results, in a multi-page response. The cursor value specified here is from the pagination response field of a prior query.
  """
  @type after_query_param :: %{required(:after_query_param) => String.t()}

  @spec call(query | first | after_query_param) ::
          {:ok, Finch.Response.t()} | {:error, Exception.t()}
  def call(%{query: query}) do
    MyFinch.request(
      "GET",
      "https://api.twitch.tv/helix/search/categories?query=#{query}",
      Headers.config_headers(),
      nil
    )
  end

  def call(%{first: first}) do
    MyFinch.request(
      "GET",
      "https://api.twitch.tv/helix/search/categories?first=#{first}",
      Headers.config_headers(),
      nil
    )
  end

  def call(%{after: after_query_param}) do
    MyFinch.request(
      "GET",
      "https://api.twitch.tv/helix/search/categories?after=#{after_query_param}",
      Headers.config_headers(),
      nil
    )
  end
end
