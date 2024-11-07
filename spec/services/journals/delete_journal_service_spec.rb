require 'rails_helper'

RSpec.describe Journals::DeleteJournalService, type: :service do
  let(:user) { create(:user) }
  let(:journal) { create(:journal, user: user) }

  describe '.call' do
    it 'deletes the journal when the user is authorized' do
      result = Journals::DeleteJournalService.call(id: journal.id, current_user: user)

      expect(result[:success]).to be(true)
      expect(result[:errors]).to be_empty
      expect(::Journal.exists?(journal.id)).to be_falsey
    end
  end
end
