defmodule DailyGrowl.Journals.Document do
  use DailyGrowl, {:schema, as: :document}

  alias DailyGrowl.Journals.Document
  alias DailyGrowl.Journals.DocumentBody
  alias DailyGrowl.Journals.Journal

  schema("documents") do
    field(:name, :string)
    field(:document_date, :naive_datetime)

    belongs_to(:journal, Journal)
    has_one(:body, DocumentBody)
  end

  @required ~w(name journal_id document_date)a
  @castable @required

  @spec changeset(t(), map()) :: Ecto.Changeset.t()
  def changeset(%Document{} = document \\ %Document{}, params) do
    document
    |> Ecto.Changeset.cast(params, @castable)
    |> Ecto.Changeset.validate_required(@required)
    |> Ecto.Changeset.unique_constraint(:document_date, name: "documents_journal_id_name_index")
  end
end
