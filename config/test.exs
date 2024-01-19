import Mix.Config

# Print only warnings and errors during test
config :logger, level: :warning

config :scrapped_twitch_api,
  callback_port: 18_090
