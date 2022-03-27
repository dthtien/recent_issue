class Comment < ApplicationRecord
  belongs_to :user

  scope :order_rating, -> { order(rating: :desc) }
end
