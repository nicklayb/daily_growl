defmodule DailyGrowl.Journals.Journal do
  use Ecto.Schema

  alias DailyGrowl.Journals.Document
  alias DailyGrowl.Journals.Journal

  schema("journals") do
    field(:name, :string)
    field(:recurrence, :map)
    field(:start_date, :naive_datetime)

    has_many(:documents, Document)
  end

  @required ~w(name)a
  @optional ~w(recurrence)a
  @castable @required ++ @optional

  def changeset(%Journal{} = journal \\ %Journal{}, params) do
    journal
    |> Ecto.Changeset.cast(params, @castable)
    |> Ecto.Changeset.validate_required(@required)
    |> Ecto.Changeset.unique_constraint(:name, name: "journals_name_index")
  end
end
