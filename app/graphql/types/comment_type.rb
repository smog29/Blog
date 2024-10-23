module Types
  class CommentType < BaseObject
    field :id, ID, null: false
    field :content, String, null: false
    field :user, UserType, null: false
    field :post, PostType, null: false
  end
end
