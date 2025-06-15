import Config

config :daily_growl, DailyGrowlWeb.Endpoint, cache_static_manifest: "priv/static/cache_manifest.json"

config :logger, level: :info

config :daily_growl, DailyGrowlWeb.Endpoint, server: true
