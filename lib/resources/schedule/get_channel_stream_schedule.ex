defmodule TwitchApi.Schedule.GetChannelStreamSchedule do
  @moduledoc """
  ⛔ This module is autogenerated please do not modify manually.

  ## Example request from twitch api docs:
  ### descriptions:
  Returns all scheduled events from the TwitchDev channel’s stream schedule.
  
  ### requests:
  curl -X GET 'https://api.twitch.tv/helix/schedule?broadcaster_id=141981764'  
   -H'Authorization: Bearer cfabdegwdoklmawdzdo98xt2fo512y'  
   -H'Client-Id: uo6dggojyb8d6soh92zknwmi5ej1q2'
  

  ## Example response from twitch api docs:
  ### descriptions:
  
  ### responses:
  {"data":{"segments":[{"id":"eyJzZWdtZW50SUQiOiJlNGFjYzcyNC0zNzFmLTQwMmMtODFjYS0yM2FkYTc5NzU5ZDQiLCJpc29ZZWFyIjoyMDIxLCJpc29XZWVrIjoyNn0=","start_time":"2021-07-01T18:00:00Z","end_time":"2021-07-01T19:00:00Z","title":"TwitchDev Monthly Update // July 1, 2021","canceled_until":null,"category":{"id":"509670","name":"Science & Technology"},"is_recurring":false},...],"broadcaster_id":"141981764","broadcaster_name":"TwitchDev","broadcaster_login":"twitchdev","vacation":null},"pagination":{}}
  

  """

  alias TwitchApi.MyFinch


  @doc """
  ### Description:
  NEW Gets all scheduled broadcasts or specific scheduled broadcasts from a channel’s stream schedule.

  ### Required authentication:
  
  """

  @typep broadcaster_id :: %{required(:broadcaster_id) => String.t()} # User ID of the broadcaster who owns the channel streaming schedule.Maximum: 1
  
  @spec call(broadcaster_id) :: {:ok, Finch.Response.t} | {:error, Exception.t}
  def call(%{broadcaster_id: broadcaster_id}) do
    MyFinch.request("GET","https://api.twitch.tv/helix/schedule?broadcaster_id=#{broadcaster_id}",
    TwitchApi.ApiJson.Template.Method.Headers.config_headers(), nil)
  end

end