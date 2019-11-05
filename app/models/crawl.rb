class Crawl < ApplicationRecord
  belongs_to :user
  has_many :locations, dependent: :destroy
  has_many :attendees, dependent: :destroy
  has_one_attached :crawl_image
  # validates :title,
  #           :location,
  #           :description,
  #           :price,
  #           :max_attendees,
  #           :crawl_date,
  #           :crawl_time,
  #           presence: true
  # validates :crawl_image, attached: true, content_type: [:png, :jpeg, :jpg]
  after_initialize :set_defaults, unless: :persisted?
  accepts_nested_attributes_for :locations, allow_destroy: true, reject_if: :all_blank

  def set_defaults
    self.finished ||= false
  end

  # def remove_past_crawls
  #   Crawl.all.each do |crawl|
  #     if Date.parse(crawl.crawl_date).past? && 
  #   end
  # end
end
