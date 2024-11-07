require 'rails_helper'

RSpec.describe Comments::CreateCommentService, type: :service do
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:valid_attributes) { { content: 'Great post!', post_id: post.id } }

  describe '.call' do
    it 'creates a comment when user is authorized and data is valid' do
      result = Comments::CreateCommentService.call(**valid_attributes.merge(current_user: user))

      expect(result[:comment]).to be_present
      expect(result[:comment].content).to eq('Great post!')
      expect(result[:errors]).to be_empty
    end
  end
end
