# app/services/users/create_user_service.rb

module Users
  class CreateUserService
    def self.call(name:, email:, password:)
      user = ::User.new(name:, email:, password:)

      if user.save
        token = JWT.encode({ user_id: user.id }, ENV["JWT_SECRET"], "HS256")
        { user: user, token: token, errors: [] }
      else
        { user: nil, token: nil, errors: user.errors.full_messages }
      end
    end
  end
end
