# frozen_string_literal: true

module Mutations
  module Posts
    class DeletePostMutation < BaseMutation
      argument :id, ID, required: true

      field :success, Boolean, null: false
      field :errors, [ String ], null: false

      def resolve(id:)
        ::Posts::DeletePostService.call(id:, current_user: context[:current_user])
      end
    end
  end
end
