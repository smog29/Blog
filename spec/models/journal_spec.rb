require 'rails_helper'

RSpec.describe Journal, type: :model do
  it 'is valid with valid attributes' do
    journal = build(:journal)
    expect(journal).to be_valid
  end

  it 'is not valid without a title' do
    journal = build(:journal, title: nil)
    expect(journal).to_not be_valid
  end

  it 'is not valid without a user' do
    journal = build(:journal, user: nil)
    expect(journal).to_not be_valid
  end
end
