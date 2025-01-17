defmodule TwitchApi.Chat.GetChatSettings do
  @moduledoc """
  ⛔ This module is autogenerated please do not modify manually.

  ## Example request from twitch api docs:
  ### descriptions:

  ### requests:
  curl -X GET 'https://api.twitch.tv/helix/chat/settings?broadcaster_id=1234'  
   -H'Authorization: Bearer 4a4x78f5wqvkybms7mxfist3jmzul'  
   -H'Client-Id: t214nt8z1rdtbj69hyarjvh5mi6fh'


  ## Example response from twitch api docs:
  ### descriptions:

  ### responses:
  {"data":[{"broadcaster_id":"713936733","slow_mode":false,"slow_mode_wait_time":null,"follower_mode":true,"follower_mode_duration":0,"subscriber_mode":false,"emote_mode":false,"unique_chat_mode":false,"non_moderator_chat_delay":true,"non_moderator_chat_delay_duration":4}]}


  """

  alias TwitchApi.MyFinch
  alias TwitchApi.ApiJson.Template.Method.Headers

  @doc """
  ### Description:
  Gets the broadcaster’s chat settings.

  ### Required authentication:


  ### Required authorization:
  Requires an App access token. However, to include the non_moderator_chat_delay or non_moderator_chat_delay_duration settings in the response, you must specify a User access token with scope set to moderator:read:chat_settings.
  """

  @typedoc """
  The ID of the broadcaster whose chat settings you want to get.
  """
  @type broadcaster_id :: %{required(:broadcaster_id) => String.t()}

  @typedoc """
  Required only to access the non_moderator_chat_delay or non_moderator_chat_delay_duration settings.The ID of a user that has permission to moderate the broadcaster’s chat room. This ID must match the user ID associated with the user OAuth token.If the broadcaster wants to get their own settings (instead of having the moderator do it), set this parameter to the broadcaster’s ID, too.
  """
  @type moderator_id :: %{required(:moderator_id) => String.t()}

  @spec call(broadcaster_id | moderator_id) :: {:ok, Finch.Response.t()} | {:error, Exception.t()}
  def call(%{broadcaster_id: broadcaster_id}) do
    MyFinch.request(
      "GET",
      "https://api.twitch.tv/helix/chat/settings?broadcaster_id=#{broadcaster_id}",
      Headers.config_headers(),
      nil
    )
  end

  def call(%{moderator_id: moderator_id}) do
    MyFinch.request(
      "GET",
      "https://api.twitch.tv/helix/chat/settings?moderator_id=#{moderator_id}",
      Headers.config_headers(),
      nil
    )
  end
end
