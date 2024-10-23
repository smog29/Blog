require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:journal) { create(:journal) }

  context 'with valid attributes' do
    let(:post) { build(:post, title: 'My Post', body: 'This is a post body', journal:) }

    it 'is valid' do
      expect(post).to be_valid
    end
  end

  context 'without a title' do
    let(:post) { build(:post, title: nil, body: 'This is a post body', journal:) }

    it 'is not valid' do
      expect(post).to_not be_valid
    end
  end

  context 'without a body' do
    let(:post) { build(:post, title: 'My Post', body: nil, journal:) }

    it 'is not valid' do
      expect(post).to_not be_valid
    end
  end

  context 'without a journal' do
    let(:post) { build(:post, title: 'My Post', body: 'This is a post body', journal: nil) }

    it 'is not valid' do
      expect(post).to_not be_valid
    end
  end
end
