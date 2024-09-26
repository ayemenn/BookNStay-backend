class BookingsController < ApplicationController
  def create
    # Only save booking if payment was successful (placeholder for now)
    booking = Booking.create!(
      user_id: params[:user_id],
      guestinfo_id: params[:guestinfo_id],
      start_date: params[:start_date],
      end_date: params[:end_date],
      location_id: params[:location_id] 
    )

    render json: { message: 'Booking created successfully', booking: booking }, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end
end
