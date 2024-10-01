class Review < ApplicationRecord
  belongs_to :user
  #belongs_to :booking
  validates :rating, presence: true, numericality: { less_than_or_equal_to: 5, greater_than: 0 }
  validates :comment, presence: true
end
