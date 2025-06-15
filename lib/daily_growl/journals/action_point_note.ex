defmodule DailyGrowl.Journals.ActionPointNote do
  use Ecto.Schema

  alias DailyGrowl.Journals.ActionPoint
  alias DailyGrowl.Journals.ActionPointNote

  schema("journals") do
    field(:content, :string)
    belongs_to(:action_point, ActionPoint)
  end

  @required ~w(action_point_id content)a
  @castable @required

  def changeset(%ActionPointNote{} = action_point_note \\ %ActionPointNote{}, params) do
    action_point_note
    |> Ecto.Changeset.cast(params, @castable)
    |> Ecto.Changeset.validate_required(@required)
  end
end
