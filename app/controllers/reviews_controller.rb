class ReviewsController < ApplicationController
  #before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    review = current_user.reviews.new(review_params)

    if review.save
      render json: { success: true, message: 'Review created successfully', review: review }, status: :created
    else
      render json: { success: false, errors: review.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def fetch_reviews
    location_id = params[:location_id] # Get location_id from params
    service = TripAdvisorReviewsService.new(location_id)
    reviews = service.fetch_reviews

    if reviews['error']
      render json: { error: reviews['error'] }, status: :unprocessable_entity
    else
      render json: reviews, status: :ok
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment, :location_id) # Ensure location_id is permitted
  end
end
