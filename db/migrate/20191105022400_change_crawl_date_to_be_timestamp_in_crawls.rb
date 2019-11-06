class ChangeCrawlDateToBeTimestampInCrawls < ActiveRecord::Migration[5.2]
  def change
    change_column :crawls, :crawl_date, :timestamp
  end
end
