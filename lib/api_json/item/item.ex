defmodule TwitchApi.ApiJson.Item do
  @moduledoc """
  Provides an ecto schema for working with twitch api json items.
  """
  use Ecto.Schema

  @twitch_api_scrapped_json "https://raw.githubusercontent.com/kamiyuzu/twitch_api_scraper/master/lib/fixtures/json/twitch_api.json"

  alias __MODULE__
  alias TwitchApi.MyFinch
  alias TwitchApi.ApiJson.Item.{Category, Doc, Request}

  @type t :: %__MODULE__{
          category: Category.t(),
          doc: Doc.t(),
          request: Request.t()
        }

  @primary_key {:id, :string, autogenerate: false}
  embedded_schema do
    embeds_one(:category, Category)
    embeds_one(:doc, Doc)
    embeds_one(:request, Request)
  end

  @doc """
  Provides the changeset for twitch api json items
  """
  @spec changeset(struct, %{binary => any}) :: Ecto.Changeset.t()
  def changeset(struct, params) do
    Ecto.Changeset.cast(struct, params, [:id])
    |> Ecto.Changeset.cast_embed(:category)
    |> Ecto.Changeset.cast_embed(:doc)
    |> Ecto.Changeset.cast_embed(:request)
  end

  @spec schema(Ecto.Changeset.t()) :: t()
  defp schema(changeset) do
    Ecto.Changeset.apply_action!(changeset, :insert)
  end

  @doc """
  Fetchs the twitch api json items
  """
  @spec get_api_items :: [Item.t()]
  def get_api_items do
    {:ok, %Finch.Response{body: twitch_api_json}} =
      MyFinch.request(:get, @twitch_api_scrapped_json)

    twitch_api_json
    |> Jason.decode!()
    |> Map.get("twitch_api_scraped_items")
    |> Enum.map(&create_api_json_items/1)
  end

  @spec create_api_json_items(map) :: Item.t()
  defp create_api_json_items(item) do
    %__MODULE__{}
    |> changeset(item)
    |> schema
  end
end
