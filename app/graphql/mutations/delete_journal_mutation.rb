# frozen_string_literal: true

module Mutations
  class DeleteJournalMutation < BaseMutation
    argument :id, ID, required: true

    field :success, Boolean, null: false
    field :errors, [ String ], null: false

    def resolve(id:)
      journal = Journal.find_by(id: id)

      if journal.nil?
        return {
          success: false,
          errors: [ "Journal not found" ]
        }
      end

      if journal.user_id != context[:current_user]&.id
        return {
          success: false,
          errors: [ "You are not authorized to delete this journal" ]
        }
      end

      if journal.destroy
        {
          success: true,
          errors: []
        }
      else
        {
          success: false,
          errors: [ "Failed to delete the journal" ]
        }
      end
    end
  end
end
