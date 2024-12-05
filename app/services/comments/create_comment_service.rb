module Comments
  class CreateCommentService < ApplicationService
    def initialize(content:, post_id:, current_user:)
      @content = content
      @post_id = post_id
      @current_user = current_user
    end

    def call
      return { comment: nil, errors: [ "Not Authorized" ] } if current_user.blank?

      save_comment
    end

    private

    attr_reader :content, :post_id, :current_user

    def save_comment
      comment = Comment.new(content:, post_id:, user_id: current_user.id)

      if comment.save
        { comment: comment, errors: [] }
      else
        { comment: nil, errors: comment.errors.full_messages }
      end
    end
  end
end
