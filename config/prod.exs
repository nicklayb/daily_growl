import Config

config :caltar, CaltarWeb.Endpoint, cache_static_manifest: "priv/static/cache_manifest.json"

config :logger, level: :info

config :caltar, CaltarWeb.Endpoint, server: true
