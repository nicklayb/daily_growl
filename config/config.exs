import Config

config :daily_growl,
  environment: config_env(),
  ecto_repos: [DailyGrowl.Repo],
  generators: [timestamp_type: :utc_datetime, binary_id: true]

config :daily_growl, DailyGrowlWeb.Endpoint,
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [json: DailyGrowlWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: DailyGrowl.PubSub

config :esbuild,
  version: "0.17.11",
  daily_growl: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

config :tailwind,
  version: "3.4.3",
  daily_growl: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{config_env()}.exs"
