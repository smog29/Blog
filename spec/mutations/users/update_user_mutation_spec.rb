require 'rails_helper'

RSpec.describe Mutations::Users::UpdateUserMutation, type: :request do
  describe '.resolve' do
    let(:user) { create(:user) }
    let(:target_user) { create(:user) }
    let(:name) { 'Updated Name' }
    let(:password) { 'new_secure_password' }
    let(:mutation) do
      <<~GQL
        mutation($id: ID!, $name: String, $password: String) {
          updateUser(input: { id: $id, name: $name, password: $password }) {
            user { id }
            errors
          }
        }
      GQL
    end
    let(:variables) do
      {
        id: target_user.id,
        name:,
        password:
      }
    end

    before do
      allow(JWT).to receive(:decode).and_return([ { 'user_id' => user.id } ])
      allow(::Users::UpdateUserService).to receive(:call).and_return({ user: target_user, errors: [] })
    end

    it 'calls the service with the correct parameters' do
      post '/graphql', params: { query: mutation, variables: }, headers: { "Authorization" => "Bearer mock_token" }

      expect(::Users::UpdateUserService).to have_received(:call).with(
        id: target_user.id.to_s,
        name:,
        password:,
        current_user: user
      )
    end
  end
end
