class User < ApplicationRecord
   before_save { self.email.downcase! }
  
  
  
  has_secure_password
  
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                   format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_many :posts
  has_many :favorites
  has_many :favoriting, through: :favorites, source: :post
                    
  def favorite(post)
    self.favorites.find_or_create_by(post_id: post.id)
  end 
  
  def unfavorite(post)
    favorite = self.favorites.find_by(post_id: post.id)
    favorite.destroy if favorite 
  end 
  
  def favorite?(post)
    self.favoriting.include?(post)
  end 
end
