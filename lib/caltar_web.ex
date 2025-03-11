defmodule CaltarWeb do
  def static_paths, do: ~w(assets fonts images favicon.ico robots.txt)

  def router do
    quote do
      use Phoenix.Router, helpers: false

      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
    end
  end

  def controller do
    quote do
      use Phoenix.Controller,
        formats: [:html, :json],
        layouts: [html: CaltarWeb.Layouts]

      use Gettext, backend: CaltarWeb.Gettext

      import Plug.Conn

      unquote(view_helpers())
    end
  end

  def verified_routes do
    quote do
      use Phoenix.VerifiedRoutes,
        endpoint: CaltarWeb.Endpoint,
        router: CaltarWeb.Router,
        statics: CaltarWeb.static_paths()
    end
  end

  def component do
    quote do
      use Phoenix.Component

      unquote(view_helpers())
    end
  end

  def live_component do
    quote do
      use Phoenix.LiveComponent

      unquote(view_helpers())
    end
  end

  def live_view do
    quote do
      use Phoenix.LiveView
      unquote(view_helpers())
    end
  end

  def view_helpers do
    quote do
      use CaltarWeb.Gettext
      alias Box.Html
      unquote(verified_routes())
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
