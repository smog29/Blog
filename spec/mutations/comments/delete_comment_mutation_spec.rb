require 'rails_helper'

RSpec.describe Mutations::Comments::DeleteCommentMutation, type: :request do
  describe '.resolve' do
    let(:user) { create(:user) }
    let(:comment) { create(:comment, user:) }
    let(:mutation) do
      <<~GQL
        mutation($id: ID!) {
          deleteComment(input: { id: $id }) {
            success
            errors
          }
        }
      GQL
    end
    let(:variables) do
      {
        id: comment.id
      }
    end

    before do
      allow(JWT).to receive(:decode).and_return([ { 'user_id' => user.id } ])
      allow(::Comments::DeleteCommentService).to receive(:call).and_return({ success: true, errors: [] })
    end

    it 'calls the service with the correct parameters' do
      post '/graphql', params: { query: mutation, variables: }, headers: { "Authorization" => "Bearer mock_token" }

      expect(::Comments::DeleteCommentService).to have_received(:call).with(
        id: comment.id.to_s,
        current_user: user
      )
    end
  end
end
