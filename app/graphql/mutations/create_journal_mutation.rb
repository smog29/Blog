# frozen_string_literal: true

module Mutations
  class CreateJournalMutation < BaseMutation
    argument :title, String, required: true
    argument :description, String, required: false
    argument :user_id, ID, required: true

    field :journal, Types::JournalType, null: true
    field :errors, [ String ], null: false

    def resolve(title:, description:, user_id:)
      journal = Journal.new(title:, description:, user_id:)

      if journal.save
        {
          journal: journal,
          errors: []
        }
      else
        {
          journal: nil,
          errors: journal.errors.full_messages
        }
      end
    end
  end
end
