require 'rails_helper'

RSpec.describe User, type: :model do
  let(:email) { 'test@gmail.com' }
  let(:password) { 'Password!' }

  context 'with valid attributes' do
    let(:user) { build(:user, email:, password:) }

    it 'is valid' do
      expect(user).to be_valid
    end
  end

  context 'without a name' do
    let(:user) { build(:user, name: nil, email:, password:) }

    it 'is not valid' do
      expect(user).to_not be_valid
    end
  end

  context 'without an email' do
    let(:user) { build(:user, email: nil, password:) }

    it 'is not valid' do
      expect(user).to_not be_valid
    end
  end

  context 'with a duplicate email' do
    let(:user) { build(:user, email:, password:) }

    before do
      create(:user, email:, password:)
    end

    it 'is not valid' do
      expect(user).to_not be_valid
    end
  end

  context 'with an invalid password (less than 6 characters)' do
    let(:user) { build(:user, email:, password: 'Pwd!') }

    it 'is not valid' do
      expect(user).to_not be_valid
    end
  end

  context 'with an invalid password (no uppercase letter)' do
    let(:user) { build(:user, email:, password: 'password!') }

    it 'is not valid' do
      expect(user).to_not be_valid
    end
  end

  context 'with an invalid password (no special character)' do
    let(:user) { build(:user, email:, password: 'Password') }

    it 'is not valid' do
      expect(user).to_not be_valid
    end
  end
end
