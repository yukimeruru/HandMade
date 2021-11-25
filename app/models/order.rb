class Order < ApplicationRecord

  belongs_to :user
  belongs_to :item

  has_many :notifications, dependent: :destroy

  def create_notification_order!(current_user, order_id)
    temp_ids = Order.select(:user_id).where(item_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_order!(current_user, order_id, temp_id['user_id'])
    end
    save_notification_order!(current_user, order_id, user_id) if temp_ids.blank?
  end

  def save_notification_order!(current_user, order_id, visited_id)
    notification = current_user.active_notifications.new(
      item_id: id,
      order_id: order_id,
      visited_id: visited_id,
    )
    if notification.visiter_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  enum comment_status: { request: 0, question: 1, reply: 2, impression: 4 }

  validates :user_id, presence: true
  validates :item_id, presence: true
  validates :order_comment, presence: true, length: { maximum: 500 }
  validates :comment_status, presence: true
end
