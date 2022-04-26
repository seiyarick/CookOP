class Relationship < ApplicationRecord
  belongs_to :following, class_name: 'User'#following,followerテーブルはフォローする側、フォローされる側を分けるため
  belongs_to :follower, class_name: 'User'#実際にはfollowing,followerテーブルは存在しないので'User'とすることでUserテーブルと判断できる。

  def create_notification_follow!(current_user)
    temp = Notification.where(["visiter_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?#tenpが空ならばtrue
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?#エラーが発生しなければtrue
    end
  end
  
end
