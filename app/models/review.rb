class Review < ApplicationRecord
  belongs_to :user
  belongs_to :crawl
  after_commit :update_crawl_rating
  after_commit :update_user_rating

  private

  def update_crawl_rating
    # update crawl rating after posting review
    reviews_scores = self.crawl.reviews.pluck(:rating)
    rating = nil
    if reviews_scores.length > 0
      # check if ratings exist first
      rating = reviews_scores.reduce(:+) / reviews_scores.length
    end
    self.crawl.update(rating: (rating * 2.0).round / 2.0)
  end

  def update_user_rating
    # update user rating after posting review
    user = self.crawl.user
    ratings = user.reviews.pluck(:rating)

    if ratings.length > 0
      user_rating = (ratings.reduce(:+) / ratings.length * 2.0).round / 2.0
      user.profile.update(rating: user_rating)
    end
  end
end
