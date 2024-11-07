require 'rails_helper'

RSpec.describe Posts::DeletePostService, type: :service do
  let(:user) { create(:user) }
  let(:journal) { create(:journal, user:) }
  let(:post) { create(:post, journal:) }

  describe '.call' do
    it 'deletes the post' do
      result = Posts::DeletePostService.call(id: post.id, current_user: user)

      expect(result[:success]).to be true
      expect(result[:errors]).to be_empty
      expect(Post.exists?(post.id)).to be false
    end
  end
end
