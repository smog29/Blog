module Authentication
  class SignInService
    def self.call(email:, password:)
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
