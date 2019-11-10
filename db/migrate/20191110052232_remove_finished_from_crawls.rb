class RemoveFinishedFromCrawls < ActiveRecord::Migration[5.2]
  def change
    remove_column :crawls, :finished, :boolean
  end
end
