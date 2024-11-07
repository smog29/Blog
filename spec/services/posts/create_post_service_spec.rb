# spec/services/posts/create_post_service_spec.rb
require 'rails_helper'

RSpec.describe Posts::CreatePostService, type: :service do
  let(:user) { create(:user) }
  let(:unauthorized_user) { create(:user) }
  let(:journal) { create(:journal, user: user) }

  describe '.call' do
    it 'creates a post' do
      result = Posts::CreatePostService.call(
        title: 'Post Title',
        body: 'This is the body of the post.',
        journal_id: journal.id,
        current_user: user
      )

      expect(result[:post]).not_to be_nil
      expect(result[:post].title).to eq('Post Title')
      expect(result[:post].body).to eq('This is the body of the post.')
      expect(result[:errors]).to be_empty
    end
  end
end
