# app/services/journals/delete_journal_service.rb
module Journals
  class DeleteJournalService
    def self.call(id:, current_user:)
      journal = ::Journal.find_by(id:)

      # Check if the journal exists
      return { success: false, errors: [ "Journal not found" ] } if journal.nil?

      # Check if the current user is authorized to delete the journal
      if journal.user_id != current_user&.id
        return { success: false, errors: [ "You are not authorized to delete this journal" ] }
      end

      # Attempt to destroy the journal
      if journal.destroy
        { success: true, errors: [] }
      else
        { success: false, errors: [ "Failed to delete the journal" ] }
      end
    end
  end
end
