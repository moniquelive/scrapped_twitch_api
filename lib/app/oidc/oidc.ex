defmodule TwitchApi.OIDC do
  use GenServer, restart: :transient

  @moduledoc """
  This module provides a process to hold the state for twitch user access tokens
  """

  require Logger

  @enforce_keys [:state]
  defstruct [:state, :access_token, :id_token, :refresh_token, :scope, :token_type]

  @typep state :: %__MODULE__{state: binary}

  @callback_uri "http://localhost:8090/callback"
  @filter_sensitive_keys ~w(access_token id_token refresh_token state)a

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
  def format_status(_reason, [pdict, state]),
    do: [pdict, Map.drop(state, @filter_sensitive_keys)]

  @doc """
  Callback for the GenServer to handle the browser message
  """
  @impl true
  @spec handle_cast({:browser, list}, state) :: {:noreply, state}
  def handle_cast({:browser, scope}, state) do
    Logger.info("Launch browser with twitch oidc authorization path")
    oidc_state = generate_state()
    path = generate_oidc_url(oidc_state, scope)
    browser_open(path)
    {:noreply, %__MODULE__{state | state: oidc_state}}
  end

  def handle_cast({:access_token, %{"code" => code}}, state) do
    Logger.info("Sending authorization request to twitch for access token")
    url = generate_authorize_url(code)
    {:ok, resp} = TwitchApi.MyFinch.request(:post, url, [], nil)

    %{
      "access_token" => access_token,
      "id_token" => id_token,
      "refresh_token" => refresh_token,
      "scope" => scope,
      "token_type" => token_type
    } = Jason.decode!(resp.body)

    new_state = %{
      state
      | access_token: access_token,
        id_token: id_token,
        refresh_token: refresh_token,
        scope: scope,
        token_type: token_type
    }

    {:noreply, new_state}
  end

  @doc """
  Callback for the GenServer to handle the state message for retieving previously created state.
  """
  @impl true
  def handle_call(:state, _from, state) do
    {:reply, state, state}
  end

  @doc """
  Starts the GenServer
  """
  @spec start_link(any) :: :ignore | {:error, term} | {:ok, pid}
  def start_link(_) do
    GenServer.start_link(__MODULE__, %__MODULE__{state: ""}, name: __MODULE__)
  end

  @spec get_state :: binary
  def get_state do
    %__MODULE__{state: state} = GenServer.call(__MODULE__, :state)
    state
  end

  @spec get_access_token :: binary
  def get_access_token do
    %__MODULE__{access_token: access_token} = GenServer.call(__MODULE__, :state)
    access_token
  end

  @spec browser_user_access_token(list) :: :ok
  def browser_user_access_token(scopes \\ []), do: GenServer.cast(__MODULE__, {:browser, scopes})

  @spec request_access_token(map) :: :ok
  def request_access_token(query_params),
    do: GenServer.cast(__MODULE__, {:access_token, query_params})

  defp browser_open(path) do
    start_browser_command =
      case :os.type() do
        {:win32, _} ->
          "start"

        {:unix, :darwin} ->
          "open"

        {:unix, _} ->
          "xdg-open"
      end

    if System.find_executable(start_browser_command) do
      System.cmd(start_browser_command, [path])
    else
      Mix.raise("Command not found: #{start_browser_command}")
    end
  end

  defp generate_oidc_url(state, []) do
    wrapped_client_id = fn -> System.fetch_env!("client_id") end

    "https://id.twitch.tv/oauth2/authorize"
    |> Kernel.<>("?response_type=code")
    |> Kernel.<>("&client_id=#{wrapped_client_id.()}")
    |> Kernel.<>("&redirect_uri=#{@callback_uri}")
    |> Kernel.<>("&scope=openid")
    |> Kernel.<>("&state=#{state}")
  end

  defp generate_oidc_url(state, scope) do
    wrapped_client_id = fn -> System.fetch_env!("client_id") end
    scopes = Enum.join(scope, "+")

    "https://id.twitch.tv/oauth2/authorize"
    |> Kernel.<>("?response_type=code")
    |> Kernel.<>("&client_id=#{wrapped_client_id.()}")
    |> Kernel.<>("&redirect_uri=#{@callback_uri}")
    |> Kernel.<>("&scope=#{scopes}+openid")
    |> Kernel.<>("&state=#{state}")
  end

  defp generate_state, do: UUID.uuid1()

  defp generate_authorize_url(code) do
    wrapped_client_id = fn -> System.fetch_env!("client_id") end
    wrapped_client_secret = fn -> System.fetch_env!("client_secret") end

    "https://id.twitch.tv/oauth2/token"
    |> Kernel.<>("?grant_type=authorization_code")
    |> Kernel.<>("&client_id=#{wrapped_client_id.()}")
    |> Kernel.<>("&client_secret=#{wrapped_client_secret.()}")
    |> Kernel.<>("&redirect_uri=#{@callback_uri}")
    |> Kernel.<>("&code=#{code}")
  end
end
