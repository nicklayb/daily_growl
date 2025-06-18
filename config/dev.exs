import Config

config :daily_growl, DailyGrowl.Repo,
  stacktrace: true,
  show_sensitive_data_on_connection_error: true

config :daily_growl, DailyGrowlWeb.Endpoint,
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  watchers: [
    esbuild: {Esbuild, :install_and_run, [:daily_growl, ~w(--sourcemap=inline --watch)]},
    tailwind: {Tailwind, :install_and_run, [:daily_growl, ~w(--watch)]}
  ],
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"priv/gettext/.*(po)$",
      ~r"lib/daily_growl/.*",
      ~r"lib/daily_growl_web/.*"
    ]
  ]

config :logger, :console, format: "[$level] $message\n"

config :phoenix, :stacktrace_depth, 20

config :phoenix, :plug_init_mode, :runtime
