defmodule TwitchApi.Moderation.AddBlockedTerm do
  @moduledoc """
  ⛔ This module is autogenerated please do not modify manually.

  ## Example request from twitch api docs:
  ### descriptions:
  This example adds a blocked term. Trying to add the same term again will return the previously added term.
  This example adds a term that uses the wildcard character (*).

  ### requests:
  curl -X POST 'https://api.twitch.tv/helix/moderation/blocked_terms?broadcaster_id=1234&moderator_id=5678'  
   -H'Authorization: Bearer 789nj68b49pwqs9nh2y2jrlgzju3f'  
   -H'Client-Id: t214nt8z1rdtbj69hyarjvh5mi6fh'  
   -H'Content-Type: application/json'  
   -d'{"text":"crac*"}'
  curl -X POST 'https://api.twitch.tv/helix/moderation/blocked_terms?broadcaster_id=1234&moderator_id=5678'  
   -H'Authorization: Bearer 789nj68b49pwqs9nh2y2jrlgzju3f'  
   -H'Client-Id: t214nt8z1rdtbj69hyarjvh5mi6fh'  
   -H'Content-Type: application/json'  
   -d'{"text":"A phrase I’m not fond of"}'


  ## Example response from twitch api docs:
  ### descriptions:

  ### responses:
  {"data":[{"broadcaster_id":"1234","moderator_id":"5678","id":"520e4d4e-0cda-49c7-821e-e5ef4f88c2f2","text":"crac*","created_at":"2021-09-29T19:45:37Z","updated_at":"2021-09-29T19:45:37Z","expires_at":null}]}
  {"data":[{"broadcaster_id":"713936733","moderator_id":"713936733","id":"3bb6e5d3-afb1-416c-ad4e-21af970ccfe7","text":"A phrase I’m not fond of","created_at":"2021-09-29T15:36:45Z","updated_at":"2021-09-29T15:36:45Z","expires_at":null}]}


  """

  alias TwitchApi.MyFinch
  alias TwitchApi.ApiJson.Template.Method.Headers

  @doc """
  ### Description:
  Adds a word or phrase to the broadcaster’s list of blocked terms.

  ### Required authentication:
  Requires a User access token with scope set to 
  moderator:manage:blocked_terms
  .

  ### Required authorization:

  """

  @typedoc """
  The ID of the broadcaster that owns the list of blocked terms.
  """
  @type broadcaster_id :: %{required(:broadcaster_id) => String.t()}

  @typedoc """
  The ID of a user that has permission to moderate the broadcaster’s chat room. This ID must match the user ID associated with the user OAuth token.If the broadcaster wants to add the blocked term (instead of having the moderator do it), set this parameter to the broadcaster’s ID, too.
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
      "https://api.twitch.tv/helix/moderation/blocked_terms?broadcaster_id=#{broadcaster_id}",
      Headers.config_oauth_headers(user_info),
      nil
    )
  end

  def call(%{moderator_id: moderator_id}, user_info) do
    MyFinch.request(
      "POST",
      "https://api.twitch.tv/helix/moderation/blocked_terms?moderator_id=#{moderator_id}",
      Headers.config_oauth_headers(user_info),
      nil
    )
  end
end
