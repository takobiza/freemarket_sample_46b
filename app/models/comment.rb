class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :message, length: { in: 1..1000 }

end
