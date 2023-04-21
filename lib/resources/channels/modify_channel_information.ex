defmodule TwitchApi.Channels.ModifyChannelInformation do
  @moduledoc """
  ⛔ This module is autogenerated please do not modify manually.

  ## Example request from twitch api docs:
  ### descriptions:

  ### requests:
  curl -X PATCH 'https://api.twitch.tv/helix/channels?broadcaster_id=41245072'  
   -H'Authorization: Bearer 2gbdx6oar67tqtcmt49t3wpcgycthx'  
   -H'Client-Id: wbmytr93xzw8zbg0p1izqyzzc5mbiz'  
   -H'Content-Type: application/json'  
   --data-raw'{"game_id":"33214", "title":"there are helicopters in the game? REASON TO PLAY FORTNITE found", "broadcaster_language":"en"}'


  ## Example response from twitch api docs:
  ### descriptions:

  ### responses:
  204NoContent


  """

  alias TwitchApi.MyFinch
  alias TwitchApi.ApiJson.Template.Method.Headers

  @doc """
  ### Description:
  Modifies channel information for users.

  ### Required authentication:
  OAuth Token required
  Required scope: channel:manage:broadcast

  ### Required authorization:

  """

  @typedoc """
  ID of the channel to be updated
  """
  @type broadcaster_id :: %{required(:broadcaster_id) => String.t()}

  # The language of the channel. A language value must be either the ISO 639-1 two-letter code for a supported stream language or “other”.
  @typep body_params ::
           %{
             required(:broadcaster_language) => String.t(),
             # Stream delay in seconds. Stream delay is a Twitch Partner feature; trying to set this value for other account types will return a 400 error.
             required(:delay) => integer,
             # The current game ID being played on the channel. Use “0” or “” (an empty string) to unset the game.
             required(:game_id) => String.t(),
             # The title of the stream. Value must not be an empty string.
             required(:title) => String.t()
           }
           | nil
  @typedoc """
  Map containing the user needed information for the fetch of the required user OAuth access token.
  You will be able to choose from one way or the other for fetching previously OAuth access tokens.
  :user_id field contains the user ID from twitch, e.g. 61425548 or "61425548"
  :user_name field constains the user name from twitch, e.g. "hiimkamiyuzu"
  """
  @type user_info :: %{user_id: integer | binary} | %{user_name: binary}

  @spec call(broadcaster_id, body_params, user_info) ::
          {:ok, Finch.Response.t()} | {:error, Exception.t()}
  def call(%{broadcaster_id: broadcaster_id}, body_params, user_info) do
    MyFinch.request(
      "PATCH",
      "https://api.twitch.tv/helix/channels?broadcaster_id=#{broadcaster_id}",
      Headers.config_oauth_headers(user_info),
      body_params
    )
  end
end
