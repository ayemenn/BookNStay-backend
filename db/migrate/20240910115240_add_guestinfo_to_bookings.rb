class AddGuestinfoToBookings < ActiveRecord::Migration[7.1]
  def change
    add_reference :bookings, :guestinfo, null: false, foreign_key: true
  end
end
