import Mix.Config

config :scrapped_twitch_api,
  default_adapter: "https://dev.twitch.tv/docs/api/reference",
  access_token_scopes: ["user:read:email"],
  callback_protocol: :http,
  callback_uri: "localhost",
  callback_port: 8090

import_config "#{Mix.env()}.exs"
