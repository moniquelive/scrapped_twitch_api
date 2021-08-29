defmodule TwitchApi.Moderation.GetModeratorEvents do
  @moduledoc """
  ⛔ This module is autogenerated please do not modify manually.

  ## Example request from twitch api docs:
  ### descriptions:
  Returns users added or removed as moderators for Broadcaster ID 198704263.
  
  ### requests:
  curl -X GET 'https://api.twitch.tv/helix/moderation/moderators/events?broadcaster_id=198704263'  
   -H'Authorization: Bearer cfabdegwdoklmawdzdo98xt2fo512y'  
   -H'Client-Id: uo6dggojyb8d6soh92zknwmi5ej1q2'
  

  ## Example response from twitch api docs:
  ### descriptions:
  
  ### responses:
  {"data":[{"id":"1IVBTnDSUDApiBQW4UBcVTK4hPr","event_type":"moderation.moderator.remove","event_timestamp":"2019-03-15T18:18:14Z","version":"1.0","event_data":{"broadcaster_id":"198704263","broadcaster_login":"aan22209","broadcaster_name":"aan22209","user_id":"423374343","user_login":"glowillig","user_name":"glowillig"}},{"id":"1IVIPQdYIEnD8nJ376qkASDzsj7","event_type":"moderation.moderator.add","event_timestamp":"2019-03-15T19:15:13Z","version":"1.0","event_data":{"broadcaster_id":"198704263","broadcaster_login":"aan22209","broadcaster_name":"aan22209","user_id":"423374343","user_login":"glowillig","user_name":"glowillig"}},{"id":"1IVBTP7gG61oXLMu7fvnRhrpsro","event_type":"moderation.moderator.remove","event_timestamp":"2019-03-15T18:18:11Z","version":"1.0","event_data":{"broadcaster_id":"198704263","broadcaster_login":"aan22209","broadcaster_name":"aan22209","user_id":"424596340","user_login":"quotrok","user_name":"quotrok"}}],"pagination":{"cursor":"eyJiIjpudWxsLCJhIjp7IkN1cnNvciI6IjEwMDQ3MzA2NDo4NjQwNjU3MToxSVZCVDFKMnY5M1BTOXh3d1E0dUdXMkJOMFcifX0"}}
  

  """

  alias TwitchApi.MyFinch


  @doc """
  ### Description:
  Returns a list of moderators or users added and removed as moderators from a channel.

  ### Required authentication:
  
  """

  @typep broadcaster_id :: %{required(:broadcaster_id) => String.t()} # Provided broadcaster_id must match the user_id in the auth token.Maximum: 1
  
  @spec call(broadcaster_id) :: {:ok, Finch.Response.t} | {:error, Exception.t}
  def call(%{broadcaster_id: broadcaster_id}) do
    MyFinch.request("GET","https://api.twitch.tv/helix/moderation/moderators/events?broadcaster_id=#{broadcaster_id}",
    TwitchApi.ApiJson.Template.Method.Headers.config_headers(), nil)
  end

end