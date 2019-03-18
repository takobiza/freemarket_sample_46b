class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  validates :password,               length: {minimum:6 ,message: 'は6文字以上128文字以下で入力してください'}, if: ->(u) { u.password.blank? }

end
