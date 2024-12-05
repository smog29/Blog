module Users
  class CreateUserService < ApplicationService
    def initialize(name:, email:, password:)
      @name = name
      @email = email
      @password = password
    end

    def call
      user = ::User.new(name:, email:, password:)

      if user.save
        token = JWT.encode({ user_id: user.id }, ENV["JWT_SECRET"], "HS256")
        { user: user, token: token, errors: [] }
      else
        { user: nil, token: nil, errors: user.errors.full_messages }
      end
    end

    private

    attr_reader :name, :email, :password
  end
end
