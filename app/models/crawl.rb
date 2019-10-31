class Crawl < ApplicationRecord
  belongs_to :user
  after_initialize :set_defaults, unless: :persisted?

  def set_defaults
    self.finished ||= false
  end
end
