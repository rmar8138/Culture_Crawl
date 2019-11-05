class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end

  def show
    @review = Review.find(params[:id])
  end

  def new
    @review = Review.new
    @crawl = Crawl.find(params[:crawl_id])
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.crawl_id = params[:crawl_id]

    if @review.save
      redirect_to profile_path(current_user)
    else
      render "new"
    end
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
