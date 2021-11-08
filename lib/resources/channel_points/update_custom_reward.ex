defmodule TwitchApi.ChannelPoints.UpdateCustomReward do
  @moduledoc """
  ⛔ This module is autogenerated please do not modify manually.

  ## Example request from twitch api docs:
  ### descriptions:
  This request disables a custom reward:
  
  ### requests:
  curl -X PATCH 'https://api.twitch.tv/helix/channel_points/custom_rewards?broadcaster_id=274637212&id=92af127c-7326-4483-a52b-b0da0be61c01'  
   -H'client-id: gx2pv4208cff0ig9ou7nk3riccffxt'  
   -H'Authorization: Bearer vjxv3i0l4zxru966wsnwji51tmpkj2'  
   -H'Content-Type: application/json'  
   -d'{
    "title": "game analysis 2v2"
   }'
  curl -X PATCH 'https://api.twitch.tv/helix/channel_points/custom_rewards?broadcaster_id=274637212&id=92af127c-7326-4483-a52b-b0da0be61c01'  
   -H'client-id: gx2pv4208cff0ig9ou7nk3riccffxt'  
   -H'Authorization: Bearer vjxv3i0l4zxru966wsnwji51tmpkj2'  
   -H'Content-Type: application/json'  
   -d'{
    "is_enabled": false
   }'
  

  ## Example response from twitch api docs:
  ### descriptions:
  
  ### responses:
  {"data":[{"broadcaster_name":"torpedo09","broadcaster_login":"torpedo09","broadcaster_id":"274637212","id":"92af127c-7326-4483-a52b-b0da0be61c01","image":null,"background_color":"","is_enabled":false,"cost":30000,"title":"game analysis 2v2","prompt":"","is_user_input_required":false,"max_per_stream_setting":{"is_enabled":true,"max_per_stream":60},"max_per_user_per_stream_setting":{"is_enabled":false,"max_per_user_per_stream":0},"global_cooldown_setting":{"is_enabled":false,"global_cooldown_seconds":0},"is_paused":false,"is_in_stock":true,"default_image":{"url_1x":"https://static-cdn.jtvnw.net/custom-reward-images/default-1.png","url_2x":"https://static-cdn.jtvnw.net/custom-reward-images/default-2.png","url_4x":"https://static-cdn.jtvnw.net/custom-reward-images/default-4.png"},"should_redemptions_skip_request_queue":true,"redemptions_redeemed_current_stream":60,"cooldown_expires_at":null}]}
  {"data":[{"broadcaster_name":"torpedo09","broadcaster_login":"torpedo09","broadcaster_id":"274637212","id":"92af127c-7326-4483-a52b-b0da0be61c01","image":null,"background_color":"#00E5CB","is_enabled":false,"cost":30000,"title":"game analysis 2v2","prompt":"","is_user_input_required":false,"max_per_stream_setting":{"is_enabled":true,"max_per_stream":60},"max_per_user_per_stream_setting":{"is_enabled":false,"max_per_user_per_stream":0},"global_cooldown_setting":{"is_enabled":false,"global_cooldown_seconds":0},"is_paused":false,"is_in_stock":false,"default_image":{"url_1x":"https://static-cdn.jtvnw.net/custom-reward-images/default-1.png","url_2x":"https://static-cdn.jtvnw.net/custom-reward-images/default-2.png","url_4x":"https://static-cdn.jtvnw.net/custom-reward-images/default-4.png"},"should_redemptions_skip_request_queue":true,"redemptions_redeemed_current_stream":60,"cooldown_expires_at":null}]}
  

  """

  alias TwitchApi.MyFinch
  alias TwitchApi.ApiJson.Template.Method.Headers


  @doc """
  ### Description:
  Updates a Custom Reward created on a channel.

  ### Required authentication:
  User OAuth token
  Required scope: channel:manage:redemptions

  ### Required authorization:
  
  """

  @typedoc """
      Provided broadcaster_id must match the user_id in the user OAuth token.
      """
  @type broadcaster_id :: %{required(:broadcaster_id) => String.t()}

  @typedoc """
      ID of the Custom Reward to update. Must match a Custom Reward on the channel of the broadcaster_id.
      """
  @type id :: %{required(:id) => String.t()}

  
  @typedoc """
  Map containing the user needed information for the fetch of the required user OAuth access token.
  You will be able to choose from one way or the other for fetching previously OAuth access tokens.
  :user_id field contains the user ID from twitch, e.g. 61425548 or "61425548"
  :user_name field constains the user name from twitch, e.g. "hiimkamiyuzu"
  """
  @type user_info :: %{user_id: integer | binary} | %{user_name: binary}

  @spec call(broadcaster_id | id, user_info) :: {:ok, Finch.Response.t} | {:error, Exception.t}
  def call(%{broadcaster_id: broadcaster_id}, user_info) do
    MyFinch.request("PATCH","https://api.twitch.tv/helix/channel_points/custom_rewards?broadcaster_id=#{broadcaster_id}",
    Headers.config_oauth_headers(user_info), nil)
  end

  def call(%{id: id}, user_info) do
    MyFinch.request("PATCH","https://api.twitch.tv/helix/channel_points/custom_rewards?id=#{id}",
    Headers.config_oauth_headers(user_info), nil)
  end

end
