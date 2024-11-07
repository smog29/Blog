# frozen_string_literal: true

module Mutations
  module Journals
    class DeleteJournalMutation < BaseMutation
      argument :id, ID, required: true

      field :success, Boolean, null: false
      field :errors, [ String ], null: false

      def resolve(id:)
        ::Journals::DeleteJournalService.call(id:, current_user: context[:current_user])
      end
    end
  end
end
