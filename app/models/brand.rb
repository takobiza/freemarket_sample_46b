class Brand < ApplicationRecord
  has_many :products, dependent: :destroy

  def get_brand_name
    self.name.nil? ? "" : self.name
  end
end
