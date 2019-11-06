class AddCrawlDateToCrawl < ActiveRecord::Migration[5.2]
  def change
    add_column :crawls, :crawl_date, :datetime
  end
end
