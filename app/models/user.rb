class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  validates :password,               length: {minimum:6 ,message: 'は6文字以上128文字以下で入力してください'}, if: ->(u) { u.password.blank? }

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
