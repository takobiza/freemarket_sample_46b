class Shippingmethod < ActiveHash::Base
  include ActiveHash::Associations
  self.data = [
      {id: 0, name: '未定'}, {id: 1, name: 'らくらくメルカリ便'}, {id: 2, name: 'ゆうメール'},{id: 3, name: 'レターパック'}, {id: 4, name: '普通郵便(定形、定形外)'}, {id: 5, name: 'クロネコヤマト'}, {id: 6, name: 'ゆうパック'}, {id: 7, name: 'クリックポスト'}, {id: 8, name: 'ゆうパケット'}
  ]
  has_many :delivary_options

  def self.purchaser_fee
    find([0,3,5,6,])
  end

end
