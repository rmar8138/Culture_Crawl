class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reviews = Review.all
  end

  def show
    @review = Review.find(params[:id])
  end

  def new
    # make sure user can't review their own crawl, 
    # or review crawl they have already reviewed
    @review = Review.new
    @crawl = Crawl.find(params[:crawl_id])

    if current_user.id == @crawl.user.id || 
       @crawl.reviews.pluck(:user_id).include?(current_user.id)
      redirect_to crawl_path(@crawl)
    end
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
    @crawl = Crawl.find(params[:crawl_id])
    @review = Review.find(params[:review_id])

    if current_user.id != @crawl.user.id 
      redirect_to crawl_path
    end
  end

  def update
    @review = Review.find(params[:review_id])
    @crawl = Crawl.find(params[:crawl_id])
    
    if @review.update(review_params)
      redirect_to crawl_path(@crawl)
    else
      render "edit"
    end
  end

  def destroy
    @review = Review.find(params[:review_id])
    @crawl = Crawl.find(params[:crawl_id])

    if @review.destroy
      redirect_to crawl_path(@crawl)
    else
      render "edit"
    end
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
