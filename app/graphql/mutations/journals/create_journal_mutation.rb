# frozen_string_literal: true

module Mutations
  module Journals
    class CreateJournalMutation < BaseMutation
      argument :title, String, required: true
      argument :description, String, required: false

      field :journal, Types::JournalType, null: true
      field :errors, [ String ], null: false

      def resolve(title:, description:)
        ::Journals::CreateJournalService.call(
          title:, description:, current_user: context[:current_user]
        )
      end
    end
  end
end
