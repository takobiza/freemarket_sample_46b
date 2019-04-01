class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
        :omniauthable,omniauth_providers: %i[google_oauth2]

  has_one :user_detail, dependent: :destroy
  accepts_nested_attributes_for :user_detail

  has_one :user_address, dependent: :destroy
  has_one :sns_credentials, dependent: :destroy
  has_many :products
  validates :nickname, presence: true
  validates :nickname,    length: { maximum: 20 }
  validates :message,    length: { maximum: 1000 }



  attr_writer :card_number, :credit_year, :credit_month, :card_code

  def card_number
    @card_number
  end

  def credit_year
    @credit_year
  end

  def credit_month
    @credit_month
  end

  def card_code
    @card_code
  end

  def self.years
   years = []
   for year in 1900..2019 do
     years << year
   end
   return years
  end

  def self.months
   months = []
   for month in 1..12 do
     months << month
   end
   return months
  end

end
