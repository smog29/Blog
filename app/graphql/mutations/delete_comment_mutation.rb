# frozen_string_literal: true

module Mutations
  class DeleteCommentMutation < BaseMutation
    argument :id, ID, required: true

    field :success, Boolean, null: false
    field :errors, [ String ], null: false

    def resolve(id:)
      comment = Comment.find_by(id: id)

      if comment.nil?
        return {
          success: false,
          errors: [ "Comment not found" ]
        }
      end

      # Check if the current user is the owner of the comment
      if comment.user_id != context[:current_user]&.id
        return {
          success: false,
          errors: [ "You are not authorized to delete this comment" ]
        }
      end

      if comment.destroy
        {
          success: true,
          errors: []
        }
      else
        {
          success: false,
          errors: [ "Failed to delete the comment" ]
        }
      end
    end
  end
end
