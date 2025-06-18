defmodule DailyGrowl.Journals do
  import DailyGrowl.UseCase, only: [delegate_use_case: 2]
  alias DailyGrowl.Journals.UseCase

  delegate_use_case(:new_journal, UseCase.Journal.New)

  delegate_use_case(:new_document, UseCase.Document.New)
  delegate_use_case(:update_document_content, UseCase.Document.UpdateContent)
end
