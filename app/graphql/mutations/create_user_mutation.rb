# frozen_string_literal: true

module Mutations
  class CreateUserMutation < BaseMutation
    argument :name, String, required: true
    argument :email, String, required: true
    argument :password, String, required: true

    field :user, Types::UserType, null: true
    field :token, String, null: true
    field :errors, [ String ], null: false

    def resolve(name:, email:, password:)
      user = User.new(name:, email:, password:)

      if user.save
        token = JWT.encode({ user_id: user.id }, ENV["JWT_SECRET"], "HS256")
        {
          user: user,
          token: token,
          errors: []
        }
      else
        {
          user: nil,
          token: nil,
          errors: user.errors.full_messages
        }
      end
    end
  end
end
