# frozen_string_literal: true

module Mutations
  class DeletePostMutation < BaseMutation
    argument :id, ID, required: true

    field :success, Boolean, null: false
    field :errors, [String], null: false

    def resolve(id:)
      post = Post.find_by(id: id)

      if post.nil?
        return {
          success: false,
          errors: [ "Post not found" ]
        }
      end

      # Check if the current user is the owner of the post
      if post.user_id != context[:current_user]&.id
        return {
          success: false,
          errors: [ "You are not authorized to delete this post" ]
        }
      end

      if post.destroy
        {
          success: true,
          errors: []
        }
      else
        {
          success: false,
          errors: [ "Failed to delete the post" ]
        }
      end
    end
  end
end
