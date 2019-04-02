class UserAddress < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  belongs_to_active_hash :prefecture

  def get_full_address
    address = "#{self.prefecture.name} #{self.city} #{self.block}"
    if self.building.present?
      address += " #{self.building}"
    end
    return address
  end

  def get_fullname
    fullname = self.family_name + " " + self.given_name
  end
end
