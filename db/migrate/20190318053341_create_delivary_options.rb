class CreateDelivaryOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :delivary_options do |t|
      t.references  :product, null: false, foreign_key: true
      t.integer      :method, null: false
      t.integer      :prefecture, null: false
      t.integer      :days, null: false
      t.integer      :burden, null: false
      t.timestamps
    end
  end
end

