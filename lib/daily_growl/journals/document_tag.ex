defmodule DailyGrowl.Journals.DocumentTag do
  use DailyGrowl, {:schema, as: :document_tag}

  alias DailyGrowl.Journals.Document
  alias DailyGrowl.Journals.DocumentTag
  alias DailyGrowl.Journals.Tag

  schema("document_bodies") do
    belongs_to(:document, Document)
    belongs_to(:tag, Tag)
  end

  @required ~w(tag_id document_id)a
  @castable @required

  def changeset(%DocumentTag{} = document_tag \\ %DocumentTag{}, params) do
    document_tag
    |> Ecto.Changeset.cast(params, @castable)
    |> Ecto.Changeset.validate_required(@required)
  end
end
