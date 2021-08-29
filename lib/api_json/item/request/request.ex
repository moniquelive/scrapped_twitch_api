defmodule TwitchApi.ApiJson.Item.Request do
  @moduledoc """
  Provides an ecto schema for working with twitch api json request items.
  """
  use Ecto.Schema

  alias TwitchApi.ApiJson.Item.Request.{Url, Param, Field, ResponseCode}

  @type t :: %__MODULE__{
          authentication: [String.t()],
          authorization: [String.t()],
          body_params: [Param.t()],
          optional_body_params: [Param.t()],
          optional_query_params: [Param.t()],
          pagination: [String.t()],
          query_params: [Param.t()],
          response_codes: [ResponseCode.t()],
          response_fields: [Field.t()],
          response_values: [Param.t()],
          url: [Url.t()]
        }

  @primary_key false
  embedded_schema do
    field(:authentication, {:array, :string})
    field(:authorization, {:array, :string})
    field(:pagination, {:array, :string})
    embeds_many(:body_params, Param)
    embeds_many(:optional_body_params, Param)
    embeds_many(:optional_query_params, Param)
    embeds_many(:query_params, Param)
    embeds_many(:response_codes, ResponseCode)
    embeds_many(:response_fields, Field)
    embeds_many(:response_values, Param)
    embeds_many(:url, Url)
  end

  @doc """
  Provides the changeset for twitch api json request items
  """
  @spec changeset(%__MODULE__{}, %{binary() => any()}) :: Ecto.Changeset.t()
  def changeset(struct, params) do
    struct
    |> Ecto.Changeset.cast(params, [
      :authentication,
      :authorization,
      :pagination
    ])
    |> Ecto.Changeset.cast_embed(:body_params)
    |> Ecto.Changeset.cast_embed(:optional_body_params)
    |> Ecto.Changeset.cast_embed(:optional_query_params)
    |> Ecto.Changeset.cast_embed(:query_params)
    |> Ecto.Changeset.cast_embed(:response_values)
    |> Ecto.Changeset.cast_embed(:response_fields)
    |> Ecto.Changeset.cast_embed(:response_codes)
    |> Ecto.Changeset.cast_embed(:url)
  end
end
