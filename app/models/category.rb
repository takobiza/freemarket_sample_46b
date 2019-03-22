class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  def self.refine_category(scale)
    if scale == "large"
      select(:large).distinct
    elsif scale == "middle"
      select(:middle).distinct
    elsif scale == "small"
      select(:small).distinct
    end
  end

end
