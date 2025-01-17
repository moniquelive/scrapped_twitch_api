defmodule TwitchApi.Entitlements.GetDropsEntitlements do
  @moduledoc """
  ⛔ This module is autogenerated please do not modify manually.

  ## Example request from twitch api docs:
  ### descriptions:

  ### requests:
  curl -H GET 'helix/entitlements/drops?user_id=25009227&game_id=33214'  
   -H'Authorization: Bearer cfabdegwdoklmawdzdo98xt2fo512y'  
   -H'Client-Id: uo6dggojyb8d6soh92zknwmi5ej1q2'


  ## Example response from twitch api docs:
  ### descriptions:

  ### responses:
  {"data":[{"id":"fb78259e-fb81-4d1b-8333-34a06ffc24c0","benefit_id":"74c52265-e214-48a6-91b9-23b6014e8041","timestamp":"2019-01-28T04:17:53.325Z","user_id":"25009227","game_id":"33214","fulfillment_status":"CLAIMED","updated_at":"2019-01-28T04:17:53.325Z"},{"id":"862750a5-265e-4ab6-9f0a-c64df3d54dd0","benefit_id":"74c52265-e214-48a6-91b9-23b6014e8041","timestamp":"2019-01-28T04:16:53.325Z","user_id":"25009227","game_id":"33214","fulfillment_status":"CLAIMED","updated_at":"2021-06-15T04:16:53.325Z"},{"id":"d8879baa-3966-4d10-8856-15fdd62cce02","benefit_id":"cdfdc5c3-65a2-43bc-8767-fde06eb4ab2c","timestamp":"2019-01-28T04:15:53.325Z","user_id":"25009227","game_id":"33214","fulfillment_status":"FULFILLED","updated_at":"2019-01-28T04:17:53.325Z"},...],"pagination":{"cursor":"eyJiIjpudW..."}}


  """

  alias TwitchApi.MyFinch
  alias TwitchApi.ApiJson.Template.Method.Headers

  @doc """
  ### Description:
  Gets a list of entitlements for a given organization that have been granted to a game, user, or both.

  ### Required authentication:
  User OAuth Token or App Access Token

  ### Required authorization:
  The client ID associated with the access token must have ownership of the game:
  Client ID > Organization ID > Game ID
  """

  @typedoc """
  Unique identifier of the entitlement.
  """
  @type id :: %{required(:id) => String.t()}

  @typedoc """
  A Twitch user ID.
  """
  @type user_id :: %{required(:user_id) => String.t()}

  @typedoc """
  A Twitch game ID.
  """
  @type game_id :: %{required(:game_id) => String.t()}

  @typedoc """
  An optional fulfillment status used to filter entitlements. Valid values are "CLAIMED" or "FULFILLED".
  """
  @type fulfillment_status :: %{required(:fulfillment_status) => String.t()}

  @typedoc """
  The cursor used to fetch the next page of data.
  """
  @type after_query_param :: %{required(:after_query_param) => String.t()}

  @typedoc """
  Maximum number of entitlements to return.Default: 20Max: 1000
  """
  @type first :: %{required(:first) => integer}

  @spec call(id | user_id | game_id | fulfillment_status | after_query_param | first) ::
          {:ok, Finch.Response.t()} | {:error, Exception.t()}
  def call(%{id: id}) do
    MyFinch.request(
      "GET",
      "https://api.twitch.tv/helix/entitlements/drops?id=#{id}",
      Headers.config_headers(),
      nil
    )
  end

  def call(%{user_id: user_id}) do
    MyFinch.request(
      "GET",
      "https://api.twitch.tv/helix/entitlements/drops?user_id=#{user_id}",
      Headers.config_headers(),
      nil
    )
  end

  def call(%{game_id: game_id}) do
    MyFinch.request(
      "GET",
      "https://api.twitch.tv/helix/entitlements/drops?game_id=#{game_id}",
      Headers.config_headers(),
      nil
    )
  end

  def call(%{fulfillment_status: fulfillment_status}) do
    MyFinch.request(
      "GET",
      "https://api.twitch.tv/helix/entitlements/drops?fulfillment_status=#{fulfillment_status}",
      Headers.config_headers(),
      nil
    )
  end

  def call(%{after: after_query_param}) do
    MyFinch.request(
      "GET",
      "https://api.twitch.tv/helix/entitlements/drops?after=#{after_query_param}",
      Headers.config_headers(),
      nil
    )
  end

  def call(%{first: first}) do
    MyFinch.request(
      "GET",
      "https://api.twitch.tv/helix/entitlements/drops?first=#{first}",
      Headers.config_headers(),
      nil
    )
  end
end
