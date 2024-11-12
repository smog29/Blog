require 'rails_helper'
require_relative '../shared/not_authorized'

RSpec.describe Journals::CreateJournalService, type: :service do
  let(:current_user) { user }
  let(:user) { create(:user) }

  describe '.call' do
    let(:result) do
      Journals::CreateJournalService.call(
        title: 'New Journal Entry',
        description: 'Description of the journal',
        current_user:
      )
    end

    it 'creates a journal when the user is authorized' do
      expect(result[:journal]).not_to be_nil
      expect(result[:errors]).to be_empty
      expect(result[:journal].title).to eq('New Journal Entry')
    end

    include_examples 'not authorized'
  end
end
