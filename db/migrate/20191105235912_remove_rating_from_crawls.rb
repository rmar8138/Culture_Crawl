class RemoveRatingFromCrawls < ActiveRecord::Migration[5.2]
  def change
    remove_column :crawls, :rating, :float
  end
end
