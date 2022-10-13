defmodule TwitchApi.Moderation.GetVIPs do
  @moduledoc """
  ⛔ This module is autogenerated please do not modify manually.

  ## Example request from twitch api docs:
  ### descriptions:
  Gets a list of the broadcaster’s VIPs
  Gets a filtered list of the broadcaster’s VIPs. The list in the response contains only those users that are VIPs.

  ### requests:
  curl -X GET 'https://api.twitch.tv/helix/channels/vips?broadcaster_id=123&user_id=456&user_id=678'  
   -H'Authorization: Bearer kpvy3cjboyptmdkiacwr0c19hotn5s'  
   -H'Client-Id: hof5gwx0su6owfnys0nyan9c87zr6t'
  curl -X GET 'https://api.twitch.tv/helix/channels/vips?broadcaster_id=123'  
   -H'Authorization: Bearer kpvy3cjboyptmdkiacwr0c19hotn5s'  
   -H'Client-Id: hof5gwx0su6owfnys0nyan9c87zr6t'


  ## Example response from twitch api docs:
  ### descriptions:

  ### responses:
  {"data":[{"user_id":"11111","user_name":"UserDisplayName","user_login":"userloginname"},...],"pagination":{"cursor":"eyJiIjpudWxsLCJhIjp7Ik9mZnNldCI6NX19"}}


  """

  alias TwitchApi.MyFinch
  alias TwitchApi.ApiJson.Template.Method.Headers

  @doc """
  ### Description:
  NEW Gets a list of the channel’s VIPs.

  ### Required authentication:


  ### Required authorization:
  Requires a user access token that includes the channel:read:vips scope. If your app also adds and removes VIP status, you can use the channel:manage:vips scope instead. The ID in the broadcaster_id query parameter must match the user ID in the access token.
  """

  @typedoc """
  Filters the list for specific VIPs. To specify more than one user, include the user_id parameter for each user to get. For example, &user_id=1234&user_id=5678. The maximum number of IDs that you may specify is 100. Ignores those users in the list that aren’t VIPs.
  """
  @type user_id :: %{required(:user_id) => String.t()}

  @typedoc """
  The ID of the broadcaster whose list of VIPs you want to get.
  """
  @type broadcaster_id :: %{required(:broadcaster_id) => String.t()}

  @typedoc """
  The maximum number of items to return per page in the response. The minimum page size is 1 item per page and the maximum is 100. The default is 20.
  """
  @type first :: %{required(:first) => integer}

  @typedoc """
  The cursor used to get the next page of results. The Pagination object in the response contains the cursor’s value. Read more.
  """
  @type after_query_param :: %{required(:after_query_param) => String.t()}

  @spec call(user_id | broadcaster_id | first | after_query_param) ::
          {:ok, Finch.Response.t()} | {:error, Exception.t()}
  def call(%{user_id: user_id}) do
    MyFinch.request(
      "GET",
      "https://api.twitch.tv/helix/channels/vips?user_id=#{user_id}",
      Headers.config_headers(),
      nil
    )
  end

  def call(%{broadcaster_id: broadcaster_id}) do
    MyFinch.request(
      "GET",
      "https://api.twitch.tv/helix/channels/vips?broadcaster_id=#{broadcaster_id}",
      Headers.config_headers(),
      nil
    )
  end

  def call(%{first: first}) do
    MyFinch.request(
      "GET",
      "https://api.twitch.tv/helix/channels/vips?first=#{first}",
      Headers.config_headers(),
      nil
    )
  end

  def call(%{after: after_query_param}) do
    MyFinch.request(
      "GET",
      "https://api.twitch.tv/helix/channels/vips?after=#{after_query_param}",
      Headers.config_headers(),
      nil
    )
  end
end