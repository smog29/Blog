module Journals
  class CreateJournalService < ApplicationService
    def initialize(title:, description:, current_user:)
      @title = title
      @description = description
      @current_user = current_user
    end

    def call
      return { journal: nil, errors: [ "Not Authorized" ] } if current_user.blank?

      save_journal
    end

    private

    attr_reader :title, :description, :current_user

    def save_journal
      journal = ::Journal.new(title:, description:, user_id: current_user.id)

      if journal.save
        { journal: journal, errors: [] }
      else
        { journal: nil, errors: journal.errors.full_messages }
      end
    end
  end
end
