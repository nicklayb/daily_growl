defmodule DailyGrowlWeb.Router do
  use DailyGrowlWeb, :router

  import Phoenix.LiveView.Router

  pipeline(:browser) do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_live_flash)
    plug(:put_root_layout, {DailyGrowlWeb.Components.Layouts, :root})
    plug(:put_layout, {DailyGrowlWeb.Components.Layouts, :app})
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  scope("/", DailyGrowlWeb) do
    pipe_through([:browser])
    live("/", Main.Live)
  end
end
