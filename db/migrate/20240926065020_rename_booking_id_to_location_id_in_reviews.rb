class RenameBookingIdToLocationIdInReviews < ActiveRecord::Migration[7.1]
  def change
    rename_column :reviews, :booking_id, :location_id
  end
end
