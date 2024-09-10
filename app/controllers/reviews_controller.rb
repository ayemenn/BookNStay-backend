class ReviewsController < ApplicationController
    before_action :authenticate_user!
  
    def create
      review = current_user.reviews.new(review_params)
  
      if review.save
        render json: { message: 'Review created successfully', review: review }, status: :created
      else
        render json: { errors: review.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    private
  
    def review_params
      params.require(:review).permit(:rating, :comment)
    end
  end
  