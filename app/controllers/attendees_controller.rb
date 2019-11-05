class AttendeesController < ApplicationController
  before_action :authenticate_user!

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