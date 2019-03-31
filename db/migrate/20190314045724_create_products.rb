class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string      :name, null: false, index: true
      t.integer     :price, null: false
      t.text        :description, null: false
      t.integer     :size
      t.integer     :state_id, null: false
      t.boolean     :is_buy, null: false, default: true
      t.boolean     :status, null: false, default: true
      t.timestamps null: true
    end
  end
end
