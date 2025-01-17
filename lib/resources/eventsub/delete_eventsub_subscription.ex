defmodule TwitchApi.EventSub.DeleteEventSubSubscription do
  @moduledoc """
  ⛔ This module is autogenerated please do not modify manually.

  ## Example request from twitch api docs:
  ### descriptions:
  This example deletes the specified EventSub subscription.
  The response body is empty.

  ### requests:
  curl -X DELETE
  'https://api.twitch.tv/helix/eventsub/subscriptions?id=26b1c993-bfcf-44d9-b876-379dacafe75a'  
   -H'Authorization: Bearer 2gbdx6oar67tqtcmt49t3wpcgycthx'  
   -H'Client-Id: wbmytr93xzw8zbg0p1izqyzzc5mbiz'


  ## Example response from twitch api docs:
  ### descriptions:

  ### responses:
  # Twitch CLI example that deletes the specified subscription.

  twitch api delete /eventsub/subscriptions -qid=c839a466-034a-4d77-8d4d-c9a751516e7



  """

  alias TwitchApi.MyFinch
  alias TwitchApi.ApiJson.Template.Method.Headers

  @doc """
  ### Description:
  Deletes an EventSub subscription.

  ### Required authentication:
  Requires an application OAuth access token.

  ### Required authorization:

  """

  @typedoc """
  The ID of the subscription to delete. This is the ID that Create Eventsub Subscription returns.
  """
  @type id :: %{required(:id) => String.t()}

  @spec call(id) :: {:ok, Finch.Response.t()} | {:error, Exception.t()}
  def call(%{id: id}) do
    MyFinch.request(
      "DELETE",
      "https://api.twitch.tv/helix/eventsub/subscriptions?id=#{id}",
      Headers.config_headers(),
      nil
    )
  end
end
