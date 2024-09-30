class Guestinfo < ApplicationRecord
  belongs_to :user
  has_one :booking
  validates :number_of_adults, :number_of_children, numericality: { greater_than_or_equal_to: 0 }
end
