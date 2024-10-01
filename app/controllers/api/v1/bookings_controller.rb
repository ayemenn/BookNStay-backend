module Api::V1
  class BookingsController < ApplicationController
    def create
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
    def destroy
      booking = Booking.find_by(id: params[:id])
      if booking
        booking.delete
        render json: { message: "Booking deleted", booking: booking }, status: :ok
      else
        render json: { error: "Booking not found" }, status: :not_found
      end
    end
  end
end
  
  