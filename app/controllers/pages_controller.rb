class PagesController < ApplicationController
  def home
    @latest_crawls = Crawl.last(6)
    @highest_rated_crawls = Crawl.where("rating > ?", 0).order(:rating).last(6)
  end

  def confirm
    @crawl = Crawl.find(params[:id])
    @public_key = Rails.application.credentials.dig(:stripe, :public_key)

    if user_signed_in?
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
    
    end
  end
end
