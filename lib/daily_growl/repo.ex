defmodule DailyGrowl.Repo do
  use Ecto.Repo,
    otp_app: :daily_growl,
    adapter: Ecto.Adapters.Postgres

  use Box.Ecto.RepoHelpers
end
