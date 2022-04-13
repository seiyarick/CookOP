class Dish < ApplicationRecord
  has_one_attached :dish_image
  belongs_to :user#, optional: true
  has_many :comments, dependent: :destroy
  has_many :favorits, dependent: :destroy

  def favorited_by?(user)
    favorits.exists?(user_id: user.id)
  end

end
