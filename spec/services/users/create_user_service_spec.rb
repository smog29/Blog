require 'rails_helper'

RSpec.describe Users::CreateUserService, type: :service do
  let(:name) { 'Test User' }
  let(:email) { 'testuser@example.com' }
  let(:password) { 'Password123!' }

  describe '#call' do
    it 'creates a user' do
      result = described_class.call(name:, email:, password:)

      expect(result[:user]).to be_present
      expect(result[:user].name).to eq(name)
      expect(result[:user].email).to eq(email)
      expect(result[:errors]).to be_empty
    end
  end
end
