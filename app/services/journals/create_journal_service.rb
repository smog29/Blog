# app/services/journals/create_journal_service.rb
module Journals
  class CreateJournalService
    def self.call(title:, description:, current_user:)
      return { journal: nil, errors: [ "Not Authorized" ] } if current_user.blank?

      journal = ::Journal.new(title:, description:, user_id: current_user.id)

      if journal.save
        { journal: journal, errors: [] }
      else
        { journal: nil, errors: journal.errors.full_messages }
      end
    end
  end
end
