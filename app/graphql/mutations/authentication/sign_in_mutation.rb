# frozen_string_literal: true

module Mutations
  module Authentication
    class SignInMutation < BaseMutation
      argument :email, String, required: true
      argument :password, String, required: true

      field :token, String, null: true
      field :errors, [ String ], null: false

      def resolve(email:, password:)
        ::Authentication::SignInService.call(email:, password:)
      end
    end
  end
end
