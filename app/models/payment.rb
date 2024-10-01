class Payment < ApplicationRecord
  belongs_to :booking
  validates :total_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
