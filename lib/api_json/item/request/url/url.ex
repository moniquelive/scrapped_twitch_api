defmodule TwitchApi.ApiJson.Item.Request.Url do
  @moduledoc """
  Provides an ecto schema for working with twitch api json request url items.
  """
  use Ecto.Schema

  @type t :: %__MODULE__{
          method: String.t(),
          url: String.t(),
          description: String.t()
        }

  @primary_key false
  embedded_schema do
    field(:method, :string, default: "")
    field(:url, :string, default: "")
    field(:description, :string, default: "")
  end

  @doc """
  Provides the changeset for twitch api json request url items
  """
  @spec changeset(%__MODULE__{}, %{binary => binary}) :: Ecto.Changeset.t()
  def changeset(struct, params) do
    Ecto.Changeset.cast(struct, params, [:method, :url, :description])
  end
end
