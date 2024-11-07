require 'rails_helper'

RSpec.describe Journals::CreateJournalService, type: :service do
  let(:user) { create(:user) }

  describe '.call' do
    it 'creates a journal when the user is authorized' do
      result = Journals::CreateJournalService.call(
        title: 'New Journal Entry',
        description: 'Description of the journal',
        current_user: user
      )

      expect(result[:journal]).not_to be_nil
      expect(result[:errors]).to be_empty
      expect(result[:journal].title).to eq('New Journal Entry')
    end
  end
end
