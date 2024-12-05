# frozen_string_literal: true

module Mutations
  module Comments
    class CreateCommentMutation < BaseMutation
      argument :content, String, required: true
      argument :post_id, ID, required: true

      field :comment, Types::CommentType, null: true
      field :errors, [ String ], null: false

      def resolve(content:, post_id:)
        ::Comments::CreateCommentService.call(
          content:, post_id:, current_user: context[:current_user]
        )
      end
    end
  end
end
