class AttendeesController < ApplicationController
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