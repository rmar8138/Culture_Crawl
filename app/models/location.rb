class Location < ApplicationRecord
  belongs_to :crawl, optional: true
  has_one_attached :location_image
  validates :title,
            :description,
            :location,
            presence: true
  validates :location_image, attached: true, content_type: [:png, :jpeg, :jpg]
end
