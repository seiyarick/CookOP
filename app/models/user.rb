class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :dishes, dependent: :destroy
  has_many :favorits, dependent: :destroy
  has_many :comments, dependent: destroy
  has_many :relationships, dependent: :destroy
end
