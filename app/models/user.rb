class User < ApplicationRecord
  has_many :journals, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :posts, through: :journals

  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }, allow_nil: true
  validates :password, format: {
    with: /\A(?=.*[A-Z])(?=.*[\W])/,
    message: "must include at least one uppercase letter and one special character"
  }, allow_nil: true
end
