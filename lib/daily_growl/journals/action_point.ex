defmodule DailyGrowl.Journals.ActionPoint do
  use DailyGrowl, {:schema, as: :action_point}

  alias DailyGrowl.Journals.Document
  alias DailyGrowl.Journals.ActionPoint

  schema("journals") do
    field(:closed_date, :naive_datetime)
    belongs_to(:origin_document, Document)
    belongs_to(:closing_document, Document)
  end

  @required ~w(origin_document_id)a
  @optional ~w(closing_document_id closed_date)a
  @castable @required ++ @optional

  def changeset(%ActionPoint{} = action_point \\ %ActionPoint{}, params) do
    action_point
    |> Ecto.Changeset.cast(params, @castable)
    |> Ecto.Changeset.validate_required(@required)
  end
end
