defmodule TwitchApi.ApiJson.Item.Doc do
  @moduledoc """
  Provides an ecto schema for working with twitch api json doc items.
  """
  use Ecto.Schema

  alias TwitchApi.ApiJson.Item.Doc.{Request, Response}

  @type t :: %__MODULE__{
          requests: Request.t(),
          responses: Response.t()
        }

  @primary_key false
  embedded_schema do
    embeds_one(:requests, Request)
    embeds_one(:responses, Response)
  end

  @doc """
  Provides the changeset for twitch api json doc items
  """
  @spec changeset(%__MODULE__{}, %{binary => %{binary => [binary]}}) :: Ecto.Changeset.t()
  def changeset(struct, params) do
    Ecto.Changeset.cast(struct, params, [])
    |> Ecto.Changeset.cast_embed(:requests)
    |> Ecto.Changeset.cast_embed(:responses)
  end
end
