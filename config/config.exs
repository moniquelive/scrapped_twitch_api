use Mix.Config

config :twitch_api,
  default_adapter: "https://dev.twitch.tv/docs/api/reference",
  authorization: System.get_env("authorization"),
  client_id: System.get_env("client_id")

import_config "#{Mix.env()}.exs"
