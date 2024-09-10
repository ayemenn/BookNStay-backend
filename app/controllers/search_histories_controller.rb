class SearchHistoriesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  
  def create
    # Fetch data from TripAdvisor API using the service object
    service = TripAdvisorSearchService.new(search_history_params[:search_query])
    search_results = service.search

    if search_results['error']
      render json: { error: search_results['error'] }, status: :unprocessable_entity
    else
      render json: search_results, status: :ok
    end
  end

  private

  def search_history_params
    params.require(:search_history).permit(:search_query)
  end
end
