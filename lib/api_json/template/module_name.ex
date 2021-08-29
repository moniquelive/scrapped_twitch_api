defmodule TwitchApi.ApiJson.Template.ModuleName do
  @moduledoc """
  Provides the module name template for a twitch api item module
  """
  alias TwitchApi.ApiJson.Item

  @doc """
  Creates a twitch api Elixir module name template
  """
  @spec create_module_name(Item.t()) :: binary
  def create_module_name(item) do
    resource = get_resource_category(item)
    resource_name = get_module_name(item)

    "TwitchApi.#{resource}.#{resource_name}"
  end

  @spec get_resource_category(Item.t()) :: binary
  defp get_resource_category(item) do
    item.category.resource
    |> String.split(" ")
    |> Enum.map_join(& &1)
  end

  @spec get_module_name(Item.t()) :: binary
  defp get_module_name(item) do
    item.category.action
    |> String.split(" ")
    |> Enum.map_join(& &1)
  end

  @doc """
  Gets the twitch api Elixir file name from a twitch api item
  """
  @spec get_file_name(Item.t()) :: binary
  def get_file_name(item) do
    item.category.action
    |> String.split(" ")
    |> Enum.map(&String.downcase/1)
    |> Enum.map_join("_", & &1)
  end
end
