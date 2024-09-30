class RemoveLocationIdForeignKeyFromReviews < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :reviews, :bookings, column: :location_id
  end
end
