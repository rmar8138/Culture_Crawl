class RemoveCrawlTimeFromCrawl < ActiveRecord::Migration[5.2]
  def change
    remove_column :crawls, :crawl_time, :time
  end
end
