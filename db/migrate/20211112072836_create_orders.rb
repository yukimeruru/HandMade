class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :user_id, null: false
      t.integer :item_id, null: false
      t.text :order_comment, null: false
      t.integer :comment_status, null: false
      t.integer :reply_id, null: false

      t.timestamps
    end
  end
end
