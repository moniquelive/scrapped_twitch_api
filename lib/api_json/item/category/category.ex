defmodule TwitchApi.ApiJson.Item.Category do
  @moduledoc """
  Provides an ecto schema for working with twitch api json category items.
  """
  use Ecto.Schema

  @type t :: %__MODULE__{
          action: String.t(),
          description: String.t(),
          resource: String.t()
        }

  @primary_key false
  embedded_schema do
    field(:action, :string)
    field(:description, :string)
    field(:resource, :string)
  end

  @doc """
  Provides the changeset for twitch api json category items
  """
  @spec changeset(%__MODULE__{}, %{binary => binary}) :: Ecto.Changeset.t()
  def changeset(struct, params) do
    Ecto.Changeset.cast(struct, params, [:action, :description, :resource])
  end
end
