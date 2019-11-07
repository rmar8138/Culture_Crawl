class PagesController < ApplicationController
  def home
    @latest_crawls = Crawl.last(6)
    @highest_rated_crawls = Crawl.where("rating > ?", 0).order(:rating).last(6)
  end
end
