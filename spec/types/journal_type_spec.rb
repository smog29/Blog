require 'rails_helper'

RSpec.describe Types::JournalType, type: :request do
  subject { described_class }

  let(:journal) { create(:journal) }
  let(:posts) { create_list(:post, 3, journal:) }

  let(:query) do
    <<~GQL
      {
        journal(id: "#{journal.id}") {
          id
          title
          user {
            id
            name
          }
          posts {
            id
            title
          }
        }
      }
    GQL
  end

  describe 'fields' do
    it 'includes the correct fields' do
      expect(subject.fields.keys).to include('id', 'title', 'user', 'posts')
    end

    it 'has the correct field types' do
      expect(subject.fields['id'].type.to_type_signature).to eq('ID!')
      expect(subject.fields['title'].type.to_type_signature).to eq('String!')
      expect(subject.fields['user'].type.to_type_signature).to eq('User!')
      expect(subject.fields['posts'].type.to_type_signature).to eq('[Post!]')
    end
  end

  describe 'resolving fields' do
    before { posts }

    it 'returns the expected data for a journal' do
      post '/graphql', params: { query: }

      json = JSON.parse(response.body)
      data = json['data']['journal']

      expect(data['id']).to eq(journal.id.to_s)
      expect(data['title']).to eq(journal.title)

      expect(data['user']['id']).to eq(journal.user.id.to_s)
      expect(data['user']['name']).to eq(journal.user.name)

      expect(data['posts'].count).to eq(posts.count)
      expect(data['posts'].map { |p| p['id'] }).to match_array(posts.map(&:id).map(&:to_s))
      expect(data['posts'].map { |p| p['title'] }).to match_array(posts.map(&:title))
    end
  end
end
