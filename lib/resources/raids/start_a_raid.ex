defmodule TwitchApi.Raids.Startaraid do
  @moduledoc """
  ⛔ This module is autogenerated please do not modify manually.

  ## Example request from twitch api docs:
  ### descriptions:

  ### requests:
  curl -X POST 'https://api.twitch.tv/helix/raids?from_broadcaster_id=12345678&to_broadcaster_id=87654321'  
   -H'Authorization: Bearer kpvy3cjboyptmdkiacwr0c19hotn5s'  
   -H'Client-Id: hof5gwx0su6owfnys0nyan9c87zr6t'


  ## Example response from twitch api docs:
  ### descriptions:

  ### responses:
  {"data":[{"created_at":"2022-02-18T07:20:50.52Z","is_mature":false}]}


  """

  alias TwitchApi.MyFinch
  alias TwitchApi.ApiJson.Template.Method.Headers

  @doc """
  ### Description:
  NEW Raid another channel by sending the broadcaster’s viewers to the targeted channel.

  ### Required authentication:


  ### Required authorization:
  Requires a user access token that includes the channel:manage:raids scope. The  ID in the from_broadcaster_id query parameter must match the user ID in the OAuth token.
  """

  @spec call() :: {:ok, Finch.Response.t()} | {:error, Exception.t()}
  def call do
    MyFinch.request("POST", "https://api.twitch.tv/helix/raids", Headers.config_headers(), nil)
  end
end
