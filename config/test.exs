import Config

config :daily_growl, DailyGrowl.Repo, pool: Ecto.Adapters.SQL.Sandbox

config :daily_growl, DailyGrowlWeb.Endpoint, server: false

config :logger, level: :warning

config :phoenix, :plug_init_mode, :runtime
