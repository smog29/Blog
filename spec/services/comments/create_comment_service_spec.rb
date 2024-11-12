require 'rails_helper'
require_relative '../shared/not_authorized'

RSpec.describe Comments::CreateCommentService, type: :service do
  let(:current_user) { user }
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:valid_attributes) { { content: 'Great post!', post_id: post.id } }

  describe '.call' do
    let(:result) { Comments::CreateCommentService.call(**valid_attributes, current_user:) }

    it 'creates a comment when user is authorized and data is valid' do
      expect(result[:comment]).to be_present
      expect(result[:comment].content).to eq('Great post!')
      expect(result[:errors]).to be_empty
    end

    include_examples 'not authorized'
  end
end
