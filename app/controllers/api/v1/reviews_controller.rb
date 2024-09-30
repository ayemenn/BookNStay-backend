module Api::V1
  class ReviewsController < ApplicationController
    # before_action :authenticate_user!
    skip_before_action :verify_authenticity_token, only: [:create]

    def create
      user = User.find(params[:review][:user_id])

      review = Review.new(
        user_id: user.id,
        rating: params[:review][:rating],
        comment: params[:review][:comment],
        location_id: params[:review][:location_id] 
      )
        if review.save
        render json: { success: true, message: 'Review created successfully', review: review.as_json(only: [:id, :rating, :comment, :created_at, :user_id])}, status: :created
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
      params.require(:review).permit(:rating, :comment, :location_id, :user_id) 
    end
  end
end