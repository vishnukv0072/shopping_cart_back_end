class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products, id: false do |t|
      t.string :id, primary_key: true
      t.string :title
      t.string :image_url
      t.string :product_url
      t.float :rating
      t.integer :reviews_count
      t.float :price
      t.boolean :is_bestseller
      t.integer :bought_in_last_month
      t.string :category
      t.datetime :created_at, null: false, default: -> { "CURRENT_TIMESTAMP" }
      t.datetime :updated_at, null: false, default: -> { "CURRENT_TIMESTAMP" }
    end
  end
end
