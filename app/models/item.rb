class Item < ApplicationRecord
  is_impressionable
  acts_as_taggable

  has_many :orders
  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end

	def bookmarked_by?(user)
    bookmarks.where(user_id: user.id).exists?
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @item = Item.where("name LIKE?","#{word}")
    elsif search == "forward_match"
      @item = Item.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @item = Item.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @item = Item.where("name LIKE?","%#{word}%")
    else
      @item = Item.all
    end
  end

  attachment :image

  enum item_status: { contribution: 0, reception: 1, reception_stop: 2 }

  validates :user_id, presence: true
  validates :name, presence: true
  validates :description, presence: true, length: { maximum: 1000 }
  validates :image, presence: true
  validates :item_status, presence: true
end


