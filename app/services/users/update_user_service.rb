# frozen_string_literal: true

module Users
  class UpdateUserService
    def self.call(id:, name: nil, password: nil, current_user:)
      user = ::User.find_by(id:)
      return { user: nil, errors: [ "User not found" ] } if user.blank?

      return { user: nil, errors: [ "Not authorized" ] } if current_user&.id != user.id

      user.update(name:) if name.present?
      user.update(password:) if password.present?

      { user:, errors: [] }
    end
  end
end
