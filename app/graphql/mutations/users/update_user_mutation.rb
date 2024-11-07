# frozen_string_literal: true

module Mutations
  module Users
    class UpdateUserMutation < BaseMutation
      argument :id, ID, required: true
      argument :name, String, required: false
      argument :password, String, required: false

      field :user, Types::UserType, null: true
      field :errors, [ String ], null: false

      def resolve(id:, name: nil, password: nil)
        ::Users::UpdateUserService.call(
          id: id,
          name: name,
          password: password,
          current_user: context[:current_user]
        )
      end
    end
  end
end
