class Crawl < ApplicationRecord
  belongs_to :user
  has_many :locations, dependent: :destroy
  has_many :attendees, dependent: :destroy
  has_one_attached :crawl_image
  after_initialize :set_defaults, unless: :persisted?
  accepts_nested_attributes_for :locations, allow_destroy: true, reject_if: :all_blank

  def set_defaults
    self.finished ||= false
  end
end
