class AddRatingToCrawls < ActiveRecord::Migration[5.2]
  def change
    add_column :crawls, :rating, :decimal
  end
end
