class CrawlsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  helper_method :crawl_attendees_string

  def index
    @crawls = Crawl.all
  end

  def show
    @crawl = Crawl.find(params[:id])
    @attendees = @crawl.attendees.map do |attendee|
      User.find(attendee.user_id)
    end
    @reviews = Review.where(crawl_id: @crawl.id)



    session = Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      customer_email: current_user.email,
      line_items: [
        {
          name: @crawl.title,
          description: @crawl.description,
          amount: @crawl.price,
          currency: "aud",
          quantity: 1
        }
      ],
      payment_intent_data: {
        metadata: {
          user_id: current_user.id,
          crawl_id: @crawl.id
        }
      },
      success_url: "#{root_url}payment/success?userId=#{current_user.id}&crawlId=#{@crawl.id}",
      cancel_url: "#{root_url}crawls/#{@crawl.id}"
    )

    @session_id = session.id
    @public_key = Rails.application.credentials.dig(:stripe, :public_key)
  end

  def new
    @crawl = Crawl.new
    @location = Location.new
  end

  def create
    @crawl = Crawl.new(crawl_params)
    @crawl.user_id = current_user.id
    @crawl.crawl_date = crawl_date_params
    @crawl.locations.build
    
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
      p crawl_params
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

    if crawl.crawl_date.past?
      case crawl.attendees.length
      when 0
        "No one attended :("
      when 1
        "#{crawl.attendees[0].user.profile.first_name} attended."
      when 2
        "#{crawl.attendees[0].user.profile.first_name} and #{crawl.attendees[1].user.profile.first_name} attended."
      when 3
        "#{crawl.attendees[0].user.profile.first_name}, #{crawl.attendees[1].user.profile.first_name} and #{crawl.attendees[2].user.profile.first_name} attended."
      else
        "#{crawl.attendees[0].user.profile.first_name}, #{crawl.attendees[1].user.profile.first_name}, #{crawl.attendees[2].user.profile.first_name} and #{crawl.attendees.length - 3} more attended."
      end
    else
      case crawl.attendees.length
      when 0
        "No one attending yet."
      when 1
        "#{crawl.attendees[0].user.profile.first_name} is attending."
      when 2
        "#{crawl.attendees[0].user.profile.first_name} and #{crawl.attendees[1].user.profile.first_name} are attending."
      when 3
        "#{crawl.attendees[0].user.profile.first_name}, #{crawl.attendees[1].user.profile.first_name} and #{crawl.attendees[2].user.profile.first_name} are attending."
      else
        "#{crawl.attendees[0].user.profile.first_name}, #{crawl.attendees[1].user.profile.first_name}, #{crawl.attendees[2].user.profile.first_name} and #{crawl.attendees.length - 3} more are attending."
      end
    end
    
  end
end
