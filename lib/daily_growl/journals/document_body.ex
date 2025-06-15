defmodule DailyGrowl.Journals.DocumentBody do
  use Ecto.Schema

  alias DailyGrowl.Journals.Document
  alias DailyGrowl.Journals.DocumentBody

  schema("document_bodies") do
    field(:content, :string, default: "")
    field(:draft_content, :string, default: "")

    belongs_to(:document, Document)
  end

  @required ~w(content document_id)a
  @castable @required

  def changeset(%DocumentBody{} = document_body \\ %DocumentBody{}, params) do
    document_body
    |> Ecto.Changeset.cast(params, @castable)
    |> Ecto.Changeset.validate_required(@required)
  end
end
