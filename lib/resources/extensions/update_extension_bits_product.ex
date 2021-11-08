defmodule TwitchApi.Extensions.UpdateExtensionBitsProduct do
  @moduledoc """
  ⛔ This module is autogenerated please do not modify manually.

  ## Example request from twitch api docs:
  ### descriptions:
  
  ### requests:
  curl -X PUT 'https://api.twitch.tv/helix/bits/extensions'  
   -H'Authorization: Bearer cfabdegwdoklmawdzdo98xt2fo512y'  
   -H'Client-Id: uo6dggojyb8d6soh92zknwmi5ej1q2'  
   -d{"sku": "1010",
    "cost": {"amount": 990,
      "type": "bits"},
    "in_development": true,
    "display_name": "Rusty Crate 2",
    "is_broadcast": true,
    "expiration": "2021-05-18T09:10:13.397Z"}
  

  ## Example response from twitch api docs:
  ### descriptions:
  
  ### responses:
  {"data":[{"sku":"1010","cost":{"amount":990,"type":"bits"},"in_development":true,"display_name":"Rusty Crate 2","expiration":"2021-05-18T09:10:13.397Z","is_broadcast":true}]}
  

  """

  alias TwitchApi.MyFinch
  alias TwitchApi.ApiJson.Template.Method.Headers


  @doc """
  ### Description:
  NEW Add or update a Bits products that belongs to an Extension.

  ### Required authentication:
  

  ### Required authorization:
  App Access Token associated with the Extension client ID
  """

  
  @spec call(%{required(:cost) => %{# Object containing cost information.
    required(:amount) => integer, # Number of Bits for which the product will be exchanged.Minimum =>  1 Maximum =>  10000.
    required(:type) => String.t(), # Cost type. The one valid value is \bits\.
    },
    required(:display_name) => String.t(), # Name of the product to be displayed in the Extension.Maximum =>  255 characters.
    required(:sku) => String.t(), # SKU of the Bits product. This must be unique across all products that belong to an Extension. The SKU cannot be changed after saving.Maximum =>  255 characters no white spaces.
    }| nil) :: {:ok, Finch.Response.t} | {:error, Exception.t}
  def call(body_params) do
    MyFinch.request("PUT","https://api.twitch.tv/helix/bits/extensions",
    Headers.config_headers(), body_params)
  end

end
