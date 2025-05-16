class CreateAddresses < ActiveRecord::Migration[8.0]
  def change
    create_table :addresses, id: :uuid, default: "uuid_generate_v4()" do |t|
      t.string :first_name
      t.string :last_name
      t.string :street
      t.string :city
      t.string :state
      t.integer :postalCode
      t.string :country
      t.string :phone
      t.string :country_code
      t.uuid :user_id
      t.boolean :default, default: false
      t.timestamps
    end
  end
end
