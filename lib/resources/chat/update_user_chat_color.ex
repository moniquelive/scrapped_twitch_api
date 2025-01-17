defmodule TwitchApi.Chat.UpdateUserChatColor do
  @moduledoc """
  ⛔ This module is autogenerated please do not modify manually.

  ## Example request from twitch api docs:
  ### descriptions:
  Uses a named color to change the color that the user uses for their name in chat.
  Uses a color Hex code to change the color that the user uses for their name in chat.

  ### requests:
  curl -X PUT 'https://api.twitch.tv/helix/chat/color?user_id=123&color=%239146FF'  
   -H'Authorization: Bearer kpvy3cjboyptmdkiacwr0c19hotn5s'  
   -H'Client-Id: hof5gwx0su6owfnys0nyan9c87zr6t'
  curl -X PUT 'https://api.twitch.tv/helix/chat/color?user_id=123&color=blue'  
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
  NEW Updates the color used for the user’s name in chat.

  ### Required authentication:


  ### Required authorization:
  Requires a user access token that includes the user:manage:chat_color scope. The ID in the user_id query parameter must match the user ID in the access token.
  """

  @typedoc """
  The ID of the user whose chat color you want to update.
  """

  # @type user_id :: %{required(:user_id) => String.t()}

  @typedoc """
  The color to use for the user’s name in chat. All users may specify one of the following named color values.blueblue_violetcadet_bluechocolatecoraldodger_bluefirebrickgolden_rodgreenhot_pinkorange_redredsea_greenspring_greenyellow_greenTurbo and Prime users may specify a named color or a Hex color code like #9146FF. If you use a Hex color code, remember to URL encode it.
  """

  # @type color :: %{required(:color) => String.t()}

  # @spec call(user_id, color) :: {:ok, Finch.Response.t()} | {:error, Exception.t()}
  def call(%{user_id: user_id} = user, %{color: color}) do
    MyFinch.request(
      "PUT",
      "https://api.twitch.tv/helix/chat/color?user_id=#{user_id}&color=#{color}",
      Headers.config_oauth_headers(user) ++ [{"content-type", "application/json"}],
      nil
    )
  end
end
