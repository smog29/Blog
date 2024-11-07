# spec/services/comments/delete_comment_service_spec.rb
require 'rails_helper'

RSpec.describe Comments::DeleteCommentService, type: :service do
  let!(:comment) { create(:comment) }
  let(:user) { create(:user) }

  describe '.call' do
    it 'deletes the comment when user is authorized' do
      # Assume the user owns the comment
      comment.update(user_id: user.id)

      result = Comments::DeleteCommentService.call(id: comment.id, current_user: user)

      expect(result[:success]).to be_truthy
      expect(result[:errors]).to be_empty
      expect(Comment.exists?(comment.id)).to be_falsey
    end
  end
end
