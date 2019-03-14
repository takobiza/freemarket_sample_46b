class Brand < ApplicationRecord
  has_mamy: products, dependent: :destroy
end
