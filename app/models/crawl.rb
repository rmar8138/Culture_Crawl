class Crawl < ApplicationRecord
  belongs_to :user
  has_many :locations, dependent: :destroy
  has_many :attendees, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_one_attached :crawl_image
  validates :title,
            :location,
            :description,
            :price,
            :max_attendees,
            :crawl_date,
            presence: true
  validates :crawl_image, attached: true, content_type: [:png, :jpeg, :jpg]
  after_initialize :set_defaults, unless: :persisted?
  accepts_nested_attributes_for :locations, allow_destroy: true, reject_if: :all_blank

  def set_defaults
    self.finished ||= false
  end

  def remove_past_crawls
    # cron job to check to see if crawl has passed and set finished boolean to true
    Crawl.all.each do |crawl|
      if crawl.crawl_date.past? && !crawl.finished
        crawl.toggle(:finished)
      end
    end
  end
end
