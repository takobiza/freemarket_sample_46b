class CreateUserDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :user_details do |t|
      t.references  :user, null: false, foreign_key: true
      t.string      :family_name, null: false
      t.string      :given_name, null: false
      t.string      :family_name_kana, null: false
      t.string      :given_name_kana, null: false
      t.integer     :birth_year, null: false
      t.integer     :birth_month, null: false
      t.integer     :birth_day, null: false
      t.string      :postal_code
      t.integer     :prefecture_id
      t.string      :city
      t.string      :block
      t.string      :building
      t.integer     :phone_number
      t.timestamps
    end
  end
end
