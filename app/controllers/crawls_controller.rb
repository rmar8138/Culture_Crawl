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
    @location = Location.new
  end

  def create
    pp params
    @user = User.find(current_user.id)
    @crawl = @user.crawls.create(crawl_params)
    @crawl.locations.create(location_params)
    if @crawl
      redirect_to crawl_path(@crawl)
    else
      render 'new'
    end
  end

  def edit
    @crawl = Crawl.find(params[:id])
  end

  def update
    @crawl = Crawl.find(params[:id])
    if @crawl.update(crawl_params)
      redirect_to crawl_path(@crawl)
    else
      render 'edit'
    end
  end

  def destroy
    @crawl = Crawl.find(params[:id])
    if @crawl.delete
      redirect_to profile_path(@crawl.user.profile)
    else
      render 'edit'
    end
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

  def location_params
    params.require(:location).permit(
      :title,
      :location,
      :description
    )
  end
end
