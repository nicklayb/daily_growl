defmodule DailyGrowl.Journals.UseCase.Document.UpdateContent do
  use Box.UseCase
  require Ecto.Query
  alias DailyGrowl.Journals.DocumentBody

  @impl Box.UseCase
  def run(%Ecto.Multi{} = multi, params, _) do
    document_id = Box.Map.get(params, :document_id)

    multi
    |> Ecto.Multi.one(
      :document_body,
      Ecto.Query.where(DocumentBody, [d], d.document_id == ^document_id)
    )
    |> Ecto.Multi.update(:updated_document_body, fn %{document_body: document_body} ->
      DocumentBody.changeset(document_body, params)
    end)
  end

  @impl Box.UseCase
  def return(%{updated_document_body: document_body}, _) do
    document_body
  end
end
