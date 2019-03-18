class AddProductsTableToColums < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :description, :text
    add_column :products, :size, :integer
    add_column :products, :state, :integer
    add_column :products, :price, :integer, null: false
    add_column :products, :is_buy, :boolean, null: false, default: true
    add_column :products, :status, :boolean, null: false, default: true
    add_reference :products, :category, foreign_key: true, null: false
  end
end
