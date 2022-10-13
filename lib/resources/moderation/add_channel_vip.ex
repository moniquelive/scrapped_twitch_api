defmodule TwitchApi.Moderation.AddChannelVIP do
  @moduledoc """
  ⛔ This module is autogenerated please do not modify manually.

  ## Example request from twitch api docs:
  ### descriptions:
  Adds a VIP to the broadcaster’s chat room.

  ### requests:
  curl -X POST 'https://api.twitch.tv/helix/channels/vips?broadcaster_id=123&user_id=456'  
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
  NEW Adds a VIP to the broadcaster’s chat room.

  ### Required authentication:


  ### Required authorization:
  Requires a user access token that includes the channel:manage:vips scope. The ID in the broadcaster_id query parameter must match the user ID in the access token.
  """

  @typedoc """
  The ID of the user to add as a VIP in the broadcaster’s chat room.
  """
  @type user_id :: %{required(:user_id) => String.t()}

  @typedoc """
  The ID of the broadcaster that’s granting VIP status to the user.
  """
  @type broadcaster_id :: %{required(:broadcaster_id) => String.t()}

  @spec call(user_id | broadcaster_id) :: {:ok, Finch.Response.t()} | {:error, Exception.t()}
  def call(%{user_id: user_id}) do
    MyFinch.request(
      "POST",
      "https://api.twitch.tv/helix/channels/vips?user_id=#{user_id}",
      Headers.config_headers(),
      nil
    )
  end

  def call(%{broadcaster_id: broadcaster_id}) do
    MyFinch.request(
      "POST",
      "https://api.twitch.tv/helix/channels/vips?broadcaster_id=#{broadcaster_id}",
      Headers.config_headers(),
      nil
    )
  end
end
