defmodule TwitchApi.Extensions.GetExtensionLiveChannels do
  @moduledoc """
  ⛔ This module is autogenerated please do not modify manually.

  ## Example request from twitch api docs:
  ### descriptions:

  ### requests:
  curl -X GET 'https://api.twitch.tv/helix/extensions/live?extension_id=uo6dggojyb8d6soh92zknwmi5ej1q2'  
   -H'Authorization: Bearer cfabdegwdoklmawdzdo98xt2fo512y'  
   -H'Client-Id: uo6dggojyb8d6soh92zknwmi5ej1q2'


  ## Example response from twitch api docs:
  ### descriptions:

  ### responses:
  {"data":[{"broadcaster_id":"252766116","broadcaster_name":"swoosh_xii","game_name":"Tom Clancy's Rainbow Six Siege","game_id":"460630","title":"[PS4] ITA/ENG UNRANKED CHILLIN' (SUB 1/15) - !instagram !donation !sens !team !youtube"},{"broadcaster_id":"264525686","broadcaster_name":"gaddem_","game_name":"For Honor","game_id":"490382","title":"any Kätzchen ? - 680 Rep + > Kompetitive Kitten"},{"broadcaster_id":"264787895","broadcaster_name":"LenhadorGameplay","game_name":"For Honor","game_id":"490382","title":"Vazou o novo personagem! *Triste*"}],"pagination":"YVc1emRHRnNiQ015TmpJek5qazVOVHBoYWpKbGRIZDFaR0Z5YjNCMGN6UTJNMkZ1TUdwM2FHWnBZbm8yYW5rNjoy"}


  """

  alias TwitchApi.MyFinch
  alias TwitchApi.ApiJson.Template.Method.Headers

  @doc """
  ### Description:
  Returns one page of live channels that have installed or activated a specific Extension.

  ### Required authentication:


  ### Required authorization:
  User OAuth Token or App Access Token
  """

  @typedoc """
  ID of the Extension to search for.
  """
  @type extension_id :: %{required(:extension_id) => String.t()}

  @typedoc """
  Maximum number of objects to return.Maximum: 100. Default: 20.
  """
  @type first :: %{required(:first) => integer}

  @typedoc """
  The cursor used to fetch the next page of data.
  """
  @type after_query_param :: %{required(:after_query_param) => String.t()}

  @spec call(extension_id | first | after_query_param) ::
          {:ok, Finch.Response.t()} | {:error, Exception.t()}
  def call(%{extension_id: extension_id}) do
    MyFinch.request(
      "GET",
      "https://api.twitch.tv/helix/extensions/live?extension_id=#{extension_id}",
      Headers.config_headers(),
      nil
    )
  end

  def call(%{first: first}) do
    MyFinch.request(
      "GET",
      "https://api.twitch.tv/helix/extensions/live?first=#{first}",
      Headers.config_headers(),
      nil
    )
  end

  def call(%{after: after_query_param}) do
    MyFinch.request(
      "GET",
      "https://api.twitch.tv/helix/extensions/live?after=#{after_query_param}",
      Headers.config_headers(),
      nil
    )
  end
end
