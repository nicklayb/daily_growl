defmodule DailyGrowl do
  @moduledoc """
  DailyGrowl keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def schema(options) do
    quote do
      use Ecto.Schema
      require Ecto.Query

      @type t :: %__MODULE__{}

      def from() do
        Ecto.Query.from(__MODULE__, as: unquote(Keyword.fetch!(options, :as)))
      end
    end
  end

  def query(options) do
    quote do
      require Ecto.Query

      @base_module Keyword.fetch!(unquote(options), :from)

      defdelegate from, to: @base_module

      def by_id(queryable \\ from(), id) do
        Ecto.Query.where(queryable, [q], q.id == ^id)
      end
    end
  end

  defmacro __using__({kind, options}) do
    apply(DailyGrowl, kind, [options])
  end
end
