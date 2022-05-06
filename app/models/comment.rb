class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :dish
  has_many :notifications, dependent: :destroy

  validates :comment_text, presence: true, length: {minimum: 1, maximum: 50}

  

end
