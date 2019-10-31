class CreateCrawls < ActiveRecord::Migration[5.2]
  def change
    create_table :crawls do |t|
      t.string :title
      t.string :location
      t.text :description
      t.integer :price
      t.integer :rating
      t.integer :max_attendees
      t.date :crawl_date
      t.time :crawl_time
      t.boolean :finished
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
