defmodule DailyGrowl.Journals.UseCase.Document.New do
  use Box.UseCase
  alias DailyGrowl.Journals.DocumentBody
  alias DailyGrowl.Journals.Document

  @impl Box.UseCase
  def run(%Ecto.Multi{} = multi, params, _) do
    multi
    |> Ecto.Multi.insert(:document, Document.changeset(params))
    |> Ecto.Multi.insert(:body, fn %{document: document} ->
      DocumentBody.changeset(%{document_id: document.id, content: "", draft_content: ""})
    end)
  end

  @impl Box.UseCase
  def return(%{document: document, body: body}, _) do
    %Document{document | body: body}
  end
end
