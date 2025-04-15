class CreateUserInterests < ActiveRecord::Migration[8.0]
  def change
    create_table :interests, id: :uuid, default: "uuid_generate_v4()" do |t|
      t.string :category
      t.string :image_urls, array: true, default: []
      t.uuid :user_id
      t.timestamps
    end
  end
end
