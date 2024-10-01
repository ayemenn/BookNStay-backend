module Api::V1
  
  class GuestinfosController < ApplicationController
    def create
      guestinfo = Guestinfo.new(guestinfo_params.merge(user_id: params[:user_id]))

      if guestinfo.save
        render json: { message: 'Guest info created successfully', guestinfo: guestinfo }, status: :created
      else
        render json: { errors: guestinfo.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      guestinfo = Guestinfo.find(params[:id])

      if guestinfo.destroy
        render json: { message: 'Guest info successfully deleted' }, status: :ok
      else
        render json: { errors: guestinfo.errors.full_messages }, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Guest info not found' }, status: :not_found
    end

    private

    def guestinfo_params
      params.require(:guestinfo).permit(:number_of_adults, :number_of_children)
    end
  end
end