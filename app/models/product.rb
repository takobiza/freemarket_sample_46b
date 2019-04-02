class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  has_many :product_images, dependent: :destroy
  accepts_nested_attributes_for :product_images
  has_one :delivary_option, dependent: :destroy
  accepts_nested_attributes_for :delivary_option
  belongs_to :category
  belongs_to :brand, optional: true
  belongs_to :user
  belongs_to_active_hash :state

  has_many :purchase, dependent: :destroy

  validates :category_id, presence: true

  validates :name, length: { in: 1..40 }
  validates :description, length: { in: 1..1000 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
  validates :product_images, length: { minimum: 1, maximum: 5}


  def item_image
    ProductImage.find_by(product_id: self.id).image.url
  end

  def six_products_related_product
    Product.where.not(id: self.id).where(category_id: self.category_id).limit(6)
  end
end
