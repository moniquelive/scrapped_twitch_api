defmodule TwitchApi.Schedule.UpdateChannelStreamSchedule do
  @moduledoc """
  ⛔ This module is autogenerated please do not modify manually.

  ## Example request from twitch api docs:
  ### descriptions:
  Enable Vacation Mode and specify vacation dates for the TwitchDev channel’s stream schedule.

  ### requests:
  curl -X PATCH 'https://api.twitch.tv/helix/schedule/settings?broadcaster_id=141981764&is_vacation_enabled=true&vacation_start_time=2021-05-16T00:00:00Z&vacation_end_time=2021-05-23T00:00:00Z&timezone=America/New_York'  
   -H'Authorization: Bearer cfabdegwdoklmawdzdo98xt2fo512y'  
   -H'Client-Id: uo6dggojyb8d6soh92zknwmi5ej1q2'


  ## Example response from twitch api docs:
  ### descriptions:

  ### responses:
  204NoContent


  """

  alias TwitchApi.MyFinch
  alias TwitchApi.ApiJson.Template.Method.Headers

  @doc """
  ### Description:
  Update the settings for a channel’s stream schedule.

  ### Required authentication:


  ### Required authorization:
  User OAuth TokenRequired scope: channel:manage:schedule
  """

  @typedoc """
  User ID of the broadcaster who owns the channel streaming schedule. Provided broadcaster_id must match the user_id in the user OAuth token.Maximum: 1
  """
  @type broadcaster_id :: %{required(:broadcaster_id) => String.t()}

  @typedoc """
  Indicates if Vacation Mode is enabled. Set to true to add a vacation or false to remove vacation from the channel streaming schedule.
  """
  @type is_vacation_enabled :: %{required(:is_vacation_enabled) => boolean}

  @typedoc """
  Start time for vacation specified in RFC3339 format. Required if is_vacation_enabled is set to true.
  """
  @type vacation_start_time :: %{required(:vacation_start_time) => String.t()}

  @typedoc """
  End time for vacation specified in RFC3339 format. Required if is_vacation_enabled is set to true.
  """
  @type vacation_end_time :: %{required(:vacation_end_time) => String.t()}

  @typedoc """
  The timezone for when the vacation is being scheduled using the IANA time zone database format. Required if is_vacation_enabled is set to true.
  """
  @type timezone :: %{required(:timezone) => String.t()}

  @typedoc """
  Map containing the user needed information for the fetch of the required user OAuth access token.
  You will be able to choose from one way or the other for fetching previously OAuth access tokens.
  :user_id field contains the user ID from twitch, e.g. 61425548 or "61425548"
  :user_name field constains the user name from twitch, e.g. "hiimkamiyuzu"
  """
  @type user_info :: %{user_id: integer | binary} | %{user_name: binary}

  @spec call(
          broadcaster_id
          | is_vacation_enabled
          | vacation_start_time
          | vacation_end_time
          | timezone,
          user_info
        ) :: {:ok, Finch.Response.t()} | {:error, Exception.t()}
  def call(%{broadcaster_id: broadcaster_id}, user_info) do
    MyFinch.request(
      "PATCH",
      "https://api.twitch.tv/helix/schedule/settings?broadcaster_id=#{broadcaster_id}",
      Headers.config_oauth_headers(user_info),
      nil
    )
  end

  def call(%{is_vacation_enabled: is_vacation_enabled}, user_info) do
    MyFinch.request(
      "PATCH",
      "https://api.twitch.tv/helix/schedule/settings?is_vacation_enabled=#{is_vacation_enabled}",
      Headers.config_oauth_headers(user_info),
      nil
    )
  end

  def call(%{vacation_start_time: vacation_start_time}, user_info) do
    MyFinch.request(
      "PATCH",
      "https://api.twitch.tv/helix/schedule/settings?vacation_start_time=#{vacation_start_time}",
      Headers.config_oauth_headers(user_info),
      nil
    )
  end

  def call(%{vacation_end_time: vacation_end_time}, user_info) do
    MyFinch.request(
      "PATCH",
      "https://api.twitch.tv/helix/schedule/settings?vacation_end_time=#{vacation_end_time}",
      Headers.config_oauth_headers(user_info),
      nil
    )
  end

  def call(%{timezone: timezone}, user_info) do
    MyFinch.request(
      "PATCH",
      "https://api.twitch.tv/helix/schedule/settings?timezone=#{timezone}",
      Headers.config_oauth_headers(user_info),
      nil
    )
  end
end
