defmodule TwitchApi.OIDC do
  use GenServer, restart: :transient

  @moduledoc """
  This module provides a process to hold the state for twitch user access tokens
  """

  require Logger

  alias __MODULE__.AccessToken

  @enforce_keys [:users_id, :users_name]
  defstruct [:state, :users_id, :users_name]

  @type user_data :: %{
          access_token: binary,
          refresh_token: binary,
          scope: binary,
          token_type: binary,
          expiration_time: integer,
          time_issued: integer
        }
  @type users_data :: %{binary => user_data}
  @type state :: %__MODULE__{state: [binary], users_id: users_data, users_name: users_data}

  @filter_state ~w(state)a
  @filter_users_data ~w(access_token refresh_token)a

  @doc """
  Callback function when the GenServer is started
  """
  @spec init(any) :: {:ok, state}
  @impl true
  def init(state) do
    Logger.info("Started user_access_token process")
    {:ok, state}
  end

  @doc """
  Callback function when the GenServer fetches the status. Filter sensitive data.
  """
  @impl true
  @spec format_status(any, list) :: list
  def format_status(_reason, [pdict, state]) do
    no_state = Map.drop(state, @filter_state)
    %__MODULE__{users_id: users_by_id, users_name: users_by_name} = no_state

    filtered_users_by_id =
      for {k, v} <- users_by_id, into: %{}, do: {k, Map.drop(v, @filter_users_data)}

    filtered_users_by_name =
      for {k, v} <- users_by_name, into: %{}, do: {k, Map.drop(v, @filter_users_data)}

    filtered_state = %__MODULE__{
      users_id: filtered_users_by_id,
      users_name: filtered_users_by_name
    }

    [pdict, filtered_state]
  end

  @doc """
  :browser => Callback for the GenServer to handle the browser message
  :access_token => Callback for the GenServer to handle the user access token
  """
  @impl true
  def handle_cast({:access_token, %{"code" => code}}, state) do
    Logger.info("Sending authorization request to twitch for access token")
    {:noreply, AccessToken.request(code, state)}
  end

  def handle_cast({:delete_state, state_to_delete}, %__MODULE__{state: states} = state) do
    Logger.info("Deleting used state from authorized user")
    {:noreply, %{state | state: List.delete(states, state_to_delete)}}
  end

  def handle_cast({:add_state, state_to_add}, %__MODULE__{state: states} = state) do
    Logger.info("Adding state from unauthorized user")
    {:noreply, %{state | state: [state_to_add | states]}}
  end

  @doc """
  Callback for the GenServer to handle the state message for retieving previously created state.
  """
  @impl true
  def handle_call(:state, _from, state) do
    Logger.debug("Fetching states list")
    {:reply, state, state}
  end

  @doc """
  Callback for the GenServer to handle the refresh message
  """
  @impl true
  def handle_info({:refresh, user_id, user_name, refresh_token, interval}, state) do
    Logger.info("Sending refresh request for access token from user: #{user_name}")
    {:noreply, AccessToken.refresh(user_id, user_name, refresh_token, interval, state)}
  end

  @doc """
  Starts the GenServer
  """
  @spec start_link(any) :: :ignore | {:error, term} | {:ok, pid}
  def start_link(_) do
    start_state = %__MODULE__{state: [], users_id: %{}, users_name: %{}}
    GenServer.start_link(__MODULE__, start_state, name: __MODULE__)
  end

  @doc """
  Returns the Genserver state
  """
  @spec get_state :: binary
  def get_state do
    %__MODULE__{state: state} = GenServer.call(__MODULE__, :state)
    state
  end

  @doc """
  Delete state the Genserver state list
  """
  @spec delete_from_state(binary) :: :ok
  def delete_from_state(state_to_delete),
    do: GenServer.cast(__MODULE__, {:delete_state, state_to_delete})

  @doc """
  Add state the Genserver state list
  """
  @spec add_to_state(binary) :: :ok
  def add_to_state(state_to_add), do: GenServer.cast(__MODULE__, {:add_state, state_to_add})

  @doc """
  Returns the access token for the given user by user_id
  """
  @spec get_access_token_id(integer | binary) :: binary
  def get_access_token_id(user_id) when is_integer(user_id) do
    user_id_binary = Integer.to_string(user_id)
    %__MODULE__{users_id: users_by_id} = GenServer.call(__MODULE__, :state)

    case Map.get(users_by_id, user_id_binary) do
      nil -> nil
      %{access_token: access_token} -> access_token
    end
  end

  def get_access_token_id(user_id) do
    %__MODULE__{users_id: users_by_id} = GenServer.call(__MODULE__, :state)

    case Map.get(users_by_id, user_id) do
      nil -> nil
      %{access_token: access_token} -> access_token
    end
  end

  @doc """
  Returns the access token for the given user by user_id
  """
  @spec get_access_token_name(binary) :: binary
  def get_access_token_name(user_name) do
    %__MODULE__{users_name: users_by_name} = GenServer.call(__MODULE__, :state)

    case Map.get(users_by_name, user_name) do
      nil -> nil
      %{access_token: access_token} -> access_token
    end
  end

  @doc """
  Request the access token for the previously authorized user
  """
  @spec request_access_token(map) :: :ok
  def request_access_token(query_params),
    do: GenServer.cast(__MODULE__, {:access_token, query_params})

  @doc """
  Function to send the message to refresh
  """
  @spec schedule_refresh(binary, binary, binary, non_neg_integer) :: reference
  def schedule_refresh(user_id, user_name, refresh_token, interval) do
    Logger.debug("Scheduling a refresh for user: #{user_name} in #{interval} seconds")

    Process.send_after(
      self(),
      {:refresh, user_id, user_name, refresh_token, interval},
      interval * 1_000
    )
  end
end
