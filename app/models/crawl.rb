class Crawl < ApplicationRecord
  belongs_to :user
  has_many :locations, dependent: :destroy
  after_initialize :set_defaults, unless: :persisted?

  def set_defaults
    self.finished ||= false
  end
end
