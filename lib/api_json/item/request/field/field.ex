defmodule TwitchApi.ApiJson.Item.Request.Field do
  @moduledoc """
  Provides an ecto schema for working with twitch api json request field items.
  """
  use Ecto.Schema

  @type t :: %__MODULE__{
          field: String.t(),
          type: String.t(),
          description: String.t()
        }

  @primary_key false
  embedded_schema do
    field(:field, :string, default: "")
    field(:type, :string, default: "")
    field(:description, :string)
  end

  @doc """
  Provides the changeset for twitch api json request field items
  """
  @spec changeset(%__MODULE__{}, %{binary => binary}) :: Ecto.Changeset.t()
  def changeset(struct, params) do
    Ecto.Changeset.cast(struct, params, [:field, :type, :description])
  end
end
