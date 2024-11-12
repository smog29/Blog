require 'rails_helper'
require_relative '../shared/not_authorized'

RSpec.describe Comments::DeleteCommentService, type: :service do
  let(:current_user) { user }
  let!(:comment) { create(:comment, user:) }
  let(:user) { create(:user) }

  describe '.call' do
    let(:result) { Comments::DeleteCommentService.call(id: comment.id, current_user:) }

    it 'deletes the comment when user is authorized' do
      expect(result[:success]).to be_truthy
      expect(result[:errors]).to be_empty
      expect(Comment.exists?(comment.id)).to be_falsey
    end

    include_examples 'not authorized'
  end
end
