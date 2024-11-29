module Posts
  class DeletePostService
    def self.call(id:, current_user:)
      post = Post.find_by(id: id)

      return { success: false, errors: [ "Post not found" ] } if post.blank?

      if post.journal.user_id != current_user&.id
        return { success: false, errors: [ "You are not authorized to delete this post" ] }
      end

      if post.destroy
        { success: true, errors: [] }
      else
        { success: false, errors: [ "Failed to delete the post" ] }
      end
    end
  end
end
