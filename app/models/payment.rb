class Payment < ApplicationRecord
  belongs_to :booking
  belongs_to :voucher, optional: true
  validates :total_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
