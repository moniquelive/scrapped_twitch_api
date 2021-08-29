defmodule TwitchApi.ApiJson.Template do
  @moduledoc """
  Provides the generic template for a twitch api item module
  """
  alias TwitchApi.ApiJson.Item
  alias TwitchApi.ApiJson.Template.{ModuleDoc, ModuleName, Doc, Method, Alias}

  @doc """
  Creates a twitch api Elixir module template
  """
  @spec create_file_content(Item.t()) :: binary
  def create_file_content(item) do
    module_name = ModuleName.create_module_name(item)
    moduledoc = ModuleDoc.create_moduledoc(item)
    doc = Doc.create_doc(item)
    method = Method.create_method(item)
    aliass = Alias.get_alias()

    """
    defmodule #{module_name} do
      #{moduledoc}
      #{aliass}

      #{doc}
      #{method}
    end
    """
  end
end
