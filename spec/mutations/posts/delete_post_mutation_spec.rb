require 'rails_helper'

RSpec.describe Mutations::Posts::DeletePostMutation, type: :request do
  describe '.resolve' do
    let(:user) { create(:user) }
    let(:post_to_delete) { create(:post) }
    let(:mutation) do
      <<~GQL
        mutation($id: ID!) {
          deletePost(input: {id: $id}) {
            success
            errors
          }
        }
      GQL
    end
    let(:variables) do
      {
        id: post_to_delete.id
      }
    end

    before do
      allow(JWT).to receive(:decode).and_return([ { 'user_id' => user.id } ])
      allow(::Posts::DeletePostService).to receive(:call).and_return({ success: true, errors: [] })
    end

    it 'calls the service with the correct parameters' do
      post '/graphql', params: { query: mutation, variables: }, headers: { "Authorization" => "Bearer mock_token" }

      expect(::Posts::DeletePostService).to have_received(:call).with(
        id: post_to_delete.id.to_s,
        current_user: user
      )
    end
  end
end
