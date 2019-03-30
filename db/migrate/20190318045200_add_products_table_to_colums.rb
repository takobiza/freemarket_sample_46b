class AddProductsTableToColums < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :description, :text, null: false
    add_column :products, :size, :integer
    add_column :products, :state_id, :integer, null: false
    add_column :products, :is_buy, :boolean, null: false, default: true
    add_column :products, :status, :boolean, null: false, default: true
  end
end
