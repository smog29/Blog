# frozen_string_literal: true

module Mutations
  class CreatePostMutation < BaseMutation
    argument :title, String, required: true
    argument :body, String, required: true
    argument :journal_id, ID, required: true

    field :post, Types::PostType, null: true
    field :errors, [ String ], null: false

    def resolve(title:, body:, journal_id:)
      post = Post.new(title:, body:, journal_id:)

      if post.save
        {
          post: post,
          errors: []
        }
      else
        {
          post: nil,
          errors: post.errors.full_messages
        }
      end
    end
  end
end
