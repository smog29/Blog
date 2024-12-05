module Comments
  class DeleteCommentService
    def self.call(id:, current_user:)
      comment = Comment.find_by(id:)

      if comment.nil?
        return { success: false, errors: [ "Comment not found" ] }
      end

      if comment.user_id != current_user&.id
        return { success: false, errors: [ " You are not authorized to delete this comment" ] }
      end

      if comment.destroy
        { success: true, errors: [] }
      else
        { success: false, errors: [ "Failed to delete the comment" ] }
      end
    end
  end
end
