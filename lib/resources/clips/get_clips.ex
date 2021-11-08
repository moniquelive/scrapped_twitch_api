defmodule TwitchApi.Clips.GetClips do
  @moduledoc """
  ⛔ This module is autogenerated please do not modify manually.

  ## Example request from twitch api docs:
  ### descriptions:
  This gets information for clip AwkwardHelplessSalamanderSwiftRage.
  This gets the top 5 clips from broadcaster 1234.
  
  ### requests:
  curl -X GET 'https://api.twitch.tv/helix/clips?broadcaster_id=1234&first=5'  
   -H'Authorization: Bearer 2gbdx6oar67tqtcmt49t3wpcgycthx'  
   -H'Client-Id: uo6dggojyb8d6soh92zknwmi5ej1q2'
  curl -X GET 'https://api.twitch.tv/helix/clips?id=AwkwardHelplessSalamanderSwiftRage'  
   -H'Authorization: Bearer 2gbdx6oar67tqtcmt49t3wpcgycthx'  
   -H'Client-Id: uo6dggojyb8d6soh92zknwmi5ej1q2'
  

  ## Example response from twitch api docs:
  ### descriptions:
  
  ### responses:
  {"data":[{"id":"RandomClip1","url":"https://clips.twitch.tv/AwkwardHelplessSalamanderSwiftRage","embed_url":"https://clips.twitch.tv/embed?clip=RandomClip1","broadcaster_id":"1234","broadcaster_name":"JJ","creator_id":"123456","creator_name":"MrMarshall","video_id":"1234567","game_id":"33103","language":"en","title":"random1","view_count":10,"created_at":"2017-11-30T22:34:18Z","thumbnail_url":"https://clips-media-assets.twitch.tv/157589949-preview-480x272.jpg","duration":12.9},...],"pagination":{"cursor":"eyJiIjpudWxsLCJhIjoiIn0"}}
  {"data":[{"id":"AwkwardHelplessSalamanderSwiftRage","url":"https://clips.twitch.tv/AwkwardHelplessSalamanderSwiftRage","embed_url":"https://clips.twitch.tv/embed?clip=AwkwardHelplessSalamanderSwiftRage","broadcaster_id":"67955580","broadcaster_name":"ChewieMelodies","creator_id":"53834192","creator_name":"BlackNova03","video_id":"205586603","game_id":"488191","language":"en","title":"babymetal","view_count":10,"created_at":"2017-11-30T22:34:18Z","thumbnail_url":"https://clips-media-assets.twitch.tv/157589949-preview-480x272.jpg","duration":60}]}
  

  """

  alias TwitchApi.MyFinch
  alias TwitchApi.ApiJson.Template.Method.Headers


  @doc """
  ### Description:
  Gets clip information by clip ID (one or more), broadcaster ID (one only), or game ID (one only).

  ### Required authentication:
  OAuth or App Access Token required.

  ### Required authorization:
  
  """

  @typedoc """
      ID of the broadcaster for whom clips are returned. The number of clips returned is determined by the first query-string parameter (default: 20). Results are ordered by view count.
      """
  @type broadcaster_id :: %{required(:broadcaster_id) => String.t()}

  @typedoc """
      ID of the game for which clips are returned. The number of clips returned is determined by the first query-string parameter (default: 20). Results are ordered by view count.
      """
  @type game_id :: %{required(:game_id) => String.t()}

  @typedoc """
      ID of the clip being queried. Limit: 100.
      """
  @type id :: %{required(:id) => String.t()}

  @typedoc """
      Cursor for forward pagination: tells the server where to start fetching the next set of results, in a multi-page response. This applies only to queries specifying broadcaster_id or game_id. The cursor value specified here is from the pagination response field of a prior query.
      """
  @type after_query_param :: %{required(:after_query_param) => String.t()}

  @typedoc """
      Cursor for backward pagination: tells the server where to start fetching the next set of results, in a multi-page response. This applies only to queries specifying broadcaster_id or game_id. The cursor value specified here is from the pagination response field of a prior query.
      """
  @type before :: %{required(:before) => String.t()}

  @typedoc """
      Ending date/time for returned clips, in RFC3339 format. (Note that the seconds value is ignored.) If this is specified, started_at also must be specified; otherwise, the time period is ignored.
      """
  @type ended_at :: %{required(:ended_at) => String.t()}

  @typedoc """
      Maximum number of objects to return. Maximum: 100. Default: 20.
      """
  @type first :: %{required(:first) => integer}

  @typedoc """
      Starting date/time for returned clips, in RFC3339 format. (The seconds value is ignored.) If this is specified, ended_at also should be specified; otherwise, the ended_at date/time will be 1 week after the started_at value.
      """
  @type started_at :: %{required(:started_at) => String.t()}

  
  @spec call(broadcaster_id | game_id | id | after_query_param | before | ended_at | first | started_at) :: {:ok, Finch.Response.t} | {:error, Exception.t}
  def call(%{broadcaster_id: broadcaster_id}) do
    MyFinch.request("GET","https://api.twitch.tv/helix/clips?broadcaster_id=#{broadcaster_id}",
    Headers.config_headers(), nil)
  end

  def call(%{game_id: game_id}) do
    MyFinch.request("GET","https://api.twitch.tv/helix/clips?game_id=#{game_id}",
    Headers.config_headers(), nil)
  end

  def call(%{id: id}) do
    MyFinch.request("GET","https://api.twitch.tv/helix/clips?id=#{id}",
    Headers.config_headers(), nil)
  end

  def call(%{after: after_query_param}) do
    MyFinch.request("GET","https://api.twitch.tv/helix/clips?after=#{after_query_param}",
    Headers.config_headers(), nil)
  end

  def call(%{before: before}) do
    MyFinch.request("GET","https://api.twitch.tv/helix/clips?before=#{before}",
    Headers.config_headers(), nil)
  end

  def call(%{ended_at: ended_at}) do
    MyFinch.request("GET","https://api.twitch.tv/helix/clips?ended_at=#{ended_at}",
    Headers.config_headers(), nil)
  end

  def call(%{first: first}) do
    MyFinch.request("GET","https://api.twitch.tv/helix/clips?first=#{first}",
    Headers.config_headers(), nil)
  end

  def call(%{started_at: started_at}) do
    MyFinch.request("GET","https://api.twitch.tv/helix/clips?started_at=#{started_at}",
    Headers.config_headers(), nil)
  end

end
