class Product < ApplicationRecord
  has_many: product_images, dependent: :destroy
  belongs_to: category
  belongs_to: brand
end
