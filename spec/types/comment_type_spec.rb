require 'rails_helper'

RSpec.describe Types::CommentType, type: :request do
  subject { described_class }

  let(:comment) { create(:comment) }

  let(:query) do
    <<~GQL
      {
        comment(id: "#{comment.id}") {
          id
          content
          user {
            id
            name
          }
          post {
            id
            title
          }
        }
      }
    GQL
  end

  describe 'fields' do
    it 'includes the correct fields' do
      expect(subject.fields.keys).to include('id', 'content', 'user', 'post')
    end

    it 'has the correct field types' do
      expect(subject.fields['id'].type.to_type_signature).to eq('ID!')
      expect(subject.fields['content'].type.to_type_signature).to eq('String!')
      expect(subject.fields['user'].type.to_type_signature).to eq('User!')
      expect(subject.fields['post'].type.to_type_signature).to eq('Post!')
    end
  end

  describe 'resolving fields' do
    it 'returns the expected data for a comment' do
      post '/graphql', params: { query: }

      json = JSON.parse(response.body)
      data = json['data']['comment']

      expect(data['id']).to eq(comment.id.to_s)
      expect(data['content']).to eq(comment.content)

      expect(data['user']['id']).to eq(comment.user.id.to_s)
      expect(data['user']['name']).to eq(comment.user.name)

      expect(data['post']['id']).to eq(comment.post.id.to_s)
      expect(data['post']['title']).to eq(comment.post.title)
    end
  end
end
