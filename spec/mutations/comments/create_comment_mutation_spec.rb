require 'rails_helper'

RSpec.describe Mutations::Comments::CreateCommentMutation, type: :request do
  describe '.resolve' do
    let(:user) { create(:user) }
    let(:comment) { create(:comment, user:) }
    let(:content) { 'Test comment content' }
    let(:mutation) do
      <<~GQL
        mutation($content: String!, $postId: ID!) {
          createComment(input: { content: $content, postId: $postId }) {
            comment { id }
            errors
          }
        }
      GQL
    end
    let(:variables) do
      {
        content:,
        postId: comment.post.id
      }
    end

    before do
      allow(JWT).to receive(:decode).and_return([ { 'user_id' => user.id } ])
      allow(::Comments::CreateCommentService).to receive(:call).and_return({ comment:, errors: [] })
    end

    it 'calls the service with the correct parameters' do
      post '/graphql', params: { query: mutation, variables: }, headers: { "Authorization" => "Bearer mock_token" }

      expect(::Comments::CreateCommentService).to have_received(:call).with(
        content:,
        post_id: comment.post.id.to_s,
        current_user: user
      )
    end
  end
end
