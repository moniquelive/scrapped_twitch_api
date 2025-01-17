defmodule TwitchApi.Moderation.UnbanUser do
  @moduledoc """
  ⛔ This module is autogenerated please do not modify manually.

  ## Example request from twitch api docs:
  ### descriptions:
  This example removes a ban or timeout from a user.
  This example tries to remove a ban or timeout from a user that is not currently banned or in a timeout.

  ### requests:
  curl -X DELETE 'https://api.twitch.tv/helix/moderation/bans?broadcaster_id=1234&moderator_id=5678&user_id=5432'  
   -H'Authorization: Bearer 4a4x78f5wqvkybms7mxfist3jmzul'  
   -H'Client-Id: t214nt8z1rdtbj69hyarjvh5mi6fh'
  curl -X DELETE 'https://api.twitch.tv/helix/moderation/bans?broadcaster_id=1234&moderator_id=5678&user_id=9876'  
   -H'Authorization: Bearer 4a4x78f5wqvkybms7mxfist3jmzul'  
   -H'Client-Id: t214nt8z1rdtbj69hyarjvh5mi6fh'


  ## Example response from twitch api docs:
  ### descriptions:

  ### responses:
  {"error":"Bad Request","status":400,"message":"user is not banned"}
  204NoContent


  """

  alias TwitchApi.MyFinch
  alias TwitchApi.ApiJson.Template.Method.Headers

  @doc """
  ### Description:
  Removes the ban or timeout that was placed on the specified user.

  ### Required authentication:
  Requires a User access token with scope set to 
  moderator:manage:banned_users
  .

  ### Required authorization:

  """

  @typedoc """
  The ID of the broadcaster whose chat room the user is banned from chatting in.
  """
  @type broadcaster_id :: %{required(:broadcaster_id) => String.t()}

  @typedoc """
  The ID of a user that has permission to moderate the broadcaster’s chat room. This ID must match the user ID associated with the user OAuth token.If the broadcaster wants to remove the ban (instead of having the moderator do it), set this parameter to the broadcaster’s ID, too.
  """
  @type moderator_id :: %{required(:moderator_id) => String.t()}

  @typedoc """
  The ID of the user to remove the ban or timeout from.
  """
  @type user_id :: %{required(:user_id) => String.t()}

  @typedoc """
  Map containing the user needed information for the fetch of the required user OAuth access token.
  You will be able to choose from one way or the other for fetching previously OAuth access tokens.
  :user_id field contains the user ID from twitch, e.g. 61425548 or "61425548"
  :user_name field constains the user name from twitch, e.g. "hiimkamiyuzu"
  """
  @type user_info :: %{user_id: integer | binary} | %{user_name: binary}

  @spec call(broadcaster_id | moderator_id | user_id, user_info) ::
          {:ok, Finch.Response.t()} | {:error, Exception.t()}
  def call(%{broadcaster_id: broadcaster_id}, user_info) do
    MyFinch.request(
      "DELETE",
      "https://api.twitch.tv/helix/moderation/bans?broadcaster_id=#{broadcaster_id}",
      Headers.config_oauth_headers(user_info),
      nil
    )
  end

  def call(%{moderator_id: moderator_id}, user_info) do
    MyFinch.request(
      "DELETE",
      "https://api.twitch.tv/helix/moderation/bans?moderator_id=#{moderator_id}",
      Headers.config_oauth_headers(user_info),
      nil
    )
  end

  def call(%{user_id: user_id}, user_info) do
    MyFinch.request(
      "DELETE",
      "https://api.twitch.tv/helix/moderation/bans?user_id=#{user_id}",
      Headers.config_oauth_headers(user_info),
      nil
    )
  end
end
