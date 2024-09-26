class RemoveBookingIdFromReviews < ActiveRecord::Migration[6.0]
  def change
    remove_reference :reviews, :booking, foreign_key: true
  end
end
