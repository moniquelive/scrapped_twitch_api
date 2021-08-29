defmodule Mix.Tasks.UpdateApi do
  @moduledoc "Updates the twitch api library"
  @shortdoc "Updates the twitch api library"

  @resources_path "lib/resources"

  alias TwitchApi.ApiJson.{Item, FileSystem}

  use Mix.Task

  @impl Mix.Task
  @spec run(any) :: :ok
  def run(_args) do
    # This will start our application
    Mix.Task.run("app.start")

    File.rm_rf!(@resources_path)
    File.mkdir!(@resources_path)
    Enum.each(Item.get_api_items(), &FileSystem.create_file_system/1)
  end
end
