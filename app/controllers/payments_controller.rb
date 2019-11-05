class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:webhook]

  def success
    # only show confirm booking if user crawl attendee established
    unless Attendee.exists?(
      crawl_id: params[:crawlId],
      user_id: params[:userId]
    )
      @crawl = Crawl.find(params[:crawlId])
      redirect_to crawl_path(@crawl)
    end
  end
  
  def webhook
    payment_id = params[:data][:object][:payment_intent]
    payment = Stripe::PaymentIntent.retrieve(payment_id)
    crawl_id = payment.metadata.crawl_id
    user_id = payment.metadata.user_id

    @crawl = Crawl.find(crawl_id)
    @attendees = @crawl.attendees.map do |attendee|
      User.find(attendee.user_id)
    end

    if !@attendees.include?(current_user)
      Attendee.create(
        crawl_id: crawl_id,
        user_id: user_id
      )
    end
  end
end
