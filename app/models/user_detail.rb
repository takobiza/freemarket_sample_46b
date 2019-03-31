class UserDetail < ApplicationRecord
  belongs_to :user
  validates :city,    length: { maximum: 50 }
  validates :block,    length: { maximum: 100 }
  validates :building,    length: { maximum: 100 }
  VALID_POSTAL_CODE_REGEX = /\A[0-9]{7}+\z/
  validates :postal_code, format: { with: VALID_POSTAL_CODE_REGEX }, unless: Proc.new { |user_detail| user_detail.postal_code.blank? }


  def get_fullname
    fullname = self.family_name + " " + self.given_name
  end

  def get_fullname_kana
    fullnamekana = self.family_name_kana + " " + self.given_name_kana
  end

  def get_birth
    birth = self.birth_year.to_s + "/" + self.birth_month.to_s + "/" + self.birth_day.to_s
  end
end
