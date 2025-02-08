import Config

config :caltar, release_name: Env.get("RELEASE_NAME")

config :caltar, Caltar.Repo,
  database:
    Env.get("DATABASE_PATH",
      required: true,
      test: Path.expand("repo/database/caltar_test.db", :code.priv_dir(:caltar)),
      dev: Path.expand("repo/database/caltar_dev.db", :code.priv_dir(:caltar))
    ),
  pool_size: Env.int("POOL_SIZE", default: "5")

app_host = Env.uri("APP_HOST", default: "http://localhost:4000")
port = Env.int("PORT", default: "4000")

config :caltar, CaltarWeb.Endpoint,
  http: [port: port],
  url: [host: app_host.host, scheme: app_host.scheme, port: app_host.port],
  secret_key_base: Env.get("SECRET_KEY_BASE", required: true),
  live_view: [signing_salt: Env.get("LIVE_VIEW_SALT", required: true)]
