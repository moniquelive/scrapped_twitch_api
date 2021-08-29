defmodule TwitchApi.ApiJson.Item.Request.ResponseCode do
  @moduledoc """
  Provides an ecto schema for working with twitch api json request response code items.
  """
  use Ecto.Schema

  @type t :: %__MODULE__{
          http_code: String.t(),
          meaning: String.t()
        }

  @primary_key false
  embedded_schema do
    field(:http_code, :string)
    field(:meaning, :string)
  end

  @doc """
  Provides the changeset for twitch api json request response code items
  """
  @spec changeset(%__MODULE__{}, %{binary => binary}) :: Ecto.Changeset.t()
  def changeset(struct, params) do
    Ecto.Changeset.cast(struct, params, [:http_code, :meaning])
  end
end
