class DelivaryOption < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :product
  belongs_to_active_hash :shippingday
  belongs_to_active_hash :shippingpay
  belongs_to_active_hash :prefecture
end
