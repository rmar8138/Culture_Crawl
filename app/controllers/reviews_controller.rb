class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end

  def show
    @review = Review.find(params[:id])
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
  end

  def edit
    
  end

  def update
    
  end

  def destroy
    
  end

  private

  def review_params
    params.require(:review).permit(
      :title,
      :rating,
      :body
    )
  end
end
