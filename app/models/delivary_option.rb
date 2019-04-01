class DelivaryOption < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :product
  belongs_to_active_hash :shippingday
  belongs_to_active_hash :shippingpay
  belongs_to_active_hash :shippingmethod
  belongs_to_active_hash :prefecture

  attr_writer :seller_fee, :purchaser_fee

  before_validation :set_shippingmethod_id

  def seller_fee
    @seller_fee
  end

  def purchaser_fee
    @purchaser_fee
  end

  def set_shippingmethod_id
    if self.seller_fee.blank?
      self.shippingmethod_id = @purchaser_fee
    else
      self.shippingmethod_id = @seller_fee
    end
  end

end
