class CreateCartItems < ActiveRecord::Migration[8.0]
  def change
    create_table :cart_items, id: :uuid, default: "uuid_generate_v4()" do |t|
      t.string :product_id
      t.integer :quantity
      t.uuid :user_id
      t.timestamps
    end
  end
end
