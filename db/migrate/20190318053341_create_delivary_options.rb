class CreateDelivaryOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :delivary_options do |t|
      t.references  :product, null: false, foreign_key: true
      t.integer      :method_id, null: false
      t.integer      :prefecture_id, null: false
      t.integer      :shippingday_id, null: false
      t.integer      :shippingpay_id, null: false
      t.timestamps
    end
  end
end

