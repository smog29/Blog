# frozen_string_literal: true

module Mutations
  module Users
    class CreateUserMutation < BaseMutation
      argument :name, String, required: true
      argument :email, String, required: true
      argument :password, String, required: true

      field :user, Types::UserType, null: true
      field :token, String, null: true
      field :errors, [ String ], null: false

      def resolve(name:, email:, password:)
         ::Users::CreateUserService.call(name:, email:, password:)
      end
    end
  end
end
