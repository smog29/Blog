module Authentication
  class SignInService < ApplicationService
    def initialize(email:, password:)
      @email = email
      @password = password
    end

    def call
      user = User.find_by(email: email)

      if user&.authenticate(password)
        token = JWT.encode({ user_id: user.id }, ENV["JWT_SECRET"], "HS256")
        token_response(token, [])
      else
        token_response(nil, [ "Invalid email or password" ])
      end
    end

    private

    attr_reader :email, :password

    def token_response(token, errors)
      {
        token: token,
        errors: errors
      }
    end
  end
end
