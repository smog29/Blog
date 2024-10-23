require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post) }

  context 'with valid attributes' do
    let(:comment) { build(:comment, content: 'This is a comment', user:, post:) }

    it 'is valid' do
      expect(comment).to be_valid
    end
  end

  context 'without content' do
    let(:comment) { build(:comment, content: nil, user:, post:) }

    it 'is not valid' do
      expect(comment).to_not be_valid
    end
  end

  context 'without a user' do
    let(:comment) { build(:comment, content: 'This is a comment', user: nil, post:) }

    it 'is not valid' do
      expect(comment).to_not be_valid
    end
  end

  context 'without a post' do
    let(:comment) { build(:comment, content: 'This is a comment', user:, post: nil) }

    it 'is not valid' do
      expect(comment).to_not be_valid
    end
  end
end
