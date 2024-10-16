class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :guestinfo
  has_one :payment, :dependent => :delete
  validates :start_date, :end_date, presence: true
end
