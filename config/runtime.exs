import Config

config :daily_growl, release_name: Box.Config.get("RELEASE_NAME")

db_hostname = Box.Config.get("DB_HOST", default: "localhost")
db_name = Box.Config.get("DB_NAME", default: "daily_growl", test: "daily_growl_test")
db_user = Box.Config.get("DB_USER", default: "postgres")
db_pass = Box.Config.get("DB_PASS", default: "postgres")

config :daily_growl, DailyGrowl.Repo,
  hostname: db_hostname,
  database: db_name,
  username: db_user,
  password: db_pass

app_host = Box.Config.uri("APP_HOST", default: "http://localhost:4000")
port = Box.Config.int("PORT", default: "4000")

config :daily_growl, DailyGrowlWeb.Endpoint,
  http: [port: port],
  url: [host: app_host.host, scheme: app_host.scheme, port: app_host.port],
  secret_key_base: Box.Config.get!("SECRET_KEY_BASE"),
  live_view: [signing_salt: Box.Config.get!("LIVE_VIEW_SALT")]
