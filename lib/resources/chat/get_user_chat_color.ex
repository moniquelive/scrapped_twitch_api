defmodule TwitchApi.Chat.GetUserChatColor do
  @moduledoc """
  ⛔ This module is autogenerated please do not modify manually.

  ## Example request from twitch api docs:
  ### descriptions:
  Gets the color code used for the specified users’ chat name.

  ### requests:
  curl -X GET 'https://api.twitch.tv/helix/chat/color?user_id=11111&user_id=44444'  
   -H'Authorization: Bearer kpvy3cjboyptmdkiacwr0c19hotn5s'  
   -H'Client-Id: hof5gwx0su6owfnys0nyan9c87zr6t'


  ## Example response from twitch api docs:
  ### descriptions:

  ### responses:
  {"data":[{"user_id":"11111","user_name":"SpeedySpeedster1","user_login":"speedyspeedster1","color":"#9146FF"},{"user_id":"44444","user_name":"SpeedySpeedster2","user_login":"speedyspeedster2","color":""}]}


  """

  alias TwitchApi.MyFinch
  alias TwitchApi.ApiJson.Template.Method.Headers

  @doc """
  ### Description:
  NEW Gets the color used for the user’s name in chat.

  ### Required authentication:


  ### Required authorization:
  Requires an app access token or user access token.
  """

  @typedoc """
  The ID of the user whose color you want to get. To specify more than one user, include the user_id parameter for each user to get. For example, &user_id=1234&user_id=5678. The maximum number of IDs that you may specify is 100.The response ignores duplicate IDs and IDs that aren’t found.
  """
  @type user_id :: %{required(:user_id) => String.t()}

  @spec call(user_id) :: {:ok, Finch.Response.t()} | {:error, Exception.t()}
  def call(%{user_id: user_id}) do
    MyFinch.request(
      "GET",
      "https://api.twitch.tv/helix/chat/color?user_id=#{user_id}",
      Headers.config_headers(),
      nil
    )
  end
end