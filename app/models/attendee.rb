class Attendee < ApplicationRecord
  belongs_to :user
  belongs_to :crawl
  validates :user_id,
            :crawl_id,
            presence: true
end
