import Config

config :caltar, Caltar.Repo, pool: Ecto.Adapters.SQL.Sandbox

config :caltar, CaltarWeb.Endpoint, server: false

config :logger, level: :warning

config :phoenix, :plug_init_mode, :runtime
