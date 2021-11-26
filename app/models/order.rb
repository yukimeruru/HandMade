class Order < ApplicationRecord

  belongs_to :user
  belongs_to :item

  enum comment_status: { request: 0, question: 1, reply: 2, impression: 4 }

  validates :user_id, presence: true
  validates :item_id, presence: true
  validates :order_comment, presence: true, length: { maximum: 500 }
  validates :comment_status, presence: true
end
