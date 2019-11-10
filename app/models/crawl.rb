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
  validates :max_attendees, numericality: { greater_than: 0 }
  after_initialize :set_defaults, unless: :persisted?
  after_commit :handle_price
  accepts_nested_attributes_for :locations, allow_destroy: true, reject_if: :all_blank
  paginates_per 6

  def handle_price
    # make sure incoming price is converted to integer (cents)
    price = (self.price.to_f * 100).to_i
    self.price = price
  end
end
