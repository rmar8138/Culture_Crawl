class RemoveCrawlDateFromCrawl < ActiveRecord::Migration[5.2]
  def change
    remove_column :crawls, :crawl_date, :date
  end
end
