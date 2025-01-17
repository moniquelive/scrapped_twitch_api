defmodule TwitchApi.Games.GetGames do
  @moduledoc """
  ⛔ This module is autogenerated please do not modify manually.

  ## Example request from twitch api docs:
  ### descriptions:
  This gets information for game ID 493057.

  ### requests:
  curl -X GET 'https://api.twitch.tv/helix/games?id=493057'  
   -H'Authorization: Bearer cfabdegwdoklmawdzdo98xt2fo512y'  
   -H'Client-Id: uo6dggojyb8d6soh92zknwmi5ej1q2'


  ## Example response from twitch api docs:
  ### descriptions:

  ### responses:
  {"data":[{"box_art_url":"https://static-cdn.jtvnw.net/ttv-boxart/Fortnite-52x72.jpg","id":"33214","name":"Fortnite"}...],"pagination":{"cursor":"eyJiIjpudWxsLCJhIjp7IkN"}}


  """

  alias TwitchApi.MyFinch
  alias TwitchApi.ApiJson.Template.Method.Headers

  @doc """
  ### Description:
  Gets game information by game ID or name.

  ### Required authentication:
  OAuth or App Access Token required.

  ### Required authorization:

  """

  @typedoc """
  Game ID. At most 100 id values can be specified.
  """
  @type id :: %{required(:id) => String.t()}

  @typedoc """
  Game name. The name must be an exact match. For example, “Pokemon” will not return a list of Pokemon games; instead, query any specific Pokemon games in which you are interested. At most 100 name values can be specified.
  """
  @type name :: %{required(:name) => String.t()}

  @spec call(id | name) :: {:ok, Finch.Response.t()} | {:error, Exception.t()}
  def call(%{id: id}) do
    MyFinch.request(
      "GET",
      "https://api.twitch.tv/helix/games?id=#{id}",
      Headers.config_headers(),
      nil
    )
  end

  def call(%{name: name}) do
    MyFinch.request(
      "GET",
      "https://api.twitch.tv/helix/games?name=#{name}",
      Headers.config_headers(),
      nil
    )
  end
end
