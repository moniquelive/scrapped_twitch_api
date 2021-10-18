defmodule TwitchApi.ApiJson.Template.Method do
  @moduledoc """
  Provides the methods template for a twitch api item module
  """
  alias TwitchApi.ApiJson.Item
  alias TwitchApi.ApiJson.Template.Method.{Url, Args, Headers, BodyParams}
  alias TwitchApi.ApiJson.Template.Method.Args.Params.Query

  @doc """
  Provides the twitch api Elixir method for a twitch api item
  """
  @spec create_method(Item.t()) :: binary
  def create_method(item) do
    {http_method, url} = Url.get_url(item)
    query_params = Args.query_params(item)
    headers = Headers.get_headers(item)
    body_params = BodyParams.set_body_params(item)

    case query_params do
      [] ->
        create_normal_method(http_method, url, headers, body_params)

      query_params ->
        create_query_param_method(http_method, url, query_params, headers, body_params)
    end
  end

  defp create_normal_method(http_method, url, headers, {specs, method_params, request_params}) do
    parsed_method_params = Headers.parse_method_params(method_params)

    """
    @spec call(#{specs}) :: {:ok, Finch.Response.t} | {:error, Exception.t}
      def call#{parsed_method_params} do
        MyFinch.request(\"#{http_method}\",\"#{url}\"#{headers}#{request_params})
      end
    """
  end

  defp create_query_param_method(http_method, url, query_params, headers, body_params) do
    query_types = Query.get_types(query_params)
    type_params = type_params(query_params)
    parsed_body_params = BodyParams.parse_body_params(type_params, body_params)
    {specs, method_param, _} = parsed_body_params
    parsed_body_specs = BodyParams.parse_body_specs(specs)
    methods_map = methods_map(query_params, http_method, url, headers, parsed_body_params)

    (query_types ++
       parsed_body_specs ++
       [
         "@spec call(#{type_params}#{method_param}) :: {:ok, Finch.Response.t} | {:error, Exception.t}"
       ])
    |> Enum.concat(methods_map)
    |> Enum.map_join("\n  ", & &1)
  end

  defp methods_map(query_params, http_method, url, headers, {_, method_params, request_params}) do
    Enum.map(query_params, fn {query_param, _type, query_param_string} ->
      parsed_param = Query.parse_query_param_type(query_param.param)

      """
      def call(%#{query_param_string}#{method_params}) do
          MyFinch.request(\"#{http_method}\",\"#{url}?#{query_param.param}=\#{#{parsed_param}}\"#{headers}#{request_params})
        end
      """
    end)
  end

  defp type_params(query_params) do
    query_params
    |> Enum.map(fn {query_param, _, _} -> parse(query_param.param) end)
    |> Enum.intersperse(" | ")
    |> Enum.map_join("", & &1)
  end

  defp parse(param), do: Query.parse_query_param_type(param)
end
