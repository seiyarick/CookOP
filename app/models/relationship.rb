class Relationship < ApplicationRecord
  belongs_to :following, class_name: 'User'#following,followerテーブルはフォローする側、フォローされる側を分けるため
  belongs_to :follower, class_name: 'User'#実際にはfollowing,followerテーブルは存在しないので'User'とすることでUserテーブルと判断できる。
  
  
end
