module Types
  class JournalType < BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :user, UserType, null: false
    field :posts, [ PostType ], null: true
  end
end
