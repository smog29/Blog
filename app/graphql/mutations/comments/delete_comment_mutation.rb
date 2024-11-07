# frozen_string_literal: true

module Mutations
  module Comments
    class DeleteCommentMutation < BaseMutation
      argument :id, ID, required: true

      field :success, Boolean, null: false
      field :errors, [ String ], null: false

      def resolve(id:)
        ::Comments::DeleteCommentService.call(id:, current_user: context[:current_user])
      end
    end
  end
end
