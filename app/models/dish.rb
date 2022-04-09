class Dish < ApplicationRecord
  belongs_to :user
  
  has_many :comments, dependent: :destroy
  has_many :favorits, dependent: :destroy
end
