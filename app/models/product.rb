class Product < ApplicationRecord
  has_many :product_images, dependent: :destroy
  accepts_nested_attributes_for :product_images
  has_one :deliveryoption, dependent: :destroy
  belongs_to :category
  belongs_to :brand
  belongs_to :user



  def item_image
    ProductImage.find_by(product_id: self.id).image
  end

  def six_products_related_product
    Product.where(category_id: self.category_id).where(brand_id: self.brand_id)
  end
end
