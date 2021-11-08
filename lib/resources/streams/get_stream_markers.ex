defmodule TwitchApi.Streams.GetStreamMarkers do
  @moduledoc """
  ⛔ This module is autogenerated please do not modify manually.

  ## Example request from twitch api docs:
  ### descriptions:
  This returns the first 5 markers in the most recent stream of user 123.
  
  ### requests:
  curl -X GET 'https://api.twitch.tv/helix/streams/markers?user_id=123&first=5'  
   -H'Authorization: Bearer cfabdegwdoklmawdzdo98xt2fo512y'  
   -H'Client-Id: uo6dggojyb8d6soh92zknwmi5ej1q2'
  

  ## Example response from twitch api docs:
  ### descriptions:
  
  ### responses:
  {"data":[{"user_id":"123","user_name":"TwitchName","user_login":"twitchname","videos":[{"video_id":"456","markers":[{"id":"106b8d6243a4f883d25ad75e6cdffdc4","created_at":"2018-08-20T20:10:03Z","description":"hello, this is a marker!","position_seconds":244,"URL":"https://twitch.tv/videos/456?t=0h4m06s"},...]}]}],"pagination":{"cursor":"eyJiIjpudWxsLCJhIjoiMjk1MjA0Mzk3OjI1Mzpib29rbWFyazoxMDZiOGQ1Y"}}
  

  """

  alias TwitchApi.MyFinch
  alias TwitchApi.ApiJson.Template.Method.Headers


  @doc """
  ### Description:
  Gets a list of markers for either a specified user’s most recent stream or a specified VOD/video (stream), ordered by recency. A marker is an arbitrary point in a stream that the broadcaster wants to mark.

  ### Required authentication:
  OAuth token required
  Required scope: user:read:broadcast

  ### Required authorization:
  
  """

  @typedoc """
      ID of the broadcaster from whose stream markers are returned.
      """
  @type user_id :: %{required(:user_id) => String.t()}

  @typedoc """
      ID of the VOD/video whose stream markers are returned.
      """
  @type video_id :: %{required(:video_id) => String.t()}

  @typedoc """
      Cursor for forward pagination: tells the server where to start fetching the next set of results, in a multi-page response. The cursor value specified here is from the pagination response field of a prior query.
      """
  @type after_query_param :: %{required(:after_query_param) => String.t()}

  @typedoc """
      Cursor for backward pagination: tells the server where to start fetching the next set of results, in a multi-page response. The cursor value specified here is from the pagination response field of a prior query.
      """
  @type before :: %{required(:before) => String.t()}

  @typedoc """
      Number of values to be returned when getting videos by user or game ID. Limit: 100. Default: 20.
      """
  @type first :: %{required(:first) => String.t()}

  
  @typedoc """
  Map containing the user needed information for the fetch of the required user OAuth access token.
  You will be able to choose from one way or the other for fetching previously OAuth access tokens.
  :user_id field contains the user ID from twitch, e.g. 61425548 or "61425548"
  :user_name field constains the user name from twitch, e.g. "hiimkamiyuzu"
  """
  @type user_info :: %{user_id: integer | binary} | %{user_name: binary}

  @spec call(user_id | video_id | after_query_param | before | first, user_info) :: {:ok, Finch.Response.t} | {:error, Exception.t}
  def call(%{user_id: user_id}, user_info) do
    MyFinch.request("GET","https://api.twitch.tv/helix/streams/markers?user_id=#{user_id}",
    Headers.config_oauth_headers(user_info), nil)
  end

  def call(%{video_id: video_id}, user_info) do
    MyFinch.request("GET","https://api.twitch.tv/helix/streams/markers?video_id=#{video_id}",
    Headers.config_oauth_headers(user_info), nil)
  end

  def call(%{after: after_query_param}, user_info) do
    MyFinch.request("GET","https://api.twitch.tv/helix/streams/markers?after=#{after_query_param}",
    Headers.config_oauth_headers(user_info), nil)
  end

  def call(%{before: before}, user_info) do
    MyFinch.request("GET","https://api.twitch.tv/helix/streams/markers?before=#{before}",
    Headers.config_oauth_headers(user_info), nil)
  end

  def call(%{first: first}, user_info) do
    MyFinch.request("GET","https://api.twitch.tv/helix/streams/markers?first=#{first}",
    Headers.config_oauth_headers(user_info), nil)
  end

end
