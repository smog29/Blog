module Users
  class UpdateUserService < ApplicationService
    def initialize(id:, name: nil, password: nil, current_user:)
      @id = id
      @name = name
      @password = password
      @current_user = current_user
    end

    def call
      user = ::User.find_by(id:)
      return { user: nil, errors: [ "User not found" ] } if user.blank?

      return { user: nil, errors: [ "Not authorized" ] } if !authorized?(current_user, user.id)

      update_user(user)

      { user:, errors: [] }
    end

    private

    attr_reader :id, :name, :password, :current_user

    def update_user(user)
      user.update(name:) if name.present?
      user.update(password:) if password.present?
    end
  end
end
