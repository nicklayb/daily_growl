defmodule DailyGrowl.Journals.UseCase.Journal.New do
  alias DailyGrowl.Journals.Journal
  use Box.UseCase

  @impl Box.UseCase
  def run(%Ecto.Multi{} = multi, params, _) do
    Ecto.Multi.insert(multi, :journal, Journal.changeset(params))
  end

  @impl Box.UseCase
  def return(%{journal: journal}, _), do: journal
end
