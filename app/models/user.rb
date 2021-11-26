class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items, dependent: :destroy
  has_many :orders, dependent: :destroy

  has_many :favorite, dependent: :destroy

  has_many :relationships, foreign_key: :follower_id, dependent: :destroy
  has_many :followers, through: :relationships, source: :followed

  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: :followed_id, dependent: :destroy
  has_many :followeds, through: :reverse_of_relationships, source: :follower
  has_many :bookmarks, dependent: :destroy


  def is_followed_by?(user)
    reverse_of_relationships.find_by(follower_id: user.id).present?
  end

  attachment :image

  validates :name, presence: true
  validates :email, presence: true
  validates :introduction, length: { maximum: 100 }

end
