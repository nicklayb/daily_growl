defmodule DailyGrowl.Repo.Migrations.CreateInitialTables do
  use Ecto.Migration

  def change do
    execute("CREATE EXTENSION citext", "DROP EXTENSION citext")

    create(table("journals")) do
      add(:name, :citext, null: false)
      add(:recurrence, :map, null: true)
      add(:start_date, :utc_datetime, null: true)
    end

    create(unique_index("journals", [:name]))

    create(table("tags")) do
      add(:name, :citext, null: false)
    end

    create(unique_index("tags", [:name]))

    create(table("documents")) do
      add(:name, :citext, null: false)
      add(:journal_id, references("journals", on_delete: :delete_all), null: true)
      add(:document_date, :utc_datetime, null: false)
    end

    create(unique_index("documents", [:journal_id, :name]))
    create(index("documents", [:journal_id]))

    create(table("document_bodies")) do
      add(:document_id, references("documents", on_delete: :delete_all), null: false)
      add(:content, :text, null: false)
      add(:draft_content, :text, null: false)
    end

    create(unique_index("document_bodies", [:document_id]))

    create(table("document_tags")) do
      add(:tag_id, references("tags", on_delete: :delete_all), null: false)
      add(:document_id, references("documents", on_delete: :delete_all), null: false)
    end

    create(unique_index("document_tags", [:document_id, :tag_id]))

    create(table("action_points")) do
      add(:name, :string, null: false)
      add(:origin_document_id, references("documents", on_delete: :delete_all), null: false)
      add(:closing_document_id, references("documents", on_delete: :delete_all), null: true)
      add(:closed_date, :utc_datetime, null: true)
    end

    create(index("action_points", [:origin_document_id]))
    create(index("action_points", [:closing_document_id]))

    create(table("action_point_notes")) do
      add(:action_point_id, references("action_points", on_delete: :delete_all), null: false)
      add(:content, :text, null: false)
    end

    create(index("action_point_notes", [:action_point_id]))

    create(table("document_references")) do
      add(:source_document_id, references("documents", on_delete: :delete_all), null: false)
      add(:destination_document_id, references("documents", on_delete: :delete_all), null: false)
    end

    create(
      unique_index("document_references", [:source_document_id, :destination_document_id],
        name: :document_references_source_destination_index
      )
    )
  end
end
