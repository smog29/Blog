class Post < ApplicationRecord
  belongs_to :journal
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
end
