class Purchase < ApplicationRecord
  belongs_to :product
  belongs_to :seller, :class_name => 'User'
  belongs_to :buyer, :class_name => 'User'

  attr_writer :is_product_arrived

  def is_product_arrived
    @is_product_arrived
  end

end
