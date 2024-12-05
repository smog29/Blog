require 'rails_helper'

RSpec.describe Types::UserType, type: :request do
  subject { described_class }

  let(:user) { create(:user) }
  let(:journals) { create_list(:journal, 2, user:) }
  let(:posts) { create_list(:post, 3, journal: journals.first) }
  let(:comments) { create_list(:comment, 4, user:) }

  let(:query) do
    <<~GQL
      {
        user(id: "#{user.id}") {
          id
          name
          journals {
            id
            title
          }
          posts {
            id
            title
          }
          comments {
            id
            content
          }
        }
      }
    GQL
  end

  describe 'fields' do
    it 'includes the correct fields' do
      expect(subject.fields.keys).to include('id', 'name', 'journals', 'posts', 'comments')
    end

    it 'has the correct field types' do
      expect(subject.fields['id'].type.to_type_signature).to eq('ID!')
      expect(subject.fields['name'].type.to_type_signature).to eq('String!')
      expect(subject.fields['journals'].type.to_type_signature).to eq('[Journal!]')
      expect(subject.fields['posts'].type.to_type_signature).to eq('[Post!]')
      expect(subject.fields['comments'].type.to_type_signature).to eq('[Comment!]')
    end
  end

  describe 'resolving fields' do
    before do
      journals
      posts
      comments
    end

    it 'returns the expected data for a user' do
      post '/graphql', params: { query: }

      json = JSON.parse(response.body)
      data = json['data']['user']

      expect(data['id']).to eq(user.id.to_s)
      expect(data['name']).to eq(user.name)

      expect(data['journals'].count).to eq(journals.count)
      expect(data['journals'].map { |j| j['id'] }).to match_array(journals.map(&:id).map(&:to_s))

      expect(data['posts'].count).to eq(posts.count)
      expect(data['posts'].map { |p| p['id'] }).to match_array(posts.map(&:id).map(&:to_s))

      expect(data['comments'].count).to eq(comments.count)
      expect(data['comments'].map { |c| c['id'] }).to match_array(comments.map(&:id).map(&:to_s))
    end
  end
end
