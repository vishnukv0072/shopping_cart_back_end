class CreateUser < ActiveRecord::Migration[8.0]
  def change
    create_table :users, id: :uuid, default: "uuid_generate_v4()" do |t|
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.date :date_of_birth
      t.string :phone_number
      t.string :email
      t.string :password
      t.timestamps
    end
  end
end
