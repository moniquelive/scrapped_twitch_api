defmodule TwitchApi.Raids.Cancelaraid do
  @moduledoc """
  ⛔ This module is autogenerated please do not modify manually.

  ## Example request from twitch api docs:
  ### descriptions:

  ### requests:
  curl -X DELETE 'https://api.twitch.tv/helix/raids?broadcaster_id=12345678'  
   -H'Authorization: Bearer kpvy3cjboyptmdkiacwr0c19hotn5s'  
   -H'Client-Id: hof5gwx0su6owfnys0nyan9c87zr6t'


  ## Example response from twitch api docs:
  ### descriptions:

  ### responses:


  """

  alias TwitchApi.MyFinch
  alias TwitchApi.ApiJson.Template.Method.Headers

  @doc """
  ### Description:
  NEW Cancel a pending raid.

  ### Required authentication:


  ### Required authorization:
  Requires a user access token that includes the channel:manage:raids scope. The  ID in the broadcaster_id query parameter must match the user ID in the OAuth token.
  """

  @spec call() :: {:ok, Finch.Response.t()} | {:error, Exception.t()}
  def call do
    MyFinch.request("DELETE", "https://api.twitch.tv/helix/raids", Headers.config_headers(), nil)
  end
end
