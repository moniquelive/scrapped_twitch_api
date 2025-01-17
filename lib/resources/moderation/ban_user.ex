defmodule TwitchApi.Moderation.BanUser do
  @moduledoc """
  ⛔ This module is autogenerated please do not modify manually.

  ## Example request from twitch api docs:
  ### descriptions:
  This example bans a user (it doesn’t include the duration field).
  This example puts a user in a 5 minute timeout.
  This example shows what happens if you try to place a banned user in a timeout. You can ban a user that’s already in a timeout but you can’t move a banned user into a timeout. To do this, you’d have to remove the ban and then place them in a timeout.
  You’ll get the same response if you try to ban a user who is already banned.

  ### requests:
  curl -X POST 'https://api.twitch.tv/helix/moderation/bans?broadcaster_id=1234&moderator_id=5678'  
   -H'Authorization: Bearer 4a4x78f5wqvkybms7mxfist3jmzul'  
   -H'Client-Id: t214nt8z1rdtbj69hyarjvh5mi6fh'  
   -H'Content-Type: application/json'  
   -d'{"data": {"user_id":"9876","duration":300,"reason":"no reason"}}'
  curl -X POST 'https://api.twitch.tv/helix/moderation/bans?broadcaster_id=1234&moderator_id=5678'  
   -H'Authorization: Bearer 4a4x78f5wqvkybms7mxfist3jmzul'  
   -H'Client-Id: t214nt8z1rdtbj69hyarjvh5mi6fh'  
   -H'Content-Type: application/json'  
   -d'{"data": {"user_id":"9876","duration":300,"reason":"no reason"}}'
  curl -X POST 'https://api.twitch.tv/helix/moderation/bans?broadcaster_id=1234&moderator_id=5678'  
   -H'Authorization: Bearer 4a4x78f5wqvkybms7mxfist3jmzul'  
   -H'Client-Id: t214nt8z1rdtbj69hyarjvh5mi6fh'  
   -H'Content-Type: application/json'  
   -d'{"data": {"user_id":"9876","reason":"no reason"}}'


  ## Example response from twitch api docs:
  ### descriptions:

  ### responses:
  {"error":"Bad Request","status":400,"message":"user is already banned"}
  {"data":[{"broadcaster_id":"1234","moderator_id":"5678","user_id":"9876","created_at":"2021-09-28T19:27:31Z","end_time":"2021-09-28T19:22:31Z"}]}
  {"data":[{"broadcaster_id":"1234","moderator_id":"5678","user_id":"9876","created_at":"2021-09-28T18:22:31Z","end_time":null}]}
  duration


  """

  alias TwitchApi.MyFinch
  alias TwitchApi.ApiJson.Template.Method.Headers

  @doc """
  ### Description:
  Bans a user from participating in a broadcaster’s chat room, or puts them in a timeout.

  ### Required authentication:
  Requires a User access token with scope set to 
  moderator:manage:banned_users
  .

  ### Required authorization:

  """

  @typedoc """
  The ID of the broadcaster whose chat room the user is being banned from.
  """
  @type broadcaster_id :: %{required(:broadcaster_id) => String.t()}

  @typedoc """
  The ID of a user that has permission to moderate the broadcaster’s chat room. This ID must match the user ID associated with the user OAuth token.If the broadcaster wants to ban the user (instead of having the moderator do it), set this parameter to the broadcaster’s ID, too.
  """
  @type moderator_id :: %{required(:moderator_id) => String.t()}

  @typedoc """
  Map containing the user needed information for the fetch of the required user OAuth access token.
  You will be able to choose from one way or the other for fetching previously OAuth access tokens.
  :user_id field contains the user ID from twitch, e.g. 61425548 or "61425548"
  :user_name field constains the user name from twitch, e.g. "hiimkamiyuzu"
  """
  @type user_info :: %{user_id: integer | binary} | %{user_name: binary}

  @spec call(broadcaster_id | moderator_id, user_info) ::
          {:ok, Finch.Response.t()} | {:error, Exception.t()}
  def call(%{broadcaster_id: broadcaster_id}, user_info) do
    MyFinch.request(
      "POST",
      "https://api.twitch.tv/helix/moderation/bans?broadcaster_id=#{broadcaster_id}",
      Headers.config_oauth_headers(user_info),
      nil
    )
  end

  def call(%{moderator_id: moderator_id}, user_info) do
    MyFinch.request(
      "POST",
      "https://api.twitch.tv/helix/moderation/bans?moderator_id=#{moderator_id}",
      Headers.config_oauth_headers(user_info),
      nil
    )
  end
end
