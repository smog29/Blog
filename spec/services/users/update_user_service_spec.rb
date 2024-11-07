# spec/services/users/update_user_service_spec.rb

require 'rails_helper'

RSpec.describe Users::UpdateUserService do
  let(:user) { create(:user, name: 'Original Name', password: 'Password123!') }

  describe '.call' do
    it 'updates the user name successfully' do
      result = described_class.call(id: user.id, name: 'Updated Name', password: 'Password123!', current_user: user)

      expect(result[:user]).not_to be_nil

      expect(result[:user].name).to eq('Updated Name')

      expect(result[:errors]).to be_empty
    end
  end
end
