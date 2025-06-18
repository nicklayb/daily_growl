defmodule DailyGrowl.Journals.Tag do
  use DailyGrowl, {:schema, as: :tag}

  alias DailyGrowl.Journals.Tag

  schema("tags") do
    field(:name, :string)
  end

  @required ~w(name)a
  @castable @required

  def changeset(%Tag{} = tag \\ %Tag{}, params) do
    tag
    |> Ecto.Changeset.cast(params, @castable)
    |> Ecto.Changeset.validate_required(@required)
  end
end
