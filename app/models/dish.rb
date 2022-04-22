class Dish < ApplicationRecord
  has_one_attached :dish_image
  belongs_to :user#, optional: true
  has_many :comments, dependent: :destroy
  has_many :favorits, dependent: :destroy

  def favorited_by?(user)
    favorits.exists?(user_id: user.id)
  end

  def self.create_all_ranks
    Dish.find(Favorit.group(:dish_id).order('count(dish_id) desc').limit(10).pluck(:dish_id))
  end
  
  def html_safe_newline(str)
   h(str).gsub(/\n|\r|\r\n/, "<br>").html_safe
  end

end
