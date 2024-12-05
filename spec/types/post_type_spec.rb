require 'rails_helper'

RSpec.describe Types::PostType, type: :request do
  subject { described_class }

  let(:post_object) { create(:post) }
  let(:query) do
    <<~GQL
      {
        post(id: "#{post_object.id}") {
          id
          title
          body
          journal {
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
      expect(subject.fields.keys).to include('id', 'title', 'body', 'journal', 'comments')
    end

    it 'has the correct field types' do
      expect(subject.fields['id'].type.to_type_signature).to eq('ID!')
      expect(subject.fields['title'].type.to_type_signature).to eq('String!')
      expect(subject.fields['body'].type.to_type_signature).to eq('String!')
      expect(subject.fields['journal'].type.to_type_signature).to eq('Journal!')
      expect(subject.fields['comments'].type.to_type_signature).to eq('[Comment!]')
    end
  end

  describe 'resolving fields' do
    before do
      create_list(:comment, 2, post: post_object)
    end

    it 'returns the expected data for a post' do
      post '/graphql', params: { query: }

      json = JSON.parse(response.body)
      data = json['data']['post']

      expect(data['id']).to eq(post_object.id.to_s)
      expect(data['title']).to eq(post_object.title)
      expect(data['body']).to eq(post_object.body)
      expect(data['journal']['id']).to eq(post_object.journal.id.to_s)
      expect(data['comments'].count).to eq(post_object.comments.count)
    end
  end
end
