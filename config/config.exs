use Mix.Config

config :twitch_api,
  default_adapter: "https://dev.twitch.tv/docs/api/reference",
  scopes: ""

import_config "#{Mix.env()}.exs"
