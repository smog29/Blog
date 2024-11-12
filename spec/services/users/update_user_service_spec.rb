require 'rails_helper'
require_relative '../shared/not_authorized'

RSpec.describe Users::UpdateUserService do
  let(:current_user) { user }
  let(:user) { create(:user, name: 'Original Name', password: 'Password123!') }

  describe '.call' do
    let(:result) do
      Users::UpdateUserService.call(id: user.id, name: 'Updated Name', password: 'Password123!', current_user:)
    end

    it 'updates the user name successfully' do
      expect(result[:user]).not_to be_nil

      expect(result[:user].name).to eq('Updated Name')

      expect(result[:errors]).to be_empty
    end

    include_examples 'not authorized'
  end
end
