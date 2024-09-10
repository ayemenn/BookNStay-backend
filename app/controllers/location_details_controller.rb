class LocationDetailsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:show]

  def show
    # Fetch data from TripAdvisor API using the service object
    service = TripAdvisorDetailsService.new(params[:id])
    location_details = service.fetch_details

    if location_details['error']
      render json: { error: location_details['error'] }, status: :unprocessable_entity
    else
      render json: location_details, status: :ok
    end
  end
end
