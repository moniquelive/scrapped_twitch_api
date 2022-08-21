defmodule TwitchApi.Users.GetUsersFollows do
  @moduledoc """
  ⛔ This module is autogenerated please do not modify manually.

  ## Example request from twitch api docs:
  ### descriptions:
  This gets the first 20 IDs of users who are following user 23161357.
  
  ### requests:
  curl -X GET 'https://api.twitch.tv/helix/users/follows?to_id=23161357'  
   -H'Authorization: Bearer 2gbdx6oar67tqtcmt49t3wpcgycthx'  
   -H'Client-Id: uo6dggojyb8d6soh92zknwmi5ej1q2'
  

  ## Example response from twitch api docs:
  ### descriptions:
  
  ### responses:
  {"total":12345,"data":[{"from_id":"171003792","from_login":"iiisutha067iii","from_name":"IIIsutha067III","to_id":"23161357","to_name":"LIRIK","followed_at":"2017-08-22T22:55:24Z"},{"from_id":"113627897","from_login":"birdman616","from_name":"Birdman616","to_id":"23161357","to_name":"LIRIK","followed_at":"2017-08-22T22:55:04Z"},...],"pagination":{"cursor":"eyJiIjpudWxsLCJhIjoiMTUwMzQ0MTc3NjQyNDQyMjAwMCJ9"}}
  

  """

  alias TwitchApi.MyFinch
  alias TwitchApi.ApiJson.Template.Method.Headers


  @doc """
  ### Description:
  Gets information on follow relationships between two Twitch users. Information returned is sorted in order, most recent follow first.

  ### Required authentication:
  User OAuth Token or App Access Token

  ### Required authorization:
  
  """

  
  def call(%{from_id: from_id, to_id: to_id}) do
    MyFinch.request("GET","https://api.twitch.tv/helix/users/follows?from_id=#{from_id}&to_id=#{to_id}",
    Headers.config_headers(), nil)
  end

end
