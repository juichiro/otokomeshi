class Post < ApplicationRecord
  
  validates :content, presence: true, length: {maximum: 300}
 validates :name, presence: true, length: {maximum: 50}
 #validates :image, presence: true
 
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorited, through: :favorites, source: :user
  #mount_uploader :image, ImageUploader
  has_one_attached :post_image#activestorage
end
