class Dish < ApplicationRecord
  has_one_attached :dish_image
  belongs_to :user#, optional: true
  has_many :comments, dependent: :destroy
  has_many :favorits, dependent: :destroy
  has_many :notifications, dependent: :destroy


  validates :dish_name, presence: true
  validates :introduction, presence: true, length: { maximum: 300 }
  validates :dish_image, attached: true, content_type: [:png, :jpg, :jpeg]

  def favorited_by?(user)
    favorits.exists?(user_id: user.id)
  end

  def self.create_all_ranks
    Dish.find(Favorit.group(:dish_id).order('count(dish_id) desc').limit(10).pluck(:dish_id))

  end

  def html_safe_newline(str)
   h(str).gsub(/\n|\r|\r\n/, "<br>").html_safe
  end

  def create_notification_favorite!(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visiter_id = ? and visited_id = ? and dish_id = ? and action = ? ", current_user.id, user_id, id, 'favorite'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        dish_id: id,
        visited_id: user_id,
        action: 'favorite'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visiter_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
end
