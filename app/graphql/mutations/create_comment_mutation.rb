# frozen_string_literal: true

module Mutations
  class CreateCommentMutation < BaseMutation
    argument :content, String, required: true
    argument :post_id, ID, required: true
    argument :user_id, ID, required: true

    field :comment, Types::CommentType, null: true
    field :errors, [ String ], null: false

    def resolve(content:, post_id:, user_id:)
      comment = Comment.new(content:, post_id:, user_id:)

      if comment.save
        {
          comment: comment,
          errors: []
        }
      else
        {
          comment: nil,
          errors: comment.errors.full_messages
        }
      end
    end
  end
end
