class Location < ApplicationRecord
  belongs_to :crawl, optional: true
  has_one_attached :location_image
end
