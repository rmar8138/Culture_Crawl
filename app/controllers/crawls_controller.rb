class CrawlsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @crawls = Crawl.all
  end

  def show
    @crawl = Crawl.find(params[:id])
    @attendees = @crawl.attendees.map do |attendee|
      User.find(attendee.user_id)
    end

    session = Stripe::Checkout::session.create(
      payment_method_types: ["card"],
      customer_email: current_user.email,
      line_items: [
        {
          title: @crawl.title,
          location: @crawl.location,
          description: @crawl.description,
          price: @crawl.price,
          crawl_date: @crawl.crawl_date,
          crawl_time: @crawl.crawl_time,
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
  end

  def new
    @crawl = Crawl.new
    @location = Location.new
  end

  def create
    @crawl = Crawl.new(crawl_params)
    @crawl.user_id = current_user.id
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
      :crawl_date,
      :crawl_time,
      :finished,
      :user_id,
      :crawl_image,
      locations_attributes: Location.attribute_names.map(&:to_sym).push(:_destroy, :location_image)
    )
  end
end
