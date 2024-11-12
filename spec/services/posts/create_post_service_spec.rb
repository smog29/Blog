require 'rails_helper'
require_relative '../shared/not_authorized'

RSpec.describe Posts::CreatePostService, type: :service do
  let(:current_user) { user }
  let(:user) { create(:user) }
  let(:journal) { create(:journal, user:) }

  describe '.call' do
    let(:result) do
      Posts::CreatePostService.call(
        title: 'Post Title',
        body: 'This is the body of the post.',
        journal_id: journal.id,
        current_user:
      )
    end

    it 'creates a post' do
      expect(result[:post]).not_to be_nil
      expect(result[:post].title).to eq('Post Title')
      expect(result[:post].body).to eq('This is the body of the post.')
      expect(result[:errors]).to be_empty
    end

    include_examples 'not authorized'
  end
end
