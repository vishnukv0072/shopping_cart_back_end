class CreateCartItems < ActiveRecord::Migration[8.0]
  def change
    create_table :cart_items, id: false do |t|
      t.string :id, primary_key: true
      t.integer :quantity
      t.float :unit_price
      t.float :total_price
      t.uuid :user_id
      t.timestamps
    end
  end
end
