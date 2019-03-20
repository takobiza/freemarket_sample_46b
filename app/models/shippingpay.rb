class Shippingpay < ActiveHash::Base
  include ActiveHash::Associations
  has_many :delivary_options
  self.data = [
    {id: 0, name: '送料込み（出品者負担）'},{id: 1, name: '着払い（購入者負担）'}
  ]
end
