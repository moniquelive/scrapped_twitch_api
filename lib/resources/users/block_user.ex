defmodule TwitchApi.Users.BlockUser do
  @moduledoc """
  ⛔ This module is autogenerated please do not modify manually.

  ## Example request from twitch api docs:
  ### descriptions:
  This example blocks a user with an ID of 198704263 on behalf of the authenticated user.
  
  ### requests:
  curl -X PUT 'https://api.twitch.tv/helix/users/blocks?target_user_id=198704263'  
   -H'Authorization: Bearer 2gbdx6oar67tqtcmt49t3wpcgycthx'  
   -H'Client-Id: wbmytr93xzw8zbg0p1izqyzzc5mbiz'  
   
  

  ## Example response from twitch api docs:
  ### descriptions:
  
  ### responses:
  204NoContent
  

  """

  alias TwitchApi.MyFinch
  alias TwitchApi.ApiJson.Template.Method.Headers


  @doc """
  ### Description:
  Blocks the specified user on behalf of the authenticated user.

  ### Required authentication:
  OAuth user token required
  Required scope: user:manage:blocked_users

  ### Required authorization:
  
  """

  @typedoc """
      User ID of the user to be blocked.
      """
  @type target_user_id :: %{required(:target_user_id) => String.t()}

  @typedoc """
      Source context for blocking the user. Valid values: "chat", "whisper".
      """
  @type source_context :: %{required(:source_context) => String.t()}

  @typedoc """
      Reason for blocking the user. Valid values: "spam", "harassment", or "other".
      """
  @type reason :: %{required(:reason) => String.t()}

  
  @typedoc """
  Map containing the user needed information for the fetch of the required user OAuth access token.
  You will be able to choose from one way or the other for fetching previously OAuth access tokens.
  :user_id field contains the user ID from twitch, e.g. 61425548 or "61425548"
  :user_name field constains the user name from twitch, e.g. "hiimkamiyuzu"
  """
  @type user_info :: %{user_id: integer | binary} | %{user_name: binary}

  @spec call(target_user_id | source_context | reason, user_info) :: {:ok, Finch.Response.t} | {:error, Exception.t}
  def call(%{target_user_id: target_user_id}, user_info) do
    MyFinch.request("PUT","https://api.twitch.tv/helix/users/blocks?target_user_id=#{target_user_id}",
    Headers.config_oauth_headers(user_info), nil)
  end

  def call(%{source_context: source_context}, user_info) do
    MyFinch.request("PUT","https://api.twitch.tv/helix/users/blocks?source_context=#{source_context}",
    Headers.config_oauth_headers(user_info), nil)
  end

  def call(%{reason: reason}, user_info) do
    MyFinch.request("PUT","https://api.twitch.tv/helix/users/blocks?reason=#{reason}",
    Headers.config_oauth_headers(user_info), nil)
  end

end
