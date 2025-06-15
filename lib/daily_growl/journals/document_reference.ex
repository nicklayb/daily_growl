defmodule DailyGrowl.Journals.DocumentReference do
  use Ecto.Schema

  alias DailyGrowl.Journals.Document
  alias DailyGrowl.Journals.DocumentReference

  schema("document_bodies") do
    belongs_to(:source_document, Document)
    belongs_to(:destination_document, Document)
  end

  @required ~w(source_document_id destination_document_id)a
  @castable @required

  def changeset(%DocumentReference{} = document_reference \\ %DocumentReference{}, params) do
    document_reference
    |> Ecto.Changeset.cast(params, @castable)
    |> Ecto.Changeset.validate_required(@required)
  end
end
