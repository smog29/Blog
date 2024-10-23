# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :me, Types::MeType, null: true do
      description "Retrieve the currently authenticated user."
    end

    def me
      context[:current_user]
    end

    field :journals, [ JournalType ], null: false

    def journals
      Journal.all
    end

    field :journal, JournalType, null: true do
      argument :id, ID, required: true
    end

    def journal(id:)
      Journal.find_by(id: id)
    end

    field :posts, [ PostType ], null: false

    def posts
      Post.all
    end

    field :post, PostType, null: true do
      argument :id, ID, required: true
    end

    def post(id:)
      Post.find_by(id: id)
    end

    field :comments, [ CommentType ], null: false

    def comments
      Comment.all
    end

    field :comment, CommentType, null: true do
      argument :id, ID, required: true
    end

    def comment(id:)
      Comment.find_by(id: id)
    end

    field :users, [ UserType ], null: false

    def users
      User.all
    end

    field :user, UserType, null: true do
      argument :id, ID, required: true
    end

    def user(id:)
      User.find_by(id: id)
    end
  end
end
