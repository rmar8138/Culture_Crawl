class Crawl < ApplicationRecord
  belongs_to :user
  has_many :locations, dependent: :destroy
  after_initialize :set_defaults, unless: :persisted?
  accepts_nested_attributes_for :locations, allow_destroy: true, reject_if: :all_blank
  has_one_attached :crawl_image

  def set_defaults
    self.finished ||= false
  end
end
