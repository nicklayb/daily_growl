defmodule DailyGrowlWeb.Journals.Live do
  alias DailyGrowl.Journals
  use DailyGrowlWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
