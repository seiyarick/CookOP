class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :dishes, dependent: :destroy
  has_many :favorits, dependent: :destroy
  has_many :comments, dependent: :destroy

 has_many :relationships, foreign_key: :following_id
 has_many :followings, through: :relationships, source: :follower

 has_many :reverse_of_relationships ,class_name: 'Relationship', foreign_key: :follower_id
 has_many :followers, through: :reverse_of_relationships, source: :following

 has_one_attached :profile_image

  def is_followed_by?(user)
    reverse_of_relationships.find_by(following_id: user.id).present?
  end

  def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/noimage.png')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image
  end

  
end

