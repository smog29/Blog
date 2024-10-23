# frozen_string_literal: true

module Types
  class MeType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :journals, [ JournalType ], null: true
    field :posts, [ PostType ], null: true
    field :comments, [ CommentType ], null: true

    def journals
      object.journals
    end

    def posts
      object.posts
    end

    def comments
      object.comments
    end
  end
end
