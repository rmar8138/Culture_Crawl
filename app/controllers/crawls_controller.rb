class CrawlsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  helper_method :crawl_attendees_string

  def index
    @crawls = Crawl.where("crawl_date > ?", DateTime.now).order(:created_at).page params[:page]
  end

  def show
    @crawl = Crawl.find(params[:id])
    @attendees = @crawl.attendees.map do |attendee|
      User.find(attendee.user_id)
    end
    @reviews = Review.where(crawl_id: @crawl.id)
    @spots_left = @crawl.max_attendees - @attendees.length
  end

  def new
    @crawl = Crawl.new
  end

  def create
    @crawl = Crawl.new(crawl_params)
    @crawl.user_id = current_user.id
    @crawl.crawl_date = crawl_date_params
    
    if @crawl.save
      redirect_to crawl_path(@crawl)
    else
      render 'new'
    end
  end

  def edit
    @crawl = Crawl.find(params[:id])
    if @crawl.user_id != current_user.id
      redirect_to crawl_path(@crawl)
    end
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
    params[:crawl][:price] = (params[:crawl][:price].to_f * 100).to_i
    params.require(:crawl).permit(
      :title,
      :location,
      :description,
      :price,
      :rating,
      :max_attendees,
      :finished,
      :user_id,
      :crawl_image,
      locations_attributes: Location.attribute_names.map(&:to_sym).push(:_destroy, :location_image)
    )
  end

  def crawl_date_params
    date_values = params[:date].values.map(&:to_i)
    crawl_date = DateTime.new(*date_values)
  end

  def crawl_attendees_string
    crawl = Crawl.find(params[:id])
    first_three_attendees = crawl.attendees.first(3)
    attendees_number = crawl.attendees.length

    if crawl.crawl_date.past?
      case attendees_number
      when 0
        "No one attended :("
      when 1
        "#{first_three_attendees[0].user.profile.first_name} attended."
      when 2
        "#{first_three_attendees[0].user.profile.first_name} and #{first_three_attendees[1].user.profile.first_name} attended."
      when 3
        "#{first_three_attendees[0].user.profile.first_name}, #{first_three_attendees[1].user.profile.first_name} and #{first_three_attendees[2].user.profile.first_name} attended."
      else
        "#{first_three_attendees[0].user.profile.first_name}, #{first_three_attendees[1].user.profile.first_name}, #{first_three_attendees[2].user.profile.first_name} and #{attendees_number - 3} more attended."
      end
    else
      case attendees_number
      when 0
        "No one attending yet."
      when 1
        "#{first_three_attendees[0].user.profile.first_name} is attending."
      when 2
        "#{first_three_attendees[0].user.profile.first_name} and #{first_three_attendees[1].user.profile.first_name} are attending."
      when 3
        "#{first_three_attendees[0].user.profile.first_name}, #{first_three_attendees[1].user.profile.first_name} and #{first_three_attendees[2].user.profile.first_name} are attending."
      else
        "#{first_three_attendees[0].user.profile.first_name}, #{first_three_attendees[1].user.profile.first_name}, #{first_three_attendees[2].user.profile.first_name} and #{attendees_number - 3} more are attending."
      end
    end
    
  end
end
