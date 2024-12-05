module Journals
  class DeleteJournalService < ApplicationService
    def initialize(id:, current_user:)
      @id = id
      @current_user = current_user
    end

    def call
      journal = ::Journal.find_by(id:)

      return { success: false, errors: [ "Journal not found" ] } if journal.nil?

      if !authorized?(current_user, journal.user_id)
        return { success: false, errors: [ "You are not authorized to delete this journal" ] }
      end

      destroy_journal(journal)
    end

    private

    attr_reader :id, :current_user

    def destroy_journal(journal)
      if journal.destroy
        { success: true, errors: [] }
      else
        { success: false, errors: [ "Failed to delete the journal" ] }
      end
    end
  end
end
