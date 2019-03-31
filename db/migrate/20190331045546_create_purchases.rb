class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :purchases do |t|
      t.references  :product, null: false, foreign_key: true
      t.integer :price_pay, null: false
      t.integer :rate
      t.timestamps
    end
  end
end
