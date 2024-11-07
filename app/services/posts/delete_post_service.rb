module Posts
  class DeletePostService
    def self.call(id:, current_user:)
      post = Post.find_by(id: id)

      # Return error if post not found
      return { success: false, errors: [ "Post not found" ] } if post.blank?

      # Check if the current user is the owner of the post
      if post.journal.user_id != current_user&.id
        return { success: false, errors: [ "You are not authorized to delete this post" ] }
      end

      # Attempt to destroy the post
      if post.destroy
        { success: true, errors: [] }
      else
        { success: false, errors: [ "Failed to delete the post" ] }
      end
    end
  end
end
