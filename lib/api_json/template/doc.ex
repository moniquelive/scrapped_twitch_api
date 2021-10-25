defmodule TwitchApi.ApiJson.Template.Doc do
  @moduledoc """
  Provides the doc template for a twitch api item module
  """
  alias TwitchApi.ApiJson.Item

  @doc """
  Creates a twitch api Elixir documentation template
  """
  @spec create_doc(Item.t()) :: binary
  def create_doc(item) do
    authentication = Enum.map_join(item.request.authentication, "\n  ", & &1)
    authorization = Enum.map_join(item.request.authorization, "\n  ", & &1)

    """
    @doc \"\"\"
      ### Description:
      #{item.category.description}

      ### Required authentication:
      #{authentication}

      ### Required authorization:
      #{authorization}
      \"\"\"
    """
  end
end
