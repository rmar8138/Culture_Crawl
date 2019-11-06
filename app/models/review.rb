class Review < ApplicationRecord
  belongs_to :user
  belongs_to :crawl
  after_commit :update_rating

  private

  def update_rating
    # update crawl rating after posting review
    reviews_scores = self.crawl.reviews.pluck(:rating)
    rating = nil
    if reviews_scores.length > 0
      # check if ratings exist first
      rating = reviews_scores.reduce(:+) / reviews_scores.length
    end
    self.crawl.update(rating: rating)
    pp "IT WORKED"
    pp self.crawl
  end
end
