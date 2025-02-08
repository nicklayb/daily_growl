defmodule Caltar.Repo do
  use Ecto.Repo,
    otp_app: :caltar,
    adapter: Ecto.Adapters.SQLite3
end
