class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  has_many :product_images, dependent: :destroy
  accepts_nested_attributes_for :product_images
  has_one :delivary_option, dependent: :destroy
  accepts_nested_attributes_for :delivary_option
  belongs_to :category
  belongs_to :brand, optional: true
  belongs_to :user
<<<<<<< HEAD
=======
  belongs_to_active_hash :state
<<<<<<< HEAD
>>>>>>> takobiza/master
=======
  validates :category_id, presence: true

>>>>>>> takobiza/master



  def item_image
    ProductImage.find_by(product_id: self.id).image.url
  end

  def six_products_related_product
    Product.where.not(id: self.id).where(category_id: self.category_id).where(brand_id: self.brand_id).limit(6)
  end
end
