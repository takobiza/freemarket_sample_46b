class CreateUserAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :user_addresses do |t|
      t.references  :user, null: false, foreign_key: true
      t.string      :family_name, null: false
      t.string      :given_name, null: false
      t.string      :family_name_kana, null: false
      t.string      :given_name_kana, null: false
      t.string      :postal_code, null: false
      t.integer     :prefecture_id, null: false
      t.string      :city, null: false
      t.string      :block, null: false
      t.string      :building
      t.integer     :phone_number
      t.timestamps
    end
  end
end
