class Category < ApplicationRecord
  acts_as_tree
  has_many :products, dependent: :destroy
end
