class SearchHistoriesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  
  def create
    # Fetch data from TripAdvisor API using the service object
    service = TripAdvisorSearchService.new(search_history_params[:search_query])
    search_results = service.search
   # Rails.logger.info("Search results: #{search_results}")

    user_id = search_history_params[:user_id]  # Get user_id from params

    # Save the search history only if user_id is present
    if user_id.present?
      search_history = SearchHistory.new(search_query: search_history_params[:search_query], user_id: user_id)
      
      if search_history.save
        # Return both search results and a success message about saving the history
        render json: { message: 'Search saved successfully', search_history: search_history, results: search_results }, status: :created
      else
        # Handle error if saving the search history fails
        render json: { errors: search_history.errors.full_messages }, status: :unprocessable_entity
      end
    else
      # If user_id is not present, just return search results without saving
      render json: { results: search_results }, status: :ok
    end
  end

  private

  def search_history_params
    params.require(:search_history).permit(:search_query, :user_id)  # Permit user_id and search_query
  end
end
