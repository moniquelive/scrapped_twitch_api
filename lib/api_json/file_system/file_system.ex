defmodule TwitchApi.ApiJson.FileSystem do
  @moduledoc """
  Provides the file system for twitch api an item
  """
  alias TwitchApi.ApiJson.{Item, Template}
  alias TwitchApi.ApiJson.Template.ModuleName

  @prepend_path "lib/resources/"

  @doc """
  Provides twitch api file system for a twitch api item.
  This file system will be created in: `#{@prepend_path}` folder
  """
  @spec create_file_system(Item.t()) :: :ok
  def create_file_system(item) do
    item |> create_folder() |> create_file()
    :ok
  end

  defp create_folder(item) do
    folder_name = get_resource_category(item)

    case File.mkdir(@prepend_path <> folder_name) do
      {:error, :eexist} -> :ok
      :ok -> :ok
    end

    item
  end

  @spec get_resource_category(Item.t()) :: binary
  defp get_resource_category(item) do
    item.category.resource
    |> String.split(" ")
    |> Enum.map_join("_", fn item ->
      String.downcase(item)
    end)
  end

  @spec create_file(Item.t()) :: Item.t()
  defp create_file(item) do
    folder_name = get_resource_category(item)
    content = Template.create_file_content(item)
    filename = ModuleName.get_file_name(item)
    File.write!(@prepend_path <> folder_name <> "/#{filename}" <> ".ex", content)
    item
  end
end
