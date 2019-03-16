class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string      :large, null: false, index: true
      t.string      :middle, null: false
      t.string      :small, null: false
      t.timestamps null: true
    end
  end
end
