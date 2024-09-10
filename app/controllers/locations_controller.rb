# app/controllers/locations_controller.rb
class LocationsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:photos]

  def photos
    service = TripAdvisorPhotosService.new(params[:id])
    photos = service.fetch_photos

    if photos['error']
      render json: { error: photos['error'] }, status: :unprocessable_entity
    else
      render json: photos, status: :ok
    end
  end
end
