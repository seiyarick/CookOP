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

  # def create_notification_comment!(current_user, comment_id)
  #       # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
  #       temp_ids = Comment.select(:user_id).where(dish_id: id).where.not(user_id: current_user.id).distinct
  #       temp_ids.each do |temp_id|
  #           save_notification_comment!(current_user, comment_id, temp_id['user_id'])
  #       end
  #       # まだ誰もコメントしていない場合は、投稿者に通知を送る
  #       save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  # end

  # def save_notification_comment!(current_user, comment_id, visited_id)
  #       # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
  #       notification = current_user.active_notifications.new(
  #         dish_id: id,
  #         comment_id: comment_id,
  #         visited_id: visited_id,
  #         action: 'comment'
  #       )
  #       # 自分の投稿に対するコメントの場合は、通知済みとする
  #       if notification.visiter_id == notification.visited_id
  #         notification.checked = true
  #       end
  #       notification.save if notification.valid?
  # end
end
