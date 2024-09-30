class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :guestinfo
  has_one :payment, :dependent => :delete


  #has_many :reviews

  validates :start_date, :end_date, presence: true
end
