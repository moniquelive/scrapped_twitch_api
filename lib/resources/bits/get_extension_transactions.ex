defmodule TwitchApi.Bits.GetExtensionTransactions do
  @moduledoc """
  ⛔ This module is autogenerated please do not modify manually.

  ## Example request from twitch api docs:
  ### descriptions:
  
  ### requests:
  curl -X GET
  'https://api.twitch.tv/helix/extensions/transactions?extension_id=1234'  
   -H'Authorization: Bearer cfabdegwdoklmawdzdo98xt2fo512y'  
   -H'Client-Id: uo6dggojyb8d6soh92zknwmi5ej1q2'
  

  ## Example response from twitch api docs:
  ### descriptions:
  
  ### responses:
  {"data":[{"id":"74c52265-e214-48a6-91b9-23b6014e8041","timestamp":"2019-01-28T04:15:53.325Z","broadcaster_id":"439964613","broadcaster_login":"chikuseuma","broadcaster_name":"chikuseuma","user_id":"424596340","user_login":"quotrok","user_name":"quotrok","product_type":"BITS_IN_EXTENSION","product_data":{"domain":"twitch.ext.uo6dggojyb8d6soh92zknwmi5ej1q2","sku":"testSku100","cost":{"amount":100,"type":"bits"},"inDevelopment":false"displayName":"Test Product 100","expiration":"","broadcast":false}},{"id":"8d303dc6-a460-4945-9f48-59c31d6735cb","timestamp":"2019-01-18T09:10:13.397Z","broadcaster_id":"439964613","broadcaster_login":"chikuseuma","broadcaster_name":"chikuseuma""user_id":"439966926","user_login":"liscuit","user_name":"liscuit","product_type":"BITS_IN_EXTENSION","product_data":{"domain":"twitch.ext.uo6dggojyb8d6soh92zknwmi5ej1q2","sku":"testSku200","cost":{"amount":200,"type":"bits"},"inDevelopment":false,"displayName":"Test Product 200","expiration":"","broadcast":false}},...],"pagination":{"cursor":"cursorString"}}
  

  """

  alias TwitchApi.MyFinch


  @doc """
  ### Description:
  Gets the list of Extension transactions for a given Extension. This allows Extension back-end servers to fetch a list of transactions that have occurred for their Extension across all of Twitch.

  ### Required authentication:
  App Access Token
  """

  @typep extension_id :: %{required(:extension_id) => String.t()} # ID of the Extension to list transactions for.Maximum: 1
  
  @spec call(extension_id) :: {:ok, Finch.Response.t} | {:error, Exception.t}
  def call(%{extension_id: extension_id}) do
    MyFinch.request("GET","https://api.twitch.tv/helix/extensions/transactions?extension_id=#{extension_id}",
    TwitchApi.ApiJson.Template.Method.Headers.config_headers(), nil)
  end

end