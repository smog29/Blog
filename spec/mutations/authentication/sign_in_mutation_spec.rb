require 'rails_helper'

RSpec.describe Mutations::Authentication::SignInMutation, type: :request do
  describe '.resolve' do
    let(:email) { 'test@example.com' }
    let(:password) { 'securepassword' }
    let(:token) { 'mock_token' }
    let(:mutation) do
      <<~GQL
        mutation($email: String!, $password: String!) {
          signIn(input: { email: $email, password: $password }) {
            token
            errors
          }
        }
      GQL
    end
    let(:variables) do
      {
        email:,
        password:
      }
    end

    before do
      allow(::Authentication::SignInService).to receive(:call).and_return({ token:, errors: [] })
    end

    it 'calls the service with the correct parameters' do
      post '/graphql', params: { query: mutation, variables: }

      expect(::Authentication::SignInService).to have_received(:call).with(
        email:,
        password:
      )
    end
  end
end
