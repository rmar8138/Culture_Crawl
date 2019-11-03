class AttendeesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    Attendee.create(
      crawl_id: attendee_params[:crawl],
      user_id: attendee_params[:user]
    )
  end

  private

  def attendee_params
    params.permit(:crawl, :user)
  end
end