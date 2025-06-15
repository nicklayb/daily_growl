defmodule DailyGrowl.Journals.UseCase.Document.New do
  alias DailyGrowl.Journals.Document
  use Box.UseCase

  @impl Box.UseCase
  def run(%Ecto.Multi{} = multi, params, _) do
    Ecto.Multi.insert(multi, :document, Document.changeset(params))
  end

  @impl Box.UseCase
  def return(%{document: document}, _), do: document
end
