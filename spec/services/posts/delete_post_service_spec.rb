require 'rails_helper'
require_relative '../shared/not_authorized'

RSpec.describe Posts::DeletePostService, type: :service do
  let(:current_user) { user }
  let(:user) { create(:user) }
  let(:journal) { create(:journal, user:) }
  let(:post) { create(:post, journal:) }

  describe '.call' do
    let(:result) { Posts::DeletePostService.call(id: post.id, current_user:) }

    it 'deletes the post' do
      expect(result[:success]).to be true
      expect(result[:errors]).to be_empty
      expect(Post.exists?(post.id)).to be false
    end

    include_examples 'not authorized'
  end
end
