# spec/graphql/mutations/journals/create_journal_mutation_spec.rb
require 'rails_helper'

RSpec.describe Mutations::Journals::CreateJournalMutation, type: :request do
  describe '.resolve' do
    let(:user) { create(:user) }
    let(:response_journal) { create(:journal) }
    let(:title) { 'Test Journal Title' }
    let(:description) { 'Test journal description content' }
    let(:mutation) do
      <<~GQL
        mutation($title: String!, $description: String) {
          createJournal(input: { title: $title, description: $description }) {
            journal { id }
            errors
          }
        }
      GQL
    end
    let(:variables) do
      {
        title:,
        description:
      }
    end

    before do
      allow(JWT).to receive(:decode).and_return([ { 'user_id' => user.id } ])
      allow(::Journals::CreateJournalService).to receive(:call).and_return({ journal: response_journal, errors: [] })
    end

    it 'calls the service with the correct parameters' do
      post '/graphql', params: { query: mutation, variables: }, headers: { "Authorization" => "Bearer mock_token" }

      expect(::Journals::CreateJournalService).to have_received(:call).with(
        title:,
        description:,
        current_user: user
      )
    end
  end
end
