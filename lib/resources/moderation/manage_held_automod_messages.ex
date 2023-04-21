defmodule TwitchApi.Moderation.ManageHeldAutoModMessages do
  @moduledoc """
  ⛔ This module is autogenerated please do not modify manually.

  ## Example request from twitch api docs:
  ### descriptions:
  Allow a message being held by AutoMod.
  Deny a message being held by AutoMod.

  ### requests:
  curl -X POST 'https://api.twitch.tv/helix/moderation/automod/message'  
   -H'Authorization: Bearer cfabdegwdoklmawdzdo98xt2fo512y'  
   -H'Client-Id: uo6dggojyb8d6soh92zknwmi5ej1q2'  
   -H'Content-Type: application/json'  
   -d'{
    "user_id": "9327994",
    "msg_id": "836013710",
    "action": "DENY"
   }'
  curl -X POST 'https://api.twitch.tv/helix/moderation/automod/message'  
   -H'Authorization: Bearer cfabdegwdoklmawdzdo98xt2fo512y'  
   -H'Client-Id: uo6dggojyb8d6soh92zknwmi5ej1q2'  
   -H'Content-Type: application/json'  
   -d'{
    "user_id": "9327994",
    "msg_id": "836013710",
    "action": "ALLOW"
   }'


  ## Example response from twitch api docs:
  ### descriptions:
  Shows that a message was successfully allowed.
  Shows that a message was successfully denied.

  ### responses:
  204NoContent
  204NoContent


  """

  alias TwitchApi.MyFinch
  alias TwitchApi.ApiJson.Template.Method.Headers

  @doc """
  ### Description:
  Allow or deny a message that was held for review by AutoMod.

  ### Required authentication:


  ### Required authorization:
  User OAuth token requiredRequired Scope: moderator:manage:automod
  Note that the scope allows this endpoint to be used for any channel that the authenticated user is a moderator, including their own channel.
  """

  @typedoc """
  Map containing the user needed information for the fetch of the required user OAuth access token.
  You will be able to choose from one way or the other for fetching previously OAuth access tokens.
  :user_id field contains the user ID from twitch, e.g. 61425548 or "61425548"
  :user_name field constains the user name from twitch, e.g. "hiimkamiyuzu"
  """
  @type user_info :: %{user_id: integer | binary} | %{user_name: binary}

  # The action to take for the message. Must be \ALLOW\ or \DENY\.
  @spec call(
          %{
            required(:action) => String.t(),
            # ID of the message to be allowed or denied. These message IDs are retrieved from PubSub as mentioned above. Only one message ID can be provided.
            required(:msg_id) => String.t(),
            # The moderator who is approving or rejecting the held message. Must match the user_id in the user OAuth token.
            required(:user_id) => String.t()
          }
          | nil,
          user_info
        ) :: {:ok, Finch.Response.t()} | {:error, Exception.t()}
  def call(body_params, user_info) do
    MyFinch.request(
      "POST",
      "https://api.twitch.tv/helix/moderation/automod/message",
      Headers.config_oauth_headers(user_info),
      body_params
    )
  end
end
