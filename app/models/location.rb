class Location < ApplicationRecord
  belongs_to :crawl, optional: true
end
