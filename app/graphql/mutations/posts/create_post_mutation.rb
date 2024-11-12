# frozen_string_literal: true

module Mutations
  module Posts
    class CreatePostMutation < BaseMutation
      argument :title, String, required: true
      argument :body, String, required: true
      argument :journal_id, ID, required: true

      field :post, Types::PostType, null: true
      field :errors, [ String ], null: false

      def resolve(title:, body:, journal_id:)
        ::Posts::CreatePostService.call(
          title:, body:, journal_id:, current_user: context[:current_user]
        )
      end
    end
  end
end
