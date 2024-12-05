require 'rails_helper'

RSpec.describe Mutations::Journals::DeleteJournalMutation, type: :request do
  describe '.resolve' do
    let(:user) { create(:user) }
    let(:journal_to_delete) { create(:journal) }
    let(:mutation) do
      <<~GQL
        mutation($id: ID!) {
          deleteJournal(input: { id: $id }) {
            success
            errors
          }
        }
      GQL
    end
    let(:variables) do
      {
        id: journal_to_delete.id
      }
    end

    before do
      allow(JWT).to receive(:decode).and_return([ { 'user_id' => user.id } ])
      allow(::Journals::DeleteJournalService).to receive(:call).and_return({ success: true, errors: [] })
    end

    it 'calls the service with the correct parameters' do
      post '/graphql', params: { query: mutation, variables: }, headers: { "Authorization" => "Bearer mock_token" }

      expect(::Journals::DeleteJournalService).to have_received(:call).with(
        id: journal_to_delete.id.to_s,
        current_user: user
      )
    end
  end
end
