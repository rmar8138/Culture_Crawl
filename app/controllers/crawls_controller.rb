class CrawlsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @crawls = Crawl.all
  end

  def show
    @crawl = Crawl.find(params[:id])
  end

  def new
    @crawl = Crawl.new
  end

  def create
    @user = User.find(current_user.id)
    @crawl = @user.crawls.create(crawl_params)
    if 
      redirect_to crawl_path(@crawl)
    else
      render 'new'
    end
  end

  def edit
    @crawl = Crawl.find(params[:id])
  end

  def update
  end

  def destroy
  end

  private

  def crawl_params
    params.require(:crawl).permit(
      :title,
      :location,
      :description,
      :price,
      :rating,
      :max_attendees,
      :crawl_date,
      :crawl_time,
      :finished,
      :user_id
    )
  end
end
