require 'rails_helper'

RSpec.describe Mutations::Users::CreateUserMutation, type: :request do
  describe '.resolve' do
    let(:name) { 'New User' }
    let(:email) { 'newuser@example.com' }
    let(:password) { 'securepassword' }
    let(:response_user) { create(:user, name:, email:) }
    let(:token) { 'mock_token' }
    let(:mutation) do
      <<~GQL
        mutation($name: String!, $email: String!, $password: String!) {
          createUser(input: { name: $name, email: $email, password: $password }) {
            user { id }
            token
            errors
          }
        }
      GQL
    end
    let(:variables) do
      {
        name:,
        email:,
        password:
      }
    end

    before do
      allow(::Users::CreateUserService).to receive(:call).and_return({ user: response_user, token:, errors: [] })
    end

    it 'calls the service with the correct parameters' do
      post '/graphql', params: { query: mutation, variables: }

      expect(::Users::CreateUserService).to have_received(:call).with(
        name:,
        email:,
        password:
      )
    end
  end
end
