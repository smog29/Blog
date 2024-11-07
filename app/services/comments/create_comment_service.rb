module Comments
  class CreateCommentService
    def self.call(content:, post_id:, current_user:)
      return { comment: nil, errors: [ "Not Authorized" ] } if current_user.blank?

      comment = Comment.new(content:, post_id:, user_id: current_user.id)

      if comment.save
        { comment: comment, errors: [] }
      else
        { comment: nil, errors: comment.errors.full_messages }
      end
    end
  end
end
