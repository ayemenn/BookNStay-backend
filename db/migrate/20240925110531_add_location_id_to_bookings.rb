class AddLocationIdToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :location_id, :integer
  end
end
