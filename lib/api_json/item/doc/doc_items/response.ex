defmodule TwitchApi.ApiJson.Item.Doc.Response do
  @moduledoc """
  Provides an ecto schema for working with twitch api json doc response items.
  """
  use Ecto.Schema

  @type t :: %__MODULE__{
          descriptions: [String.t()],
          responses: [String.t()]
        }

  @primary_key false
  embedded_schema do
    field(:descriptions, {:array, :string})
    field(:responses, {:array, :string})
  end

  @doc """
  Provides the changeset for twitch api json doc response items
  """
  @spec changeset(%__MODULE__{}, %{binary => [binary]}) :: Ecto.Changeset.t()
  def changeset(struct, params) do
    Ecto.Changeset.cast(struct, params, [:descriptions, :responses])
  end
end
