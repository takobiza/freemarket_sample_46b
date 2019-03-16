class Product < ApplicationRecord
  has_many :product_images, dependent: :destroy
  belongs_to :category
  belongs_to :brand

  def item_image
    ProductImage.find_by(product_id: self.id).image;
  end

end
