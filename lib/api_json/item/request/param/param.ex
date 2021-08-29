defmodule TwitchApi.ApiJson.Item.Request.Param do
  @moduledoc """
  Provides an ecto schema for working with twitch api json request param items.
  """
  use Ecto.Schema

  @type t :: %__MODULE__{
          description: String.t(),
          type: String.t(),
          param: String.t()
        }

  @primary_key false
  embedded_schema do
    field(:description, :string, default: "")
    field(:type, :string, default: "")
    field(:param, :string, default: "")
  end

  @doc """
  Provides the changeset for twitch api json request param items
  """
  @spec changeset(%__MODULE__{}, %{binary => binary}) :: Ecto.Changeset.t()
  def changeset(struct, params) do
    Ecto.Changeset.cast(struct, params, [:description, :type, :param])
  end
end
