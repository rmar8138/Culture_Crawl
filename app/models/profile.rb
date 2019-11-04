class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :profile_image
  validates :first_name,
            :last_name,
            :location,
            :bio,
            presence: true
end
