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
  has_many :products, dependent: :destroy
  has_many :purchase_seller, :class_name => 'Purchase', :foreign_key => 'seller_id'
  has_many :purchase_buyer, :class_name => 'Purchase', :foreign_key => 'buyer_id'
  has_many :products_of_seller, :through => :purchase_seller, :source => 'product'
  has_many :products_of_buyer, :through => :purchase_buyer, :source => 'product'
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :nickname, presence: true
  validates :nickname,    length: { maximum: 20 }
  validates :message,    length: { maximum: 1000 }


  attr_writer :card_number, :credit_year, :credit_month, :card_code

  def get_good_rate
    self.purchase_seller.select{|purchase| purchase.rate == 1}.length
  end

  def get_normal_rate
    self.purchase_seller.select{|purchase| purchase.rate == 2}.length
  end

  def get_low_rate
    self.purchase_seller.select{|purchase| purchase.rate == 3}.length
  end

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

  def like_user?(id)
    self.favorites.select{|favorite| favorite.product_id == id}.present?
  end

end
