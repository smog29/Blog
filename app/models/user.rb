class User < ApplicationRecord
  has_many :journals, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :posts, through: :journals

  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password, format: {
    with: /\A(?=.*[A-Z])(?=.*[\W])/,
    message: "must include at least one uppercase letter and one special character"
  }
end
