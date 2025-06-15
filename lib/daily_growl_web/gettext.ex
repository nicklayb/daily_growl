defmodule DailyGrowlWeb.Gettext do
  use Gettext.Backend, otp_app: :daily_growl

  defmacro __using__(_) do
    quote do
      use Gettext, backend: DailyGrowlWeb.Gettext
    end
  end
end
