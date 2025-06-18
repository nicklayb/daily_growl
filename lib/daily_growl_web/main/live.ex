defmodule DailyGrowlWeb.Main.Live do
  alias DailyGrowl.Journals
  use DailyGrowlWeb, :live_view

  alias DailyGrowl.Repo
  alias DailyGrowl.Journals.Document

  def mount(_params, _session, socket) do
    document =
      Document
      |> Repo.first()
      |> Repo.preload([:body])

    socket =
      socket
      |> assign(:document, document)
      |> assign(:markdown_html, MDEx.to_html!(document.body.content))
      |> assign(:update_timer, nil)
      |> assign(:save_state, :none)

    {:ok, socket}
  end

  @debounce_timer 1000
  def handle_event("Editor:documentUpdated", %{"body" => body}, socket) do
    socket =
      socket
      |> assign(:updated_body, body)
      |> assign(:markdown_html, MDEx.to_html!(body))
      |> assign(:save_state, :waiting)
      |> update(:update_timer, fn timer ->
        if timer, do: Process.cancel_timer(timer)
        Process.send_after(self(), :save_document, @debounce_timer)
      end)

    {:noreply, socket}
  end

  def handle_info(:save_document, %{assigns: %{updated_body: updated_body}} = socket) do
    document_id = socket.assigns.document.id

    with {:ok, document_body} <-
           Journals.update_document_content(%{document_id: document_id, content: updated_body}) do
      socket =
        socket
        |> assign(:update_timer, nil)
        |> assign(:save_state, :saved)
        |> update(:document, fn %Document{} = document ->
          %Document{document | body: document_body}
        end)

      {:noreply, socket}
    else
      _ ->
        {:noreply, socket}
    end
  end
end
