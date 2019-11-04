class AttendeesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @crawl = Crawl.find(params[:crawl])
    @attendees = @crawl.attendees.map do |attendee|
      User.find(attendee.user_id)
    end

    if !@attendees.include?(current_user)
      Attendee.create(
        crawl_id: attendee_params[:crawl],
        user_id: attendee_params[:user]
      )
    end

    redirect_to crawl_path(@crawl)
  end

  def destroy
    @crawl = Crawl.find(params[:crawl])
    @attendee = Attendee.where(
      crawl_id: attendee_params[:crawl],
      user_id: attendee_params[:user]
    )

    @attendee.destroy_all

    redirect_to crawl_path(@crawl)
  end

  private

  def attendee_params
    params.permit(:crawl, :user)
  end
end