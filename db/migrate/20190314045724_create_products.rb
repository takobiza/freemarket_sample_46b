class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string      :name, null: false, index: true
      t.integer     :price, null: false
      t.references  :category, null: false, foreign_key: true
      t.timestamps null: true
    end
  end
end
