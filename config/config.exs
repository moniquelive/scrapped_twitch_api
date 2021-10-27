use Mix.Config

config :scrapped_twitch_api,
  default_adapter: "https://dev.twitch.tv/docs/api/reference",
  access_token_scopes: ""

import_config "#{Mix.env()}.exs"
