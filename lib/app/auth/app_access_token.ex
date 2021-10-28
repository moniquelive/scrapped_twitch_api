defmodule TwitchApi.AppAccessToken do
  use GenServer, restart: :transient

  @moduledoc """
  This module provides a refresh process and holds the state for twitch app access tokens
  """

  require Logger
  alias TwitchApi.MyFinch

  @enforce_keys [:access_token, :expires_in, :token_type]
  defstruct [:access_token, :expires_in, :token_type]

  @typep state :: %__MODULE__{access_token: binary, expires_in: integer, token_type: binary}

  @twitch_token_url "https://id.twitch.tv/oauth2/token?grant_type=client_credentials"
  @filtered_token "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
  @filter_access_token ["access_token"]

  @doc """
  Callback function when the GenServer is started
  """
  @spec init(any) :: {:ok, state}
  @impl true
  def init(_) do
    fetch_app_access_token()
    state = %__MODULE__{access_token: "", expires_in: 0, token_type: ""}
    Logger.info("Started app_access_token process")
    {:ok, state}
  end

  @doc """
  Callback function when the GenServer fetches the status
  """
  @impl true
  @spec format_status(any, list) :: list
  def format_status(_reason, [pdict, state]),
    do: [pdict, %__MODULE__{state | access_token: @filtered_token}]

  @doc """
  Callback for the GenServer to handle the refresh message
  """
  @impl true
  @spec handle_info(:fetch, state) :: {:noreply, state}
  def handle_info(:fetch, state) do
    Logger.info("Started fetch state for App access token")
    {:ok, response} = MyFinch.request(:post, configure_twitch_token_url(), [], nil)
    new_state = update_app_access_token_state(state, response)
    %__MODULE__{expires_in: expires_in} = new_state
    refresh_seconds = expires_in * 1_000 - 10_000
    schedule_refresh(refresh_seconds)
    Logger.debug("Updating the App access token in: #{refresh_seconds} seconds")
    {:noreply, new_state}
  end

  @impl true
  def handle_call(:state, _from, state) do
    {:reply, state, state}
  end

  @doc """
  Starts the GenServer
  """
  @spec start_link(any) :: :ignore | {:error, term} | {:ok, pid}
  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  @spec get_app_access_token :: binary
  def get_app_access_token do
    %__MODULE__{access_token: app_access_token} = GenServer.call(__MODULE__, :state)
    app_access_token
  end

  defp fetch_app_access_token, do: Process.send(self(), :fetch, [])

  defp schedule_refresh(interval), do: Process.send_after(self(), :fetch, interval)

  defp update_app_access_token_state(state, response) do
    %{
      "access_token" => access_token,
      "expires_in" => expires_in,
      "token_type" => token_type
    } = handle_and_log_response_body(response, @filter_access_token)

    %__MODULE__{
      state
      | access_token: access_token,
        expires_in: expires_in,
        token_type: token_type
    }
  end

  defp handle_and_log_response_body(response, filter_keys) do
    parsed_body = Jason.decode!(response.body)
    filtered_body = Map.drop(parsed_body, filter_keys)
    response_filtered = %Finch.Response{response | body: filtered_body}
    Logger.debug(response_filtered)
    parsed_body
  end

  defp configure_twitch_token_url do
    wrapped_client_secret = fn -> System.fetch_env!("client_secret") end
    wrapped_client_id = fn -> System.fetch_env!("client_id") end

    scopes =
      :scrapped_twitch_api
      |> Application.get_env(:access_token_scopes)
      |> Enum.join("+")

    @twitch_token_url
    |> Kernel.<>("&client_id=#{wrapped_client_id.()}")
    |> Kernel.<>("&client_secret=#{wrapped_client_secret.()}")
    |> Kernel.<>("&scope=#{scopes}")
  end
end
