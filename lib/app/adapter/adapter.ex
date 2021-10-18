defmodule TwitchApi.MyFinch do
  @moduledoc """
  Provides funcion wrapper for making Finch requests
  """

  @spec request(
          Finch.Request.method(),
          Finch.Request.url()
        ) :: {:ok, Finch.Response.t()} | {:error, Exception.t()}
  def request(method, url),
    do: Finch.build(method, url) |> Finch.request(MyFinch)

  @spec request(
          Finch.Request.method(),
          Finch.Request.url(),
          Finch.Request.headers(),
          Finch.Request.body()
        ) :: {:ok, Finch.Response.t()} | {:error, Exception.t()}
  def request(method, url, headers, body),
    do: Finch.build(method, url, headers, body) |> Finch.request(MyFinch)
end
