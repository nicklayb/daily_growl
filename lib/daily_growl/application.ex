defmodule DailyGrowl.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      DailyGrowl.Repo,
      {Ecto.Migrator,
       repos: Application.fetch_env!(:daily_growl, :ecto_repos), skip: skip_migrations?()},
      {Phoenix.PubSub, name: DailyGrowl.PubSub},
      DailyGrowlWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: DailyGrowl.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    DailyGrowlWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp skip_migrations?() do
    System.get_env("RELEASE_NAME") != nil
  end
end
