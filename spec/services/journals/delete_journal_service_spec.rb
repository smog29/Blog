require 'rails_helper'
require_relative '../shared/not_authorized'

RSpec.describe Journals::DeleteJournalService, type: :service do
  let(:current_user) { user }
  let(:user) { create(:user) }
  let(:journal) { create(:journal, user: user) }

  describe '.call' do
    let(:result) { Journals::DeleteJournalService.call(id: journal.id, current_user:) }

    it 'deletes the journal when the user is authorized' do
      expect(result[:success]).to be(true)
      expect(result[:errors]).to be_empty
      expect(::Journal.exists?(journal.id)).to be_falsey
    end

    include_examples 'not authorized'
  end
end
