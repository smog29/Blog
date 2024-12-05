module Comments
  class DeleteCommentService < ApplicationService
    def initialize(id:, current_user:)
      @id = id
      @current_user = current_user
    end

    def call
      comment = Comment.find_by(id:)

      if comment.nil?
        return { success: false, errors: [ "Comment not found" ] }
      end

      if !authorized?(current_user, comment.user_id)
        return { success: false, errors: [ " You are not authorized to delete this comment" ] }
      end

      destroy_comment(comment)
    end

    private

    attr_reader :id, :current_user

    def destroy_comment(comment)
      if comment.destroy
        { success: true, errors: [] }
      else
        { success: false, errors: [ "Failed to delete the comment" ] }
      end
    end
  end
end
