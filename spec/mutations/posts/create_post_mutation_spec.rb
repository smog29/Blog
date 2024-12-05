require 'rails_helper'

RSpec.describe Mutations::Posts::CreatePostMutation, type: :request do
  describe '.resolve' do
    let(:user) { create(:user) }
    let(:journal) { create(:journal, user:) }
    let(:response_post) { create(:post) }
    let(:title) { 'Test Post Title' }
    let(:body) { 'Test post body content' }
    let(:mutation) do
      <<~GQL
        mutation($title: String!, $body: String!, $journalId: ID!) {
          createPost(input: { title: $title, body: $body, journalId: $journalId }) {
            post {
              id
              title
              body
            }
            errors
          }
        }
      GQL
    end
    let(:variables) do
      {
        title:,
        body:,
        journalId: journal.id
      }
    end

    before do
      allow(JWT).to receive(:decode).and_return([ { 'user_id' => user.id } ])
      allow(::Posts::CreatePostService).to receive(:call).and_return({ post: response_post, errors: [] })
    end

    it 'calls the service with the correct parameters' do
      post '/graphql', params: { query: mutation, variables: }, headers: { "Authorization" => "Bearer mock_token" }

      expect(::Posts::CreatePostService).to have_received(:call).with(
        title:,
        body:,
        journal_id: journal.id.to_s,
        current_user: user
      )
    end
  end
end
