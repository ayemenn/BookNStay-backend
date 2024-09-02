class SearchHistoriesController < ApplicationController
  before_action :authenticate_user!

  def create
    search_history = current_user.search_histories.new(search_history_params)
    
    if search_history.save
      render json: { message: 'Search saved successfully', search_history: search_history }, status: :created
    else
      render json: { errors: search_history.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def search_history_params
    params.require(:search_history).permit(:search_query)
  end
end
