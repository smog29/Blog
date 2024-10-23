# frozen_string_literal: true

module Mutations
  class SignInMutation < BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    field :token, String, null: true
    field :errors, [ String ], null: false

    def resolve(email:, password:)
      user = User.find_by(email: email)

      if user&.authenticate(password)
        token = JWT.encode({ user_id: user.id }, ENV["JWT_SECRET"], "HS256")
        {
          token: token,
          errors: []
        }
      else
        {
          token: nil,
          errors: [ "Invalid email or password" ]
        }
      end
    end
  end
end
